# EcoEnsemble with Synthetic Forest Mammal Populations

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

---

## Outputs

| Figure               | Description                       |
| -------------------- | --------------------------------- |
| `Mammal_Figure1.png` | Prior predictive distribution     |
| `Mammal_Figure2.png` | Posterior predictive distribution |

---

## ⚙️ Project Structure

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


##  Author

**Iris Nana Obeng**


## Acknowledgements

* EcoEnsemble R package
* Bayesian modeling framework (Stan)



##  Future Extensions

* Apply EcoEnsemble to **real ecological datasets**
* Compare performance across different ecosystems
* Extend to **climate or epidemiological models**

