function best_attr = find_best_attr(X,Y,left_indices, left_cases)

error = 0;
counter = 0;

for i = 1:length(left_indices)
    if (left_indices(i))
        
        temp = find_error(X,Y,left_cases,i);
        counter = counter+1;
        
        if (counter > 1)
            if (temp<error)
                best_attr = i;
                error = temp;
            end
        else
            error = temp;
            best_attr = i;
        end
        
    end
end