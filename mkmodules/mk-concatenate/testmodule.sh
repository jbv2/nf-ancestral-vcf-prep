#!/bin/#!/usr/bin/env bash

## ENVIRONMENTE VARIABLES REQUIRED
#format is: export VARNAME="value"
#For castillo:
#export BCFTOOLS="/home/ballesteros/programs/bcftools/bcftools"

# borrar resultados de prueba anterior
rm -fr test/results/

# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh && mv test/data/concatenated.vcf test/results/ \
 && echo "module test successful"
