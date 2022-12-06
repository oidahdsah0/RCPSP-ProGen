function [net_mat, st_act_list, ed_act_list, init_list] = netStep1(J, S_1_min, S_1_max, P_J_min, P_J_max)

% Prepare the network mat:
% Tip: col head is the predecessors & row head is the successors
net_mat = zeros(J, J);

% generate random sample list
init_list = 2:J-1;
% number of start-activity
st_act_num = randi([S_1_min, S_1_max]);
% number of finish-activity
ed_act_num = randi([P_J_min, P_J_max]);

% list of start-activity
st_act_list = init_list(1:st_act_num);
% adjust random sample list
init_list = init_list(st_act_num + 1:end);
% list of finish-activity
ed_act_list = init_list(end - ed_act_num + 1:end);
% adjust random sample list
init_list = init_list(1:(end - ed_act_num));
% build arc of start jobs
net_mat(1, st_act_list) = 1;
% build arc of end jobs
net_mat(ed_act_list, end) = 1;

end

