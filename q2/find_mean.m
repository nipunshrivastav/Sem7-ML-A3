function mean = find_mean(cluster_set, pixel_values, k, eg_num, pixel_count)

mean = zeros(k,pixel_count);

for i = 1:k
    sum_temp = zeros(1,pixel_count);
    counter = 0;
    for j = 1:eg_num
        if (cluster_set(i,j) == 0)
            continue;
        else
            counter = counter+1;
            sum_temp = sum_temp + pixel_values(j,:);
        end
    end
    mean(i,:) = sum_temp/counter;
end