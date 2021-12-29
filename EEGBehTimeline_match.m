function [match_MI,match_M_data]=EEGBehTimeline_match(oricue_marker,M_type,M_data,step)
% oricue_marker:marker inform
% M_type:
% M_data:
% step:
match_MI=zeros(size(oricue_marker));
match_M_data=zeros(size(M_data));
l=length(M_type);
while 1
%% forward direction match
i=1;
while 1
pattern=M_type(i:i+step);
pat_dat=M_data(i:i+step);
index=findpattern(oricue_marker,pattern);
if isempty(index)
elseif length(index)~=1
    [~,Index] = min(abs(i-index));
    match_MI(index(Index):index(Index)+step)=pattern;
    match_M_data(index(Index):index(Index)+step)=pat_dat;
elseif length(index)==1
    match_MI(index(1):index(1)+step)=pattern;
    match_M_data(index(1):index(1)+step)=pat_dat;
end
i=i+1;
if i+step==l
    break
end
end
%% backward direction match
ii=l;
while 1
pattern=M_type(ii-step:ii);
index=findpattern(oricue_marker,pattern);
if isempty(index)
elseif length(index)~=1
    [~,Index] = max(abs(ii-index));
    match_MI(index(Index):index(Index)+step)=pattern;
    match_M_data(index(Index):index(Index)+step)=pat_dat;
elseif length(index)==1
    match_MI(index(1):index(1)+step)=pattern;
    match_M_data(index(1):index(1)+step)=pat_dat;
end
ii=ii-1;
if ii-step==1
    break
end
end
%% break loop
if length(find(match_MI==0))+l==length(oricue_marker)
    fprintf('Successful')
    fprintf('\n');
    break
elseif step<5
    fprintf('Almost successful')
    fprintf('\n'); 
    break
end
step=step-1;
end
end

