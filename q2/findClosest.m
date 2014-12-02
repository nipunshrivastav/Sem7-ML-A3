function cluster_num = findClosest(i, mean, pixel_values, k)

min_dist = findDist(i, mean(1,:), pixel_values);
cluster_num = 1;

for j = 2:k
    temp_dist = findDist(i, mean(j,:), pixel_values);
    if (min_dist>temp_dist)
        cluster_num = j;
        min_dist = temp_dist;
    end
end