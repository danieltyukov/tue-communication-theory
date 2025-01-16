%% Preamble
%   In this section of the code, the system selects the system parameters
clear, close, clc

%%% CHANGE THESE VARIABLES %%%
SNR = 0:15; %dB
N = 100;

% variable for speeding up your simulations through matlab optimizations
N_par = 1000;

%%% NO NEED TO CHANGE THESE VARIABLES %%%
n = 7;
k = 4;
P = 1/2;

ERRS = zeros(4, length(SNR));
%% Simulator
%   This part of the code runs the simulation using your provided system
for idx = 1:length(SNR)
    for jdx = 1:N
        % Generate k random bits
        info = randi([0, 1], N_par, k);
        
        %Encode the codeword using your implementation
        encoded = encodeHamming(info);
    
        %Modulate the encoded symbols using OOK modulation
        modulated = sqrt(2*P) * encoded;
    
        %Transmit the signals over the channel
        sigma = sqrt(P / 10.^(SNR(idx)/10));
        received = modulated + sigma*randn(size(modulated));
        %Count uncoded errors
        ERRS(1, idx) = ERRS(1, idx) + calculateErrors(encoded, received);
    
        %Decode using ML-HD decoding
        decoded = decodeML_HD(received, P)
        %Count ML-HD errors
        ERRS(2, idx) = ERRS(2, idx) + calculateErrors(info, decoded);
    
        %Decode using ML-SD decoding
        decoded = decodeML_SD(received, P)
        %Count ML-SD errors
        ERRS(3, idx) = ERRS(3, idx) + calculateErrors(info, decoded);

        %Decode using Hamming decoding
        decoded = decodeSyndrome(received, P);
        %Count Hamming errors
        ERRS(4, idx) = ERRS(4, idx) + calculateErrors(info, decoded);
    end
end

%% Plot results
figure()
semilogy(SNR, ERRS(1, :)./(N*N_par*7))
hold on, grid on
semilogy(SNR, ERRS(2, :)./(N*N_par*4), '-x')
semilogy(SNR, ERRS(3, :)./(N*N_par*4), '-o')
semilogy(SNR, ERRS(4, :)./(N*N_par*4), '-square')

legend("pre-FEC", "HD ML", "SD ML", "Syndrome")