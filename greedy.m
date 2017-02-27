function [action] = greedy(state,W,epsilon)

    Q_hat = zeros(2,1);
    Q_hat(1) = featureft(state,1)' * W;
    Q_hat(2) = featureft(state,2)' * W;

    [a,b] = max(Q_hat,[],1);
    c = find(Q_hat == a);
    
    if length(c) == 1   
        egreedy = zeros(1,2);
        for i = 1:size(egreedy,2)
            if i == b
                egreedy(i) = 1-epsilon+epsilon/2;
            else
                egreedy(i) = epsilon/2;
            end
        end

        rnd = rand(1);
        if rnd<egreedy(1)
            action = 1;
        else
            action = 2;
        end
    else
%         d = randsample(c,1);
%         
%         egreedy = zeros(1,2);
%         for i = 1:size(egreedy,2)
%             if i == d
%                 egreedy(i) = 1-epsilon+epsilon/2;
%             else
%                 egreedy(i) = epsilon/2;
%             end
%         end
% 
%         rnd = rand(1);
%         if rnd<egreedy(1)
%             action = 1;
%         else
%             action = 2;
%         end
        action = randsample(2,1);
    end
%     disp('egreedy');
%     disp(egreedy);
    
end

