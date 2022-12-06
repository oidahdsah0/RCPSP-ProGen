function suc_list = getSuccessors(net_mat, suc_list)
% Recursion getting all suc jobs

ori_suc_list = suc_list;

for i = ori_suc_list
    t_suc_list = find(net_mat(i, :));
    if numel(t_suc_list) > 0        
        t_suc_list = getSuccessors(net_mat, t_suc_list);
        suc_list = unique([suc_list, t_suc_list]);
    end    
end

end