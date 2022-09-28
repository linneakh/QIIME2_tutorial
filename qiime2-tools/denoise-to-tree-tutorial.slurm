#!/bin/bash
#################SBATCH job######################
#SBATCH --job-name=Denoise
#SBATCH --ntasks=28
#SBATCH --nodes=1
#SBATCH --mem=168gb
#SBATCH --time=2:00:00
#SBATCH --partition=standard
#SBATCH --account=laurameredith
#SBATCH --mail-user=linneah@hpc.arizona.edu
##################################################

#############load programs here####################
module load anaconda/2022.05
source activate qiime2-2022.8
##################################################

#############set directory here####################
cd ~/qiime2-atacama-tutorial/
###################################################

############enter script here#####################
TRIMLF=13
TRIMLR=13
TRUNCF=150
TRUNCR=150

qiime dada2 denoise-paired  \
	--i-demultiplexed-seqs demux.qza \
	--o-table table.qza \
	--o-representative-sequences rep-seqs.qza \
	--p-trim-left-f $TRIMLF \
	--p-trim-left-r $TRIMLR \
	--p-trunc-len-f $TRUNCF \
	--p-trunc-len-r $TRUNCR \
	--o-denoising-stats denoising-stats.qza \
	--verbose --p-n-threads 28
 
qiime feature-table summarize \
	--i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.tsv

qiime metadata tabulate \
	--m-input-file denoising-stats.qza \
	--o-visualization denoising-stats.qzv

qiime feature-table tabulate-seqs \
	--i-data rep-seqs.qza \
	--o-visualization rep-seqs.qzv

qiime phylogeny align-to-tree-mafft-fasttree \
	--i-sequences rep-seqs.qza \
	--o-alignment aligned-rep-seqs.qza \
	--o-masked-alignment masked-aligned-rep-seqs.qza \
	--o-tree unrooted-tree.qza \
	--o-rooted-tree rooted-tree.qza
##############################################
