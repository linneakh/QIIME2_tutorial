#!/bin/bash
#################SBATCH job######################
#SBATCH --job-name=Taxonomy
#SBATCH --ntasks=28
#SBATCH --nodes=1
#SBATCH --mem=100gb
#SBATCH --time=10:00:00
#SBATCH --partition=standard
#SBATCH --account=laurameredith
#SBATCH --mail-user=linneah@hpc.arizona.edu
##################################################

#############load programs here####################
module load anaconda/2022.05
source activate qiime2-2022.8
##################################################

#############set directory here####################
cd ~/qiime2-atacama-tutorial/
###################################################

############enter script here#####################
set -u

wget -O "gg-13-8-99-515-806-nb-classifier.qza" "https://data.qiime2.org/2022.8/common/gg-13-8-99-515-806-nb-classifier.qza"

qiime feature-classifier classify-sklearn \
  --i-classifier gg-13-8-99-515-806-nb-classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

qiime taxa barplot \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization taxa-bar-plots.qzv

qiime taxa collapse \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-level 7 \
  --o-collapsed-table table-l7.qza

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
	--input-path table-l7.qza \
	--output-path exported-table-l7

qiime tools export \
	--input-path table-l6.qza \
	--output-path exported-table-l6

qiime tools export \
        --input-path table-l5.qza \
        --output-path exported-table-l5

qiime tools export \
        --input-path table-l4.qza \
        --output-path exported-table-l4

qiime tools export \
        --input-path table-l3.qza \
        --output-path exported-table-l3

qiime tools export \
        --input-path table-l2.qza \
        --output-path exported-table-l2

qiime tools export \
	--input-path table.qza \
	--output-path exported-table

biom convert -i exported-table/feature-table.biom -o exported-table/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l7/feature-table.biom -o exported-table-l7/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l6/feature-table.biom -o exported-table-l6/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l5/feature-table.biom -o exported-table-l5/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l4/feature-table.biom -o exported-table-l4/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l3/feature-table.biom -o exported-table-l3/feature-table.txt --table-type="OTU table" --to-tsv
biom convert -i exported-table-l2/feature-table.biom -o exported-table-l2/feature-table.txt --table-type="OTU table" --to-tsv

#remove the first line and # from second line in feature-table.txt in order to combine 
#taxonomy with otu table and for stamp
sed -i '1d' exported-table/feature-table.txt
sed 's/#//' exported-table/feature-table.txt > exported-table/feature-table.tmp && mv exported-table/feature-table.tmp exported-table/feature-table.txt

sed -i '1d' exported-table-l7/feature-table.txt
sed 's/#//' exported-table-l7/feature-table.txt > exported-table-l7/feature-table.tmp && mv exported-table-l7/feature-table.tmp exported-table-l7/feature-table.txt

sed -i '1d' exported-table-l6/feature-table.txt
sed 's/#//' exported-table-l6/feature-table.txt > exported-table-l6/feature-table.tmp && mv exported-table-l6/feature-table.tmp exported-table-l6/feature-table.txt

sed -i '1d' exported-table-l5/feature-table.txt
sed 's/#//' exported-table-l5/feature-table.txt > exported-table-l5/feature-table.tmp && mv exported-table-l5/feature-table.tmp exported-table-l5/feature-table.txt

sed -i '1d' exported-table-l4/feature-table.txt
sed 's/#//' exported-table-l4/feature-table.txt > exported-table-l4/feature-table.tmp && mv exported-table-l4/feature-table.tmp exported-table-l4/feature-table.txt

sed -i '1d' exported-table-l3/feature-table.txt
sed 's/#//' exported-table-l3/feature-table.txt > exported-table-l3/feature-table.tmp && mv exported-table-l3/feature-table.tmp exported-table-l3/feature-table.txt

sed -i '1d' exported-table-l2/feature-table.txt
sed 's/#//' exported-table-l2/feature-table.txt > exported-table-l2/feature-table.tmp && mv exported-table-l2/feature-table.tmp exported-table-l2/feature-table.txt

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

