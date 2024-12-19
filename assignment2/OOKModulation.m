function s_t = OOKModulation(P, phi, b)
    % amplitude-modulated signa l
    s_k = b .* sqrt(2 * P);
    
    s_t = (s_k * phi')';

    s_t = s_t(1:numel(s_t));
end
