#!/bin/bash

SAM_FILES="hisat_out"
BAM_DIR="bam_files"

mkdir -p ${BAM_DIR}

samples=(ERR188044 ERR188104 ERR188234 ERR188245 ERR188257 ERR188273 ERR188337 ERR188383 ERR188401 ERR188428 ERR188454 ERR204916)

for sample in "${samples[@]}"; do 
    samtools sort -@ 8 -o ${BAM_DIR}/${sample}_chrX.bam ${SAM_FILES}/${sample}_chrX.sam
done
