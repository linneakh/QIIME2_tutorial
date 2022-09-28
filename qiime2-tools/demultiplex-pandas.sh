#!/bin/bash

#PBS -N demultiplex
#PBS -m bea
#PBS -M linneah@email.arizona.edu
#PBS -W group_list=donata
#PBS -q standard
#PBS -l select=1:ncpus=1:mem=5gb
#PBS -l place=pack:shared
#PBS -l walltime=10:00:00
#PBS -l cput=10:00:00

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2018.4

#Fill in file path
cd /rsgrps/donata/AMISH-HUTT-PROJECT/Lung_gut_16S_fastqs/fullset/

qiime tools import \
	--type EMPPairedEndSequences \
	--input-path sequences \
	--output-path emp-paired-end-sequences.qza
qiime demux emp-paired \
	--m-barcodes-file sample_metadata.txt \
	--m-barcodes-column BarcodeSequence \
	--i-seqs emp-paired-end-sequences.qza \
	--o-per-sample-sequences demux.qza \
	--p-rev-comp-mapping-barcodes \
	--verbose
qiime demux summarize \
	--i-data demux.qza \
	--o-visualization demux.qzv \
	--verbose
