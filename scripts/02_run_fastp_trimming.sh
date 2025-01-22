#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/trimming/output_fastp_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/trimming/error_fastp_%j.e
#SBATCH --partition=pibu_el8

#load fastp module from vital-it
module load fastp/0.23.4-GCC-10.3.0

# Set input and output directories
WORKDIR_RNA="/data/users/vflueck/assembly_annotation_course_HS_2024/data/RNAseq_Sha"
WORKDIR_DNA="/data/users/vflueck/assembly_annotation_course_HS_2024/data/Etna-2"
OUTDIR="/data/users/vflueck/assembly_annotation_course_HS_2024/trimming"

# Run trimming on RNA data
# Create output directory if it doesn't exist
mkdir -p "$OUTDIR"

# Process all fastq.gz files in the input directory

# Run fastp on the input file
fastp \
-i $WORKDIR_RNA/ERR754081_1.fastq.gz \
-o $OUTDIR/ERR754081_1_cleaned.fastq.gz \
-I $WORKDIR_RNA/ERR754081_2.fastq.gz \
-O $OUTDIR/ERR754081_2_cleaned.fastq.gz \
-h $OUTDIR/RNA_fastp_report.html \
-j $OUTDIR/RNA_fastp_report.json \
--detect_adapter_for_pe \
--cut_mean_quality 20 \
--qualified_quality_phred 15 \
--unqualified_percent_limit 40


#slightly cleaner output, since overlap analysis might fail

echo "Fastp processing of RNA reads complete!"


# Run fastp without trimming on DNA reads
# Process all fastq.gz files in the input directory
# Run fastp on the input file
fastp \
-i $WORKDIR_DNA/ERR11437333.fastq.gz \
-o $OUTDIR/ERR11437333_cleaned.fastq.gz \
-h $OUTDIR/ERR11437333_report.html \
-j $OUTDIR/ERR11437333_report.json \
--disable_quality_filtering \
--disable_length_filtering \
--disable_trim_poly_g \
--disable_adapter_trimming \


echo "Fastp processing of DNA reads complete!"


