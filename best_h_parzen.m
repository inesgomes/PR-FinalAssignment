%best h=0.5
function best_h_parzen()
    a = matfile('data1.mat'); 
    [trn,tst] = gendat(a.a,0.8);
    hs = [0.01 0.05 0.1 0.25 0.5 1 1.5 2 3 4 5]; % Array of h's to try
    for i = 1:length(hs) % For each h...
        w = parzenm(trn,hs(i)); % estimate Parzen density
        LL(i) = sum(log((tst*w))); % calculate log-likelihood
    end
    plot(hs,LL); % Plot log-likelihood as function of h
end