%% Calculate Node Functional Connectivity 
% ts in rows, edges in columns ie 450x35778
tic
load('onesub.mat'); %load the subject data

%Initialization
examplesub=out.ts{peeps}';
num_nodes=size(examplesub,2); %find the number of nodes
num_edges=nchoosek(num_nodes,2); %calculate the number of edges
x=zeros(nchoosek(num_edges,2),1); %preallocate 'x' as correct size. 'x' will be input to CPM
comb=nchoosek(1:num_nodes,2); %create matrix of all combinations of nodes



for peeps=1:length(out.ts) %for each person in dataset
    sub=out.ts{peeps}'; %sub = current participant's data
    TEMP=zeros(size(sub,1),length(comb)); %create temp matrix for filling with edge TS data
    
    for k=1:num_edges %for all the possible combinations of nodes
        TEMP(:,k)=sub(:,comb(k,1)).*sub(:,comb(k,2)); %calculate dot produce of node timeseries & store in TEMP
    end
    
%% Calculate Edge Functional Connectivity Matrix
    location = 'Users/Anita/Documents/MATLAB/Edge/datastorage';
    TEMPtall=tall(TEMP);
    comb2=tall(nchoosek(1:num_edges,2));

    TEMP2tall=tall(zeros(size(x,1),1)); %create temp vector for filling with edge correlation coefficients

    for kk=1:size(x,1) % for all possible combinations
        TEMP2(kk)=corr(TEMP(comb2(kk,1),:),TEMP(comb2(kk,2),:));
    end
    x(:,peeps)=TEMP2;
    write(location,x);
end
toc