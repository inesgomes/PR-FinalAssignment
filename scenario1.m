% linear (week 5) : loglc
% non-parametric (week 4) : parznc, knnc, naivebc

%SCENARIO 1: trained once and then applied 200-1000 objs 
%feature : pixels!

%combiners: start by analysing the confusion matrix, 

%labels
%W*a*labelc

function scenario1()
    %addpaths() %just the first run :)
    a = matfile('data1616.mat');
    trn = a.a;
    
    %train it: trying with knnc, because it is good
    w = trn*knnc;
    
    %combiners
    
    %pca
    
    %something else?
    
    %cross-val for some reason
    prcrossval(trn,knnc,10,10)
    
    %test it
    %final_test(trn*knn);
end

function final_test(w)
    nist_eval('my_rep',w,100)
end

function addpaths
    addpath('tests');
    addpath('../prtools');
    addpath('../coursedata');
end
