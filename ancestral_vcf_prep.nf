#!/usr/bin/env nextflow
/*
==============================
Fecha: OCT 10, 2019
Version: 0.001
Autores: Judith Ballesteros Villascán
Descripción: Know the variants shared between data sets projects.
GIT Repository:
==============================
INITIALIZE PARAMETERS
==============================
Pipeline processes in brief:
Pre-Processing:
_pre1_add_header
_pre2_filter_vcfs
Core-Processing:
_001_concatenate_vcfs
Post-Processing:
_pst1_normalize_and_compress
==============================
*/

/*
PIPELINE START
*/
/* DEFINE INPUT PATHS
/* Load feature files into channel*/
Channel
  .fromPath( "${params.input_dir}/*.vcf.gz" )
   .set{feature_files_inputs}
/*
===========================================
Process for adding contigs to avoid mistakes
===========================================
*/
/* Loading mkfiles*/
Channel
  .fromPath("mkmodules/mk-add-header/*")
    .toList()
    .set{mkfiles_pre1}

process _pre1_add_header {
  publishDir "test/results/_pre1_add_header/", mode: "copy"
  input:
    file vcfs from feature_files_inputs
    file mkfiles from mkfiles_pre1
    output:
     file "*.header.vcf.gz" into results_pre1_add_header
    """
    export HEADER="${params.header_lines}"
    bash runmk.sh
    """
}

/*
=========================================================
Process for filtering vcfs
=========================================================
*/
/* Prepare inputs */
results_pre1_add_header
  .view()
  .toList()
  .view()
  .set{inputs_for_pre2}

/* Load mkfiles */
Channel
  .fromPath("mkmodules/mk-filter-vcfs/*")
    .toList()
    .view()
    .set{mkfiles_pre2}

process _pre2_filter_vcfs{
  publishDir "test/results/_pre2_filter_vcfs/", mode: "copy"
  input:
  file header_vcfs from inputs_for_pre2
  file mkfiles from mkfiles_pre2
  output:
  file "*.filtered.vcf.g*" into results_pre2_filter_vcfs

  """
  bash runmk.sh
  """
}

/*
=========================================================
Process for concatenating vcfs
=========================================================
*/
/* Prepare inputs */
// results_pre2_filter_vcfs
//   .view()
//   .toList()
//   .view()
//   .set{inputs_for_001}

/* Load mkfiles */
Channel
  .fromPath("mkmodules/mk-concatenate/*")
    .toList()
    .view()
    .set{mkfiles_001}

process _001_concatenate_vcfs{
  publishDir "test/results/_001_concatenate_vcfs/", mode: "copy"
  input:
  file filtered_vcfs from results_pre2_filter_vcfs
  file mkfiles from mkfiles_001
  output:
  file "concatenated.vcf" into results_001_concatenate_vcfs

  """
  bash runmk.sh
  """
}

/*
=========================================================
Process for normalizing and compressing vcf
=========================================================
*/
/* Prepare inputs */
results_001_concatenate_vcfs
  .view()
  .toList()
  .view()
  .set{inputs_for_pst1}
/* Load mkfiles */

Channel
  .fromPath("mkmodules/mk-normalize-and-compress/*")
    .toList()
    .view()
    .set{mkfiles_pst1}

process _pst1_normalize_and_compress{
  publishDir "test/results/_pst1_normalize_and_compress/", mode: "copy"
  input:
  file concatenated_vcf from inputs_for_pst1
  file mkfiles from mkfiles_pst1
  output:
  file "concatenated.sorted.normalized.split_multiallelics.vcf.gz" into results_pst1_normalize_and_compress

  """
  export GENOME_REFERENCE="${params.genome_reference}"
  bash runmk.sh
  """
}
