#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=mummer
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/genomes_comparison/output_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/genomes_comparison/error_%j.e
#SBATCH --partition=pibu_el8


#Run comperative genomics mummer analysis on all assemblies

WORKDIR="/data/users/vflueck/assembly_annotation_course_HS_2024"
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"
FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Etna-2_assembly.fa"
LJA="$WORKDIR/assemblies/LJA/Etna-2_hifiasm_assembly/assembly.fasta"
RESULTDIR="$WORKDIR/genomes_comparison"


#mummer
#flye
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot $RESULTDIR/genome_flye.delta \
-R $REF \
-Q $FLYE \
-breaklen 1000 \
--filter \
-t png \
--large \
--layout \
--fat \
-p $RESULTDIR/flye

#hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot $RESULTDIR/genome_hifiasm.delta \
-R $REF \
-Q $HIFIASM \
-breaklen 1000 \
--filter \
-t png \
--large \
--layout \
--fat \
-p $RESULTDIR/hifiasm

#LJA
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot $RESULTDIR/genome_LJA.delta \
-R $REF \
-Q $LJA \
-breaklen 1000 \
--filter \
-t png \
--large \
--layout \
--fat \
-p $RESULTDIR/LJA


echo "MUMmer analysis was done for all assemblies!"



