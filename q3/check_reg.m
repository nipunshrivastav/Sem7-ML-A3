function result = check_reg(theta, x, y, d)

correct = 0;
m = size(y,1);
% fprintf('Number of Testing examples: %d\n',m);

ext_x = cat(2,x,double(ones(m,1))); % adding column of 1 to x
n = d + 1;
h_theta = 1./(1 + exp(-ext_x*theta));

for i = 1:m    
    if ((h_theta(i) > 0.5) && (y(i)==1))
        correct = correct + 1;
    elseif ((h_theta(i) < 0.5) && (y(i)==0))
        correct = correct + 1;
    end
end

result = correct/m*100;