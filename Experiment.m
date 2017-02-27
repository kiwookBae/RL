clear;clc;

itr = 100;

epsilon = 0.1;
gamma = 1;
num_state = 15;

V = -1*[num_state-1:-1:0]';

% I = eye(num_state);
% P = [0.05,0.95,0,0,0,0,0,0,0,0,0,0,0,0,0;
%     0.05,0,0.95,0,0,0,0,0,0,0,0,0,0,0,0;
%     0,0.05,0,0.95,0,0,0,0,0,0,0,0,0,0,0;
%     0,0,0.05,0,0.95,0,0,0,0,0,0,0,0,0,0;
%     0,0,0,0.05,0,0.95,0,0,0,0,0,0,0,0,0;
%     0,0,0,0,0.05,0,0.95,0,0,0,0,0,0,0,0;
%     0,0,0,0,0,0.05,0,0.95,0,0,0,0,0,0,0;
%     0,0,0,0,0,0,0.05,0,0.95,0,0,0,0,0,0;
%     0,0,0,0,0,0,0,0.05,0,0.95,0,0,0,0,0;
%     0,0,0,0,0,0,0,0,0.05,0,0.95,0,0,0,0;
%     0,0,0,0,0,0,0,0,0,0.05,0,0.95,0,0,0;
%     0,0,0,0,0,0,0,0,0,0,0.05,0,0.95,0,0;
%     0,0,0,0,0,0,0,0,0,0,0,0.05,0,0.95,0;
%     0,0,0,0,0,0,0,0,0,0,0,0,0.05,0,0.95;
%     0,0,0,0,0,0,0,0,0,0,0,0,0,0,1];
% R = [-1*ones(num_state-1,1);0];
% V = (I-gamma*P) \ R;

Sarsa;
Qlearning;
Bootstrapping_Incremental;
Bootstrapping_Batch;
Residual_Incremental;
Residual_Batch;

figure;
plot(V);
hold on;
plot(Sarsa_QSpace,'r');
hold on;
plot(Qlearning_QSpace,'g');
hold on;
plot(BI_QSpace,'b');
hold on;
plot(BB_QSpace,'k');
hold on;
plot(RI_QSpace,'m');
hold on;
plot(RB_QSpace,'c');
legend('V True','Sarsa','Qlearning','Bootstrapping Incremental','Bootstrapping Batch','Residual Incremental','Residual Batch','Location','best');
xlabel('State');
ylabel('V Value');
axis([1 15 -14 inf]);

MSE_S = sum((V - Sarsa_QSpace).^2)/num_state;
MSE_Q = sum((V - Qlearning_QSpace).^2)/num_state;
MSE_BI = sum((V - BI_QSpace).^2)/num_state;
MSE_BB = sum((V - BB_QSpace).^2)/num_state;
MSE_RI = sum((V - RI_QSpace).^2)/num_state;
MSE_RB = sum((V - RB_QSpace).^2)/num_state;

% disp('MSE of Sarsa');
% disp(MSE_S);
% disp('MSE of Qlearning');
% disp(MSE_Q);
% disp('MSE of Bootstrapping_Incremental');
% disp(MSE_BI);
% disp('MSE of Bootstrapping_Batch');
% disp(MSE_BB);
% disp('MSE of Residual_Incremental');
% disp(MSE_RI);
% disp('MSE of Residual_Batch');
% disp(MSE_RB);
% 
% disp('Sarsa_Time');
% disp(Sarsa_Time);
% disp('Qlearning_Time');
% disp(Qlearning_Time);
% disp('Bootstrapping_Incremental_Time');
% disp(BI_Time);
% disp('Bootstrapping_Batch_Time');
% disp(BB_Time);
% disp('Residual_Incremental_Time');
% disp(RI_Time);
% disp('Residual_Batch_Time');
% disp(RB_Time);

MSEs = [MSE_S,MSE_Q,MSE_BI,MSE_BB,MSE_RI,MSE_RB];
Times = [Sarsa_Time,Qlearning_Time,BI_Time,BB_Time,RI_Time,RB_Time];

save experiment_10000itr.mat
