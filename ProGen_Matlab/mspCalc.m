function [K_max, real_odds] = mspCalc(AList, J, D, net_mat, cons_mat, horizon)

r_lim = 100000;

staTimes = zeros(1,J);
endTimes = zeros(1,J);
resOdds = repmat(r_lim,1,horizon);
real_odds = repmat(r_lim,1,horizon);

DList = AList(2:end-1);
schJobs = single(DList);

for iterI = 1:J-2
    [jobId,schJobs] = next(schJobs,DList);
    precJobs = single(find(net_mat(:,jobId)));
    staTimes(jobId) = max(staTimes(precJobs) + D(precJobs));
    [staTimes(jobId), endTimes(jobId)] = ...
        resourceCheck(staTimes(jobId), D(jobId), cons_mat(jobId), resOdds);
    durInter = staTimes(jobId)+1:endTimes(jobId);
    resOdds(:,durInter) = resOdds(:,durInter) - repmat(cons_mat(jobId),1,length(durInter));
end

real_odds = real_odds - resOdds;
K_max = max(real_odds);

end

function [eStTime,lStTime] = resourceCheck(eStTime,jobDur,rResConsumps,resCheckMat)
durMat = eStTime:eStTime+jobDur-1;
iterI = 1;
while any(any(repmat(rResConsumps,[1 numel(durMat)]) > resCheckMat(:,durMat+iterI)))
    iterI = iterI + 1;
end
eStTime = eStTime + iterI - 1;
lStTime = eStTime + jobDur;
end

function [jobNum,doList] = next(doList,AList)
jobNum = AList(ismember(AList,doList));
jobNum = jobNum(1); 
doList(doList == jobNum) = [];
end