function horizon = horiCalc(J, dur_mat)
horizon = 0;
for j = 2:J-1
    horizon = horizon + max(dur_mat(j,:));
end
end

