#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=04:00:00
#SBATCH --job-name=fastqc_multi
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/read_QC/fastqc/output_fastqc_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/read_QC/fastqc/error_fastqc_%j.e
#SBATCH --partition=pibu_el8


#Do the analysis of Hifi data:
# Define directories
WORKDIR_RNA="/data/users/vflueck/assembly_annotation_course_HS_2024/data/RNAseq_Sha/"
WORKDIR_DNA="/data/users/vflueck/assembly_annotation_course_HS_2024/data/Etna-2/"
OUTDIR="/data/users/vflueck/assembly_annotation_course_HS_2024/read_QC/fastqc/"

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

#first run FASTQC on RNA data
# Change to working directory
cd $WORKDIR_RNA || exit 1

echo "Starting FastQC analysis on all RNA FASTQ files..."

# Loop through all fastq.gz files in the working directory
for file in *.fastq.gz
do
    echo "Processing $file..."
    
    apptainer exec \
    --bind $WORKDIR_RNA,$OUTDIR \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc "$file" -o $OUTDIR
    


#then run FASTQC on DNA data
# Change to working directory
cd $WORKDIR_DNA || exit 1

echo "Starting FastQC analysis on all RNA FASTQ files..."

# Loop through all fastq.gz files in the working directory
for file in *.fastq.gz
do
    echo "Processing $file..."
    
    apptainer exec \
    --bind $WORKDIR_DNA,$OUTDIR \
    /containers/apptainer/fastqc-0.12.1.sif \
    fastqc "$file" -o $OUTDIR

done

echo "FastQC analysis complete for all files!"


