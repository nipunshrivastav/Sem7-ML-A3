function res = find_error(X,Y,left_cases,index)

counter_y0 = 0;
counter_y1 = 0;
counter_n0 = 0;
counter_n1 = 0;
counter_u0 = 0;
counter_u1 = 0;

for i = 1:length(Y)
    if (left_cases(i))
        
        if (X(i,index) == 1)
            if (Y(i) == 0)
                counter_y0 = counter_y0 + 1;
            else
                counter_y1 = counter_y1 + 1;
            end
            
        elseif (X(i,index) == 0)
            if (Y(i) == 0)
                counter_n0 = counter_n0 + 1;
            else
                counter_n1 = counter_n1 + 1;
            end
        elseif (X(i,index) == -1)
            if (Y(i) == 0)
                counter_u0 = counter_u0 + 1;
            else
                counter_u1 = counter_u1 + 1;
            end
        end
        
    end
end

if (counter_u0 > counter_u1)
    counter_u = counter_u1;
else
    counter_u = counter_u0;
end

if (counter_y0 > counter_y1)
    counter_y = counter_y1;
else
    counter_y = counter_y0;
end

if (counter_n0 > counter_n1)
    counter_n = counter_n1;
else
    counter_n = counter_n0;
end

res = counter_u + counter_y + counter_n;