% Create a head phantom image and display it
image_size = 128;
head_phantom = phantom(image_size);
imshow(head_phantom, []);

% Generate sinogram from the image
theta_increment = 10;
theta = 0:theta_increment:180;
sinogram = radon(head_phantom, theta);

% Apply Filtered Backprojection without filter
reconstructed_image_no_filter = iradon(sinogram, theta, 'none');

% Apply Filtered Backprojection with Hamming filter
reconstructed_image_hamming = iradon(sinogram, theta, 'hamming');

% Resize reconstructed images to match the original size
reconstructed_image_no_filter = imresize(reconstructed_image_no_filter, [image_size, image_size]);
reconstructed_image_hamming = imresize(reconstructed_image_hamming, [image_size, image_size]);

% Create a Gaussian filter kernel
gaussian_kernel = fspecial('gaussian', [5, 5], 1);  % Adjust the size and standard deviation as needed

% Apply Gaussian filter to the reconstructed images
reconstructed_image_no_filter_gaussian = imfilter(reconstructed_image_no_filter, gaussian_kernel, 'conv', 'replicate');
reconstructed_image_hamming_gaussian = imfilter(reconstructed_image_hamming, gaussian_kernel, 'conv', 'replicate');

% Compare SNR of the images
snr_no_filter = calculate_snr(head_phantom, reconstructed_image_no_filter);
snr_hamming = calculate_snr(head_phantom, reconstructed_image_hamming);
snr_no_filter_gaussian = calculate_snr(head_phantom, reconstructed_image_no_filter_gaussian);
snr_hamming_gaussian = calculate_snr(head_phantom, reconstructed_image_hamming_gaussian);

% Display images and SNR values
figure;
subplot(2, 3, 1), imshow(head_phantom, []), title('Original Image');
subplot(2, 3, 2), imshow(reconstructed_image_no_filter, []), title('No Filter');
subplot(2, 3, 3), imshow(reconstructed_image_hamming, []), title('Hamming Filter');
subplot(2, 3, 4), imshow(reconstructed_image_no_filter_gaussian, []), title('No Filter + Gaussian');
subplot(2, 3, 5), imshow(reconstructed_image_hamming_gaussian, []), title('Hamming Filter + Gaussian');

disp('SNR (No Filter):');
disp(snr_no_filter);

disp('SNR (Hamming Filter):');
disp(snr_hamming);

disp('SNR (No Filter + Gaussian):');
disp(snr_no_filter_gaussian);

disp('SNR (Hamming Filter + Gaussian):');
disp(snr_hamming_gaussian);

% Function to calculate Signal-to-Noise Ratio (SNR)
function snr = calculate_snr(original, reconstructed)
    % Ensure both images have the same size
    min_size = min(size(original));
    original = original(1:min_size, 1:min_size);
    reconstructed = reconstructed(1:min_size, 1:min_size);

    signal = sum(original(:).^2);
    noise = sum((original(:) - reconstructed(:)).^2);
    snr = 10 * log10(signal / noise);
end