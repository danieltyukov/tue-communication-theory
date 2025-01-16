function decoded = decodeML_SD(r, P)
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
    
    % OOK modulation
    modulated_codebook = C * sqrt(2 * P);
   
    N_par = size(r, 1);
    decoded = zeros(N_par, size(C, 2));
    
    % closest codeword in Euclidean distance
    for i = 1:N_par
        distances = sum((modulated_codebook - r(i, :)).^2, 2);
        [~, min_idx] = min(distances);
        decoded(i, :) = C(min_idx, :);
    end
end
