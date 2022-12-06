function pre_list = getPredecessors(net_mat, pre_list)
% Recursion getting all suc jobs

ori_pre_list = pre_list;

for j = ori_pre_list
    t_pre_list = find(net_mat(:, j))';
    if numel(t_pre_list) > 0        
        t_pre_list = getPredecessors(net_mat, t_pre_list);
        pre_list = unique([pre_list, t_pre_list]);
    end    
end

end