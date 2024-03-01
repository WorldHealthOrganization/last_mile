#!/usr/bin/env

# Script to generate figure of model trajectories
# 
# Example call:
# Rscript src/viz/plot_trajectories.R "data/examples" "reports/figures/example_trajectories.png"
# 
# Saves figure to 'reports/figures'

require(ggplot2)

# Read command-line args
# Args should be:
# input_dir: path to files of projections of trajectories from models
args <- commandArgs(trailingOnly=TRUE)


# Read files in input dir
input_dir <- args[1]
output_file <- args[2]

# Find files matching template name
files <- Sys.glob(paste0(input_dir, '/phase1-traj-*.csv'))

# Read files as CSV
list_files <- lapply(files, read.csv)
df_traj <- do.call(rbind, list_files)

# Plot output
p <- ggplot(df_traj, aes(x = year, y = value, 
    group = interaction(trajectory_id, model_name))) + 
    geom_line(aes(colour = model_name), alpha = 0.3) +
    theme_classic() + 
    xlab("Year")+
    ylab("HIV incidence (per 100py)") + 
    scale_colour_brewer(palette = "Set1") + 
        theme(
        axis.text=element_text(size=12),
        axis.title=element_text(size=16),
        legend.text=element_text(size=16),
        legend.title=element_text(size=18),
        legend.position='top'
    )
ggsave(output_file, p, width = 12, height = 6)
