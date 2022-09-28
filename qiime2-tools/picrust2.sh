#!/bin/bash

#PBS -N picrust2
#PBS -m bea
#PBS -M linneah@email.arizona.edu
#PBS -W group_list=donata
#PBS -q standard
#PBS -l select=1:ncpus=28:mem=20gb
#PBS -l place=free:shared
#PBS -l walltime=1:00:00
#PBS -l cput=28:00:00

FILEPATH=CRS_sputum_29_march_19/w_host

module load unsupported
module load donata/miniconda/3/
source activate qiime2-2019.10
cd /extra/linneah/QIIME2/$FILEPATH

echo "my job_id is: ${PBS_JOBID}"

qiime picrust2 full-pipeline --i-table table.qza \
                             --i-seq rep_seqs.qza \
                             --output-dir q2-picrust2_output \
                             --p-threads 28 \
                             --p-hsp-method pic \
                             --p-max-nsti 2
