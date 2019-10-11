#!/bin/#!/usr/bin/env bash

## ENVIRONMENTE VARIABLES REQUIRED
#format is: export VARNAME="value"
#export BCFTOOLS="/home/ballesteros/programs/bcftools/bcftools"
export GENOME_REFERENCE="test/reference/Homo_sapiens_assembly19.fasta"

# borrar resultados de prueba anterior
rm -r test/results/

# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh \
&& mv test/data/*.sorted.normalized.split_multiallelics.vcf.gz* test/results \
&& echo "module test successful"
