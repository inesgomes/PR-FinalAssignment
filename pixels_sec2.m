%SCENARIO 2: train with 10 ojbects, goal 75% accuracy
%feature : pixels!
%--------------------------------------
% use my_rep with im_resize([],[16 16])
% use my_rep with im_resize([],[35 35])

prwarning off

% Scenario 2
[trn, tst, a] = createDataset();
    
clsf = knnc;
%clsf = parzenc([],0.5);
u = pcam([],0.95)*clsf;
   
% SIMPLE TESTS
batch_tests(a,clsf);
final_test(a,clsf);
final_test(a,u);

%FEATURE SELECTION
% featnum = [1:20:324];
% mf = max(featnum);
% [w,r] = featseli(trn,'eucl-m',mf);
% e = clevalf(trn*w,u,featnum,[],1,tst*w);
% plote(e);
% x = trn*w*u;
% e_test = testc(tst*w*x);
%final_test(trn*w,u); %NOT WORKING

%TRAINING SET SIZES 
% sizes = [100,500,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
% e = cleval(trn,u,sizes,10,tst);
% plote(e);

%BAGGING
% w = baggingc(a,u,50,maxc);
% e_test = testc(tst*w)
% e = nist_eval('my_rep',w, 100)

%COMBINERS
% v = [knnc parzenc(0.5)]*nmc;
% v = [knnc parzenc(0.5) qdc]*votec;
% v = [knnc parzenc(0.5) nmc]*votec;
% w = trn*v;
% e_test = testc(tst*w)
% e = nist_eval('my_rep',a*v, 100)

%BOOSTING
% [w,v,alf] = adaboostc(trn,u);
% e_test = testc(tst*w)
% e = nist_eval('my_rep',w,100)


function [trn, tst, a] = createDataset
    m = prnist([0:9],[1:100:1000]);
    %optimal N
    N = 900;

    %create big training set
    preproc = im_box([],0,1)*im_rotate*im_resize([],[16 16],'cubic')*im_box([],1,0);
    %rotate images
    obj1 = m * preproc;
    obj4 = m * preproc*im_rotate([],0.4);
    obj5 = m * preproc*im_rotate([],-0.4);
    obj6 = m * preproc*im_rotate([],0.2);
    obj7 = m * preproc*im_rotate([],-0.2);
    %create dataset
    a1 = prdataset(obj1);
    a4 = prdataset(obj4);
    a5 = prdataset(obj5);
    a6 = prdataset(obj6);
    a7 = prdataset(obj7);
    %add noise
    a1_n = gendatk(a1,N);
    a4_n = gendatk(a4,N);
    a5_n = gendatk(a5,N);
    a6_n = gendatk(a6,N);
    a7_n = gendatk(a7,N);
    
    a =[a1;a1_n;a4;a4_n;a5;a5_n;a6;a6_n;a7;a7_n];
   
    %OTHERS
    %create test and training set
    [trn1,tst1] = gendat(a1,0.9);
    [trn4,tst4] = gendat(a4,0.9);
    [trn5,tst5] = gendat(a5,0.9);
    [trn6,tst6] = gendat(a6,0.9);
    [trn7,tst7] = gendat(a7,0.9);
    [tst1_n,trn1_n] = gendat(a1_n,[1,1,1,1,1,1,1,1,1,1]);
    [tst4_n,trn4_n] = gendat(a4_n,[1,1,1,1,1,1,1,1,1,1]);
    [tst5_n,trn5_n] = gendat(a5_n,[1,1,1,1,1,1,1,1,1,1]);
    [tst6_n,trn6_n] = gendat(a6_n,[1,1,1,1,1,1,1,1,1,1]);
    [tst7_n,trn7_n] = gendat(a7_n,[1,1,1,1,1,1,1,1,1,1]);
    
    trn = [trn1;trn4;trn5;trn6;trn7;trn1_n;trn4_n;trn5_n;trn6_n;trn7_n];
    tst = [tst1;tst4;tst5;tst6;tst7;tst1_n;tst4_n;tst5_n;tst6_n;tst7_n];
end

function batch_tests(a, algorithm)
    disp("10-fold - without PCA")
    prcrossval(a,algorithm,10);
    disp("10-fold - with PCA")
    prcrossval(a,pcam([],0.95)*algorithm,10);
    disp("10-fold - with PCA scaled")
    u = scalem([],'variance')*pcam([],0.95)*algorithm;
    prcrossval(a,u,10);
end

function final_test(trn,algorithm)
    w = trn*algorithm;
    e = nist_eval('my_rep',w, 100);
    X = sprintf('FINAL     e = %d',e);
    disp(X);
end
