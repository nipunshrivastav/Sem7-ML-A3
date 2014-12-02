function result = check(x, y, d, probClass, probPerClass)


correct = 0;


for i = 1:length(y)
    total_prob = log(probClass);
    for j = 1:d
        total_prob = total_prob + log(probPerClass(:,j,x(i,j)));
    end
    [a, index] = max(total_prob);
    
    if ((index-1) == y(i))
        correct = correct+1;
    end
end

result = correct/length(y)*100;