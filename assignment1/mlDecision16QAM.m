function s_hat = mlDecision16QAM(r, P)
    msg = sqrt(P)*(1/sqrt(10)) * [-3 -3 -3 -3 -1 -1 -1 -1  1  1  1  1  3  3  3  3; 
                                  -3 -1  1  3 -3 -1  1  3 -3 -1  1  3 -3 -1  1  3];
    min_dist = inf;
    mini = 1;
    for i = 1:size(msg, 2)
        si = msg(:, i); % Constellation point
        dist = norm(r - si);
        if dist < min_dist % if better distance found...
            min_dist = dist;
            mini = i;
        end
    end
    s_hat = msg(:, mini);
end
