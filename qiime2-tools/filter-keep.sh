#!/bin/bash

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10

set -u

if [[ $# -lt 1 ]]; then
        printf "Usage: %s HEADING and GROUP\n" $0
        exit 1

elif [[ $# == 2 ]]; then
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

	qiime feature-table summarize --i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.txt


elif [[ $# == 3 ]]; then
	HEADING=$1
	GROUP1=$2
	GROUP2=$3

	cd ..

	cp ../sample_metadata.txt sample_metadata.txt

	cp ../rep-seqs.qza rep-seqs.qza

	cp ../rooted-tree.qza rooted-tree.qza

	qiime feature-table filter-samples --i-table ../table.qza \
	--o-filtered-table table.qza \
	--m-metadata-file sample_metadata.txt \
	--p-where "$HEADING='$GROUP1' OR $HEADING='$GROUP2'" \

	qiime feature-table summarize --i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.txt


elif [[ $# == 4 ]]; then
	HEADING=$1
	GROUP1=$2
	GROUP2=$3
	GROUP3=$4
	
	cd ..

	cp ../sample_metadata.txt sample_metadata.txt

	cp ../rep-seqs.qza rep-seqs.qza

	cp ../rooted-tree.qza rooted-tree.qza

	qiime feature-table filter-samples --i-table ../table.qza \
	--o-filtered-table table.qza \
	--m-metadata-file sample_metadata.txt \
	--p-where "$HEADING='$GROUP1' OR $HEADING='$GROUP2' OR $HEADING='$GROUP3'" \

	qiime feature-table summarize --i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.txt

else
	HEADING=$1
	GROUP1=$2
	GROUP2=$3
	GROUP3=$4
	GROUP4=$5

	cd ..

	cp ../sample_metadata.txt sample_metadata.txt

	cp ../rep-seqs.qza rep-seqs.qza

	cp ../rooted-tree.qza rooted-tree.qza

	qiime feature-table filter-samples --i-table ../table.qza \
	--o-filtered-table table.qza \
	--m-metadata-file sample_metadata.txt \
	--p-where "$HEADING='$GROUP1' OR $HEADING='$GROUP2' OR $HEADING='$GROUP3' OR $HEADING='$GROUP4'" \

	qiime feature-table summarize --i-table table.qza \
	--o-visualization table.qzv \
	--m-sample-metadata-file sample_metadata.txt


fi

echo "done"
