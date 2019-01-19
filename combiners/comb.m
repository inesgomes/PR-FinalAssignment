% Scenario 2
 m = prnist([0:9],[1:100:1000]); 
 a = my_rep(m);

v = [knnc parzenc(1)]*nmc;

[tst,trn] = gendat(a,0.8);

disp('fisherc')
cm(svc([],proxm('p',1)),trn,tst);
disp('nmc')
cm(nmc,trn,tst)

%prcrossval(a,v,10);
%final_test(a,v);

function cm(v,trn,tst)
    lab = getlab(tst);
    w = trn*v;
    lab2 = tst*w*labeld;
    confmat(lab,lab2);
end

function final_test(trn,algorithm)
    w = trn*algorithm;
    e = nist_eval('my_rep',w,100);
    X = sprintf('e = %d',e);
    disp(X);
end