function errs = calculateErrors(v, v_hat)
    decidedBits = (v_hat >= 0.5);
    errs = 0;
    [numRows, numCols] = size(v);
    for r = 1:numRows
        for c = 1:numCols
            if v(r,c) ~= decidedBits(r,c)
                errs = errs + 1;
            end
        end
    end
end
