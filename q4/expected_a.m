function [g,d,i,l,s]  = expected_a(data,g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new, counter)

g = zeros(4,3);
d = zeros(2,1);
i = zeros(2,1);
l = zeros(3,2);
s = zeros(2,2);

n = 0;
for k = 1:counter
    
    cur_arr(1,:) = data(k,:);
    
    if (sum(sum(isnan(cur_arr(1,:))))>0)
        
     for n = 1:5
        if (isnan(cur_arr(1,n)))
            
            break;
        end
     end
    

    
    
if (n == 3)
     g((cur_arr(2)*2)+cur_arr(1)+1,:) = g((cur_arr(2)*2)+cur_arr(1)+1,:)+( g_prob_new((cur_arr(2)*2)+cur_arr(1)+1,:));
    
elseif (n == 4)
     s(cur_arr(2)+1,:) = s(cur_arr(2)+1,:) + s_prob_new(cur_arr(2)+1,:);
    
    
elseif (n == 5)
    l(cur_arr(3),:) = l(cur_arr(3),:)+l_prob_new(cur_arr(3),:);
    
    
elseif (n==1)
    cur_arr(1) = 0;
    zero_prob = d_prob_new(cur_arr(1)+1,1) * i_prob_new(cur_arr(2)+1,1) * g_prob_new((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob_new(cur_arr(3),cur_arr(5)+1) * s_prob_new(cur_arr(2)+1,cur_arr(4)+1);
    cur_arr(1) = 1;
    one_prob = d_prob_new(cur_arr(1)+1,1) * i_prob_new(cur_arr(2)+1,1) * g_prob_new((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob_new(cur_arr(3),cur_arr(5)+1) * s_prob_new(cur_arr(2)+1,cur_arr(4)+1);
    
    denominator = zero_prob+one_prob;
    
    d(1) = d(1) + zero_prob/denominator;
    d(2) = d(2) + one_prob/denominator;
    
elseif(n==2)
    cur_arr(2) = 0;
    zero_prob = d_prob_new(cur_arr(1)+1,1) * i_prob_new(cur_arr(2)+1,1) * g_prob_new((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob_new(cur_arr(3),cur_arr(5)+1) * s_prob_new(cur_arr(2)+1,cur_arr(4)+1);
    cur_arr(2) = 1;
    one_prob = d_prob_new(cur_arr(1)+1,1) * i_prob_new(cur_arr(2)+1,1) * g_prob_new((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)) * l_prob_new(cur_arr(3),cur_arr(5)+1) * s_prob_new(cur_arr(2)+1,cur_arr(4)+1);
    
    denominator = zero_prob+one_prob;
    
    i(1) = i(1) + zero_prob/denominator;
    i(2) = i(2) + one_prob/denominator;
end
     
    end
        
end