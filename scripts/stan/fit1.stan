data {
    int<lower=0> N;
    array[N] real<lower=0, upper=100> humidity;
    array[N] int<lower=0> accidents;
}

parameters {
    real<lower=0> a;
}

model {
    a ~ normal(0, 68);
    for (i in 1:N) {
        accidents[i] ~ poisson(a * humidity[i]);
    }
}

generated quantities {
    array[N] int accidents_pred;
    array[N] real log_lik;
    for (i in 1:N) {
        log_lik[i] = poisson_lpmf(accidents[i] | a * humidity[i]);
        accidents_pred[i] = poisson_rng(a * humidity[i]);
    }
}