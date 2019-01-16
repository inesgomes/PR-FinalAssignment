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

%============================
% NMC
%============================
% => Scenario2 
% err100 = prcrossval(a,nmc([]));
% fprintf('NMC 100-fold error = %d\n', err100);
% err100pca = prcrossval(a,pcam([],0.95)*nmc([]));
% fprintf('NMC 100-fold + PCA error = %d\n', err100pca);

% => Scenario1 
% err10 = prcrossval(a,nmc([]), 10);
% fprintf('NMC 10-fold error = %d\n', err10);
% err10pca = prcrossval(a,pcam([],0.95)*nmc([]), 10);
% fprintf('NMC 10-fold + PCA error = %d\n', err10pca);
%============================
% LDC
%============================
% => Scenario2 
% err100 = prcrossval(a,ldc([]));
% fprintf('LDC 100-fold error = %d\n', err100);
% err100pca = prcrossval(a,pcam([],0.95)*ldc([]));
% fprintf('LDC 100-fold + PCA error = %d\n', err100pca);

% => Scenario1 
% err10 = prcrossval(a,ldc([]), 10);
% fprintf('LDC 10-fold error = %d\n', err10);
% err10pca = prcrossval(a,pcam([],0.95)*ldc([]), 10);
% fprintf('LDC 10-fold + PCA error = %d\n', err10pca);
%============================
% QDC
%============================
% => Scenario2 
% err100 = prcrossval(a,qdc([]));
% fprintf('QDC 100-fold error = %d\n', err100);
% err100pca = prcrossval(a,pcam([],0.95)*qdc([]));
% fprintf('QDC 100-fold + PCA error = %d\n', err100pca);

% => Scenario1 
% err10 = prcrossval(a,qdc([]), 10);
% fprintf('QDC 10-fold error = %d\n', err10);
% err10pca = prcrossval(a,pcam([],0.95)*qdc([]), 10);
% fprintf('QDC 10-fold + PCA error = %d\n', err10pca);
%============================
% FISHERC
%============================
% => Scenario2 
% err100 = prcrossval(a,fisherc([]));
% fprintf('FISHERC 100-fold error = %d\n', err100);
% err100pca = prcrossval(a,pcam([],0.95)*fisherc([]));
% fprintf('FISHERC 100-fold + PCA error = %d\n', err100pca);

% => Scenario1 
% err10 = prcrossval(a,fisherc([]), 10);
% fprintf('FISHERC 10-fold error = %d\n', err10);
% err10pca = prcrossval(a,pcam([],0.95)*fisherc([]), 10);
% fprintf('FISHERC 10-fold + PCA error = %d\n', err10pca);



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
