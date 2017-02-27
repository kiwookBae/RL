function [nextstate,reward,terminal] = stepGrid(state,action)

    goal = 15;
    
    % East
    if action == 1
        nextstate = state + 1;
        reward = - 1;
    end
        
    % West
    if action == 2
        if state == 1
            nextstate = state;
        else
            nextstate = state - 1;
        end
        reward = - 1;
    end

    if nextstate == goal
        terminal = 1; % reach the goal
    else
        terminal = 0;
    end
    
end

