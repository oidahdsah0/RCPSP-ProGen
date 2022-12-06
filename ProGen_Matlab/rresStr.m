function [r_res_lim, max_cons] = rresStr(J, RRS, R_num, r_cons_mat, dur_mat, net_mat, horizon)

K_min = zeros(1, R_num);

for j = 2:J-1
    for r = 1:R_num
        K_min(r) = max([K_min(r), min(r_cons_mat(j,:,r))]);
    end
end

R_res_list = zeros(J,R_num);
R_dur_list = zeros(J,R_num);

for j = 2:J-1
    for r = 1:R_num
        R_res_list(j, r) = max(r_cons_mat(j, :, r));
        idx = r_cons_mat(j, :, r) == R_res_list(j, r);
        if numel(dur_mat(j, idx)) > 1
            R_dur_list(j, r) = min(dur_mat(j, idx));
        else
            R_dur_list(j, r) = dur_mat(j, idx);
        end
    end
end

list_arran = 1;
list_tmp = 2:J;
list_len = numel(list_arran);
while list_len < J
    for j = list_tmp
        if ~ismember(j, list_arran)
            pre = find(net_mat(:, j));
            if all(ismember(pre,list_arran))
                list_arran = [list_arran,j];
            end
        end
    end
    list_len = numel(list_arran);
end

K_max = zeros(1, R_num);
max_cons = zeros(R_num, horizon);
for r = 1:R_num
    [K_max(r), max_cons(r,:)] = mspCalc(list_arran, J, R_dur_list(:,r)',...
        net_mat, R_res_list(:,r)', horizon);
end

r_res_lim = K_min + round(RRS .* (K_max - K_min));

end