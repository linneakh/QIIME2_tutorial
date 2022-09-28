#!/bin/bash

cd ..

module load unsupported
module load donata/miniconda/3/3
source activate qiime2-2019.4

set -u

qiime taxa barplot \
  --i-table table.qza \
  --i-taxonomy 97_otu_taxonomy.qza \
  --m-metadata-file sample_metadata.txt \
  --o-visualization taxa-bar-plots.qzv

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 6 \
  --o-collapsed-table table-l6.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 5 \
  --o-collapsed-table table-l5.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 4 \
  --o-collapsed-table table-l4.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 3 \
  --o-collapsed-table table-l3.qza

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 2 \
  --o-collapsed-table table-l2.qza

qiime tools export \
	table-l6.qza \
	--output-dir exported-table-l6

qiime tools export \
        table-l5.qza \
        --output-dir exported-table-l5

qiime tools export \
        table-l4.qza \
        --output-dir exported-table-l4

qiime tools export \
        table-l3.qza \
        --output-dir exported-table-l3

qiime tools export \
        table-l2.qza \
        --output-dir exported-table-l2

qiime tools export \
	table.qza \
	--output-dir exported-table

biom convert -i exported-table/feature-table.biom -o exported-table/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l6/feature-table.biom -o exported-table-l6/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l5/feature-table.biom -o exported-table-l5/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l4/feature-table.biom -o exported-table-l4/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l3/feature-table.biom -o exported-table-l3/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l2/feature-table.biom -o exported-table-l2/feature-table.txt --table-type="OTU table" --to-tsv

#remove the first line and # from second line in feature-table.txt in order to combine 
#taxonomy with otu table
sed -i '1d' exported-table/feature-table.txt
sed 's/#//' exported-table/feature-table.txt > exported-table/feature-table.tmp && mv exported-table/feature-table.tmp exported-table/feature-table.txt



qiime metadata tabulate \
	--m-input-file exported-table/feature-table.txt \
	--m-input-file taxonomy.qza \
	--o-visualization table-tabulated-combined-otu-taxonomy.qzv	

mkdir taxonomy
mv tax*.qz* taxonomy/
mv table-* taxonomy/
mv exported* taxonomy/
mv gg* taxonomy/

echo done

