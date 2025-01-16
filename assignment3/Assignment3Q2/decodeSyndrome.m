function v_hat = decodeSyndrome(r, P)
    H = [
        1 0 1 1 1 0 0;
        1 1 1 0 0 1 0;
        0 1 1 1 0 0 1
    ];
    thresh = sqrt(P / 2);
    y = r > thresh;
    S = mod(H * y', 2);
    s_hashes = 8 - sum(S .* [4; 2; 1], 1);
    s_hashes = s_hashes + (s_hashes < 6) + (s_hashes < 2) - 4 * (s_hashes == 5) - 2 * (s_hashes == 2);
    I = [eye(7), zeros(7, 1)];
    v_hat = mod(y' + I(:, s_hashes), 2)';
    v_hat = v_hat(:, 1:4);
end
