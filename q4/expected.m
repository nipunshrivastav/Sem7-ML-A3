function new_data = expected(data,g_prob,d_prob,i_prob,l_prob,s_prob, counter)

for m = 1:counter
    cur_arr(1,:) = data(m,:);
    for n = 1:5
        if (isnan(cur_arr(1,n)))
            cur_arr(1,n) = filler(g_prob,d_prob,i_prob,l_prob,s_prob,cur_arr, n);
            break;
        end
    end
    new_data(m,:) = cur_arr(1,:);
end