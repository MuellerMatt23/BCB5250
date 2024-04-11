#!/bin/bash
dir=/student/muellermw/courses/bcb5250/RNAseq/RNAseq_protocol/chrX_data
SAMPLES="samples"
INDEXES="indexes"
HISAT_OUT="hisat_out"
SUMMARY="summaries"

mkdir -p ${HISAT_OUT}
mkdir -p ${SUMMARY}

samples=(ERR188044 ERR188104 ERR188234 ERR188245 ERR188257 ERR188273 ERR188337 ERR188383 ERR188401 ERR188428 ERR188454 ERR204916)

for sample in "${samples[@]}"; do
    /opt/hisat2-2.2.0/hisat2 -p 8 --dta -x chrX_data/${INDEXES}/chrX_tran -1 chrX_data/${SAMPLES}/${sample}_chrX_1.fastq.gz -2 chrX_data/${SAMPLES}/${sample}_chrX_2.fastq.gz -S ${HISAT_OUT}/${sample}_chrX.sam &> ${SUMMARY}/${sample}_summary.txt
done
