#!/bin/#!/usr/bin/env bash

## ENVIRONMENTE VARIABLES REQUIRED
#format is: export VARNAME="value"
export HEADER="test/reference/header_lines.txt"
# borrar resultados de prueba anterior
rm -fr test/results/

# Crear un test/results vacío
mkdir -p test/results
bash runmk.sh && mv test/data/*.header.vcf.gz test/results/ \
 && echo "module test successful"
