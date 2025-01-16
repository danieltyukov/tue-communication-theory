function s_hat = mlDecision16QAM(r, P)
    min_dist = inf;
    s_hat = zeros(2, 1);

    % personal note: P is the expected symbols (since we aleady aligned the 
    % position of the constellation diagram for r^1 we can hust use the give message symbol positions...)
    % so P is just a set of {s} and then since pass {r} we can calculate
    % Euclidean disatnce (r-s)^2 and then just find lowest distance..
    


    % all possible symbol pairs
    for i = 1:length(P)
        for j = 1:length(P)
            % the symbol (isolated kinda)
            s_candidate = [P(i); P(j)];

            % euclidean distance
            dist = norm(r - s_candidate);

            % as it loops through and finds lower distance -> change...
            if dist < min_dist
                min_dist = dist;
                s_hat = s_candidate;
            end
        end
    end
end
