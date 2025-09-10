% Loads sinograms from Excel files
sinogram1 = xlsread('Sinogram1-2.xlsx');
sinogram2 = xlsread('Sinogram3.xlsx');

% Apply Filtered Backprojection
recon1 = iradon(sinogram1, 0:179, 'linear', 'Ram-Lak', 1, size(sinogram1, 1));
recon2 = iradon(sinogram2, 0:179, 'linear', 'Ram-Lak', 1, size(sinogram2, 1));

% Registers the two images
registered_image = imregister(recon2, recon1, 'rigid', optimizer, metric);

% Segments major feature
threshold = graythresh(registered_image);
binary_image = imbinarize(registered_image, threshold);
segmented_image = bwlabel(binary_image);

% Uses original grayscale image to calculate properties
object_properties = regionprops(segmented_image, registered_image, 'Area', 'MeanIntensity');

% Reports the area and intensity statistics
area = object_properties.Area;
mean_intensity = object_properties.MeanIntensity;
% Minimum and maximum intensity
min_intensity = min(registered_image(segmented_image > 0));
max_intensity = max(registered_image(segmented_image > 0));
% Displays the registered image and also the segmented object
figure;
subplot(1, 2, 1);
imshow(registered_image, []);
title('Registered Image');
subplot(1, 2, 2);
imshow(segmented_image, []);
title('Segmented Object');

% Reports the results
fprintf('Area of segmented object: %d pixels\n', area);
fprintf('Mean intensity of segmented object: %f\n', mean_intensity);