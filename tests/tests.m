%TESTS DONE

function tests()
    a = matfile('data1.mat');
  
     R_vec = zeros(10,4);
     for i=1:10
         %divide in test and training set --> should not be in here
         [trn,tst] = gendat(a.a,0.8);
         %compute classifier
         W = trn*{parzenc([],0.5),knnc,naivebc,loglc};
         %calculate the error
         R_vec(i,:) = testc(tst*W);
     end
     plot(R_vec);
     legend('parzen','knn','naiveb','logl');
     mean(R_vec)
     
     %OR use cross-validation ?
     [trn,tst] = gendat(a.a,0.8);
     prcrossval(trn,{parzenc([],0.5),knnc,naivebc,loglc},10,10)
     
     %learning curve and shit
     cleval_version(a);
end

function cleval_version(data)
    h=0.5; k=3;
    W = {parzenc([],h),knnc([],k),naivebc,loglc};
    E =  cleval(data,W,[700 800 900],10);
    E.error
    plote(E)
end