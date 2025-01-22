#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=nucmur
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

mkdir -p $RESULTDIR/hifiasm_vs_flye $RESULTDIR/flye_vs_lja $RESULTDIR/lja_vs_hifiasm 

#mummer
#flye
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot $RESULTDIR/flye_vs_lja/genome_flye_LJA.delta \
-R $LJA \
-Q $FLYE \
-breaklen 1000 \
--filter \
-t png \
--large \
--layout \
--fat \
-p $RESULTDIR/flye_vs_lja/mummerplot

#hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot $RESULTDIR/hifiasm_vs_flye/genome_hifiasm_flye.delta \
-R $FLYE \
-Q $HIFIASM \
-breaklen 1000 \
--filter \
-t png \
--large \
--layout \
--fat \
-p $RESULTDIR/hifiasm_vs_flye/mummerplot

#LJA
apptainer exec \
--bind /data \
/containers/apptainer/mummer4_gnuplot.sif \
mummerplot $RESULTDIR/lja_vs_hifiasm/genome_LJA_hifiasm.delta \
-R $HIFIASM \
-Q $LJA \
-breaklen 1000 \
--filter \
-t png \
--large \
--layout \
--fat \
-p $RESULTDIR/lja_vs_hifiasm/mummerplot


echo "MUMmer analysis was done for all assemblies!"



