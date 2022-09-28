#!/bin/bash

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10

FILEPATH=$1
METHOD=$2
MAPPING_FILE=$3
CATEGORY=$4
cd ..
mkdir $FILEPATH/beta-correlation
mkdir $FILEPATH/beta-correlation/$CATEGORY

qiime diversity beta-correlation \
  --i-distance-matrix $FILEPATH/bray_curtis_distance_matrix.qza \
  --p-method $METHOD \
  --m-metadata-file $MAPPING_FILE \
  --m-metadata-category $CATEGORY \
  --o-visualization $FILEPATH/beta-correlation/$CATEGORY/bray_curtis_corr_$METHOD.qzv

qiime diversity beta-correlation \
  --i-distance-matrix $FILEPATH/jaccard_distance_matrix.qza \
  --p-method $METHOD \
  --m-metadata-category $CATEGORY \
  --m-metadata-file $MAPPING_FILE \
  --o-visualization $FILEPATH/beta-correlation/$CATEGORY/jaccard_corr_$METHOD.qzv

qiime diversity beta-correlation \
  --i-distance-matrix $FILEPATH/un_unifrac_distance_matrix.qza \
  --p-method $METHOD \
  --m-metadata-category $CATEGORY \
  --m-metadata-file $MAPPING_FILE \
  --o-visualization $FILEPATH/beta-correlation/$CATEGORY/un_unifrac_corr_$METHOD.qzv

qiime diversity beta-correlation \
  --i-distance-matrix $FILEPATH/weighted_unifrac_distance_matrix.qza \
  --m-metadata-file $MAPPING_FILE \
  --m-metadata-category $CATEGORY \
  --p-method $METHOD \
  --o-visualization $FILEPATH/beta-correlation/$CATEGORY/w_unifrac_corr_$METHOD.qzv
