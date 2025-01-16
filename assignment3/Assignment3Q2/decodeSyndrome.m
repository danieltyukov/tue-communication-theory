function [v_hat] = decodeSyndrome(r, P)
    % DECODESYNDROME Decodes received symbols using syndrome decoding.
    % INPUT:
    %   r: Received symbols, size N_par x n.
    %   P: Transmission power.
    % OUTPUT:
    %   v_hat: Decoded sequence of bits, size N_par x k.
    
    % Define the parity check matrix H
    H = [
        1 0 1 1 1 0 0;
        1 1 1 0 0 1 0;
        0 1 1 1 0 0 1
    ];
    
    % Codebook for (7,4) Hamming code
        C = [
    0 0 0 0 0 0 0
    1 0 0 0 1 1 0
    0 1 0 0 0 1 1
    1 1 0 0 1 0 1
    0 0 1 0 1 1 1
    1 0 1 0 0 0 1
    0 1 1 0 1 0 0
    1 1 1 0 0 1 0
    0 0 0 1 1 0 1
    1 0 0 1 0 1 1
    0 1 0 1 1 1 0
    1 1 0 1 0 0 0
    0 0 1 1 0 1 0
    1 0 1 1 1 0 0
    0 1 1 1 0 0 1
    1 1 1 1 1 1 1
];
    
    % OOK modulation threshold
    threshold = sqrt(P);
    
    % Hard decision demodulation
    y = double(r >= threshold);
    
    % Precompute syndromes and error patterns
    syndromes = mod(H * C', 2)'; % Compute all syndromes
    error_patterns = [zeros(1, 7); eye(7)]; % Error patterns
    
    % Preallocate space for decoded codewords
    N_par = size(y, 1);
    v_hat = zeros(N_par, size(C, 2));
    
    % Syndrome decoding
    for i = 1:N_par
        % Compute the syndrome for the received codeword
        syndrome = mod(H * y(i, :)', 2)';
        
        % Find the matching error pattern
        error_idx = find(ismember(syndromes, syndrome, 'rows'), 1);
        
        % Handle invalid syndrome
        if isempty(error_idx)
            % If no matching syndrome, assume no error
            error_pattern = zeros(1, 7);
        else
            % Retrieve the corresponding error pattern
            error_pattern = error_patterns(error_idx, :);
        end
        
        % Correct the error
        corrected = mod(y(i, :) + error_pattern, 2);
        
        % Find the corresponding codeword
        codeword_idx = find(ismember(C, corrected, 'rows'), 1);
        
        % Handle invalid codeword
        if isempty(codeword_idx)
            % If no valid codeword, assume all zeros
            v_hat(i, :) = zeros(1, size(C, 2));
        else
            v_hat(i, :) = C(codeword_idx, :);
        end
    end
end
