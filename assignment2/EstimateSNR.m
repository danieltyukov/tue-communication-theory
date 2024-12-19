function snr = EstimateSNR(r_k, s_k)
    n_k = r_k - s_k;

    Ps = mean(s_k.^2);
    Pn = mean(n_k.^2);

    snr = Ps / Pn;
end