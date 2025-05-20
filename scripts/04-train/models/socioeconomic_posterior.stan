data {
    int<lower=0> N;  // number of observations
    int<lower=0> K;  // number of predictors
    matrix[N, K] X;  // design matrix
    array[N] int<lower=0> y;  // observed incident counts
    
    // Parameters that can be changed without recompilation
    real alpha_mean;  // Mean of the intercept prior
    real alpha_sd;    // SD of the intercept prior
    real beta_sd;     // SD of the coefficient priors
    real max_log_lambda; // Maximum log-rate to prevent overflow
}

parameters {
    vector[K] beta;  // Coefficients for predictors
    real alpha;      // Intercept
}

model {
    // Priors
    alpha ~ normal(alpha_mean, alpha_sd);
    for (k in 1:K)
        beta[k] ~ normal(0, beta_sd);
    
    // Likelihood
    for (n in 1:N) {
        real linear_pred = alpha + dot_product(X[n], beta);
        linear_pred = fmin(linear_pred, max_log_lambda);
        y[n] ~ poisson_log(linear_pred);
    }
}

generated quantities {
    array[N] int y_rep;  // posterior predictive replications
    vector[N] log_lik;   // log-likelihood for model comparison
    
    for (n in 1:N) {
        real linear_pred = alpha + dot_product(X[n], beta);
        linear_pred = fmin(linear_pred, max_log_lambda);
        
        y_rep[n] = poisson_log_rng(linear_pred);
        log_lik[n] = poisson_log_lpmf(y[n] | linear_pred);
    }
}