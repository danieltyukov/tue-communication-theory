function [v] = encodeHamming(u)
    P = [1 1 0; 
         0 1 1; 
         1 1 1; 
         1 0 1];
    G = [eye(4), P];
    v = mod(u * G, 2);
end
