%SCENARIO 1: train with 1000 ojbects, goal 95% error
%SCENARIO 2: train with 10 ojbects, goal 75% accuracy
%feature : pixels!
%--------------------------------------
% use my_rep with im_resize([],[16 16])
% use my_rep with im_resize([],[35 35])

% Scenario 1
% a = prnist([0:9],[1:1000]);
% Scenario 2
a = prnist([0:9],[1:100:1000]);
a = my_rep(a);
a = prdataset(a);

b = a*im_profile;
c = a*im_features;


% Scenario 1: Training and Testing with 10-fold cross validation.
disp("Profile: 10-fold - without PCA")
prcrossval(b,knnc([]),10);
disp("Profile: 10-fold - with PCA")
prcrossval(b,pcam([],0.95)*knnc([]),10);
disp("Features: 10-fold - without PCA")
prcrossval(c,knnc([]),10);
disp("Features: 10-fold - with PCA")
prcrossval(c,pcam([],0.95)*knnc([]),10);
% Scenario 2: Training and Testing with leave one out cross validation.
disp("Profile: Leave one out - without PCA")
prcrossval(b,knnc([]));
disp("Profile: Leave one out - with PCA")
prcrossval(b,pcam([],0.95)*knnc([]));
disp("Features: Leave one out - without PCA")
prcrossval(c,knnc([]));
disp("Features: eave one out - with PCA")
prcrossval(c,pcam([],0.95)*knnc([]));

function final_test(trn,algorithm)
    w = trn*algorithm;
    e = nist_eval('my_rep',w,100);
    X = sprintf('Normal     e = %d',e);
    disp(X);
end
