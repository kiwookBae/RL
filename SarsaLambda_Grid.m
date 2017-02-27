tic

lambda = 0.9;
QSarsaLambda = zeros(15,2);
count = zeros(15,2);

for i=1:itr
    state = 1;
    [a, b] = max(QSarsaLambda(state,:),[],2);
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
    elig = zeros(1,3);

    while terminal==0
        count(state,action) = count(state,action)+1;
        for m=1:size(elig,1)
            if sum(elig(m,1:2) == [state,action])==2
                elig(m,3) = elig(m,3)+1;
                break
            end
            if m==size(elig,1)
                if sum(elig(m,:)) == 0
                    elig(m,:) = [state,action,1];
                else
                    elig(m+1,:) = [state,action,1];
                end
            end
        end
        
        [nextState, reward, terminal] = stepGrid(state,action);

        if terminal~=0
            delta = reward+0-QSarsaLambda(state,action);
            for n = 1:size(elig,1)
                QSarsaLambda(elig(n,1),elig(n,2))=QSarsaLambda(elig(n,1),elig(n,2))+1/count(elig(n,1),elig(n,2))*delta*elig(n,3);
            end
            break
        end
        [a, b] = max(QSarsaLambda(nextState,:),[],2);
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
        delta = reward+gamma*QSarsaLambda(nextState,nextAction)-QSarsaLambda(state,action);
        for p = 1:size(elig,1)
            QSarsaLambda(elig(p,1),elig(p,2))=QSarsaLambda(elig(p,1),elig(p,2))+1/count(elig(p,1),elig(p,2))*delta*elig(p,3);
        end
        
        elig(:,3) = lambda.*elig(:,3);
        deleteIdx=[];
        for q=1:size(elig,1)
           if elig(q,3)<10^-5
               deleteIdx=[deleteIdx,q];
           end           
        end
        elig(deleteIdx,:)=[];
        state = nextState;
        action = nextAction;
    end
    
    disp('SarsaLambda_iteration')
    disp(i);
end

[SarsaLambda_QSpace, SarsaLambda_policySpace] = max(QSarsaLambda,[],2);

toc
SarsaLambda_Time = toc;