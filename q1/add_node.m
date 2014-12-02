function res = add_node(X,Y,index, dom_class, child_y, child_n, child_u, depth)

res = zeros(1,8);
res(1,1) = index;
res(1,3) = 0;
res(1,4) = dom_class;
res(1,8) = depth;

cur_dist = 8;

if (not(length(child_y) > 0))
    res(1,5) = -1;
else
    res(1,5) = cur_dist;
    res = [res child_y];
    res(1,cur_dist+2) = -cur_dist-1;
end

cur_dist = cur_dist + length(child_y);

if (not(length(child_n) > 0))
    res(1,6) = -1;
else
    res(1,6) = cur_dist;
    res = [res child_n];
    res(1,cur_dist+2) = -cur_dist-1;
end

cur_dist = cur_dist + length(child_n);

if (not(length(child_u) > 0))
    res(1,7) = -1;    
else
    res(1,7) = cur_dist;
    res = [res child_u];
    res(1,cur_dist+2) = -cur_dist-1;
end
% 
% y_pred = pred(res, X);
% accuracy = find_acc(y_pred, Y)
% depth