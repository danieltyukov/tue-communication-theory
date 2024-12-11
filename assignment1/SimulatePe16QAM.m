%% Comparison of simulated P_e and theoretical P_e
% A1.MATLAB.Q3
% This script estimates by simulations the probability of error, and then 
% plots the theoretical probability of error and the simulated one as a 
% function of power on the same figure.
%
% A. Barreiro               Nov-04-2022
% S. Goossens & G. Yilmaz   Nov-17-2023
% J. Lagendijk              Oct-10-2024

clear
close all

% Start measuring elapsed time
tic

% Number of simulated symbols
N = 250;
% Noise variance
sigma2 = 1;

Pvec_dB = -15:0.5:20; % Vector in dB that contains different SNR levels since sigma2 = 1
Pvec = 10.^(Pvec_dB/10); % SNR vector in linear representation

% Generate list of signal vectors
%8-PSK
%angles = pi/8 + (0:7)*pi/4; % Angles of 8PSK symbols
%messages = [cos(angles); sin(angles)]; % Generate list of messages

%16-QAM
messages = (1/sqrt(10)) * [-3 -3 -3 -3 -1 -1 -1 -1  1  1  1  1  3  3  3  3; 
                           -3 -1  1  3 -3 -1  1  3 -3 -1  1  3 -3 -1  1  3];
    
% Prealocate soace for the error probability vectors
PeTh  = zeros(1,length(Pvec)); % Vector to save theoretical probability of error
PeSim = zeros(1,length(Pvec)); % Vector to save estimated probability of error that is computed by simulations

% Initialize iteration counter
iterE = 1;

for P=Pvec % Calculate the probabilty of error for each energy level in Evec
    PeTh(iterE) = Pe16QAM(P, sigma2);

    % Run simulations
    NbErrors=0; % Initialize number of error and set to zero
    for iter=1:N
        % Select one signal vector randomly from the signal set
        s = sqrt(P)*messages(:,randi([1 length(messages)]));
        % Add AGN with variance sigma2 to the signal s
        r = s + sqrt(sigma2/2)*randn(2,1);
        % Estimate the transmitted signal vector based on the received noisy vector r
        s_hat = mlDecision16QAM(r,P);


        % Check for error and increment NbErrors accordingly
        if (sum(abs(s - s_hat)) > 1e-5)
            NbErrors = NbErrors+1;
        end
    end
    PeSim(iterE) = NbErrors/N; % Append the estimated probabilty of error to PeSim
    iterE = iterE+1;
end

%% Plot the calculated probabilities of error using the base-10 logarithmic scale on the y-axis
figure;
semilogy(Pvec_dB, PeTh, 'LineWidth',2,'LineStyle','-');
hold on;
semilogy(Pvec_dB, PeSim, 'LineWidth',2,'LineStyle','--');
set(gca,'FontName','Times')
xlabel('SNR (dB)');
ylabel('Probability of Error');
xlim([min(Pvec_dB) max(Pvec_dB)])
ylim([1e-3 1e0])
grid on;
simName = ['Simulated N=',num2str(N)];
legend('Theoretical', simName, 'interpreter', 'latex');
% Display elapsed time
toc
