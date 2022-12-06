function flag = redundantCheck3(net_mat, i, j)

flag = 1;

i_pre_list = find(net_mat(:, i))';

if numel(i_pre_list) > 0
    i_pre_list = getPredecessors(net_mat, i_pre_list);
    % i_pre_list(i_pre_list == 1) = [];
end

j_pre_list = find(net_mat(:, j))';
% j_pre_list(j_pre_list == 1) = [];

if any(ismember(j_pre_list, i_pre_list))
    flag = 0;
end

end

