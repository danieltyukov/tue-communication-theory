function b_tilde = OOKDemodulation(P, r_k)
    threshold = sqrt(2 * P) / 2;
    
    b_tilde = double(r_k > threshold);
end
