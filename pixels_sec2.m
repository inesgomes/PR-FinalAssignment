%SCENARIO 2: train with 10 ojbects, goal 75% accuracy
%feature : pixels!
%--------------------------------------
% use my_rep with im_resize([],[16 16])
% use my_rep with im_resize([],[35 35])

% Scenario 2
m = prnist([0:9],[1:100:1000]);

%create big training set
preproc = im_box([],0,1)*im_rotate*im_resize([],[16 16])*im_box([],1,0);
obj1 = m * preproc;
obj2 = m * preproc*im_rotate([],0.4);
obj3 = m * preproc*im_rotate([],-0.4);
obj4 = m * preproc*im_rotate([],0.2);
obj5 = m * preproc*im_rotate([],-0.2);
obj6 = m * preproc*im_rotate([],0.1);
obj7 = m * preproc*im_rotate([],-0.1);
merged = [obj1; obj2; obj3; obj4; obj5; obj6; obj7];
trn = prdataset(merged);

w = baggingc(trn,pcam([],0.95)*nmc,50,meanc);

%prcrossval(trn,knnc,10);

e = nist_eval('my_rep', trn*w, 100)

%final_test(a, ldc);
function final_test(trn,algorithm)
    w = trn*algorithm;
    l = labeld * w;
    l
    e = nist_eval('my_rep',w, 50);
    X = sprintf('Normal     e = %d',e);
    disp(X);
end
