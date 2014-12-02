function res = filler(g_prob,d_prob,i_prob,l_prob,s_prob,cur_arr, n)

res = 10000;

if (n == 3)
    [val, ind] = max( g_prob((cur_arr(2)*2)+cur_arr(1)+1,:));
    res = ind;
    
elseif (n == 4)
    [val, ind] = max(s_prob(cur_arr(2)+1,:));
    res = ind-1;
    
elseif (n == 5)
    [val, ind] = max( l_prob(cur_arr(3),:));
    res = ind-1;
    
elseif (n==1)
    cur_arr(1) = 0;
    zero_prob = d_prob(cur_arr(1)+1,1) * i_prob(cur_arr(2)+1,1) * g_prob((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob(cur_arr(3),cur_arr(5)+1) * s_prob(cur_arr(2)+1,cur_arr(4)+1);
    cur_arr(1) = 1;
    one_prob = d_prob(cur_arr(1)+1,1) * i_prob(cur_arr(2)+1,1) * g_prob((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob(cur_arr(3),cur_arr(5)+1) * s_prob(cur_arr(2)+1,cur_arr(4)+1);
    if (zero_prob > one_prob)
        res = 0;
    elseif (zero_prob < one_prob)
        res = 1;
    else
        r = rand(1);
        if (r>0.5)
            res = 1;
        else
            res = 0;
        end
    end
    
elseif(n==2)
    cur_arr(2) = 0;
    zero_prob = d_prob(cur_arr(1)+1,1) * i_prob(cur_arr(2)+1,1) * g_prob((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob(cur_arr(3),cur_arr(5)+1) * s_prob(cur_arr(2)+1,cur_arr(4)+1);;
    cur_arr(2) = 1;
    one_prob = d_prob(cur_arr(1)+1,1) * i_prob(cur_arr(2)+1,1) * g_prob((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob(cur_arr(3),cur_arr(5)+1) * s_prob(cur_arr(2)+1,cur_arr(4)+1);;
    if (zero_prob > one_prob)
        res = 0;
    elseif (zero_prob < one_prob)
        res = 1;
    else
        r = rand(1);
        if (r>0.5)
            res = 1;
        else
            res = 0;
        end
    end
end