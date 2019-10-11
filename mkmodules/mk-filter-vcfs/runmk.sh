#!/bin/bash

find -L . \
        -type f \
        -name "*.vcf.gz" \
        ! -name "*.filtered.vcf.gz" \
| sed "s#.vcf.gz#.filtered.vcf.gz#" \
| xargs mk $@
