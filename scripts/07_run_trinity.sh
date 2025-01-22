#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=90G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/trinity/output_trinity_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/trinity/error_trinity_%j.e
#SBATCH --partition=pibu_el8


#Run Transcriptome assembly using trinity
module load Trinity/2.15.1-foss-2021a

# Define directories
WORKDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/trimming/
OUTDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/trinity/

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Change to working directory
cd $WORKDIR || exit 1

echo "Starting trinity assembly process on FASTQ files..."
   
Trinity \
--seqType fq \
--left $WORKDIR/ERR754081_1_cleaned.fastq.gz \
--right $WORKDIR/ERR754081_2_cleaned.fastq.gz \
--CPU 20 \
--max_memory 85G \
--output $OUTDIR
    
echo "Trinity assembly complete for all files!"
