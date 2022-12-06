function flag = redundantCheck4(net_mat, J, i, j)

flag = 1;

j_suc_list = find(net_mat(j, :));

if numel(j_suc_list) > 0
    j_suc_list = getSuccessors(net_mat, j_suc_list);
    % j_suc_list(j_suc_list == J) = [];
end

i_suc_list = find(net_mat(i, :));
% i_suc_list(i_suc_list == J) = [];

if any(ismember(i_suc_list, j_suc_list))
    flag = 0;
end

end

