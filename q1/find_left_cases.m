function left_cases = find_left_cases(X, Y, left_cases, best_attr, value)

for i = 1:length(left_cases)
    if (left_cases(i))
        if (X(i,best_attr) == value)
            left_cases(i) = 1;
        else
            left_cases(i) = 0;
        end
    end
end