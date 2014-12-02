function [res, resa, repeata] = find_labels(label, cluster_set, eg_num, k)

result = zeros(k);

repeata = 0;
for i = 1:k
    for j = 1:eg_num
        if(cluster_set(i,j)==1)
            result(i,label(j)) = result(i,label(j)) + 1;
        end
    end
end

res = zeros(k,3);

done = zeros(k,1);

for i = 1:k
    [res(i,2),res(i,1)] = max(result(i,:));
    res(i,3) = res(i,2)/sum(result(i,:))*100;
    res(i,4) = sum(result(i,:));
end

resa = res;

for i = 1:k
    done(res(i,1)) = done(res(i,1))+1;
end
missing = 0;
for i = 1:k
    if (done(i)==0)
        missing = i;
    end
    if (done(i)>1)
        repeat = i;
    end
end
if (missing>0)
    repeata = 1;
    cur_acc = 100;
    change_index = -1;

    for i = 1:k
        if (res(i,1)==repeat)
            if (cur_acc > res(i,3))
                cur_acc = res(i,3);
                change_index = i;
            end
        end
    end

    sum_row = sum(result(change_index,:));
    res(change_index,2) = result(change_index,missing);
    res(change_index,1) = missing;
    res(change_index,3) = res(change_index,2)/sum_row*100;
end