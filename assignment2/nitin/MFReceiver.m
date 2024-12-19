function r_k = MFReceiver(r_n, phi, T0, T)
    r_k = filter(phi, 1, r_n);
    r_k = r_k';
    r_k = r_k(T0:T:length(r_k));
end