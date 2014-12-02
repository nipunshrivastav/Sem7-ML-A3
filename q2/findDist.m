function res = findDist(i, mean_value, pixel_values)

res = pixel_values(i,:) - mean_value;
res = sum(res.*res);