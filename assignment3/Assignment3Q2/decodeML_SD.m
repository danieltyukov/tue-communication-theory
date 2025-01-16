function decoded = decodeML_SD(r, P)
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
    
    codebookSymbols = sqrt(2*P) * C;
    
    decoded = zeros(size(r));
    for i = 1:size(r,1)
        dists = sum((codebookSymbols - r(i,:)).^2, 2);
        [~, idx] = min(dists);
        decoded(i,:) = C(idx,:);
    end
end
