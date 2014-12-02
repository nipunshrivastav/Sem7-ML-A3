function [acc_nb, acc_reg] = nb_reg(X, Y, dimension, no_of_egs, train_frac_array, main_frac)

acc_nb = zeros(length(train_frac_array),1);
acc_reg = zeros(length(train_frac_array),1);

siz = main_frac*no_of_egs;

for k = 1:5
    train_x = zeros(siz,dimension);train_y = zeros(siz,1);test_x = zeros(no_of_egs-siz,dimension);test_y = zeros(no_of_egs-siz,1);
    random_divide = randperm(no_of_egs);

    for j = 1:no_of_egs
        if(j>siz)
            test_x(j - siz,:) = X(random_divide(j),:);
            test_y(j - siz,:) = Y(random_divide(j),:);
        else
            train_x(j,:) = X(random_divide(j),:);
            train_y(j,:) = Y(random_divide(j),:);
        end
    end

    
    for i = 1:length(train_frac_array)

    
        [probClass,probPerClass] = findProb(train_x(1:train_frac_array(i)*siz,:), train_y(1:train_frac_array(i)*siz,:), dimension, train_frac_array(i)*siz);
        theta = reg(train_x(1:train_frac_array(i)*siz,:), train_y(1:train_frac_array(i)*siz,:), dimension);

        acc_nb(i,k) = check(test_x, test_y, dimension, probClass, probPerClass);
        acc_reg(i,k) =check_reg(theta, test_x, test_y, dimension);
    end
    
    clear test_x train_x test_y train_x;
    
end