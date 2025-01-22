#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=QUAST_all
#SBATCH --mail-user=vera.flueck@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/QUAST/output_QUAST_%j.o
#SBATCH --error=/data/users/vflueck/assembly_annotation_course_HS_2024/assembly_eval/QUAST/error_QUAST_%j.e
#SBATCH --partition=pibu_el8


#Run QUAST analysis on genome assemblies (all)
WORKDIR="/data/users/vflueck/assembly_annotation_course_HS_2024"

FLYE="$WORKDIR/assemblies/flye/assembly.fasta"
FLYERESULTSREF="$WORKDIR/assembly_eval/QUAST/QUAST_flye_ref"
FLYERESULTSNOREF="$WORKDIR/assembly_eval/QUAST/QUAST_flye_noref"

mkdir -p $FLYERESULTSREF $FLYERESULTSNOREF

HIFIASM="$WORKDIR/assemblies/hifiasm/Etna-2_assembly.fa"
HIFIASMRESULTSREF="$WORKDIR/assembly_eval/QUAST/QUAST_hifiasm_ref"
HIFIASMRESULTSNOREF="$WORKDIR/assembly_eval/QUAST/QUAST_hifiasm_noref"

mkdir -p $HIFIASMRESULTSREF $HIFIASMRESULTSNOREF

LJA="$WORKDIR/assemblies/LJA/Etna-2_hifiasm_assembly/assembly.fasta"
LJARESULTSREF="$WORKDIR/assembly_eval/QUAST/QUAST_LJA_ref"
LJARESULTSNOREF="$WORKDIR/assembly_eval/QUAST/QUAST_LJA_noref"

mkdir -p $LJARESULTSREF $LJARESULTSNOREF

ALLREF="$WORKDIR/assembly_eval/QUAST/QUAST_all_ref"
ALLNOREF="$WORKDIR/assembly_eval/QUAST/QUAST_all_noref"

mkdir -p $ALLREF $ALLNOREF


REF_FEATURE="/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff"
REF="/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa"



# Change to working directory
cd $WORKDIR || exit 1

echo "Starting QUAST analysis on assemblies..."


# with ref
#flye
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $FLYE \
-o $FLYERESULTSREF \
--labels Etna2_flye \
-r $REF \
--features $REF_FEATURE \
--threads 16 \
--eukaryote

#hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $HIFIASM \
-o $HIFIASMRESULTSREF \
--labels Etna2_hifiasm \
-r $REF \
--features $REF_FEATURE \
--threads 16 \
--eukaryote

#LJA
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $LJA \
-o $LJARESULTSREF \
--labels Etna2_LJA \
-r $REF \
--features $REF_FEATURE \
--threads 16 \
--eukaryote

#all
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $LJA $HIFIASM $FLYE \
-o $ALLREF \
--labels Etna2_LJA,Etna2_hifi,Etna2_flye \
-r $REF \
--features $REF_FEATURE \
--threads 16 \
--eukaryote


# without ref
#flye
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $FLYE \
-o $FLYERESULTSNOREF \
--labels Etna2_flye_noref \
--threads 16 \
--eukaryote \
--est-ref-size 130000000

#hifiasm
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $HIFIASM \
-o $HIFIASMRESULTSNOREF \
--labels Etna2_hifi_noref \
--threads 16 \
--eukaryote \
--est-ref-size 130000000

#lja
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $LJA \
-o $LJARESULTSNOREF \
--labels Etna2_LJA_noref \
--threads 16 \
--eukaryote \
--est-ref-size 130000000

#all
apptainer exec \
--bind /data \
/containers/apptainer/quast_5.2.0.sif \
quast.py $LJA $HIFIASM $FLYE \
-o $ALLNOREF \
--labels Etna2_LJA_noref,Etna2_hifi_noref,Etna2_flye_noref \
--threads 16 \
--eukaryote \
--est-ref-size 130000000


echo "QUAST analysis was done for all assemblies!"

