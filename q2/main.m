clear all; clc; close all;

%% Reading data
[pixels, pixel_values, eg_num, pixel_count] = read_data();
label = read_label();


%% Visualizing data
eg_index = input('eg_index. ');
visualize(eg_index,pixel_values(eg_index,:),pixels, pixel_count);

%% Clustering

    k = 4;
    repeat = 1;
while (repeat)    
    mean_index = randperm(eg_num, k);
    cluster_set = zeros(k,eg_num);

    for i = 1:k
        mean(i,:) = pixel_values(mean_index(i),:);
    end


    change_error = 10;counter = 0;
    error_old = 0;

    while (change_error>-0.001)
        if (counter>0)
            error_old = error_new;
        else
            error_old = -100;
        end

        counter = counter+1;
        cluster_set = zeros(k,eg_num);

        for i = 1:eg_num
            cluster_num = findClosest(i, mean, pixel_values, k);
            cluster_set(cluster_num, i) = 1;
        end

        mean = find_mean(cluster_set, pixel_values, k, eg_num, pixel_count);

        error_new = find_error(mean, cluster_set, k, pixel_values, eg_num);
        error_matrix(counter) = error_new;
        change_error = abs(error_new - error_old);
        
        [final_label, final_labela, repeat] = find_labels(label, cluster_set, eg_num, k);
        missclassify_matrix(counter) = 0;
        for m = 1:k
            missclassify_matrix(counter) = missclassify_matrix(counter) + final_label(m,4) - final_label(m,2);
        end

        if(counter>30)
            break;
        end
    end


    %% Verification

    [final_label, final_labela, repeat] = find_labels(label, cluster_set, eg_num, k);
end   
sum(final_label(:,3))/k

figure, plot(1:length(error_matrix),error_matrix);
title('Error v/s iterations');
figure, plot(1:length(missclassify_matrix),missclassify_matrix);
title('MissClassify v/s iterations');