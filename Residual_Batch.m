tic

QRB = zeros(num_state,2);

W_RB = zeros(3,1);
X_square_RB = zeros(3);
X_sum_RB = zeros(3,1);

for i=1:itr
    state = 1;
%     steps = 0;
    
    action = greedy(state,W_RB,epsilon);
    
    terminal = 0;

    while terminal ~= 1
        [nextState, reward, terminal] = stepGrid(state,action);

        if terminal == 1 % reach the goal
            X_square_RB = X_square_RB + featureft(state,action)*featureft(state,action)';
%             X_sum_RB = X_sum_RB + featureft(state,action)*reward;
            break
        else
            nextAction = greedy(nextState,W_RB,epsilon);
            X_square_RB = X_square_RB + (featureft(state,action)-gamma*featureft(nextState,nextAction))*(featureft(state,action)-gamma*featureft(nextState,nextAction))';
            X_sum_RB = X_sum_RB + (featureft(state,action)-gamma*featureft(nextState,nextAction))*reward;
        end

        state = nextState;
        action = nextAction;
        
%         steps = steps + 1;
%         disp('steps');
%         disp(steps);
%         disp('state');
%         disp(state);
    end
    
    disp('Residual_Batch_iteration')
    disp(i);
end

W_RB = (X_square_RB) \ (X_sum_RB);

for i = 1:num_state
    QRB(i,1) = featureft(i,1)' * W_RB;
    QRB(i,2) = featureft(i,2)' * W_RB;
end

[RB_QSpace, RB_policySpace] = max(QRB,[],2);

toc
RB_Time = toc;