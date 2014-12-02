function [all_state, dom_class] = check(Y, left_cases, no_egs)

all_state = 0;

counter = 0;
counter1 = 0;
counter0 = 0;

for i = 1:no_egs
    if(left_cases(i))
        counter = counter+1;
        if(Y(i))
            counter1 = counter1+1;
        else
            counter0 = counter0+1;
        end
    end
end

if (counter0 == counter)
    all_state = 1;
    dom_class = 0;
elseif (counter1 == counter)
    all_state = 1;
    dom_class = 1;
else
    if(counter1>counter0)
        dom_class = 1;
    else
        dom_class = 0;
    end
end