clear; clc; close all;
% // republicans are 0 and democrats are represented by 1 and train_label
% // y is 1, n is 0 and ? is -1 in train_data

trainX = csvread('trainX.csv');
trainY = csvread('trainY.csv');
testX = csvread('testX.csv');
testY = csvread('testY.csv');
validX = csvread('validX.csv');
validY = csvread('validY.csv');

res_tree = make_tree(trainX, trainY);


for depth = 1:16
    y_pred = pred(res_tree, trainX,depth-1);
    accuracy(depth) = find_acc(y_pred, trainY);
    
    y_pred1 = pred(res_tree, testX,depth-1);
    accuracy1(depth) = find_acc(y_pred1, testY);
    
    y_pred2 = pred(res_tree, validX,depth-1);
    accuracy2(depth) = find_acc(y_pred2, validY);
end


figure;
hold on;
plot([100-accuracy' (100-accuracy1') (100-accuracy2')])
