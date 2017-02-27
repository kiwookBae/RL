tic

QBI = zeros(num_state,2);
count_BI = zeros(num_state,2);

W_BI = zeros(3,1);

for i=1:itr
    state = 1;
%     steps = 0;
    
    action = greedy(state,W_BI,epsilon);
    
    terminal = 0;

    while terminal ~= 1
        count_BI(state,action) = count_BI(state,action) + 1;
%         alpha = 0.01;
        alpha = 1/(100*i);
        [nextState,reward,terminal] = stepGrid(state,action);

        if terminal == 1 % reach the goal
            delta = -featureft(state,action)'*W_BI;
            W_BI = W_BI + delta*featureft(state,action)*alpha;
            break
        else
            nextAction = greedy(nextState,W_BI,epsilon);
            delta = reward + gamma*featureft(nextState,nextAction)'*W_BI - featureft(state,action)'*W_BI;
            W_BI = W_BI + delta*featureft(state,action)*alpha;  
        end

        state = nextState;
        action = nextAction;
        
%         steps = steps + 1;
%         disp('steps');
%         disp(steps);
%         disp('state');
%         disp(state);       
    end
    
    disp('Bootstrapping_Incremental_iteration')
    disp(i);
end

for i = 1:num_state
    QBI(i,1) = featureft(i,1)' * W_BI;
    QBI(i,2) = featureft(i,2)' * W_BI;
end

[BI_QSpace, BI_policySpace] = max(QBI,[],2);

toc
BI_Time = toc;