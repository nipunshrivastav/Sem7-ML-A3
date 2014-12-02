function [g_new,d_new,i_new,l_new,s_new] = find_prob_new(new_data, counter, g,d,i,l,s)

for k = 1:counter
    
    cur_arr(1,:) = new_data(k,:);
    
    d(cur_arr(1)+1,1) = d(cur_arr(1)+1,1) + 1;
    i(cur_arr(2)+1,1) = i(cur_arr(2)+1,1) + 1;
    
    g((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) = g((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) + 1;
    
    l(cur_arr(3),cur_arr(5)+1) = l(cur_arr(3),cur_arr(5)+1) + 1;
    
    s(cur_arr(2)+1,cur_arr(4)+1) = s(cur_arr(2)+1,cur_arr(4)+1) + 1;        
end

g_new = g;
d_new = d;
i_new = i;
l_new = l;
s_new = s;