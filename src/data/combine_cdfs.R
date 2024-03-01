#!/usr/bin/env

# Script to aggregate CDFs from multiple models
# 
# Example call:
# Rscript src/viz/combine_cdfs.R "data/examples" "data/examples/phase1-targ-aggregated.csv"
# 
# Saves all results, including ensemble/aggregate to the specified output file

require(data.table)
require(CombineDistributions)

quantiles <- c(0.01, 0.025, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 
                0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 
                0.75, 0.8, 0.85, 0.9, 0.95, 0.975, 0.99)

# Read command-line args
# Args should be:
# input_dir: path to files of projections of cdfs from models
args <- commandArgs(trailingOnly=TRUE)

# Read files in input dir
input_dir <- args[1]
output_file <- args[2]


# Find files matching template name
files <- Sys.glob(paste0(input_dir, '/phase1-targ-*.csv'))

# Read files as CSV
list_files <- lapply(files, read.csv)
df_targ <- do.call(rbind, list_files)

# Aggregate the different model results
cdfs <- aggregate_cdfs(df_targ, 
    id_var = "model_name", 
    group_by = c("year", "country_iso3", "target", "scenario"), 
    method = "LOP", 
    ret_quantiles = quantiles)

# Add metadata to the ensemble projection
cdfs$projection_date <- Sys.Date()
cdfs$model_name <- "ensemble"
cdfs <- data.frame(cdfs)
cdfs <- cdfs[,colnames(df_targ)]
df_targ <- rbind(df_targ, cdfs)

# Write to file
write.csv(df_targ, output_file, row.names=F)
