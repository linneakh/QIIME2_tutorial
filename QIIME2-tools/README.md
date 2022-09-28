# Qiime tools was created by Linnea Honeker (linneah@arizona.edu) in order to streamline QIIME2 analysis into modules of slurm or bash scripts. 
# They are intended to be run in the following order:

1. demultiplex.sh

2. denoise-to-tree.sh

3. taxonomy.sh

4. filter-mito.sh (filteres out mitochondrial reads and unclassified bacteria sp. which are usually garbage)

5. taxonomy-no-mito.sh (redo taxonomy without the mitochondrial reads)

6. diversity.sh (alpha and beta diversity)

7. beta-group-significance.sh 

8. alpha-group-significance.sh

optional

9. filter.sh (choose which columns to filter out)

10. filter-keep.sh (choose which columns to keep)

11. picrust2.sh (predicts functional capacity)

12. denoise-merge-tree (merge two data sets then produce phylogenetic tree)

