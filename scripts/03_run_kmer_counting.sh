#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=04:00:00
#SBATCH --job-name=kmer
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/read_QC/kmer_counting/output_fastqc_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/read_QC/kmer_counting_%j.e
#SBATCH --partition=pibu_el8

# kmer_counting with jellyfish
module load Jellyfish/2.3.0-GCC-10.3.0

# Define directories
WORKDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/data/Etna-2/
OUTDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/read_QC/kmer_counting/

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Change to working directory
cd $WORKDIR || exit 1

echo "Starting kmer analysis with jellyfish on all FASTQ files..."

# Process all fastq.gz files in the working directory
jellyfish count \
    -C -m 21 -s 5G -t 4 \
    <(for file in *.fastq.gz; do zcat "$file"; done) \
    -o "${OUTDIR}/all_reads.jf"

echo "Jellyfish count completed. Generating histogram..."

# Generate histogram
jellyfish histo -t 4 "${OUTDIR}/all_reads.jf" > "${OUTDIR}/kmer_histogram.histo"

echo "Kmer analysis completed. Results are in ${OUTDIR}"

