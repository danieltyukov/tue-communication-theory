function b_tilde = OOKDemodulation(P, r_k)
    thresh = sqrt(2*P)/2;
    b_tilde = ones([1 length(r_k)]).*(r_k>thresh);
end