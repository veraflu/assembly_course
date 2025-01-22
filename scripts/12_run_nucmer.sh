#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=nucmur
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/genomes_comparison/output_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/genomes_comparison/error_%j.e
#SBATCH --partition=pibu_el8


#Run comperative genomics nucmur analysis on all assemblies

WORKDIR="/data/users/vflueck/assembly_annotation_course_HS_2024"

REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
FLYE="/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Etna-2_assembly.fa"
LJA="$WORKDIR/assemblies/LJA/Etna-2_hifiasm_assembly/assembly.fasta"
RESULTDIR="$WORKDIR/genomes_comparison"

mkdir -p $RESULTDIR

apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer \
--delta $RESULTDIR/genome_flye.delta \
--breaklen 1000 \
--mincluster 1000 \
--threads 6 \
$REF \
$FLYE

apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer \
--delta $RESULTDIR/genome_hifiasm.delta \
--breaklen 1000 \
--mincluster 1000 \
--threads 6 \
$REF \
$HIFIASM

apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
nucmer \
--delta $RESULTDIR/genome_LJA.delta \
--breaklen 1000 \
--mincluster 1000 \
--threads 6 \
$REF \
$LJA

echo "nucmer analysis was done for all assemblies!"
