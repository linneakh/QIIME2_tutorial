#!/bin/bash

#################SBATCH job######################
#SBATCH --job-name=Demultiplex
#SBATCH --ntasks=1
#SBATCH --nodes=1             
#SBATCH --mem=50gb                    
#SBATCH --time=10:00:00   
#SBATCH --partition=standard
#SBATCH --account=laurameredith
#SBATCH --mail-user=linneah@hpc.arizona.edu   
##################################################

#############load programs here####################
module load anaconda/2022.05 
source activate qiime2-2022.8
##################################################

#############set directory here####################
cd ~/qiime2-atacama-tutorial
###################################################

############enter script here#####################
qiime tools import \
        --type EMPPairedEndSequences \
        --input-path sequences \
        --output-path emp-paired-end-sequences.qza

qiime demux emp-paired \
  --m-barcodes-file sample-metadata.tsv \
  --m-barcodes-column barcode-sequence \
  --p-rev-comp-mapping-barcodes \
  --i-seqs emp-paired-end-sequences.qza \
  --o-per-sample-sequences demux-full.qza \
  --o-error-correction-details demux-details.qza

qiime demux subsample-paired \
  --i-sequences demux-full.qza \
  --p-fraction 0.3 \
  --o-subsampled-sequences demux-subsample.qza

qiime demux summarize \
  --i-data demux-subsample.qza \
  --o-visualization demux-subsample.qzv
##############################################
