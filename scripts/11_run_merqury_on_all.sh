#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/merqury/output_merqury_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/merqury/error_merqury_%j.e
#SBATCH --partition=pibu_el8


WORKDIR="/data/users/vflueck/assembly_annotation_course_HS_2024"

# Define directories
FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
HIFIASM="$WORKDIR/assemblies/hifiasm/Etna-2_assembly.fa"
LJA="$WORKDIR/assemblies/LJA/Etna-2_hifiasm_assembly/assembly.fasta"
ETNA2READS="$WORKDIR/data/Etna-2/ERR11437333.fastq.gz"
OUTDIR="$WORKDIR/assembly_eval/merqury"
MERYL="$OUTDIR/meryl/"

mkdir -p $MERYL

export MERQURY="/usr/local/share/merqury"

# find best kmer size
#apptainer exec \
#--bind /data \
#/containers/apptainer/merqury_1.3.sif \
#$MERQURY/best_k.sh 135000000

#-->best kmer size 18

k1=18
# build kmer dbs
#apptainer exec \
#--bind /data \
#/containers/apptainer/merqury_1.3.sif \
#meryl k=$k1 count $ETNA2READS output $MERYL/meryl.meryl

k2=21
#apptainer exec \
#--bind \
#/data /containers/apptainer/merqury_1.3.sif \
#meryl k=$k1 count $ETNA2READS output $MERYL.meryl

#k1=18
#apptainer exec \
#--bind /data \
#/containers/apptainer/meryl_1.4.1.sif \
#meryl count k=$k1 $ETNA2READS output $MERYL/meryl.meryl

#run merqury
#flye
#mkdir -p $OUTDIR/flye
#cd $OUTDIR/flye
#apptainer exec \
#--bind /data \
#/containers/apptainer/merqury_1.3.sif \
#merqury.sh $MERYL/meryl.meryl $FLYE flye_kmer18

#hifiasm
mkdir -p $OUTDIR/hifiasm
cd $OUTDIR/hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/merqury_1.3.sif \
merqury.sh $MERYL/meryl.meryl $HIFIASM hifiasm_kmer18

#LJA
mkdir -p $OUTDIR/LJA
cd $OUTDIR/LJA
apptainer exec \
--bind /data \
/containers/apptainer/merqury_1.3.sif \
merqury.sh $MERYL/meryl.meryl $LJA lja_kmer18

