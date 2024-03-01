# Last mile project: analysis scripts

Repository to house code for analysing and visualising data for the project 'Modelling to achieve the greatest and most durable reduction in HIV incidence in high burden settings'.  

## Set up

Requires R version 4.1.3 with packages [CombineDistributions](https://github.com/eahowerton/CombineDistributions), and `ggplot2`.

## Submission guidelines

Submissions are via pull requests with data submitted to the folder [`data/submissions`](data/submissions).  

Teams are requested to: 

1. Make a fork of this repository
2. Create a subfolder within `data/submission` of the team name (no spaces, 30 characters, only letters, numbers and underscore).
3. Commit CSV files of the form described below and make a pull request.

For phase 1 the following files are requested:


**Trajectories**
`phase1-traj-modelname.csv`: A file of trajectories of impact from 2020 to 2040 (where `modelname` is the model abbreviation from model metadata below).  The file will have the following columns: 

- `projection_date`: Date on which the projections were made by the modelling team (e.g. today), in the format `YYYY-MM-DD`.
- `model_name`: Name of the model making the projections (can use the `model_abbreviation` below instead).
- `year`: The year of the projection (should run from 2020 to 2040).
- `scenario_name`: Name of the scenario, to be decided with modelling teams during country consultations (e.g. `statusquo`).
- `trajectory_id`: An ID for the trajectory, from 1 to 100.
- `country_iso3`: ISO 3 code country name (e.g. `KEN` for Kenya).
- `target`: The target metric being projected, e.g. `hiv_incidence`.
- `value`: The value of the model projection.


**Target metrics in specific years**
`phase1-targ-modelname.csv`: A file of targets of impact and cost in years 2023, 2030 and 2040.  The file will have the following columns: 

- `projection_date`: Date on which the projections were made by the modelling team (e.g. today), in the format `YYYY-MM-DD`.
- `model_name`: Name of the model making the projections (can use the `model_abbreviation` below instead).
- `year`: The year of the projection (there should be values for 2023, 2030, and 2040).
- `scenario`: Name of the scenario, to be decided with modelling teams during country consultations (e.g. `statusquo`).
- `quantile`: Quantiles of the target metric being projected, with 23 quantiles: 0.01, 0.025, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 0.975, 0.99.
- `country_iso3`: ISO 3 code country name (e.g. `KEN` for Kenya).
- `target`: The target metric being projected, e.g. `hiv_incidence`.
- `value`: The value of the model projection for the target, quantile, country and year in question.

Example data are provided in `data/examples`.

**Sensitivity analysis**

A sensitivity analysis for priority scale-up scenarios is requested, with file format to be decided after finalising priority scale-up scenarios for specific interventions.  


**Model metadata**

Modelling teams are requested to submit a yaml file in the same subfolder with the following fields filled:

- `modelling_group_name`: Modelling group name
- `model_name`:	Model name
- `model_abbreviation`:	An abbreviation for the model to be displayed on figures and tables (and used as subfolder name), only numbers/letters/underscore, 30 characters max
- `model_version:`	Version of the model used for the projections.  If the model has no versioning then use the current date (YYYY-MM-DD).
- `model_contributors`:	A list of model contributors
-`model_website`:	URL of the model (may be different to the source code URL)
- `model_code_url`:	URL of the model source code, if available
- `model_license`:	Licence of the model and URL of license
- `model_calibration`:	Short description of the calibration method used with the model
- `data_sources`:	Short description of input data sources used for model calibration and parameterisation
- `methods`:	Short description of the model and key assumptions
- `citation`:	Citation for the model


## Analysis

This repository contains basic scripts for aggregating forecasts from models and plotting results.  

1. Aggregate forecasts from 3 models (mock data in `data/examples`):

```
Rscript src/viz/combine_cdfs.R \
	"data/examples" \
	"data/examples/phase1-targ-aggregated.csv"
```

2. Plot forecasts from 3 models and ensemble/aggregate:

```
Rscript src/viz/plot_cdfs.R \
	"data/examples/phase1-targ-aggregated.csv" \
	"reports/figures/example_cdfs.png"
```

3. Plot 100 forecast trajectories from 3 models:

```
Rscript src/viz/plot_trajectories.R \
	"data/examples" \
	"reports/figures/example_trajectories.png"
```

## Acknowledgements

This repository follows similar approaches of other multi-model hubs, such as the [COVID-19 Scenario Modelling Hub](https://github.com/midas-network/covid19-scenario-modeling-hub) and [covidHubUtils](https://github.com/reichlab/covidHubUtils/).  

