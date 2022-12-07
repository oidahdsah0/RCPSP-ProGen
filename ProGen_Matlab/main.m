%%% Cleaning workspace
clc;clear;clf;close all;

%% Important parameters

% real jobs num
J_proj = 20;
% mode num
m_list = 1 % or [1, 2, 3];
% network complexity
C_list = 1.5 % or [1.5, 1.8, 2.1];
% re resource limit params
RRF_list = 0.7 % or [0.7, 0.8, 0.9];
RRS_list = 0.6 % or [0.6, 0.8, 1.0];
% nr resource limit params
NRF = 1.0; NRS = 0.7;
% example num
expNum = 100;
for m_num = m_list
    for C = C_list
        for RRF = RRF_list
            for RRS = RRS_list
                % example file save path
                file_head = num2str(J_proj);
                save_path_1 = strcat('./dataSets/', file_head, '/');
                save_path_2 = "J" + num2str(J_proj) + "_M" + num2str(m_num) + ...
                    "_NC" + num2str(C) + "_RRF" + num2str(RRF,'%.1f') + "_RRS" + num2str(RRS) + ...
                    "/";
                save_path = strcat(save_path_1, save_path_2);

                %% Base Data Generation

                % total number of jobs
                J = J_proj + 2; n = J;

                % duration limit
                d_min = 1; d_max = 10;
                dur_mat = zeros(J, m_num);
                % Step 0 - Basic data
                dur_mat(2:J-1, :) = randi([d_min, d_max], J_proj, m_num);
                horizon = horiCalc(J, dur_mat);

                %% Network Generation

                % the minimal number of non-redundant arcs
                A_min = J - 1;

                % The maximal number of non-redundant arcs
                if mod(n, 2) == 0
                    A_max = n - 2 + ((n - 2) / 2) ^ 2;
                else
                    A_max = n - 2 + ((n - 1) / 2) * ((n - 3) / 2);
                end

                % maximal number of predecessors per activity
                max_in = 3;
                % maximal number of successor per activity
                max_out = 3;
                % minmimal number of start activities / MinOutSource
                S_1_min = 1;
                % maximal number of start activities / MaxOutSource
                S_1_max = 3;
                % minmimal number of finish activities / MinInSink
                P_J_min = 1;
                % maximal number of finish activities / MaxInSink
                P_J_max = 2;
                % tolerated network deviation
                epsilon_net = 0.05;

                % resource available num
                R_min = 2; R_max = 2;
                R_num = randi([R_min, R_max]);
                N_min = 2; N_max = 2;
                N_num = randi([N_min, N_max]);
                % resource type request limit
                RR_min = 1; RR_max = 2;
                NR_min = 1; NR_max = 2;
                % resource quantities request limit
                UR_min = 1; UR_max = 10;
                UN_min = 1; UN_max = 10;
                % probability to choose monotonically decreaseing function
                rp = 1; np = 1;

                %% Main Loop

                for iterMain = 1:expNum

                    redo_flag = 1;

                    while redo_flag

                        % Step 1
                        [net_mat, st_act_list, ed_act_list, init_list] = netStep1(J, S_1_min, ...
                            S_1_max, P_J_min, P_J_max);

                        % Step 2
                        net_mat = netStep2(net_mat, st_act_list, ed_act_list, init_list, max_out);

                        % Step 3
                        [net_mat, redo_flag] = netStep3(net_mat, J, max_in, st_act_list, ed_act_list);
                        if redo_flag == 1
                            continue;
                        end

                        % Step 4
                        [net_mat, redo_flag] = netStep4(net_mat, J, C, max_in, max_out, st_act_list, ed_act_list);
                        if redo_flag == 1
                            continue;
                        end

                        if sum(sum(net_mat)) > J * C * (1 + epsilon_net)
                            redo_flag = 1;
                        else
                            redo_flag = 0;
                        end
                        if redo_flag == 1
                            continue;
                        end

                        % resource part

                        % resource factor
                        [Rq_r, Rq_n] = resFac(J, m_num, RRF, NRF, ...
                            R_num, N_num, RR_min, RR_max, NR_min, NR_max);

                        % resource quantities
                        [r_cons_mat, n_cons_mat] = resQua(J, m_num, Rq_r, Rq_n, R_num, N_num,...
                            UR_min, UR_max, UN_min, UN_max, rp, np, dur_mat);

                        if m_num > 1
                            redo_flag = consCheck(J, m_num, Rq_r, Rq_n, R_num, N_num,...
                                r_cons_mat, n_cons_mat, dur_mat);
                        end
                        if redo_flag == 1
                            continue;
                        end

                        % nr resource strength
                        n_res_lim = nresStr(J, NRS, N_num, n_cons_mat);

                        % re resource strength
                        [r_res_lim, max_cons] = rresStr(J, RRS, R_num, r_cons_mat, dur_mat, net_mat, horizon);

                    end

                    example_fileName = num2str(iterMain) + ".mat";

                    if exist(save_path,'dir') == 0
                        mkdir(save_path);
                    end
                    % 'MPM_Time' is lower border of the problem
                    save(strcat(save_path,example_fileName),...
                        'J','m_num','horizon','R_num','N_num','net_mat',...
                        'dur_mat','r_cons_mat','n_cons_mat',...
                        'r_res_lim','n_res_lim','max_cons');

                    disp("Example " + num2str(iterMain) + " Finished !");

                end
            end
        end
    end
end
disp("=== All Procession Finished ! ===");
