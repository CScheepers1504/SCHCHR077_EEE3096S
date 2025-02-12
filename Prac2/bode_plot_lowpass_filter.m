% Load the data
data = readtable('eee3096_prac2.xlsx'); 
frequencies = data.Frequency; % Keep the frequencies in Hz
output_amplitudes = data.OutputAmplitude;

% Calculating the magnitude in dB
input_amplitude = 3.3; 
magnitude_dB = 20 * log10(output_amplitudes / input_amplitude);

% Defining the R and C values for the low-pass filter
R = 1500; % Ohms
C = 100e-9; % Farads

% Plot the experimental magnitude vs frequency data
figure;
semilogx(frequencies, magnitude_dB, 'rx');
hold on; % Keeps the plot open to overlay the Bode plot

% Generating and plotting the Bode plot for the 1st order low-pass filter
% Calculate the theoretical Bode plot manually
omega = logspace(log10(min(frequencies)), log10(max(frequencies)), 100); % Logarithmic frequency range in Hz
H = 1 ./ (1 + 1i * 2 * pi * omega * R * C); % Transfer function in frequency domain, now using omega in Hz

% Magnitude in dB
mag_dB = 20 * log10(abs(H));

% Plot the magnitude response of the low-pass filter
semilogx(omega, mag_dB, 'b-'); % Overlays the Bode plot in blue

% Adds labels, title, and grid
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Bode Plot of 1st Order Passive Low-Pass Filter');
grid on;

% Displays the cutoff frequency
cutoff_frequency = 1 / (2*pi*R * C);
disp(['Cutoff Frequency: ', num2str(cutoff_frequency), ' Hz']);

% Add legend
legend('Measured Data Points', 'Theoretical Bode Plot', 'Location', 'southwest');

% Release the plot
hold off;
