% linear (week 5) : loglc
% non-parametric (week 4) : parznc, knnc, naivebc

%SCENARIO 1: trained once and then applied 200-1000 objs 
%pixels!

%1: process

function scenario1()
    a = matfile('data1.mat');
    
    %divide in test and training set --> should not be in here
    [trn,tst] = gendat(a.a,0.8);
    
    %compute classifier
    W = compute_classifier(trn);
    
    %labels
    %W*a*labelc
    
    e = nist_eval(tst,W);
    e
    
    %learning curve and shit
    %cleval_version(a);
end

function W = compute_classifier(trn)
    h=0.5; k=3;

    %train it
    W = trn*{parzenc([],h),knnc([],k),naivebc,loglc};
    
    %should have: dimension reduction and 
end

%i'm confused about this one
function e = nist_eval(tst, W)
    %test 10 times and do the average
    R_vec = zeros(10,4);
    for i=1:10
        R_vec(i,:) = testc(tst*W);
    end
    e = mean(R_vec);
end

function cleval_version(data)
    h=0.5; k=3;
    W = {parzenc([],h),knnc([],k),naivebc,loglc};
    E =  cleval(data,W,[700 800 900],10);
    E.error
    plote(E)
end
