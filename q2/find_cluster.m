function index = find_cluster(i, cluster_set, k)

for j = 1:k
    if (cluster_set(j,i)==1)
        index = j;
        break;
    end
end