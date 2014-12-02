function [pixels, pixel_values, counter, pixel_count] = read_data()

fileName = 'digitdata.txt';
inputfile = fopen(fileName);

tline = fgetl(inputfile);

pixels_temp = strsplit(tline,' ');

pixel_count = length(pixels_temp);

pixels = zeros(pixel_count,1);

for i = 1:pixel_count
    pixels(i) = str2num(pixels_temp{1,i}(7:end-1));
end

counter = 0;

while 1
    % Get a line from the input file
    tline = fgetl(inputfile);

    % Quit if end of file
    if ~ischar(tline)
        break
    end
    
    counter = counter+1;
    
    pixel_values_temp = strsplit(tline,' ');
    for j = 2:pixel_count+1
        pixel_values(counter,j-1) = str2num(pixel_values_temp{1,j});
    end
    
end

fclose(inputfile);