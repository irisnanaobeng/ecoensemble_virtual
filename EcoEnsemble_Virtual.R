# EcoEnsemble and Remote Sensing Time Series: A Synthetic Forest Mammal and NDVI Example
# Author: Iris Nana Obeng
# Date: 23-04-2026

# Loading packages

library(EcoEnsemble)
library(ggplot2)
library(dplyr)


# Define time and species

set.seed(456)

years <- 2000:2050
n_years <- length(years)
time <- 1:n_years

species_names <- c("Deer", "Wolf", "Moose", "Black bear")
predator_names <- c("Deer", "Wolf", "Moose")


# Create synthetic true population trends

deer_truth <- 10 + 0.03 * time + sin(time / 8)
wolf_truth <- 10 + 0.4 * sin(time / 5)
moose_truth <- 12 - 0.04 * time + 0.5 * cos(time / 10)
bear_truth <- 11 + 0.01 * time - 0.4 * sin(time / 12)

true_pop <- cbind(deer_truth, wolf_truth, moose_truth, bear_truth)
colnames(true_pop) <- species_names


# Create observations (partial data)

obs_years <- 1:25
obs_labels <- as.character(years[obs_years])

mammal_obs <- true_pop[obs_years, ] +
  matrix(rnorm(length(obs_years) * 4, sd = 0.15),
         nrow = length(obs_years))

mammal_obs <- as.data.frame(mammal_obs)
colnames(mammal_obs) <- species_names
rownames(mammal_obs) <- obs_labels

Sigma_obs_mammals <- diag(rep(0.15^2, 4))
colnames(Sigma_obs_mammals) <- species_names
rownames(Sigma_obs_mammals) <- species_names


# Create distinct simulator outputs

sim_habitat <- cbind(
  deer_truth + 0.8,
  wolf_truth + 0.3,
  moose_truth + 0.5,
  bear_truth + 0.4
)

sim_climate <- cbind(
  deer_truth - 0.6 + seq(0, -1, length.out = n_years),
  wolf_truth - 0.2,
  moose_truth - 1.0 + seq(0, -0.8, length.out = n_years),
  bear_truth - 0.5
)

sim_population <- cbind(
  deer_truth + 0.1 * sin(time / 3),
  wolf_truth + 0.15 * cos(time / 4),
  moose_truth + 0.1 * sin(time / 6),
  bear_truth + 0.15 * cos(time / 5)
)

sim_predator <- cbind(
  deer_truth + 1.2 * sin(time / 7),
  wolf_truth + 0.8 * cos(time / 6),
  moose_truth - 0.7 * sin(time / 8)
)

# Add noise and format data

sim_habitat <- sim_habitat + matrix(rnorm(n_years * 4, 0, 0.15), n_years)
sim_climate <- sim_climate + matrix(rnorm(n_years * 4, 0, 0.15), n_years)
sim_population <- sim_population + matrix(rnorm(n_years * 4, 0, 0.10), n_years)
sim_predator <- sim_predator + matrix(rnorm(n_years * 3, 0, 0.20), n_years)

sim_habitat <- as.data.frame(sim_habitat)
sim_climate <- as.data.frame(sim_climate)
sim_population <- as.data.frame(sim_population)
sim_predator <- as.data.frame(sim_predator)

colnames(sim_habitat) <- species_names
colnames(sim_climate) <- species_names
colnames(sim_population) <- species_names
colnames(sim_predator) <- predator_names

rownames(sim_habitat) <- as.character(years)
rownames(sim_climate) <- as.character(years)
rownames(sim_population) <- as.character(years)
rownames(sim_predator) <- as.character(years)

Sigma_habitat <- diag(rep(0.12^2, 4))
Sigma_climate <- diag(rep(0.15^2, 4))
Sigma_population <- diag(rep(0.10^2, 4))
Sigma_predator <- diag(rep(0.13^2, 3))

colnames(Sigma_habitat) <- species_names
rownames(Sigma_habitat) <- species_names

