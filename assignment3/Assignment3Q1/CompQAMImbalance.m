function [r_Ik_prime, r_Qk_prime] = CompQAMImbalance(r_Ik, r_Qk, delay, f1)
    % CompQAMImbalance: Compensates for QAM imbalance in carrier f1 due to phase shift.
    % phase shift introduced by the delay
    theta = 2 * pi * f1 * delay;

    % rotation matrix to compensate imbalance
    rotation_matrix = [cos(theta), sin(theta); 
                      -sin(theta), cos(theta)];

    r_k = [r_Ik; r_Qk];
    r_k_prime = rotation_matrix * r_k;

    r_Ik_prime = r_k_prime(1, :);
    r_Qk_prime = r_k_prime(2, :);
end
