function theta = reg(x, y, d)



m = size(y,1);
% fprintf('Number of Training examples: %d\n',m);

ext_x = cat(2,x,double(ones(m,1))); % adding column of 1 to x
n = d + 1; 
% Number of features
% fprintf('Number of features: %d\n',n);

theta = zeros(n,1); % initialising theta to zero


%% Logistic Gradient Descent Parameters

iteration = 0;s = 1;counter = 0;

eta = 0.00001;
threshold = 0.00001;

while (s>threshold)
    

    counter = counter+1; % Loop Count
    
    if(counter == 1)
        s = 10;
    else
        R_old = R_new;
    end
    % Updating R_old with the R_new of last loop
    % Special Condition for first loop
        
    
    h_theta = ext_x*theta;
    error = y - h_theta;
    % value of differentiation of J_theta without multiplied with x
    
    for k = 1:n
        theta(k) = theta(k) + eta*sum(error'*ext_x(:,k));
    end
    % updating thetas
    
    R_new = sum(error.*error);
    % updating R_new, which is J_theta with new theta obtained
    
    
    if(counter>1)
        s = abs(R_old - R_new);
    end

    
end