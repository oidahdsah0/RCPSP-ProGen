function flag = redundantCheck1(net_mat, J, i, j)

flag = 1;

i_suc_list = find(net_mat(i, :));

if numel(i_suc_list) > 0
    i_suc_list = getSuccessors(net_mat, i_suc_list);
    % i_suc_list(i_suc_list == J) = [];
end

if any(ismember(j, i_suc_list))
    flag = 0;
end

end

