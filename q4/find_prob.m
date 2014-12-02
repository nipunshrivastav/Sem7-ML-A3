function [g,d,i,l,s] = find_prob(data, count)

g = zeros(4,3);
d = zeros(2,1);
i = zeros(2,1);
l = zeros(3,2);
s = zeros(2,2);

for k = 1:count
    for j = 1:5
        cur_arr(j) = str2num(data{1,k}{1,1}{j,1});
    end
    
    d(cur_arr(1)+1,1) = d(cur_arr(1)+1,1) + 1;
    i(cur_arr(2)+1,1) = i(cur_arr(2)+1,1) + 1;
    
    g((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) = g((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) + 1;
    
    l(cur_arr(3),cur_arr(5)+1) = l(cur_arr(3),cur_arr(5)+1) + 1;
    
    s(cur_arr(2)+1,cur_arr(4)+1) = s(cur_arr(2)+1,cur_arr(4)+1) + 1;        
end