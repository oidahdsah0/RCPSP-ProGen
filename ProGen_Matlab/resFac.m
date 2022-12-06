function [Rq_r, Rq_n] = resFac(J, m_num, RRF, NRF, R_num,...
    N_num, RR_min, RR_max, NR_min, NR_max)

% re resource fac
if RRF ~= 1
    Rq_r = zeros(J, m_num, R_num);
    if RR_min ~= 0
        for j = 2:J-1
            m_idx = randi([1,m_num]);
            idxs = unique(randsample(1:R_num, RR_min));
            Rq_r(j,m_idx,idxs) = 1;
        end
    end

    % actual RRF
    ARRF = sum(sum(sum(Rq_r))) / (J * m_num * R_num);

    while ARRF < RRF
        j = randi([2, J-1]);
        m = randi([1, m_num]);
        r = randi([1, R_num]);
        while Rq_r(j,m,r) == 1 || sum(Rq_r(j,m,:)) >= RR_max
            j = randi([2, J-1]);
            m = randi([1, m_num]);
            r = randi([1, R_num]);
        end
        Rq_r(j,m,r) = 1;
        ARRF = sum(sum(sum(Rq_r))) / (J * m_num * R_num);
    end

elseif RRF == 1

    Rq_r = ones(J, m_num, R_num);

end
% nr resource fac
if NRF ~= 1
    Rq_n = zeros(J, m_num, N_num);
    if NR_min ~= 0
        for j = 2:J-1
            m_idx = randi([1,m_num]);
            idxs = unique(randsample(1:N_num, NR_min));
            Rq_n(j,m_idx,idxs) = 1;
        end
    end
    ANRF = sum(sum(sum(Rq_n))) / (J * m_num * N_num);

    while ANRF < NRF
        j = randi([2, J-1]);
        m = randi([1, m_num]);
        n = randi([1, N_num]);
        while Rq_n(j,m,n) == 1 || sum(Rq_n(j,m,:)) >= NR_max
            j = randi([2, J-1]);
            m = randi([1, m_num]);
            n = randi([1, N_num]);
        end
        Rq_n(j,m,n) = 1;
        ANRF = sum(sum(sum(Rq_n))) / (J * m_num * N_num);
    end

elseif NRF == 1

    Rq_n = ones(J, m_num, N_num);

end

end