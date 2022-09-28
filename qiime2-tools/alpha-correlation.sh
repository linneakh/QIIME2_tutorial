#!/bin/bash

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10

FILEPATH=$1
METHOD=$2
MAPPING_FILE=$3
cd ..
mkdir $FILEPATH/alpha-correlation

qiime diversity alpha-correlation \
  --i-alpha-diversity $FILEPATH/faith_pd_vector.qza \
  --p-method $METHOD \
  --m-metadata-file $MAPPING_FILE \
  --o-visualization $FILEPATH/alpha-correlation/faith-pd-correlation-$METHOD.qzvA

qiime diversity alpha-correlation \
  --i-alpha-diversity $FILEPATH/evenness_vector.qza \
  --p-method $METHOD \
  --m-metadata-file $MAPPING_FILE \
  --o-visualization $FILEPATH/alpha-correlation/evenness-correlation-$METHOD.qzv

qiime diversity alpha-correlation \
  --i-alpha-diversity $FILEPATH/observed_otus_vector.qza \
  --p-method $METHOD \
  --m-metadata-file $MAPPING_FILE \
  --o-visualization $FILEPATH/alpha-correlation/observed-otus-correlation-$METHOD.qzv

qiime diversity alpha-correlation \
  --i-alpha-diversity $FILEPATH/shannon_vector.qza \
  --m-metadata-file $MAPPING_FILE \
  --p-method $METHOD \
  --o-visualization $FILEPATH/alpha-correlation/shannon-correlation-$METHOD.qzv
