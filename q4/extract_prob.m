function [g_prob,d_prob,i_prob,l_prob,s_prob] = extract_prob(g,d,i,l,s)

sum_matrix_g = sum(g');

sum_matrix_l = sum(l');
sum_matrix_s = sum(s');

for p = 1:size(g,1)
    g_prob(p,:) = g(p,:)/sum_matrix_g(p);
end

d_prob = d/sum(d);

i_prob = i/sum(i);

for p = 1:size(l,1)
    l_prob(p,:) = l(p,:)/sum_matrix_l(p);
end

for p = 1:size(s,1)
    s_prob(p,:) = s(p,:)/sum_matrix_s(p);
end