function [data, counter] = read_train0()

fileName = 'train-0.data';
inputfile = fopen(fileName);

counter = 0;

while (1)
% Get a line from the input file
tline = fgetl(inputfile);
% Quit if end of file
if ~ischar(tline)
break
end

counter = counter+1;

data{counter} = textscan(tline,'%s');
end
fclose(inputfile);