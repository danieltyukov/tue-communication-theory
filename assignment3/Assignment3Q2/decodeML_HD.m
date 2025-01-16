function v_hat = decodeML_HD(r, P)
    % codebook
    C = [
        0 0 0 0 0 0 0;
        1 0 0 0 1 0 1;
        0 1 0 0 1 1 1;
        1 1 0 0 0 1 0;
        0 0 1 0 1 1 0;
        1 0 1 0 0 1 1;
        0 1 1 0 0 0 1;
        1 1 1 0 1 0 0;
        0 0 0 1 0 1 1;
        1 0 0 1 1 1 0;
        0 1 0 1 1 0 0;
        1 1 0 1 0 0 1;
        0 0 1 1 1 0 1;
        1 0 1 1 0 0 0;
        0 1 1 1 0 1 0;
        1 1 1 1 1 1 1
    ];
    
    % demodulation at sqrt(P)
    threshold = sqrt(P);
    % demodulate
    y = double(r >= threshold);
    
    N_par = size(r, 1);
    v_hat = zeros(N_par, size(C, 2));
    
    % closest codeword in Hamming distance
    for i = 1:N_par
        distances = sum(abs(C - y(i, :)), 2);
        [~, min_idx] = min(distances);
        v_hat(i, :) = C(min_idx, :);
    end
end
