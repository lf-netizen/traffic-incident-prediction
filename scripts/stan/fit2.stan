data {
    int<lower=0> N;
    array[N] real<lower=0, upper=100> humidity;
    array[N] real temperature;
    array[N] int<lower=0> accidents;
}

parameters {
    real a;
    real b;
    real c;
}

model {
    a ~ normal(0, 68);
    b ~ normal(0, 680);
    c ~ normal(2000, 1000);
    for (i in 1:N) {
        accidents[i] ~ poisson(abs(a * humidity[i] + b * temperature[i] + c));
    }
}

generated quantities {
    array[N] int accidents_pred;
    array[N] real log_lik;
    for (i in 1:N) {
        log_lik[i] = poisson_lpmf(accidents[i] | abs(a * humidity[i] + b * temperature[i] + c));
        accidents_pred[i] = poisson_rng(abs(a * humidity[i] + b * temperature[i] + c));
    }
}