#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/output_flye_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/error_flye_%j.e
#SBATCH --partition=pibu_el8


#Run whole genome assembly using flye

# Define directories
WORKDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/data/Etna-2/
OUTDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/flye/

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Change to working directory
cd $WORKDIR || exit 1

echo "Starting flye assembly process on FASTQ files..."

# Loop through all fastq.gz files in the working directory
for file in *.fastq.gz
do
    echo "Processing $file..."
    
    apptainer exec \
    --bind $WORKDIR,$OUTDIR \
    /containers/apptainer/flye_2.9.5.sif \
    flye --pacbio-hifi "$file" -o $OUTDIR --threads 4
    
done

echo "Flye assembly complete for all files!"

