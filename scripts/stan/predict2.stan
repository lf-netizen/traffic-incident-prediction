data {
    int<lower=0> N;
    array[N] real<lower=0, upper=100> humidity;
    array[N] real<lower=0, upper=100> humidity_pred;
    // array[N] real<lower=-30, upper=50> avg_temp;
    array[N] int<lower=0> accidents;
}

parameters {
    real<lower=0> a;
    // real b;
}

model {
    a ~ normal(0, 40);      // 82 is upper bound, 40 is good
    // b ~ normal(0, 40);
    for (i in 1:N) {
        accidents[i] ~ poisson(a*humidity[i]);
    }
}

generated quantities {
    array[N] int accidents_pred;
    for (i in 1:N) {
        accidents_pred[i] = poisson_rng(a*humidity_pred[i]);
    }
}