## Bayesian approach to traffic incident prediction

This project focuses on developing a Bayesian model to predict traffic incident counts based on weather data. The objective was to generate monthly predictions at the voivodeship level in Poland.

You can find the final report in the `report.pdf` file or as an one-click reproducible notebook `report.ipynb`.


### Reproducibility

To reproduce our work, please follow the steps below:

1. Clone this repo.
2. Build a Docker image based on the provided Dockerfile.
3. Run the container with the `./data` dir mounted as volume at `/project/data`
4. Attach to the container and run `report.ipynb`

or using the Visual Studio Code Dev Containers extension:

1. Clone this repo.
2. Open the repo in VSCode.
3. Use the _Dev Containers: Rebuild and Reopen in Container_ command.
4. Run `report.ipynb`
