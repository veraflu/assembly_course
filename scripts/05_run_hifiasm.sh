#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm/output_hifiasm_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8


#Run whole genome assembly using hifiasm

# Define directories
WORKDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/data/Etna-2/
OUTDIR=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm/

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Change to working directory
cd $WORKDIR || exit 1

echo "Starting Hifiasm assembly process on FASTQ files..."

# Loop through all fastq.gz files in the working directory
for file in *.fastq.gz
do
    echo "Processing $file..."
    
    apptainer exec \
    --bind $WORKDIR,$OUTDIR \
    /containers/apptainer/hifiasm_0.19.8.sif \
    hifiasm -o $OUTDIR/Etna-2_hifiasm_assembly -t 16 $WORKDIR/*.fastq.gz
    
done

awk '/^S/{print ">"$2;print $3}' $OUTDIR/Etna-2_hifiasm_assembly.pb.p_ctg.gfa > $OUTDIR/Etna-2_assembly.fa

echo "Hifiasm assembly complete for all files!"
