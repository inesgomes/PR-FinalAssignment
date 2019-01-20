% linear (week 5) : loglc
% non-parametric (week 4) : parznc, knnc, naivebc

%SCENARIO 1: trained once and then applied 200-1000 objs 
%feature : pixels!

%combiners: start by analysing the confusion matrix, 

%reject curves? should we use this?

%labels
%W*a*labelc

function scenario1()
    %addpaths() %just the first run :)
    a = matfile('data3535.mat');
    trn = a.a;
    
    %trying with knn because it's good
    disp('35x35 pixel');
    batch_tests(trn,knnc);
    
    %you can add here your algorithms!
    
end

function batch_tests(trn,algorithm)
    %regular 
    regular_test(trn,algorithm);
    %combiners
    combiners_test(trn,algorithm);
    %pca
    pca_test(trn,algorithm); 
    %something else?
    
    %cross-val ?
    e = prcrossval(trn,algorithm,10,10);
    X = sprintf('Cross-Val  e = %d',e);
    disp(X);
end

function regular_test(trn,algorithm)
    w = trn*algorithm;
    e = nist_eval('my_rep',w,100);
    X = sprintf('Normal     e = %d',e);
    disp(X);
end

function combiners_test(trn,algorithm)
    %TODO
end

function pca_test(trn,algorithm)
    u = scalem([],'variance')*pcam([],0.95)*algorithm;
    w = trn*u;
    e = nist_eval('my_rep',w,100);
    X = sprintf('PCA        e = %d',e);
    disp(X)
end
