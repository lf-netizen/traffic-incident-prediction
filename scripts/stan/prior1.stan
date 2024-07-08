data {
    int<lower=0> N;
    array[N] real<lower=0, upper=100> humidity;
}

generated quantities {
    real<lower=0> a = abs(normal_rng(0, 68));

    array[N] int<lower=0> accidents_pred;
    for (i in 1:N) {
        accidents_pred[i] = poisson_rng(a * humidity[i]);
    }
}