function label = read_label()

fileName = 'digitlabels.txt';
inputfile = fopen(fileName);

tline = fgetl(inputfile);

counter = 0;

while 1
    % Get a line from the input file
    tline = fgetl(inputfile);

    % Quit if end of file
    if ~ischar(tline)
        break
    end
    
    counter = counter+1;
    
    temp = strsplit(tline,' ');
    label(counter) = str2num(temp{1,2});
    
end

fclose(inputfile);


label1 = zeros(size(label));
label3 = zeros(size(label));
label5 = zeros(size(label));
label7 = zeros(size(label));
label1(label == 1) = 1;
label3(label == 3) = 2;
label5(label == 5) = 3;
label7(label == 7) = 4;

label = label1 + label3 + label5 + label7;