chmod 777 $TMP
indir=qiime2_tutorial
ls # load sequences
qiime tools import --type EMPSingleEndSequences --p-n-threads 32 --input-path /${indir}/emp-single-end-sequences --output-path /${indir}/emp-single-end-sequences.qza
# demultiplexing
qiime demux emp-single --i-seqs /${indir}/emp-single-end-sequences.qza --m-barcodes-file /${indir}/sample-metadata.tsv --m-barcodes-column BarcodeSequence --o-per-sample-sequences /${indir}/demux.qza --output-dir /${indir}/out_tmp
# summary
qiime demux summarize --i-data /${indir}/demux.qza --o-visualization /${indir}/demux.qzv --output-dir /${indir}/out_tmp2
# dada table
qiime dada2 denoise-single \
  --p-n-threads 32 \
  --i-demultiplexed-seqs /${indir}/demux.qza \
  --p-trim-left 0 \
  --p-trunc-len 120 \
  --o-representative-sequences /${indir}/rep-seqs-dada2.qza \
  --o-table /${indir}/table-dada2.qza \
  --o-denoising-stats /${indir}/stats-dada2.qza
# table summary 1
qiime metadata tabulate \
  --m-input-file /${indir}/stats-dada2.qza \
  --o-visualization /${indir}/stats-dada2.qzv
# rename
mv /${indir}/rep-seqs-dada2.qza /${indir}/rep-seqs.qza
mv /${indir}/table-dada2.qza /${indir}/table.qza
# table summary 2 
qiime feature-table summarize \
  --i-table /${indir}/table.qza \
  --o-visualization /${indir}/table.qzv \
  --m-sample-metadata-file /${indir}/sample-metadata.tsv
qiime feature-table tabulate-seqs \
  --i-data /${indir}/rep-seqs.qza \
  --o-visualization /${indir}/rep-seqs.qzv
# tree
qiime phylogeny align-to-tree-mafft-fasttree \
  --p-n-threads 32 \
  --i-sequences /${indir}/rep-seqs.qza \
  --o-alignment /${indir}/aligned-rep-seqs.qza \
  --o-masked-alignment /${indir}/masked-aligned-rep-seqs.qza \
  --o-tree /${indir}/unrooted-tree.qza \
  --o-rooted-tree /${indir}/rooted-tree.qza
# alpha/beta diversity
qiime diversity core-metrics-phylogenetic \
  --p-n-threads 32 \
  --i-phylogeny /${indir}/rooted-tree.qza \
  --i-table /${indir}/table.qza \
  --p-sampling-depth 1109 \
  --m-metadata-file /${indir}/sample-metadata.tsv \
  --output-dir /${indir}/core-metrics-results
# summary
#qiime diversity alpha-group-significance \
#  --i-alpha-diversity /${indir}/core-metrics-results/faith_pd_vector.qza \
#  --m-metadata-file /${indir}/sample-metadata.tsv \
#  --o-visualization /${indir}/core-metrics-results/faith-pd-group-significance.qzv

#qiime diversity alpha-group-significance \
#  --i-alpha-diversity /${indir}/core-metrics-results/evenness_vector.qza \
#  --m-metadata-file /${indir}/sample-metadata.tsv \
#  --o-visualization /${indir}/core-metrics-results/evenness-group-significance.qzv
# result 1
#qiime diversity beta-group-significance \
#  --i-distance-matrix /${indir}/core-metrics-results/unweighted_unifrac_distance_matrix.qza \
#  --m-metadata-file /${indir}/sample-metadata.tsv \
#  --m-metadata-column BodySite \
#  --o-visualization /${indir}/core-metrics-results/unweighted-unifrac-body-site-significance.qzv \
#  --p-pairwise
# result 2
#qiime diversity beta-group-significance \
#  --i-distance-matrix /${indir}/core-metrics-results/unweighted_unifrac_distance_matrix.qza \
#  --m-metadata-file /${indir}/sample-metadata.tsv \
#  --m-metadata-column Subject \
#  --o-visualization /${indir}/core-metrics-results/unweighted-unifrac-subject-group-significance.qzv \
#  --p-pairwise
# pcoa plot
qiime emperor plot \
  --i-pcoa /${indir}/core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file /${indir}/sample-metadata.tsv \
  --p-custom-axes DaysSinceExperimentStart \
  --o-visualization /${indir}/core-metrics-results/unweighted-unifrac-emperor-DaysSinceExperimentStart.qzv

qiime emperor plot \
  --i-pcoa /${indir}/core-metrics-results/bray_curtis_pcoa_results.qza \
  --m-metadata-file /${indir}/sample-metadata.tsv \
  --p-custom-axes DaysSinceExperimentStart \
  --o-visualization /${indir}/core-metrics-results/bray-curtis-emperor-DaysSinceExperimentStart.qzv

