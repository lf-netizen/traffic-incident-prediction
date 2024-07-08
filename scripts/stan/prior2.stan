data {
    int<lower=0> N;
    array[N] real<lower=0, upper=100> humidity;
    array[N] real temperature;
}

generated quantities {
    real a = normal_rng(0, 68);
    real b = normal_rng(0, 680);
    real c = normal_rng(2000, 1000);

    array[N] int<lower=0> accidents_pred;
    for (i in 1:N) {
        accidents_pred[i] = poisson_rng(abs(a * humidity[i] + b * temperature[i] + c));
    }
}