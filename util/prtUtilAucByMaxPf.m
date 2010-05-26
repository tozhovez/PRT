function auc = prtUtilAucByMaxPf(pf,pd,maxPfVal)
%auc = prtUtilAucByMaxPf(pf,pd,maxPfVal)

pf = pf(:);
pd = pd(:);

[pf,sortInd] = sort(pf,'ascend');
pd = pd(sortInd);

pf(end+1) = maxPfVal + eps;
pd(end+1) = pd(end);

firstInd = find(pf > maxPfVal,1,'first');

pf = pf(1:firstInd);
pd = pd(1:firstInd);
auc = trapz(pf,pd);
