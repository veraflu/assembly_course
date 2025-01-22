#!/usr/bin/env bash

#SBATCH --cpus-per-task=21
#SBATCH --mem=80G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=edta
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end,fail
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/annotation/EDTA/output_edta_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/annotation/EDTA/error_edta_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/vflueck/assembly_annotation_course_HS_2024"
FLYE="$WORKDIR/assembly/flye/assembly.fasta"
#HIFIASM="$WORKDIR/assembly/hifiasm/Kar-1.fa"
#LJA="$WORKDIR/assembly/LJA/assembly.fasta"
OUTDIR="$WORKDIR/annotation/EDTA"
CDS_FILE="/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated"

mkdir -p $OUTDIR

cd $OUTDIR/EDTA

#run it within conda environment

perl EDTA.pl --genome $WORKDIR/assemblies/flye/assembly.fasta --species others --step all --overwrite 1 --cds $CDS_FILE --anno 1 --threads 20