function log_hood = extract_log_hood(g_prob,d_prob,i_prob,l_prob,s_prob,fileName)


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
data = textscan(tline,'%s');
for j = 1:5
    cur_arr(j) = str2num(data{1,1}{j,1});
end

log_hood(counter) = log(d_prob(cur_arr(1)+1,1)) + log(i_prob(cur_arr(2)+1,1)) + log(g_prob((cur_arr(2)*2)+cur_arr(1)+1,cur_arr(3)+1))+log(l_prob(cur_arr(3)+1,cur_arr(5)+1))+log(s_prob(cur_arr(2)+1,cur_arr(4)+1));
end
fclose(inputfile);

log_hood = log_hood';