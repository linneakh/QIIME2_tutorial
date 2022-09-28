#!/bin/bash

module load anaconda/2022.05
source activate qiime2-2022.8
cd ..

set -u

#wget -O "gg-13-8-99-515-806-nb-classifier.qza" "https://data.qiime2.org/2018.4/common/gg-13-8-99-515-806-nb-classifier.qza"

#qiime feature-classifier classify-sklearn \
#  --i-classifier taxonomy/gg-13-8-99-515-806-nb-classifier.qza \
#  --i-reads rep-seqs.qza \
#  --o-classification taxonomy.qza

#qiime metadata tabulate \
#  --m-input-file taxonomy.qza \
#  --o-visualization taxonomy.qzv

qiime taxa barplot \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization filtered-mito/taxa-bar-plots.qzv

qiime taxa collapse \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 7 \
  --o-collapsed-table filtered-mito/table-l7.qza

qiime taxa collapse \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 6 \
  --o-collapsed-table filtered-mito/table-l6.qza

qiime taxa collapse \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 5 \
  --o-collapsed-table filtered-mito/table-l5.qza

qiime taxa collapse \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 4 \
  --o-collapsed-table filtered-mito/table-l4.qza

qiime taxa collapse \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 3 \
  --o-collapsed-table filtered-mito/table-l3.qza

qiime taxa collapse \
  --i-table filtered-mito/table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 2 \
  --o-collapsed-table filtered-mito/table-l2.qza

qiime tools export \
	--input-path filtered-mito/table-l7.qza \
	--output-path filtered-mito/exported-table-l7

qiime tools export \
	--input-path filtered-mito/table-l6.qza \
	--output-path filtered-mito/exported-table-l6

qiime tools export \
        --input-path filtered-mito/table-5.qza \
        --output-path filtered-mito/exported-table-l5

qiime tools export \
        --input-path filtered-mito/table-l4.qza \
        --output-path filtered-mito/exported-table-l4

qiime tools export \
        --input-path filtered-mito/table-l3.qza \
        --output-path filtered-mito/exported-table-l3

qiime tools export \
        --input-path filtered-mito/table-l2.qza \
        --output-path filtered-mito/exported-table-l2

qiime tools export \
	--input-path filtered-mito/table.qza \
	--output-path filtered-mito/exported-table

biom convert -i filtered-mito/exported-table/feature-table.biom -o filtered-mito/exported-table/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i filtered-mito/exported-table-l7/feature-table.biom -o filtered-mito/exported-table-l7/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i filtered-mito/exported-table-l6/feature-table.biom -o filtered-mito/exported-table-l6/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i filtered-mito/exported-table-l5/feature-table.biom -o filtered-mito/exported-table-l5/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i filtered-mito/exported-table-l4/feature-table.biom -o filtered-mito/exported-table-l4/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i filtered-mito/exported-table-l3/feature-table.biom -o filtered-mito/exported-table-l3/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i filtered-mito/exported-table-l2/feature-table.biom -o filtered-mito/exported-table-l2/feature-table.txt --table-type="OTU table" --to-tsv

qiime metadata tabulate \
	--m-input-file filtered-mito/exported-table/feature-table.txt \
	--m-input-file filtered-mito/taxonomy.qza \
	--o-visualization filtered-mito/table-tabulated-combined-otu-taxonomy.qzv	

mkdir filtered-mito/taxonomy-no-mito
mv tax*.qz* filtered-mito/taxonomy-no-mito/
mv table-* filtered-mito/taxonomy-no-mito/
mv exported* filtered-mito/taxonomy-no-mito/
mv gg* filtered-mito/taxonomy-no-mito/

echo done

