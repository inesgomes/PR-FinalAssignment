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


% Scenario 1: Training and Testing with 10-fold cross validation.
% disp("10-fold - without PCA")
% prcrossval(a,knnc([]),10);
% disp("10-fold - with PCA")
% prcrossval(a,pcam([],0.95)*knnc([]),10);
% Scenario 2: Training and Testing with leave one out cross validation.
disp("Leave one out - without PCA")
prcrossval(a,knnc([]));
disp("Leave one out - with PCA")
prcrossval(a,pcam([],0.95)*knnc([]));

% Parameter optimization. (use if needed)
% param = ['p', 'r']; % Array of params
% for i = 1:length(param)
%     prcrossval(a,svc([],(proxm(param(i),1)),1));
% end

% nist_eval to evaluate performance of best implementation(once at the end)
% final_test(a, pcam([],0.95)*knnc([]));

function final_test(trn,algorithm)
    w = trn*algorithm;
    e = nist_eval('my_rep',w,100);
    X = sprintf('Normal     e = %d',e);
    disp(X);
end
