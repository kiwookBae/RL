tic

QRI = zeros(num_state,2);
count_RI = zeros(num_state,2);

W_RI = zeros(3,1);

for i=1:itr
    state = 1;
%     steps = 0;
    
    action = greedy(state,W_RI,epsilon);
    
    terminal = 0;

    while terminal ~= 1
        count_RI(state,action) = count_RI(state,action) + 1;
%         alpha = 0.01;
%         alpha = 1/count_RI(state,action);
        alpha = 1/(100*i);
        [nextState, reward, terminal] = stepGrid(state,action);

        if terminal == 1 % reach the goal
            delta = -featureft(state,action)'*W_RI;
            W_RI = W_RI + delta*featureft(state,action)*alpha;
            break
        else
            nextAction = greedy(nextState,W_RI,epsilon);
            delta = reward + gamma*featureft(nextState,nextAction)'*W_RI - featureft(state,action)'*W_RI;
            W_RI = W_RI + delta*(featureft(state,action) - gamma*featureft(nextState,nextAction))*alpha;
        end

        state = nextState;
        action = nextAction;
        
%         steps = steps + 1;
%         disp('steps');
%         disp(steps);
%         disp('state');
%         disp(state);
    end
    
    disp('Residual_Incremental_iteration')
    disp(i);
end

for i = 1:num_state
    QRI(i,1) = featureft(i,1)' * W_RI;
    QRI(i,2) = featureft(i,2)' * W_RI;
end

[RI_QSpace, RI_policySpace] = max(QRI,[],2);

toc
RI_Time = toc;