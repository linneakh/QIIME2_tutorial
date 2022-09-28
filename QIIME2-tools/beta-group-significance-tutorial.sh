#!/bin/bash

module load anaconda/2022.05
source activate qiime2-2022.8

set -u

if [[ $# -lt 2 ]]; then
        printf "Usage: %s filepath category\n" $0
        exit 1
fi


FILEPATH=$1
GROUP=$2
cd ..
mkdir $FILEPATH/bd-group-significance/

qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/unweighted_unifrac_distance_matrix.qza --m-metadata-file sample-metadata.tsv --m-metadata-column $GROUP --o-visualization $FILEPATH/bd-group-significance/unweighted-unifrac-$GROUP-sig.qzv --p-pairwise
qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/weighted_unifrac_distance_matrix.qza --m-metadata-file sample-metadata.tsv --m-metadata-column $GROUP --o-visualization $FILEPATH/bd-group-significance/weighted-unifrac-$GROUP-sig.qzv --p-pairwise
qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/jaccard_distance_matrix.qza --m-metadata-file sample-metadata.tsv --m-metadata-column $GROUP --o-visualization $FILEPATH/bd-group-significance/jaccard-$GROUP-sig.qzv --p-pairwise
qiime diversity beta-group-significance --i-distance-matrix $FILEPATH/bray_curtis_distance_matrix.qza --m-metadata-file sample-metadata.tsv --m-metadata-column $GROUP --o-visualization $FILEPATH/bd-group-significance/bray-curtis-distance-$GROUP-sig --p-pairwise

echo done


