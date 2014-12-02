function data_proc = pre_process(data, avg_fc)

data_proc = data - repmat(avg_fc,[length(data) 1]);