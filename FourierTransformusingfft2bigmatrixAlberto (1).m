% Given matrix
input_matrix = [
    0, 0, 5, 5, 5, 5, 0, 0;
    0, 5, 90, 80, 70, 5, 0, 0;
    0, 5, 100, 120, 110, 5, 0, 0;
    0, 5, 120, 130, 130, 5, 0, 0;
    0, 5, 140, 150, 160, 5, 0, 0;
    0, 5, 5, 5, 5, 5, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
    0, 0, 0, 0, 0, 0, 0, 0;
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
fft_result_manual(u, v) = sum_val;
end
end

% Display results
disp('Input Matrix:');
disp(input_matrix);

disp('Fourier Transform Result (Built-in):');
disp(fft_result_builtin);

disp('Fourier Transform Result (Manual):');
disp(fft_result_manual);