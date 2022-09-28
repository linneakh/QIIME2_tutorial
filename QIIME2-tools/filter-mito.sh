#!/bin/bash

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10

set -u

cd ..

cp ../sample_metadata.txt sample_metadata.txt

cp ../rep-seqs.qza rep-seqs.qza

cp ../rooted-tree.qza rooted-tree.qza


qiime taxa filter-table \
	--i-table table.qza \
	--o-filtered-table table.qza \
	--i-taxonomy taxonomy/taxonomy.qza \
	--p-include p__ \
	--p-exclude mitochondria,chloroplast

qiime feature-table summarize --i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.txt

echo "done"
