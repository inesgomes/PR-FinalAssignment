%SCENARIO 2: train with 10 ojbects, goal 75% accuracy
%feature : pixels!
%--------------------------------------
% use my_rep with im_resize([],[16 16])
% use my_rep with im_resize([],[35 35])

% Scenario 2
m = prnist([0:9],[1:100:1000]);

%create big training set
preproc = im_box([],0,1)*im_rotate*im_resize([],[16 16])*im_box([],1,0);
%rotate images
obj1 = m * preproc;
obj2 = m * preproc*im_rotate([],0.4);
obj3 = m * preproc*im_rotate([],-0.4);
obj4 = m * preproc*im_rotate([],0.2);
obj5 = m * preproc*im_rotate([],-0.2);
%create dataset
a1 = prdataset(obj1);
a2 = prdataset(obj2);
a3 = prdataset(obj3);
a4 = prdataset(obj4);
a5 = prdataset(obj5);
%add noise
a1_n = gendatk(a1);
a2_n = gendatk(a2);
a3_n = gendatk(a3);
a4_n = gendatk(a4);
a5_n = gendatk(a5);
      
a = [a1;a1_n;a2;a2_n;a3;a3_n;a4;a4_n;a5;a5_n];
%a = [a_n;a2_n;a3_n];
    
%algorithm = svc([],proxm('p',4));
algorithm = knnc;
%algorithm = parzenc([],1);
   
batch_tests(a,algorithm);
u = pcam([],0.95)*algorithm;
final_test(a,u);

%OTHERS
%w1 = baggingc(trn,pcam([],0.95)*nmc,50,meanc);

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
    e = nist_eval('my_rep',w, 50);
    X = sprintf('FINAL     e = %d',e);
    disp(X);
end
