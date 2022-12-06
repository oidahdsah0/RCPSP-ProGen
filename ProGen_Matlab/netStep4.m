function [net_mat, redo_flag] = netStep4(net_mat, J, C, max_in, max_out, st_act_list, ed_act_list)

redo_flag = 0;
maxIter = 500;
tmp_list = 2:J-1;

net_complex = sum(sum(net_mat))/J;

idx = 0;

while net_complex < C

    t_jobs = randsample(tmp_list, 2);
    i = t_jobs(1); j = t_jobs(2);
    while (sum(net_mat(:, j)) >= max_in) || ...
            (sum(net_mat(i, :)) >= max_out) || ...
            all(ismember(t_jobs,[st_act_list,ed_act_list])) || ...
            ismember(j, st_act_list)
        t_jobs = randsample(tmp_list, 2);
        i = t_jobs(1); j = t_jobs(2);
    end

    % redundant check 1
    pass_flag = redundantCheck1(net_mat, J, i, j);
    if pass_flag == 0
        idx = loopCounter(idx);
        if idx > maxIter
            redo_flag = 1;
            break;
        end
        continue;
    end

    % redundant check 2
    pass_flag = redundantCheck2(net_mat, J, i, j);
    if pass_flag == 0
        idx = loopCounter(idx);
        if idx > maxIter
            redo_flag = 1;
            break;
        end
        continue;
    end

    % redundant check 3
    pass_flag = redundantCheck3(net_mat, i, j);
    if pass_flag == 0
        idx = loopCounter(idx);
        if idx > maxIter
            redo_flag = 1;
            break;
        end
        continue;
    end

    % redundant check 4
    pass_flag = redundantCheck4(net_mat, J, i, j);
    if pass_flag == 0
        idx = loopCounter(idx);
        if idx > maxIter
            redo_flag = 1;
            break;
        end
        continue;
    end

    if pass_flag == 1
        net_mat(i, j) = 1;
        net_complex = sum(sum(net_mat))/J;
    end

end

end