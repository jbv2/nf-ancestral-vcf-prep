#!/bin/bash

find -L . \
        -type f \
        -name "*.vcf.gz" \
        ! -name "*.header.vcf.gz" \
| sed "s#.vcf.gz#.header.vcf.gz#" \
| xargs mk $@
