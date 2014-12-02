close all; clc;clear all;
load('q3-all.mat')
train_frac_array = [0.01 0.02 0.03 0.05 0.1 0.3 0.5 0.7 0.9 1];

[acc_nb, acc_reg] = nb_reg(data.X, data.Y, data.d, data.n, train_frac_array, 0.67);

figure, plot(train_frac_array, mean(acc_nb'));
title('Naive Bayes (accuracy v/s training fraction)');

figure, plot(train_frac_array, mean(acc_reg'));
title('Logistic Regression (accuracy v/s training fraction)');