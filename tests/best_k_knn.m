%best knn = 1
function best_k_knn()
    a = matfile('data1.mat'); 
    [trn,tst] = gendat(a.a,0.8);
    R_vec = zeros(10,1);
    for k=1:10
        w = trn*knnc([],k);
        for i=1:20
            R_vec(k,i) = testc(tst*w);
        end
    end
    plot(R_vec);
end