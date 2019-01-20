function cleval_version(data)
    h=0.5; k=3;
    W = {parzenc([],h),knnc([],k),naivebc,loglc};
    E =  cleval(data,W,[700 800 900],10);
    E.error
    plote(E)
end