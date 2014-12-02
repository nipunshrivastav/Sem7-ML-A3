function data_final = read_train(fileName,counter)

inputfile = fopen(fileName);

data_final = zeros(counter,5);

counter = 0;

while (1)
% Get a line from the input file
tline = fgetl(inputfile);
% Quit if end of file
if ~ischar(tline)
break
end

counter = counter+1;
data = textscan(tline,'%s');
for j = 1:5
    temp = str2num(data{1,1}{j,1});
    
    if (not(isempty(temp)))
        cur_arr(1,j) = temp;
    else
        cur_arr(1,j) = nan;
    end
end

data_final(counter,:) = cur_arr(1,:);
end
fclose(inputfile);