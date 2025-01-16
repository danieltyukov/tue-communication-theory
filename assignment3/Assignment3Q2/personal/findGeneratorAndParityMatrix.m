function [G, H] = findGeneratorAndParityMatrix()
    % Number of information bits (k) and codeword length (n) for Hamming (7,4) code
    k = 4; 
    n = 7; 

    % Identity matrix (k x k) for systematic encoding
    I_k = eye(k);
    
    % Parity matrix (k x (n-k)) for Hamming (7,4) code
    P = [1 1 0; 
         0 1 1; 
         1 1 1; 
         1 0 1];
    
    % Generator matrix G in systematic form
    G = [I_k P]
    
    % Parity-check matrix H in standard form
    % H = [P^T | I_(n-k)]
    I_n_k = eye(n - k); 
    H = [P.' I_n_k]
end
