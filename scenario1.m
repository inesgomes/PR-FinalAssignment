% linear (week 5) : loglc
% non-parametric (week 4) : parznc, knnc, naivebc

%SCENARIO 1: trained once and then applied 200-1000 objs 
%pixels!

%combiners: which ones

function scenario1()
    a = matfile('data1.mat');
    
    %first test
    R_vec = zeros(10,4);
    for i=1:10
        %divide in test and training set --> should not be in here
        [trn,tst] = gendat(a.a,0.8);
        %compute classifier
        W = compute_classifier(trn);
        %calculate the error
        R_vec(i,:) = testc(tst*W);
    end
    plot(R_vec);
    legend('parzen','knn','naiveb','logl');
    mean(R_vec)
    
    %OR use cross-validation ?
    [trn,tst] = gendat(a.a,0.8);
    prcrossval(trn,{parzenc([],0.5),knnc,naivebc,loglc},10,10)
    
    %labels
    %W*a*labelc
    
    %learning curve and shit
    %cleval_version(a);
end

function W = compute_classifier(trn)
    h=0.5; k=3;

    %train it
    W = trn*{parzenc([],h),knnc([],k),naivebc,loglc};
    
    %should have: dimension reduction and 
end

%i'm confused about this one (about what Tax say to do)
function e = nist_eval(tst, W)
     %TODO
end

function cleval_version(data)
    h=0.5; k=3;
    W = {parzenc([],h),knnc([],k),naivebc,loglc};
    E =  cleval(data,W,[700 800 900],10);
    E.error
    plote(E)
end
