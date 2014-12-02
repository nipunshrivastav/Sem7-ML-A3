function visualize(eg_index, pixel_value, pixels, pixel_count)

image = zeros(28,28);

for i = 1:pixel_count
    image(pixels(i)) = pixel_value(i);
end

% image = imrotate(image, -90);
figure, imshow(image');