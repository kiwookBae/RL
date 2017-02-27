tic

QQlearning = zeros(num_state,2);
count_Qlearning = zeros(num_state,2);

for i=1:itr
    state = 1;
%     steps = 0;
    [a, b] = max(QQlearning(state,:),[],2);
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
        count_Qlearning(state,action) = count_Qlearning(state,action)+1;
        [nextState, reward, terminal] = stepGrid(state,action);

        if terminal == 1 % reach the goal
            delta = reward+0-QQlearning(state,action);
            QQlearning(state,action) = QQlearning(state,action)+1/count_Qlearning(state, action)*delta;
            break
        else
            [a, b] = max(QQlearning(nextState,:),[],2);
            delta = reward+gamma*QQlearning(nextState,b)-QQlearning(state,action);
            QQlearning(state,action) = QQlearning(state,action)+1/count_Qlearning(state, action)*delta;            
        end

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
        
        state = nextState;
        action = nextAction;
        
%         steps = steps + 1;
%         disp('steps');
%         disp(steps);
%         disp('state');
%         disp(state);
    end
    disp('Qlearning_iteration')
    disp(i);
end

[Qlearning_QSpace, Qlearning_policySpace] = max(QQlearning,[],2);

toc
Qlearning_Time = toc;