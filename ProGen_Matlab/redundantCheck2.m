function flag = redundantCheck2(net_mat, J, i, j)

flag = 1;

j_suc_list = find(net_mat(j, :));

if numel(j_suc_list) > 0
    j_suc_list = getSuccessors(net_mat, j_suc_list);
    % j_suc_list(j_suc_list == J) = [];
end

i_pre_list = find(net_mat(:, i))';

if numel(i_pre_list) > 0
    i_pre_list = getPredecessors(net_mat, i_pre_list);
    % i_pre_list(i_pre_list == 1) = [];
end

for k = j_suc_list

    k_pre_list = find(net_mat(:, k));
    % k_pre_list(k_pre_list == 1) = [];

    if any(ismember(k_pre_list, i_pre_list))
        flag = 0;
        break;
    end

end

end

