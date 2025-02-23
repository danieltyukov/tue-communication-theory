%% 5ETB0: Assigment 3 Q1 2024-2025
% Felipe Villenas       Dec 12-2024

clear, close all
load('A3Q1_Dataset.mat');

fs = 1e3;                   % Sampling frequency for continuous-time representation [GHz]
T = Nsps/fs;                % Symbol period [ns]
t = 0:1/fs:T*Nsym-1/fs;     % Time vector [ns]
%% Q1.1
% QAM Demodulation
% matched filter has a nature of a rectangular pulse
% so we Nsps/2 coz peak of matched filter output
T0 = Nsps / 2;

% --- Carrier f0 ---
psi0_I = sqrt(2) * cos(2 * pi * f0 * t);        % <-- fill in
psi0_Q = sqrt(2) * sin(2 * pi * f0 * t);        % <-- fill in

r0_Ik = QAMDemuxReceiver(r_t, psi0_I, phi, T0, Nsps);
r0_Qk = QAMDemuxReceiver(r_t, psi0_Q, phi, T0, Nsps);

% --- Carrier f0 ---
psi1_I = sqrt(2) * cos(2 * pi * f1 * t);        % <-- fill in
psi1_Q = sqrt(2) * sin(2 * pi * f1 * t);        % <-- fill in

r1_Ik = QAMDemuxReceiver(r_t, psi1_I, phi, T0, Nsps);
r1_Qk = QAMDemuxReceiver(r_t, psi1_Q, phi, T0, Nsps);
%% Q1.2
% Visualize received signal samples

myScatterplot(r0_Ik, r0_Qk, 'Received Signal on Carrier $f_0$');
myScatterplot(r1_Ik, r1_Qk, 'Received Signal on Carrier $f_1$');
%% Q1.3
% Compensate QAM imbalance on f1

[r1_Ik_prime, r1_Qk_prime] = CompQAMImbalance(r1_Ik, r1_Qk, delay, f1);
myScatterplot(r1_Ik_prime, r1_Qk_prime, 'Compensated Signal on Carrier $f_1$');
%% Q1.4
% Decode received signals

s0_hat_vec = zeros(2,Nsym);
s1_hat_vec = zeros(2,Nsym);
% possible msgs, kinda works but if there was shitty signal then better to
% look at the constellation directly...
P = [-3, -1, 1, 3];         % <-- fill in

for n = 1:Nsym
    r0 = [r0_Ik(n); r0_Qk(n)]; 
    s0_hat_vec(:,n) = mlDecision16QAM(r0, P);

    r1 = [r1_Ik(n); r1_Qk(n)];
    s1_hat_vec(:,n) = mlDecision16QAM(r1, P);
end

% --- Calculate histograms ---
edges = -4:2:4;

H_s0_hat = histcounts2(s0_hat_vec(1,:), s0_hat_vec(2,:), edges, edges);
H_s1_hat = histcounts2(s1_hat_vec(1,:), s1_hat_vec(2,:), edges, edges);

fprintf('Received Signal f0:\n');
displayHistogram(H_s0_hat);

fprintf('\n')
fprintf('Received Signal f1:\n');
displayHistogram(H_s1_hat);
%% Functions

function myScatterplot(rI, rQ, title_text)
    R = [rI(:) rQ(:)];
    h = scatterplot(R);
    title(title_text, 'Interpreter', 'latex','Color','k');
    grid on;
    xticks([-3 -1 1 3]), yticks([-3 -1 1 3]);

    lineObjs = findall(h, 'Type', 'Line'); 

    for k = 1:length(lineObjs)
        lineObjs(k).MarkerEdgeColor = 'b'; 
        lineObjs(k).MarkerFaceColor = 'b';
    end
    set(gcf, 'Color', [0 0 0]);
    set(gca, 'Color', [1 1 1], 'XColor', 'k', 'YColor', 'k'); 
    set(h, 'Color', [0.9412 0.9412 0.9412]);

    set(gca, 'FontSize',14)
    set(gcf, 'Units','normalized', 'Position',  [0.1, 0.1, 0.3, 0.5]);
end

function [] = displayHistogram(H_s_hat)
    headers = {'-3', '-1', '+1', '+3'};     % Column headers
    rowHeaders = {'-3', '-1', '+1', '+3'};  % Row headers
    
    % Print column headers
    fprintf('      '); 
    for col = 1:numel(headers)
        fprintf('%6s', headers{col});
    end
    fprintf('\n');
    
    % Print each row with its row header
    for i = 1:size(H_s_hat, 1)
        fprintf('%6s', rowHeaders{i});
        for j = 1:size(H_s_hat, 2)
            fprintf('%6d', H_s_hat(i, j));
        end
        fprintf('\n');
    end
end