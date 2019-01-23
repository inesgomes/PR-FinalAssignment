function a = my_rep(m)
    %load and preprocess some data
    preproc = im_box([],0,1)*im_rotate*im_resize([],[16 16])*im_box([],1,0);
    obj = m * preproc;
    %show(obj)
    a=prdataset(obj);
    
    %JUST FOR FEATURE SELECTION
%     [w,r] = featseli(a,'eucl-m',321);
%     a = a*w
end