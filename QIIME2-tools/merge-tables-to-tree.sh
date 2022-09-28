#!/bin/bash

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.10

cd ../

qiime feature-table merge --i-tables table-1.qza --i-tables table-2.qza --o-merged-table table.qza
qiime feature-table merge-seqs --i-data rep-seqs-1.qza --i-data rep-seqs-2.qza --o-merged-data rep-seqs.qza

qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file sample-metadata.txt
qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv


qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file sample_metadata.txt
qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv
qiime alignment mafft --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza
qiime alignment mask --i-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza
qiime phylogeny fasttree --i-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza
qiime phylogeny midpoint-root --i-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza
