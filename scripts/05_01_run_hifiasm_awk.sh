#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=500M
#SBATCH --time=01:00:00
#SBATCH --job-name=hifiasm_awk
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm/output_hifiasm_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assemblies/hifiasm/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/vflueck/assembly_annotation_course_HS_2024"
RESULTDIR="$WORKDIR/assembly/hifiasm"

awk '/^S/{print ">"$2;print $3}' $RESULTDIR/Etna-2.gfa.bp.p_ctg.gfa > $RESULTDIR/Etna-2_assembly.fa