function accuracy = find_acc(y_pred, Y)

correct = 0;

for i = 1: length(Y)
    if (Y(i) == y_pred(i))
        correct = correct+1;
    else
        i
    end
end

accuracy = correct/length(Y) * 100;