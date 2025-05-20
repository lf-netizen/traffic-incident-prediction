data {
    int<lower=0> N;  // number of observations
    int<lower=0> K;  // number of predictors
    matrix[N, K] X;  // design matrix
    
    // Parameters that can be changed without recompilation
    real alpha_mean;  // Mean of the intercept prior
    real alpha_sd;    // SD of the intercept prior
    real beta_sd;     // SD of the coefficient priors
    real max_log_lambda; // Maximum log-rate to prevent overflow
}

generated quantities {
    // Priors for coefficients
    vector[K] beta;
    real alpha;
    
    // Generate beta coefficients from prior
    for (k in 1:K) {
        beta[k] = normal_rng(0, beta_sd);
    }
    
    // Generate intercept from prior
    alpha = normal_rng(alpha_mean, alpha_sd);
    
    // Generate predicted counts
    array[N] int y_prior;
    
    for (n in 1:N) {
        // Constrain linear predictor to prevent overflow
        real log_lambda = alpha + dot_product(X[n], beta);
        // Clamp to avoid numerical issues
        log_lambda = fmin(log_lambda, max_log_lambda);
        
        // Use poisson_log_rng directly with the log rate
        y_prior[n] = poisson_log_rng(log_lambda);
    }
}