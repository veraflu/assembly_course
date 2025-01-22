#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=LJA
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/LJA/output_LJA_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/LJA/error_LJA_%j.e
#SBATCH --partition=pibu_el8


#Run whole genome assembly using LJA

# Define directories
WORKDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/data/Etna-2/
OUTDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/LJA/

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Change to working directory
cd $WORKDIR || exit 1

echo "Starting LJA assembly process on FASTQ files..."

# Loop through all fastq.gz files in the working directory
for file in *.fastq.gz
do
    echo "Processing $file..."
    
    apptainer exec \
    --bind $WORKDIR,$OUTDIR \
    /containers/apptainer/lja-0.2.sif \
    lja -o $OUTDIR/Etna-2_hifiasm_assembly --reads $WORKDIR/*.fastq.gz --threads 16
    
done

echo "LJA assembly complete for all files!"

