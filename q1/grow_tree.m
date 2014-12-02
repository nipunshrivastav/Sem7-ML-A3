function res = grow_tree(X,Y,no_egs,no_features, left_indices, left_cases, depth, acc_matrix1, testX, testY, acc_matrix2, validX, validY, acc_matrix3)

if (sum(sum(left_cases))==0)
    res = [];
else
    [all_state, dom_class] = check(Y, left_cases, no_egs);
    
    if (all_state == 1)
        res = [-1 0 1 dom_class -1 -1 -1 depth];
        
    else
        best_attr = find_best_attr(X,Y,left_indices, left_cases);
        left_indices(best_attr) = 0;

        left_cases_y = find_left_cases(X, Y, left_cases, best_attr, 1);
        left_cases_n = find_left_cases(X, Y, left_cases, best_attr, 0);
        left_cases_u = find_left_cases(X, Y, left_cases, best_attr, -1);

        res = add_node(X,Y,best_attr,dom_class, grow_tree(X,Y,no_egs,no_features, left_indices, left_cases_y, depth+1),grow_tree(X,Y,no_egs,no_features, left_indices, left_cases_n, depth+1),grow_tree(X,Y,no_egs,no_features, left_indices, left_cases_u, depth+1), depth);
    end
end