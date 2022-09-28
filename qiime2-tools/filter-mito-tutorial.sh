#!/bin/bash

module load anaconda/2022.05
source activate qiime2-2022.8

set -u

cd ..

mkdir filter-mito

cp sample-metadata.tsv filter-mito/sample-metadata.tsv

cp rep-seqs.qza filter-mito/rep-seqs.qza

cp rooted-tree.qza filter-mito/rooted-tree.qza


qiime taxa filter-table \
	--i-table table.qza \
	--o-filtered-table filted-mito/table.qza \
	--i-taxonomy taxonomy/taxonomy.qza \
	--p-include p__ \
	--p-exclude mitochondria,chloroplast

qiime feature-table summarize --i-table filtered-mito/table.qza \
	--o-visualization filtered-mito/table.qzv \
	--m-sample-metadata-file filtered-mito/sample-metadata.tsv

echo "done"
