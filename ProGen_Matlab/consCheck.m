function redo_flag = consCheck(J, m_num, Rq_r, Rq_n, R_num, N_num,...
    r_cons_mat, n_cons_mat, dur_mat)

redo_flag = 0;
m_list = 1:m_num;

% re resource check

for j = 2:J-1
    for m = m_list
        flag_r = zeros(1,R_num);
        flag_n = zeros(1,N_num);
        for mm = m_list(m_list~=m)
            for r = R_num
                if Rq_r(j,m,r) == 1 && Rq_r(j,mm,r) == 1
                    if dur_mat(j, m) <= dur_mat(j, mm)
                        if r_cons_mat(j,m,r) <= r_cons_mat(j,mm,r)
                            flag_r(r) = 1;
                        end
                    end
                end                
            end
            for n = N_num
                if Rq_n(j,m,n) == 1 && Rq_n(j,mm,n) == 1
                    if dur_mat(j, m) <= dur_mat(j, mm)
                        if n_cons_mat(j,m,n) <= n_cons_mat(j,mm,n)
                            flag_n(n) = 1;
                        end
                    end
                end
            end
        end
        if all([flag_r, flag_n])
            redo_flag = 1;
            break;
        end
    end
    if redo_flag == 1
        break;
    end
end

end

