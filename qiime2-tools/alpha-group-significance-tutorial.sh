#!/bin/bash

module load anaconda/2022.05
source activate qiime2-2022.8

FILEPATH=$1

cd ..

mkdir $FILEPATH/alpha-group-significance

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/faith_pd_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization $FILEPATH/alpha-group-significance/faith-pd-group-sig.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/evenness_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization $FILEPATH/alpha-group-significance/evenness-group-sig.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/observed_features_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization $FILEPATH/alpha-group-significance/observed-otus-group-sig.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity $FILEPATH/shannon_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization $FILEPATH/alpha-group-significance/shannon-group-sig.qzv


