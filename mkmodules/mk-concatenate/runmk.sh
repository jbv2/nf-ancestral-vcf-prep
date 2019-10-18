#!/bin/bash

find -L . \
	-type f \
	-name "*.vcf.gz" \
	-exec dirname {} \; \
| sort -u \
| sed "s#\$#/concatenated.vcf#" \
| xargs mk $@
