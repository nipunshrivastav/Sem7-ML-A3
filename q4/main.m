close all; clc; clear;

[data, counter] = read_train0();

[g,d,i,l,s] = find_prob(data, counter);

[g_prob,d_prob,i_prob,l_prob,s_prob] = extract_prob(g,d,i,l,s);

log_hood = sum(extract_log_hood(g_prob,d_prob,i_prob,l_prob,s_prob,'test.data'))


filename = 'train-20.data';
data = read_train(filename, counter);

log_hood_new = 0;
log_hood_old = 0;
error = 2;

%% Initialisation
g_prob_new = g_prob;
d_prob_new = d_prob;
i_prob_new = i_prob;
s_prob_new = s_prob;
l_prob_new = l_prob;

[g_new,d_new,i_new,l_new,s_new] = find_prob_a(data, counter);
[g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new] = extract_prob(g_new,d_new,i_new,l_new,s_new);

while (error>0.0001)
    log_hood_old = log_hood_new;
    %% E Step
%     new_data = expected(data,g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new, counter);
    [g_new_a,d_new_a,i_new_a,l_new_a,s_new_a] = expected_a(data,g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new, counter);
    % Find sum of expected values of nan
    %% M Step
%     [g_new,d_new,i_new,l_new,s_new] = find_prob_new(new_data, counter, g,d,i,l,s);
    g_prob_newa = g_new_a+g_new;
    d_prob_newa = d_new_a+d_new;
    i_prob_newa = i_new_a+i_new;
    l_prob_newa = l_new_a+l_new;
    s_prob_newa = s_new_a+s_new;
    [g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new] = extract_prob(g_prob_newa,d_prob_newa,i_prob_newa,l_prob_newa,s_prob_newa);
    
    
    log_hood_new = sum(extract_log_hood(g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new,'test.data'));
    error = abs(log_hood_new - log_hood_old)
end

%% For different missing data
for m = 0:5:25
    filename = ['train-' num2str(m) '.data'];
    data = read_train(filename, counter);
temp = isnan(data);
sum(temp)
    log_hood_new = 0;
    log_hood_old = 0;
    error = 2;

    %% Initialisation
    g_prob_new = g_prob;
    d_prob_new = d_prob;
    i_prob_new = i_prob;
    s_prob_new = s_prob;
    l_prob_new = l_prob;

    [g_new,d_new,i_new,l_new,s_new] = find_prob_a(data, counter);
    [g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new] = extract_prob(g_new,d_new,i_new,l_new,s_new);

    while (error>0.0001)
        log_hood_old = log_hood_new;
        %% E Step
    %     new_data = expected(data,g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new, counter);
        [g_new_a,d_new_a,i_new_a,l_new_a,s_new_a] = expected_a(data,g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new, counter);
        % Find sum of expected values of nan
        %% M Step
    %     [g_new,d_new,i_new,l_new,s_new] = find_prob_new(new_data, counter, g,d,i,l,s);
        g_prob_newa = g_new_a+g_new;
        d_prob_newa = d_new_a+d_new;
        i_prob_newa = i_new_a+i_new;
        l_prob_newa = l_new_a+l_new;
        s_prob_newa = s_new_a+s_new;
        [g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new] = extract_prob(g_prob_newa,d_prob_newa,i_prob_newa,l_prob_newa,s_prob_newa);


        log_hood_new = sum(extract_log_hood(g_prob_new,d_prob_new,i_prob_new,l_prob_new,s_prob_new,'test.data'));
        error = abs(log_hood_new - log_hood_old);
    end
    log_hood_array(m/5+1) = log_hood_new;
end

plot([0:5:25],log_hood_array);
title('log-likelihood of test data vs amount of missing info/5+1');