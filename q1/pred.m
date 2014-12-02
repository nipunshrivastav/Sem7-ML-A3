function y = pred(tree, X, value)

for i = 1:length(X)
    temp = X(i,:);
    y(i) = findVal(tree,temp,1, 0, value);
end