colnames(Sigma_climate) <- species_names
rownames(Sigma_climate) <- species_names

colnames(Sigma_population) <- species_names
rownames(Sigma_population) <- species_names

colnames(Sigma_predator) <- predator_names
rownames(Sigma_predator) <- predator_names


# Define priors

priors_mammals <- EnsemblePrior(
  4,
  ind_st_params = IndSTPrior(
    "hierarchical",
    list(-3, 1, 8, 4),
    list(0.1, 0.1, 0.1, 0.1),
    AR_params = c(2, 2)
  ),
  ind_lt_params = IndLTPrior("lkj", list(1, 1), 1),
  sha_st_params = ShaSTPrior("lkj", list(1, 10), 1, AR_params = c(2, 2)),
  sha_lt_params = 5
)


# Figure 1: Prior predictive distribution

prior_fit <- prior_ensemble_model(
  priors = priors_mammals,
  M = 4,
  full_sample = TRUE
)

prior_samples <- sample_prior(
  observations = list(mammal_obs, Sigma_obs_mammals),
  simulators = list(
    list(sim_habitat, Sigma_habitat, "Habitat model"),
    list(sim_climate, Sigma_climate, "Climate model"),
    list(sim_population, Sigma_population, "Population model"),
    list(sim_predator, Sigma_predator, "Predator-prey model")
  ),
  priors = priors_mammals,
  sam_priors = prior_fit,
  num_samples = 1,
  full_sample = TRUE
)

png("Mammal_Figure1.png", width = 1400, height = 900, res = 150)
plot(prior_samples)
dev.off()


# Figure 2: Posterior predictive distribution

fit <- fit_ensemble_model(
  observations = list(mammal_obs, Sigma_obs_mammals),
  simulators = list(
    list(sim_habitat, Sigma_habitat, "Habitat model"),
    list(sim_climate, Sigma_climate, "Climate model"),
    list(sim_population, Sigma_population, "Population model"),
    list(sim_predator, Sigma_predator, "Predator-prey model")
  ),
  priors = priors_mammals,
  full_sample = TRUE,
  chains = 1,
  iter = 300,
  warmup = 150,
  cores = 1
)

samples <- generate_sample(fit, num_samples = 1)

png("Mammal_Figure2.png", width = 1400, height = 900, res = 150)
plot(samples)
dev.off()


# Remote sensing time series (simulated NDVI)

set.seed(123)

years_ndvi <- 2000:2020
time_ndvi <- 1:length(years_ndvi)

ndvi_data <- data.frame(
  Year = rep(years_ndvi, each = 10),
  NDVI = 0.5 +
    0.1 * sin(rep(time_ndvi, each = 10) / 3) +
    rnorm(length(years_ndvi) * 10, 0, 0.03)
)


# Summarise NDVI by year

ndvi_summary <- ndvi_data %>%
  group_by(Year) %>%
  summarise(
    mean_ndvi = mean(NDVI),
    sd_ndvi = sd(NDVI),
    n = n(),
    se = sd_ndvi / sqrt(n),
    lower_ci = mean_ndvi - 1.96 * se,
    upper_ci = mean_ndvi + 1.96 * se,
    .groups = "drop"
  )


# Plot NDVI time series

ndvi_plot <- ggplot(ndvi_summary, aes(x = Year, y = mean_ndvi)) +
  geom_ribbon(
    aes(ymin = lower_ci, ymax = upper_ci),
    fill = "darkgreen",
    alpha = 0.2
  ) +
  geom_line(color = "darkgreen", linewidth = 1.2) +
  geom_point(color = "darkgreen", size = 2.5) +
  labs(
    title = "Simulated NDVI Time Series with Confidence Intervals",
    x = "Year",
    y = "NDVI"
  ) +
  theme_minimal(base_size = 14)

print(ndvi_plot)

ggsave("NDVI_TimeSeries.png", ndvi_plot, width = 8, height = 5)


