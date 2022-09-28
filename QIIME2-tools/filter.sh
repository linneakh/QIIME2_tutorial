#!/bin/bash

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10

set -u

if [[ $# -lt 1 ]]; then
        printf "Usage: %s HEADING and GROUP\n" $0
        exit 1
fi

HEADING=$1
GROUP=$2

cd ..

cp ../sample_metadata.txt sample_metadata.txt

cp ../rep-seqs.qza rep-seqs.qza

cp ../rooted-tree.qza rooted-tree.qza

qiime feature-table filter-samples --i-table ../table.qza \
	--o-filtered-table table.qza \
	--m-metadata-file sample_metadata.txt \
	--p-where "$HEADING='$GROUP'" \
	--p-exclude-ids

qiime feature-table summarize --i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.txt

echo "done"
