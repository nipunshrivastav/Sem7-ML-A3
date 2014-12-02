function [g,d,i,l,s] = find_prob_a(data, count)

g = zeros(4,3);
d = zeros(2,1);
i = zeros(2,1);
l = zeros(3,2);
s = zeros(2,2);

for k = 1:count
    
    cur_arr(1,:) = data(k,:);
    
    if (sum(sum(isnan(cur_arr(1,:))))>0)
        continue;
    end
        
    
    d(cur_arr(1)+1,1) = d(cur_arr(1)+1,1) + 1;
    
    i(cur_arr(2)+1,1) = i(cur_arr(2)+1,1) + 1;
    
    g((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) = g((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) + 1;
    
    l(cur_arr(3),cur_arr(5)+1) = l(cur_arr(3),cur_arr(5)+1) + 1;
    
    s(cur_arr(2)+1,cur_arr(4)+1) = s(cur_arr(2)+1,cur_arr(4)+1) + 1;        
end