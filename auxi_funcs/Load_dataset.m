if strcmp(dataset,'dataset#1') == 1 % MCD of multispectral VS. multispectral
    load('dataset#1.mat')
    opt.type_t1 = 'optical';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#2') == 1 % MCD of multispectral VS. multispectral
    load('dataset#2.mat')
    opt.type_t1 = 'optical';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#3') == 1 % MCD of SAR VS. Optical
    load('dataset#3.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'optical';   
elseif strcmp(dataset,'dataset#4') == 1 % MCD of SAR VS. Optical
    load('dataset#4.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'optical';  
elseif strcmp(dataset,'dataset#5') == 1 % MCD of SAR VS. Optical
    load('dataset#5.mat')
    opt.type_t1 = 'optical';% the SAR image has been Log transformed
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#6') == 1 % MCD of multispectral VS. multispectral
    load('dataset#6.mat')
    opt.type_t1 = 'optical';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#7') == 1 % MCD of SAR VS. Optical
    load('dataset#7.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#8') == 1 % MCD of multispectral VS. multispectral
    load('dataset#8.mat')
    opt.type_t1 = 'optical';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#9') == 1 % MCD of SAR VS. Optical
    load('dataset#9.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'optical';
elseif strcmp(dataset,'dataset#10') == 1 % MCD of SAR VS. SAR with different ENL
    load('dataset#10.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'sar';
elseif strcmp(dataset,'dataset#11') == 1 % MCD of SAR VS. SAR with different ENL
    load('dataset#11.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'sar';
elseif strcmp(dataset,'dataset#12') == 1 % MCD of SAR VS. SAR with different ENL
    load('dataset#12.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'sar';
elseif strcmp(dataset,'dataset#13') == 1 % MCD of SAR VS. SAR with different ENL
    load('dataset#13.mat')
    opt.type_t1 = 'sar';
    opt.type_t2 = 'sar';
end
%% plot images
if strcmp(dataset,'dataset#1') == 1
    figure;
    subplot(131);imshow(2*image_t1(:,:,[4 3 2]));title('imaget1')
    subplot(132);imshow(6*image_t2(:,:,[7 5 4]));title('imaget2')
    subplot(133);imshow(Ref_gt,[]);title('Refgt')
elseif strcmp(dataset,'dataset#6') == 1
    figure;
    subplot(131);imshow(2*image_t1(:,:,[4 3 2]));title('imaget1')
    subplot(132);imshow(2*image_t2(:,:,[7 5 4]));title('imaget2')
    subplot(133);imshow(Ref_gt,[]);title('Refgt')
elseif strcmp(dataset,'dataset#5') == 1
    figure;
    subplot(131);imshow(image_t1);title('imaget1')
    subplot(132);imshow(image_t2+1);title('imaget2')
    subplot(133);imshow(Ref_gt,[]);title('Refgt')
else
    figure;
    subplot(131);imshow(image_t1);title('imaget1')
    subplot(132);imshow(image_t2);title('imaget2')
    subplot(133);imshow(Ref_gt,[]);title('Refgt')
end
