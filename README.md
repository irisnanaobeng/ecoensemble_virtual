# EcoEnsemble and Remote Sensing Time Series
A Synthetic Forest Mammal and NDVI Example

This project demonstrates how the **EcoEnsemble R package** can be used to combine multiple ecosystem model outputs into a single, uncertainty-aware prediction.

Instead of relying on a single model, EcoEnsemble integrates:

* observed data
* multiple simulator outputs
* prior assumptions

to produce a robust **ensemble prediction**.


##  Overview

We simulate population dynamics for four forest mammals:

* Deer
* Wolf
* Moose
* Black bear

Using four different ecological simulators:

* Habitat model
* Climate model
* Population model
* Predator-prey model

Each simulator represents a different ecological assumption, and EcoEnsemble combines them into one unified prediction.



##  What This Project Shows

This project illustrates:

* How to **generate synthetic ecological data**
* How to **define priors** in EcoEnsemble
* How to run:

  * **Prior predictive analysis**
  * **Posterior predictive analysis**
* How combining models **reduces uncertainty**



## Key Results

###  Figure 1: Prior Predictive Distribution

* Shows model behavior **before learning from data**
* High uncertainty
* Wide prediction bands

###  Figure 2: Posterior Predictive Distribution

* Shows model behavior **after incorporating observations**
* Reduced uncertainty
* More refined predictions



## Project Structure

```
├── EcoEnsemble_Mammals.R      # Main R script
├── Mammal_Figure1.png         # Prior predictive plot
├── Mammal_Figure2.png         # Posterior predictive plot
├── EcoEnsemble_Mammals.Rmd    # Full markdown analysis
└── README.md                  # Project overview
```




3. Output figures will be saved as:

* `Mammal_Figure1.png`
* `Mammal_Figure2.png`

Outputs
Figure 1 (Prior Predictive)
Shows model behavior before observing data → high uncertainty
Figure 2 (Posterior Predictive)
Shows fitted model after incorporating observations → reduced uncertainty

Key idea:
Learning from data reduces uncertainty and improves predictions.

##  About the Data

The data used in this project are **synthetic (simulated)** and created to:

* demonstrate the EcoEnsemble workflow
* illustrate model behavior clearly
* allow controlled comparison between models


##  Key Concepts

* Ensemble modeling
* Bayesian inference
* Prior vs posterior predictive distributions
* Uncertainty quantification


Remote Sensing Time Series (NDVI)

The second part of the project simulates a Normalized Difference Vegetation Index (NDVI) time series.

NDVI is a commonly used satellite-derived measure of vegetation health.

This project demonstrates two complementary approaches to analyzing ecological time-series data:

EcoEnsemble – a model-based approach that combines multiple ecosystem simulators with observed data to produce ensemble predictions with uncertainty.

Remote Sensing Time Series (NDVI) – a simple, data-driven approach that visualizes trends and uncertainty directly using statistical summaries.


What the plot shows
Line → mean NDVI over time
Points → yearly estimates
Shaded ribbon → 95% confidence interval

Key idea:
Trends and uncertainty can be visualized directly without complex models.

Conclusion

This project demonstrates that:

Complex models like EcoEnsemble provide powerful tools for combining multiple sources of information and making predictions.
Simple time-series visualizations, such as NDVI plots, offer intuitive insights into trends and variability.

Author
Iris Nana Obeng
Global Change Ecology Student


