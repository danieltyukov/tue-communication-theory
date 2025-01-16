function errs = calculateErrors(v, v_hat)
v_hat_prime=v_hat>=0.5;
errs=0;
for i=1:length(v)
    for j=1:size(v,2)
        if v(i,j)~=v_hat_prime(i,j)
            errs=errs+1;
        end
    end
end