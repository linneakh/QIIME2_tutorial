# Qiime tools was created by Linnea Honeker (linneah@arizona.edu) in order to streamline QIIME2 analysis into modules of slurm or bash scripts. 
# They are intended to be run in the following order:

1. demultiplex.slurm
	- demultiplexes sequences

2. denoise-to-tree.slurm
	- performs dada2 seequence varient identification, aligns rep-seqs, makes phylogenetic tree

3. taxonomy.slurm
	- performs taxonomic identification, and exports feature-tables for each phylogenetic level

4. filter-mito.sh 
	- filteres out mitochondrial reads and unclassified bacteria sp. which are usually garbage

5. taxonomy-no-mito.sh 
	- redo taxonomy without the mitochondrial reads

6. diversity.sh 
	- alpha and beta diversity
	- single input is number to rarefy too

7. beta-group-significance.sh 

8. alpha-group-significance.sh

optional

9. filter.sh (choose which columns to filter out)

10. filter-keep.sh (choose which columns to keep)

11. picrust2.sh (predicts functional capacity)

12. denoise-merge-tree (merge two data sets then produce phylogenetic tree)

