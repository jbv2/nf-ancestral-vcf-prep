#!/bin/bash

find -L . \
        -type f \
        -name "*.vcf" \
| sed "s#.vcf#.sorted.normalized.split_multiallelics.vcf.gz#" \
| xargs mk $@

