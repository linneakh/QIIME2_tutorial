#!/bin/bash

module load anaconda/2022.05
source activate qiime2-2022.8

set -u

if [[ $# -lt 1 ]]; then
	printf "Usage: %s DEPTH\n" $0
	exit 1
fi

DEPTH=$1

cd ..

qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table.qza \
  --p-sampling-depth $DEPTH \
  --m-metadata-file sample-metadata.tsv \
  --output-dir core-metrics-results-$DEPTH

echo done
