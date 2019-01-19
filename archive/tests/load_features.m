%load and save data in data.mat, just to speed up things
function load_features(size,pixel,name)
    m = prnist([0:9],[1:10:size]);
    %load and preprocess some data
    preproc = im_box([],0,1)*im_rotate*im_resize([],[pixel pixel])*im_box([],1,0);
    obj = m * preproc;
    %show(obj)
    a = im_features(obj,obj,'all');
    a = prdataset(a);
    
    filename = strcat(name,'.mat');
    save(filename,'a');
end