function net_mat = netStep2(net_mat, st_act_list, ed_act_list, init_list, max_out)
% set predecessors for normal jobs
prede_list = st_act_list;
for j = init_list

    if numel(prede_list) == 1
        tmp_pred = prede_list;
    else
        tmp_pred = randsample(prede_list, 1);
        while sum(net_mat(tmp_pred, :)) >= max_out
            tmp_pred = randsample(prede_list, 1);
        end
    end

    prede_list = [prede_list, j];

    net_mat(tmp_pred, j) = 1;

end

% avoid redundant arc
prede_list(ismember(prede_list, st_act_list)) = [];

% set predecessors for finish-activities
for j = ed_act_list

    tmp_pred = randsample(prede_list, 1);

    while sum(net_mat(tmp_pred, :)) >= max_out
        tmp_pred = randsample(prede_list, 1);
    end

    % prede_list = [prede_list, j];

    net_mat(tmp_pred, j) = 1;

end
end

