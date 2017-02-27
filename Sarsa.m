tic

QSarsa = zeros(num_state,2);
count_Sarsa = zeros(num_state,2);

for i=1:itr
    state = 1;
%     steps = 0;
    [a, b] = max(QSarsa(state,:),[],2);
    egreedy = zeros(1,2);
    for k = 1:size(egreedy,2)
        if k==b
            egreedy(k) = 1-epsilon+epsilon/2;
        else
            egreedy(k) = epsilon/2;
        end
    end
    %e-greedy policy
    rnd = rand(1);
    if rnd<egreedy(1)
        action = 1;
    else
        action = 2;
    end
    terminal = 0;

    while terminal ~= 1
        count_Sarsa(state,action) = count_Sarsa(state,action)+1;
        [nextState, reward, terminal] = stepGrid(state,action);

        if terminal == 1 % reach the goal
            delta = reward+0-QSarsa(state,action);
            QSarsa(state,action) = QSarsa(state,action)+1/count_Sarsa(state, action)*delta;
            break
        else
            [a, b] = max(QSarsa(state,:),[],2);
            egreedy = zeros(1,2);
            for k = 1:size(egreedy,2)
                if k==b
                    egreedy(k) = 1-epsilon+epsilon/2;
                else
                    egreedy(k) = epsilon/2;
                end
            end
            %e-greedy policy
            rnd = rand(1);
            if rnd<egreedy(1)
                nextAction = 1;
            else
                nextAction = 2;
            end
            
            delta = reward+gamma*QSarsa(nextState,nextAction)-QSarsa(state,action);
            QSarsa(state,action) = QSarsa(state,action)+1/count_Sarsa(state, action)*delta;            
        end
        
        state = nextState;
        action = nextAction;
        
%         steps = steps + 1;
%         disp('steps');
%         disp(steps);
%         disp('state');
%         disp(state);
    end
    disp('Sarsa_iteration')
    disp(i);
end

[Sarsa_QSpace, Sarsa_policySpace] = max(QSarsa,[],2);

toc
Sarsa_Time = toc;