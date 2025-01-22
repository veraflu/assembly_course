#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=1-00:00:00
#SBATCH --job-name=gfastats
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/gfastats/output_stats_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/gfastats/error_stats_%j.e
#SBATCH --partition=pibu_el8


FLYE="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/flye"
HIFIASM="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm"
LJA="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/LJA/Etna-2_hifiasm_assembly"
TRINITY="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/trinity"

OUTDIR="/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/gfastats"
mkdir -p $OUTDIR

apptainer \
exec --bind $FLYE,$OUTDIR \
/containers/apptainer/gfastats_1.3.7.sif \
gfastats $FLYE/assembly.fasta > $OUTDIR/flye_stats.txt

apptainer \
exec --bind $HIFIASM,$OUTDIR \
/containers/apptainer/gfastats_1.3.7.sif \
gfastats $HIFIASM/Etna-2_assembly.fa > $OUTDIR/hifiasm_stats.txt

apptainer \
exec --bind $LJA,$OUTDIR \
/containers/apptainer/gfastats_1.3.7.sif \
gfastats $LJA/assembly.fasta > $OUTDIR/LJA_stats.txt

apptainer \
exec --bind $TRINITY,$OUTDIR \
/containers/apptainer/gfastats_1.3.7.sif \
gfastats $TRINITY/trinity.Trinity.fasta > $OUTDIR/trinity_stats.txt

