#!/usr/bin/env Rscript
#
# Collect file paths for sample.csv input
#
# -------------------------------------------------------------------------------------------------
library(data.table)


r1 <- list.files(
  path="/mnt/data/data_gc/20250713_immuno-analysis/data/00_fastq", 
  pattern="*_1.fastq.gz", 
  recursive=TRUE,
  full.names=TRUE
)

# Keep only RNA-seq
r1 <- r1[r1 %like% "RNA"]
r2 <- gsub("1.fastq.gz", "2.fastq.gz", r1)

samples <- data.table(read1=r1, read2=r2)

samples[, bioproject := regmatches(read1, regexpr("PRJNA[0-9]+", read1))]
samples[, run := regmatches(basename(read1), regexpr("SRR[0-9]+", basename(read1)))]
samples[, sample := regmatches(basename(read1), regexpr("GSM[0-9]+", basename(read1)))]

setcolorder(samples, c("bioproject", "sample", "run", "read1", "read2"))

# PRJNA694637 was mislabeled as paired-end data, remove read2 for this project
samples[bioproject == "PRJNA694637", read2 := NA]

# Create a separate samples sheet for each project
by_project <- split(samples, by="bioproject")

for (prj in names(by_project)) {
  fwrite(by_project[[prj]], paste0("scripts/", prj, "/samples.csv"))
}
