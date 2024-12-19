function s_t = OOKModulation(P, phi, b)
    %phi = phi /sqrt(mean(phi.^2));
    s_k = b*sqrt(2*P);
    s_t = s_k*phi';
    s_t = s_t';
    s_t = s_t([1:numel(s_t)]);
end