#!/usr/bin/env Rscript
#
# Import and save rmskProfiler imported quants
#
# Usage:
# importQuants.R /path/to/quants /path/to/outdir
# ------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))

args <- commandArgs(trailingOnly=TRUE)

se <- rmskProfiler::importQuants(
  quant_dir = args[[1]], 
  resource_dir = "/home/gennaro/data/references/GRCh38/rmskProfiler/hg38-resources_v48"
)

outfile <- file.path(args[[2]], "se.rds")

saveRDS(se, outfile)
