function r_k = MFReceiver(r, phi, T0, T)
    % matched filter
    filtered_signal = filter(phi, 1, r);
    
    r_k = filtered_signal(T0:T:end);
end
