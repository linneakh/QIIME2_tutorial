#!/bin/bash

#PBS -N phylogeny
#PBS -m bea
#PBS -M linneah@email.arizona.edu
#PBS -W group_list=donata
#PBS -q standard
#PBS -l select=1:ncpus=14:mem=80gb
#PBS -l place=free:shared
#PBS -l walltime=1:00:00
#PBS -l cput=14:00:00

FILEPATH=Nov2019-germfree-lungs-crs

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10
cd /extra/linneah/QIIME2/$FILEPATH

#echo "my job_id is: ${PBS_JOBID}"

qiime phylogeny align-to-tree-mafft-fasttree \
	--i-sequences rep-seqs.qza \
	--o-alignment alignment.qza \
	--o-masked-alignment masked-aligned-rep-seqs.qza \
	--o-tree unrooted-tree.qza \
	--o-rooted-tree rooted-tree.qza
