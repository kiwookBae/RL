tic

QBB = zeros(num_state,2);

W_BB = zeros(3,1);
X_square_BB = zeros(3);
X_sum_BB = zeros(3,1);

for i=1:itr
    state = 1;
%     steps = 0;
    
    action = greedy(state,W_BB,epsilon);
    
    terminal = 0;

    while terminal ~= 1
        [nextState, reward, terminal] = stepGrid(state,action);

        if terminal == 1 % reach the goal
            X_square_BB = X_square_BB + featureft(state,action)*featureft(state,action)';
%             X_sum_BB = X_sum_BB + featureft(state,action)*reward;
            break
        else
            nextAction = greedy(nextState,W_BB,epsilon);
            X_square_BB = X_square_BB + featureft(state,action)*(featureft(state,action)-gamma*featureft(nextState,nextAction))';
            X_sum_BB = X_sum_BB + featureft(state,action)*reward;
        end

        state = nextState;
        action = nextAction;
        
%         steps = steps + 1;
%         disp('steps');
%         disp(steps);
%         disp('state');
%         disp(state);
    end
    
    disp('Bootstrapping_Batch_iteration')
    disp(i);
end

W_BB = (X_square_BB) \ (X_sum_BB);

for i = 1:num_state
    QBB(i,1) = featureft(i,1)' * W_BB;
    QBB(i,2) = featureft(i,2)' * W_BB;
end

[BB_QSpace, BB_policySpace] = max(QBB,[],2);

toc
BB_Time = toc;