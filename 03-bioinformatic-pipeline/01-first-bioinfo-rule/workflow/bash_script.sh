#!/bin/bash

# Create output directories
echo "Creating output directories..."
mkdir -p results/mapped_reads/
mkdir -p results/sorted_reads/
mkdir -p results/calls/
echo "Output directories created."
echo ""

# Index the reference genome
echo "Indexing the reference genome..."
bwa index ../resources/ref/genome.fa
echo "Reference genome indexed."
echo ""

# Map reads to the reference genome, sort and index the resulting BAM files
for sample in A B; do
    
    # Map reads to the reference genome and convert to BAM format
    echo "Processing sample: $sample"
    bwa mem ../resources/ref/genome.fa ../resources/reads/"$sample".fastq | samtools view -Sb - > results/mapped_reads/"$sample".bam
    echo "Reads mapped for sample: $sample"
    echo ""
    
    # Sort the BAM file and index it
    echo "Sorting BAM file for sample: $sample"
    samtools sort -T results/sorted_reads/"$sample" -O bam results/mapped_reads/"$sample".bam > results/sorted_reads/"$sample".bam
    echo "BAM file sorted for sample: $sample"
    echo ""

    # Index the sorted BAM file
    echo "Indexing sorted BAM file for sample: $sample"
    samtools index results/sorted_reads/"$sample".bam
    echo "Sorted BAM file indexed for sample: $sample"
    echo ""
done

# Call variants using bcftools
echo "Calling variants with bcftools..."
bcftools mpileup -f ../resources/ref/genome.fa results/sorted_reads/A.bam ../resources/ref/genome.fa results/sorted_reads/B.bam | bcftools call -mv - > results/calls/all.vcf
echo "Variants called and saved to results/calls/all.vcf"
echo ""

# Plot quality scores of the called variants
echo "Plotting quality scores..."
#python scripts/plot-quals.py
echo "Quality scores plotted."
echo ""
