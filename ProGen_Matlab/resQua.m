function [r_cons_mat, n_cons_mat] = resQua(J, m_num, Rq_r, Rq_n,...
    R_num, N_num, UR_min, UR_max, UN_min, UN_max, rp, np, dur_mat)

% re resource quantities
r_cons_mat = zeros(J, m_num, R_num);
if rand <= rp
    for j = 2:J-1
        min_d = min(dur_mat(j, :));
        max_d = max(dur_mat(j, :));
        if max_d ~= min_d
            d_interval = max_d - min_d;
        end
        UR = randi([UR_min,UR_max], 1, 2);
        UR_low = min(UR); UR_high = max(UR);
        UR_interval = UR_high - UR_low;
        delta = UR_interval / m_num;
        sorted_dur = sort(dur_mat(j, :));
        for m = 1:m_num
            for r = 1:R_num
                if Rq_r(j, m, r) == 1
                    d = dur_mat(j, m);
                    if max_d ~= min_d
                        idxs = find(sorted_dur == d);
                        delta_1 = idxs(1) * delta;
                        delta_2 = (idxs(1) - 1) * delta;
                        range = round([UR_high-delta_1, UR_high-delta_2]);
                        r_cons_mat(j, m, r) = randi(range);
                    else
                        r_cons_mat(j, m, r) = randi([UR_min, UR_max]);
                    end
                end
            end
        end
    end
    r_cons_mat(Rq_r == 0) = 0;
else
    r_cons_mat(2:J-1,:,:) = randi([UR_min, UR_max], 2:J-1, m_num, R_num);
    r_cons_mat(Rq_r == 0) = 0;
end

% nr resourec quantities
n_cons_mat = zeros(J, m_num, N_num);
if rand <= np
    for j = 2:J-1
        min_d = min(dur_mat(j,:));
        max_d = max(dur_mat(j,:));
        if max_d ~= min_d
            d_interval = max_d - min_d;
        end
        UN = randi([UN_min,UN_max], 1, 2);
        UN_low = min(UN); UN_high = max(UN);
        UN_interval = UN_high - UN_low;
        delta = UN_interval / m_num;
        sorted_dur = sort(dur_mat(j, :));
        for m = 1:m_num
            for n = 1:N_num
                if Rq_n(j, m, n) == 1
                    d = dur_mat(j, m);
                    if max_d ~= min_d
                        idxs = find(sorted_dur == d);
                        delta_1 = idxs(1) * delta;
                        delta_2 = (idxs(1) - 1) * delta;
                        range = round([UN_high-delta_1, UN_high-delta_2]);
                        n_cons_mat(j, m, n) = randi(range);
                    else
                        n_cons_mat(j, m, n) = randi([UN_min, UN_max]);
                    end
                end
            end
        end
    end
    n_cons_mat(Rq_n == 0) = 0;
else
    n_cons_mat(2:J-1,:,:) = randi([UN_min, UN_max], 2:J-1, m_num, N_num);
    n_cons_mat(Rq_n == 0) = 0;
end

end