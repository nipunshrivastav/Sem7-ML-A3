function [probClass,probPerClass] = findProb(x, y, d, n)

probClass = [n-sum(y); sum(y)]/n;

probPerClass = zeros(2,d,max(max(x)));

for i = 1:n
    for j = 1:d
        probPerClass(y(i)+1,j,x(i,j)) = probPerClass(y(i)+1,j,x(i,j)) + 1;
    end
end

for i = 1:2
    for j = 1:d
        temp = 0;
        for k = 1:max(max(x))
            temp = temp + probPerClass(i,j,k);
        end
        sum_matrix(i,j) = temp;
    end
end

for i = 1:2
    for j = 1:d
        probPerClass(i,j,:) = probPerClass(i,j,:)/sum_matrix(i,j);
    end
end