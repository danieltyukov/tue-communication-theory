% findGeneratorMatrix.m
function G = findGeneratorMatrix()
    % Identity matrix of size k x k
    I_k = eye(4);
    
    % Parity matrix from the Hamming (7,4) code definition
    P = [1 0 1; 
         1 1 1; 
         1 1 0; 
         0 1 1];
    
    % Concatenate identity matrix and parity matrix
    G = [I_k P];
end
