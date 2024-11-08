rm(list = ls())
devtools::load_all(compile = FALSE) # load the package
df <- read.csv(here::here("data/fake_re_sample.csv"))
df$type <- as.factor(df$type)
df$geno <- as.factor(df$geno)

clutchs <- c(
  "clutch_start1", "clutch_end1", "clutch_size1",
  "clutch_start2", "clutch_end2", "clutch_size2"
)
dataLH <- lifelihoodData(
  df = df,
  sex = "sex",
  sex_start = "sex_start",
  sex_end = "sex_end",
  maturity_start = "mat_start",
  maturity_end = "mat_end",
  clutchs = clutchs,
  death_start = "mor_start",
  death_end = "mor_end",
  covariates = c("geno", "type"),
  model_specs = c("wei", "lgn", "wei")
)
results <- lifelihood(
  lifelihoodData = dataLF,
  path_config = here::here("config2.yaml")
)
summary(results)
results$effects





# aller chercher dnas results les formulas associées à chaque paramètre
# Predict de expt_death sur échelle lifelihood
m <- model.frame(~ geno * type, data = df)
Terms <- terms(m)
predicted <- model.matrix(Terms, m) %*% results$effects$estimation[1:6] # on prend les 6 premiers car ils concernent geno
pred_expdeath <- link(predicted, min_and_max = c(0.001, 40)) # original scale
# equivalent predict survival

# aller chercher dnas results les formulas associées à chaque paramètre
# Predict de survival_shape sur échelle lifelihood
# m <- model.frame(~ geno * type, data = df)
# Terms <- terms(m)
# predicted <- model.matrix(Terms, m) %*% results$effects$estimation[3:8] # on prend les 3 à 8 car ils concernent geno + type
# pred_survivalshape <- link(predicted, min_and_max = c(0.05, 500)) # original scale



library(survival)
# m <- lm((df$mor_start + df$mor_end) / 2 ~ df$geno)
df <- read.csv(here::here("data/fake_re_sample.csv"))
df$type <- as.factor(df$type)
df$geno <- as.factor(df$geno)
df$event <- rep(1, nrow(df))
df$geno_type <- as.factor(paste(df$geno, df$type, sep = "_"))
m <- survreg(Surv(
  time = mor_start,
  time2 = mor_end,
  event = event,
  type = "interval"
) ~ geno * type, dist = "weibull", data = df)
predict(m)

summary(m)
exp(m$coefficients)
survival::predict(m)

survival::predict.survreg

predict.lm



# si niveau de référence alors link de intercept,
# sinon intercept
link(results$effects$estimation, min_and_max = c(0.001, 40))
default_bounds_df(data)








plot_mortality_rate(
  results_lifelihood = results,
  newdata = df,
  covariates = c("geno", "type"),
  intervals = seq(0, 20, 5),
  use_log_x = TRUE,
  use_log_y = TRUE
)

stats::predict.glm
