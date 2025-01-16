function v_hat = decodeML_HD(r, P)
threshold = sqrt(P/2);
y = r > threshold;
    C = [
    0 0 0 0 0 0 0
    1 0 0 0 1 1 0
    0 1 0 0 0 1 1
    1 1 0 0 1 0 1
    0 0 1 0 1 1 1
    1 0 1 0 0 0 1
    0 1 1 0 1 0 0
    1 1 1 0 0 1 0
    0 0 0 1 1 0 1
    1 0 0 1 0 1 1
    0 1 0 1 1 1 0
    1 1 0 1 0 0 0
    0 0 1 1 0 1 0
    1 0 1 1 1 0 0
    0 1 1 1 0 0 1
    1 1 1 1 1 1 1
];
    v_hat = zeros(size(y));
    for i = 1:size(y,1)
        dist = sum(abs(C - y(i,:)), 2);
        [~, idx] = min(dist);
        v_hat(i,:) = C(idx,:);
    end
end
