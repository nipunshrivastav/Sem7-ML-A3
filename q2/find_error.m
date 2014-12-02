function res = find_error(mean, cluster_set, k, pixel_values, eg_num)

res = 0;

for i = 1:eg_num
    cluster_index = find_cluster(i, cluster_set, k);
    res = res+findDist(i, mean(cluster_index,:), pixel_values);
end