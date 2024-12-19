%% 5ETB0: Assigment 2 2024-2025

% Load the workspace
load('A2_Dataset.mat');
t = linspace(0, N_data*N_frame, N_data*N_frame*N_sps);      % time vector for waveform signals [us]
P = 0.5;

%% Q2.1
% OOK Modulator
s_t = OOKModulation(P, phi, b);

% ------------------------ Plot figure ----------------------------
figure(1);
plot(t, s_t, 'LineWidth', 2);
grid on; hold on;
xlabel('Time [us]');
ylabel('Amplitude [V]');
xlim([440 456]);    % <- fill in values

set(gcf, 'Units','normalized', 'Position',  [0.1, 0.1, 0.8, 0.5]);

% -----------------------------------------------------------------
%% Q2.2
% Check filtered signal (Example with r_n2)
u_t = filter(phi, 1, r_n3);
figure(1); plot(t, u_t, 'LineWidth', 2);
% Obtain received signal samples
T0 = 101;     % <- fill in
T = 101;      % <- fill in ask if this value is supposed to be 101 or it can be anything

r_k1 = MFReceiver(r_n1, phi, T0, T);
r_k2 = MFReceiver(r_n2, phi, T0, T);
r_k3 = MFReceiver(r_n3, phi, T0, T);

% ------------------------ Plot figure ----------------------------
figure(2);
subplot(3,1,1);
histogram(r_k1, 200);   xlim([-1.5 2.5]);

subplot(3,1,2);
histogram(r_k2, 200);   xlim([-1.5 2.5]);

subplot(3,1,3);
histogram(r_k3, 200);   xlim([-1.5 2.5]);
xlabel('Received Signal Samples')
set(gcf, 'Units','normalized', 'Position',  [0.1, 0.1, 0.8, 0.5]);
% -----------------------------------------------------------------
%% Q2.3
% OOK Demodulation
b_tilde1 = OOKDemodulation(P, r_k1);
b_tilde2 = OOKDemodulation(P, r_k2);
b_tilde3 = OOKDemodulation(P, r_k3);

%% Q2.4
% Calculate Bit Error Rate
ber1 = OOKBitErrorRate(b, b_tilde1);
ber2 = OOKBitErrorRate(b, b_tilde2);
ber3 = OOKBitErrorRate(b, b_tilde3);

% Display the results
fprintf("BER_1 = %.4f | BER_2 = %.4f | BER_3 = %.4f\n", ber1, ber2, ber3);

%% Q2.5
% Estimate Signal-to-Noise Ratio
s_k = b*sqrt(2*P);% <- fill in

snr1 = EstimateSNR(r_k1, s_k);
snr2 = EstimateSNR(r_k2, s_k);
snr3 = EstimateSNR(r_k3, s_k);

% Display the results
fprintf("SNR_1 = %.2f [dB] | SNR_2 = %.2f [dB] | SNR_3 = %.2f [dB]\n", snr1, snr2, snr3);

%% Q2.6
% Decode the temperature readings
t_temps = 0:6:6*(N_data-1);     % time vector for temperature readings

temps1 = GetTempReadings(b_tilde1, n_pre, n_data, n_post);
temps2 = GetTempReadings(b_tilde2, n_pre, n_data, n_post);
temps3 = GetTempReadings(b_tilde3, n_pre, n_data, n_post);
temps_real = GetTempReadings(b, n_pre, n_data, n_post);         % Real temperature readings

% ------------------------ Plot figure ----------------------------
figure(3);
plot(t_temps, temps1/10, 'LineWidth', 2); hold on; grid on
plot(t_temps, temps2/10, 'LineWidth', 2); hold on; grid on
plot(t_temps, temps3/10, 'LineWidth', 2); hold on; grid on
plot(t_temps, temps_real/10, 'k--', 'LineWidth', 2); hold on; grid on

xlabel('Time [s]'), ylabel('Temperature [C]')
legend('r_1(t) [SNR='+string(round(snr1))+' dB]','r_2(t) [SNR='+string(round(snr2))+' dB]','r_3(t) [SNR='+string(round(snr3))+' dB]','s(t)')
%legend('r_2(t) [SNR='+string(round(snr2))+' dB]','s(t)')
set(gcf, 'Units','normalized', 'Position',  [0.1, 0.1, 0.7, 0.7]);
% -----------------------------------------------------------------