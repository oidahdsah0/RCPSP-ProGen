function n_res_lim = nresStr(J, NRS, N_num, n_cons_mat)

K_min = zeros(1, N_num); 
K_max = zeros(1, N_num);

for j = 2:J-1
    for n = 1:N_num
        K_min(n) = K_min(n) + min(n_cons_mat(j,:,n));
        K_max(n) = K_max(n) + max(n_cons_mat(j,:,n));
    end
end

n_res_lim = K_min + round(NRS .* (K_max - K_min));

end