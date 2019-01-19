% Scenario 2
 m = prnist([0:9],[1:100:1000]); 
 a = my_rep(m);

[trn,tst] = gendat(a,0.8);
[v,N] = pcam(trn,0.95);
N
% 
% disp('boosting')
 boost(nmc,trn,tst)
 boost(knnc,trn,tst)
 
% disp('boosting PCA')
% boost(v*nmc,trn,tst)
% boost(v*knnc,trn,tst)
% boost(v*naivebc,trn,tst)
% 
%  disp('bagging - PCA')
%  bag(v*parzenc(1),trn,tst,votec)
%  bag(v*parzenc(1),trn,tst,prodc)
%  bag(v*parzenc(1),trn,tst,meanc)
%  bag(v*parzenc(1),trn,tst,minc)  
%  bag(v*parzenc(1),trn,tst,maxc) 
 
%  disp('bagging')
%  bag(nmc,trn,tst,votec)
%  bag(nmc,trn,tst,prodc)
%  bag(nmc,trn,tst,meanc)
%  bag(nmc,trn,tst,minc)  
%  bag(nmc,trn,tst,maxc) 

% disp('bagging PCA')
% bag(v*nmc,trn,tst)
% bag(v*knnc,trn,tst)
% bag(v*naivebc,trn,tst)
% bag(v*parzenc(1),trn,tst)

%knnc
function boost(alg,trn,tst)
    w = adaboostc(trn,alg);
    e1 = tst*w*testc
    e2 = nist_eval('my_rep',w,100)
end

%v = [knnc*classc parzenc(0.5)*classc]*naivebc;

%nmc, knnc, parzenc, naivebc
function bag(alg,trn,tst,type)
    w = baggingc(trn,alg,50,type);
    e1 = tst*w*testc
    e2 = nist_eval('my_rep',w,100)
end

function just_test(trn,tst)
    e1 = tst*w*testc
    e2 = nist_eval('my_rep',w,100)
end


function final_test(trn,algorithm)
    w = trn*algorithm;
    e = nist_eval('my_rep',w,100);
    X = sprintf('e = %d',e);
    disp(X);
end