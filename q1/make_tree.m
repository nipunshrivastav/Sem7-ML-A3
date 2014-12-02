function res = make_tree(X, Y)

[no_egs, no_features] = size(X);

left_indices = ones(no_features,1);
left_cases = ones(no_egs,1);

depth = 1;

res = grow_tree(X,Y,no_egs,no_features, left_indices, left_cases, depth);