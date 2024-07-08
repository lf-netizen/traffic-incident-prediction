functions {
    // Difference between one-sided Gaussian tail probability and target probability
    vector tail_delta(vector y, vector theta, array[] real x_r, array[] int x_i) {
        vector[1] deltas;
        // Calculate the CDF at the threshold theta[1] and subtract the desired probability (0.99)
        deltas[1] = 2 * (normal_cdf(theta[1] | 0, exp(y[1])) - 0.5) - 0.99;
        return deltas;
    }
}

data {
    vector[1] y_guess;  // Initial guess of Gaussian standard deviation (log scale)
    vector[1] theta;    // Target quantile (e.g., 15)
}

transformed data {
    vector[1] y;
    array[0] real x_r;
    array[0] int x_i;

    real rel_tol = 1e-4;  // Relative tolerance
    real fun_tol = 1e-4;  // Function tolerance
    real max_num_steps = 1e9;  // Maximum number of steps

    // Find the Gaussian standard deviation that ensures 99% probability below theta[1]
    y = algebra_solver(tail_delta, y_guess, theta, x_r, x_i, rel_tol, fun_tol, max_num_steps);

    // Print the found standard deviation
    print("Standard deviation = ", exp(y[1]));
}

generated quantities {
    // Output the computed standard deviation
    real sigma = exp(y[1]);
}