#!/usr/bin/env

# Script to generate figure of CDFs
# 
# Example call:
# Rscript src/viz/plot_cdfs.R  "data/examples/phase1-targ-aggregated.csv" "reports/figures/example_cdfs.png"
# 
# Saves figure to 'reports/figures'

require(ggplot2)

# Read command-line args
# Args should be:
# input_dir: path to files of projections of cdfs from models
args <- commandArgs(trailingOnly=TRUE)


# Read input file and output dir
input_file <- args[1]
output_file <- args[2]

df_cdfs <- read.csv(input_file)

p <- ggplot(df_cdfs, aes(x = value, y = quantile, 
        group = model_name, colour = model_name)) + 
        geom_line() + 
        facet_grid(rows=vars(year)) + 
        theme_classic()+
        scale_colour_brewer(palette="Set1") +
    xlab("HIV incidence (per 100py)") +
    ylab("Cumulative distribution function")+
    theme(
        axis.text=element_text(size=12),
        axis.title=element_text(size=12),
        legend.text=element_text(size=16),
        legend.title=element_text(size=18),
        legend.position='top'
    )

ggsave(output_file, p, width = 12, height = 6)
