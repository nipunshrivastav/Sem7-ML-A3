function res = findVal(tree,x, cur_index, depth, value)

if (depth == value)
    res = tree(cur_index+3);
else

    best_attr = tree(cur_index);
    new_index = 0;

    if (tree(cur_index+2)==1)
        res =  tree(cur_index+3);

    elseif(best_attr<0 && best_attr>length(x))
        res = tree(cur_index+3);
    else
        x_val = x(best_attr);
        if(x_val == 1)
            new_index =tree(cur_index+4);
        elseif (x_val == 1)
            new_index =tree(cur_index+5);
        elseif (x_val == -1)
            new_index =tree(cur_index+6);
        end

        if (new_index<=0)
            res = tree(cur_index+3);
        else
            res = findVal(tree,x, cur_index+new_index, depth+1, value);
        end
    end
end