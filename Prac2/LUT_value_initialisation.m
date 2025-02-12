% Number of samples per period
n_values = 128;

% Time vector for one period
t = linspace(0, 1, n_values);

% Generate the sawtooth signal
sawtooth_signal = mod(linspace(0, 1023, n_values), 1024);

% Generate the sine signal
sine_wave = 511.5 * (1 + sin(2 * pi * t));  % Scale and shift to range [0, 1023]

% Generate the triangular signal
triangular_wave = 1023 * (2 * abs(t - floor(t + 0.5)));

% Plot the signals for one period
figure;

subplot(3,1,1);
stem(sawtooth_signal, 'filled');
title('Sawtooth Discrete Signal (One Period)');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
stem(sine_wave, 'filled');
title('Sine Discrete Signal (One Period)');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
stem(triangular_wave, 'filled');
title('Triangular Discrete Signal (One Period)');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

% Output LUT values in a format suitable for C arrays
fprintf('uint32_t saw_LUT[%d] = {', n_values);
fprintf('%u, ', round(sawtooth_signal));
fprintf('};\n');

fprintf('uint32_t sine_LUT[%d] = {', n_values);
fprintf('%u, ', round(sine_wave));
fprintf('};\n');

fprintf('uint32_t triangle_LUT[%d] = {', n_values);
fprintf('%u, ', round(triangular_wave));
fprintf('};\n');
