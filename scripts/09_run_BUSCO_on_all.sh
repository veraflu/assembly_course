#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=BUSCO
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/BUSCO/output_BUSCO_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/BUSCO/error_BUSCO_%j.e
#SBATCH --partition=pibu_el8


# Define directories
FLYE="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/flye"
HIFIASM="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm"
LJA="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/LJA/Etna-2_hifiasm_assembly"
TRINITY="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/trinity"

OUTDIR="/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/BUSCO/"

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# flye
# Change to working directory
cd $FLYE || exit 1

echo "Starting BUSCO analysis on flye assembly..."

apptainer exec \
--bind $FLYE,$OUTDIR \
/containers/apptainer/busco_5.7.1.sif \
busco \
--force \
--in $FLYE/assembly.fasta \
--mode genome \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out_path $OUTDIR \
--out "flye"

echo "BUSCO analysis was done for flye assembly!"


# hifiasm
# Change to working directory
cd $HIFIASM || exit 1

echo "Starting BUSCO analysis on hifiasm assembly..."

apptainer exec \
--bind $HIFIASM,$OUTDIR \
/containers/apptainer/busco_5.7.1.sif \
busco \
--force \
--in $HIFIASM/Etna-2_assembly.fa \
--mode genome \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out_path $OUTDIR \
--out "hifiasm"
     

echo "BUSCO analysis was done for hifiasm assembly!"


# LJA
# Change to working directory
cd $LJA || exit 1

echo "Starting BUSCO analysis on LJA assembly..."

apptainer exec \
--bind $LJA,$OUTDIR \
/containers/apptainer/busco_5.7.1.sif \
busco \
--force \
--in $LJA/assembly.fasta \
--mode genome \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out_path $OUTDIR \
--out "LJA"


echo "BUSCO analysis was done for LJA assembly!"


# trinity
# Change to working directory
cd $TRINITY || exit 1

echo "Starting BUSCO analysis on trinity assembly..."

apptainer exec \
--bind $TRINITY,$OUTDIR \
/containers/apptainer/busco_5.7.1.sif \
busco \
--force \
--in $TRINITY/trinity.Trinity.fasta \
--mode transcriptome \
--lineage_dataset brassicales_odb10 \
--cpu 16 \
--out_path $OUTDIR \
--out "trinity"
  

echo "BUSCO analysis was done for trinity assembly!"

