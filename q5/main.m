clear all; close all; clc;

%% Visualize

[data, avg_fc, m, n, rows, cols] = avg_face();
% you forgot to divide by the variance, but that we do for rescaling which
% i dnt think is required

%% PreProcessing

data_proc = pre_process(data, avg_fc);

% Sigma = data_proc;
Sigma = (data_proc'*data_proc) ./ m;
[U, S, V] = svd(Sigma);

%% Compressing data
% u is also n by n just like sigma if we want to reduce the data to k vectors
% we take first k columns of u which are a linear combination of the n dimensions
% so we will get k length long features



%% Eigenvectors as eigenfaces
for i = 1:5
    figure,imshow(mat2gray(reshape(V(:,i), rows, cols)));
%     pause
end

% z = U'x where z is the reduced vector for of x
% x has to nx1 and remember no x0 = 1

%% Variance retained
% S will be a diagonal matrix of nxn For given value of k,
% (sum(Sii for 1 to k),sum(Sii for 1 to n)) which gives the value of variance retained

%% Reconstruction
% if z is reduced vector for of some Xi then Xapprox = Ured * Z for each example
face_id = input('Enter the id of the face whose projected image you want to see on top 50 dimensions');
project(face_id, data_proc, U, 1, rows, cols);
