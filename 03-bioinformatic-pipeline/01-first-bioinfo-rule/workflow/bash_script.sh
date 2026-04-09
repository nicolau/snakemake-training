#!/bin/bash


SAMPLES = ["A", "B"]

for sample in "${SAMPLES[@]}"; do
    bwa mem ../resources/ref/genome.fa ../resources/reads/"$sample".fastq | samtools view -Sb - > results/mapped_reads/"$sample".bam
    samtools sort -T results/sorted_reads/"$sample" -O bam results/mapped_reads/"$sample".bam > results/sorted_reads/"$sample".bam
    samtools index results/sorted_reads/"$sample".bam
done

bcftools mpileup -f ../resources/ref/genome.fa results/sorted_reads/A.bam ../resources/ref/genome.fa results/sorted_reads/B.bam | bcftools call -mv - > results/calls/all.vcf
python scripts/plot-quals.py
