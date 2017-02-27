function [output] = featureft(state,action)

    goal = 15;
    output = zeros(3,1);

%     % f3
%     if action == 1
%         output(1) = goal - state;
%         output(2) = 0;
%     elseif action == 2
%         output(1) = 0;
%         output(2) = goal - state;
%     end

    % f2
%     if action == 1
%         output(1) = state;
%         output(2) = 0;
%     elseif action == 2
%         output(1) = 0;
%         output(2) = state;
%     end

    % f1
    output(1) = state;
    output(2) = action;
    
    output(3) = 1;
    
end