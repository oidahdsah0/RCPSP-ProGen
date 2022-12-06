function [net_mat, redo_flag] = netStep3(net_mat, J, max_in, st_act_list, ed_act_list)

redo_flag = 0;

tmp_list = 2:J-1;

maxIter = 500;

for i = 2:J-1

    idx = 0;

    while sum(net_mat(i, :)) == 0
        
        % define the range you can select
        if ismember(i, st_act_list) || ismember(i, ed_act_list)
            % select a suc for st/ed acts
            del_idx = ismember(tmp_list, [i, st_act_list, ed_act_list]);
            real_tmp_list = tmp_list(del_idx == 0);
        else
            % select a suc for normal acts
            del_idx = ismember(tmp_list, [i, st_act_list]);
            real_tmp_list = tmp_list(del_idx == 0);
        end

        % rand sampling
        j = randsample(real_tmp_list, 1);
        while sum(net_mat(:, j)) >= max_in
            j = randsample(real_tmp_list, 1);
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
        end

    end

    if redo_flag
        break;
    end

end

% Check whether a suc or pre is available
if ~redo_flag
    for ii = 2:J-1
        if sum(net_mat(ii,:)) == 0
            redo_flag = 1;
            break;
        elseif sum(net_mat(:,ii)) == 0
            redo_flag = 1;
            break;
        end
    end
end

end