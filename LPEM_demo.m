clear;
close all
addpath(genpath(pwd))
%% load dataset
% dataset#1 to #13, where dataset#1-#5 are used in the paper.
dataset = 'dataset#1'; 
Load_dataset % For other datasets, we recommend a similar pre-processing as in "Load_dataset"
image_t1 = image_normlized(image_t1,opt.type_t1);
image_t2 = image_normlized(image_t2,opt.type_t2);
fprintf(['\n Data loading is completed...... ' '\n'])
%% Parameter setting
% With different parameter settings, the results will be a little different
% Ns: the number of superpxiels,  Ns = 5000 is recommended.
% alpha: 0.2 <= alfa <= 0.9 is recommended.
% beta: beta = 5 is recommended.
%--------------------Available datasets and Parameters---------------------
%    Dataset       |     alpha     |        min(sparse_level*7.5,0.9)  |   
%   dataset#1      |      0.9      |               0.7979              |
%   dataset#2      |      0.9      |               0.9000              |
%   dataset#3      |      0.3      |               0.3447              |
%   dataset#4      |      0.5      |               0.4911              |
%   dataset#5      |      0.3      |               0.3280              |
%   dataset#6      |      0.5      |               0.6551              |
%   dataset#7      |      0.2      |               0.2524              |
%   dataset#8      |      0.4      |               0.4627              |
%   dataset#9      |      0.4      |               0.4812              |
%   dataset#10     |      0.9      |               0.9000              |
%   dataset#11     |      0.2      |               0.0802              |
%   dataset#12     |      0.3      |               0.2515              |
%   dataset#13     |      0.4      |               0.4439              |
%--------------------------------------------------------------------------
% When the sparsity level is unknown, alpha can be set according to the above table
sparsity_level = sum(Ref_gt(:))/(size(Ref_gt,1)*size(Ref_gt,2));
par.alpha = min(sparsity_level*7.5,0.9); 
par.beta = 5;
par.Ns = 5000;
% LSA is more robust than QPBO, but not as fast as QPBO! In the paper, we use the LSA£¡
par.SolutionMethod = 'QPBO'; % QPBO or LSA
if strcmp(dataset,'dataset#2') == 1 && par.Ns <=5000
    par.SolutionMethod = 'LSA';
end
par
%% LPEM
fprintf(['\n LPEM is running...... ' '\n'])
time = clock;
[CM,labels,Cosup] = LPEM_main(image_t1,image_t2,par);
change_ratio = sum(CM(:))/(size(CM,1)*size(CM,2));
if  change_ratio > (1-1e-5)
    par.alfa = par.alfa/2;
    [CM,labels,Cosup] = LPEM_main(image_t1,image_t2,par);
end
if  change_ratio < 1e-5
    par.alfa = par.alfa*2;
    [CM,labels,Cosup] = LPEM_main(image_t1,image_t2,par);
end
fprintf('\n');fprintf('The total computational time of LPEM using %s is %i \n', par.SolutionMethod,etime(clock,time));
fprintf(['\n' '====================================================================== ' '\n'])

%% Displaying results
fprintf(['\n Displaying the results...... ' '\n'])
figure;
subplot(121);imshow( CMplotRGB(CM,Ref_gt));title('Change map')
subplot(122);imshow(Ref_gt,[]);title('Ground truth')
[tp,fp,tn,fn,fplv,fnlv,~,~,OA,kappa]=performance(CM,Ref_gt);
F1 = 2*tp/(2*tp+fp+fn);
result = 'LPEM: OA is %4.3f; Kc is %4.3f; F1 is %4.3f \n';
fprintf(result,OA,kappa,F1)
%% 
if F1 < 0.3
   fprintf('\n');disp('Please select the appropriate alpha and beta for LPEM!')
end 

