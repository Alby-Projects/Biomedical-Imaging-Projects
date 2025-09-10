% Given matrix
input_matrix = [
    1, 2, 0, 2, 1;
    1, 5, 4, 5, 1;
    2, 5, 10, 5, 1;
    1, 5, 3, 5, 1;
    0, 2, 2, 2, 2
];

% Step 1: Apply Fourier Transform using fft2
fft_result_builtin = fft2(input_matrix);

% Step 2: Implement Fourier Transform equation manually
[M, N] = size(input_matrix);
fft_result_manual = zeros(M, N);

for u = 1:M
for v = 1:N
sum_val = 0;
for x = 1:M
for y = 1:N
pixel_val = input_matrix(x, y);
sum_val = sum_val + pixel_val * exp(-1i * 2 * pi * ((u-1) * (x-1) / M + (v-1) * (y-1) / N));
end
end
fft_result_manual(u, v) = sum_val / sqrt(M * N);
end
end

% Display results
disp('Input Matrix:');
disp(input_matrix);

disp('Fourier Transform Result (Built-in):');
disp(fft_result_builtin);

disp('Fourier Transform Result (Manual):');
disp(fft_result_manual);