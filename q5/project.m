function project(face_id, data_proc, U, k, rows, cols)

x = data_proc(face_id,:)';
U_red = U(:,1:k);
x_red = U_red'*x;
x_app = U_red*x_red;
figure,imshow(mat2gray(reshape(x_app, rows, cols)));