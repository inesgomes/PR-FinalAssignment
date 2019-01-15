function a = my_rep(m)
    %load and preprocess some data
    preproc = im_box([],0,1)*im_rotate*im_resize([],[35 35])*im_box([],1,0);
    obj = m * preproc;
    %show(obj)
    a=prdataset(obj);
end