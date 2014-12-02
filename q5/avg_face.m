function [data, temp, m, n, rows, cols] = avg_face()

temp = double(imread('q5_data\face00001.pgm'));
siz = size(temp);
n = siz(1)*siz(2);

rows = siz(1); cols = siz(2);

temp = reshape(temp,1,n);

dirName = 'D:\IIT Sem7\ml\ass3\q5\q5_data';
D = dir(dirName); % check dir command, in matlab documentation

m = length(D)-2;

data = zeros(m,n);
data(1,:) = temp;
temp = temp/(m);


for (i=4:m+2) % for each file in the directory (1 and 2 are '.' and '..')
  if ( strcmp(D(i).name(end-3:end), '.pgm') == 1) % check if the extension of the current filename is '.pgm'
      data(i-2,:) = reshape((double(imread(D(i).name))),1,n);
%       size(temp)
%       size(data(:,:,i-2)/(no_faces-2))
     temp = temp + data(i-2,:)/m;
  end
end

figure, imshow(uint8(reshape(temp,siz(1),siz(2))));