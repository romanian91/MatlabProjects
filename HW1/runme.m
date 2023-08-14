% Nearest Neighbor script to run knncv.m and knn.m
% Author: Chris Nogales

% Predict labels
%% Obtain data and set variables
clc
clear
%{
% There are 800 training images.
% From each image, they took 512 GIST features
% For each image, there is a label (1-8)
  k = number of neighbors
  f = distance function to use (ex: 'sqeuclidean')
  D = Matrix (ntrain x ntest) 
 %}
% Add path, load data
addpath('/home/nogalesc/MATLAB/HW1/k-NN/k-NN')
S = load('SceneCateg.mat');
traindata = S.trainfeatgist;
trainlabels = S.trainlabels;
testdata = S.testfeatgist;
% Choose k,f,n (D is optional)
k = 9;
f = 'sqeuclidean';
n = 10;                              % 10 fold cross validation
%% Randomly permute traindata and trainlabels
[traindata, trainlabels] = randomly_permute_both(traindata, trainlabels);
%% Problem 4.2.1
predlabels = knn(traindata, trainlabels, testdata, k, f);
% Make special matrix of alpha-numeric entries 
Image_ID =reshape(1:size(predlabels,2),1,size(predlabels,2));
predictions = horzcat(Image_ID',predlabels');
A = num2cell(predictions);
myCell = {'Image_ID','Category'};
finalAnswer =vertcat (myCell,A);
% Uncomment the following line to save data to excel sheet:
% xlswrite('test_finalAnswer.xls',finalAnswer)
%% Problem 4.2.2
cv_error = knncv(traindata, trainlabels, n, k, f);
train_error = calculate_train_error(traindata,trainlabels,k,f);
%% Plots
%{
    For k = 1, 2, . . . , 100, compute and plot the 10-fold (i.e., n = 10) cross-val error. Also plot
    the train error (i.e. if you train on all 800 images, and make predictions on these same 800
    images).
%}
n = 10;
f = 'sqeuclidean';
CV_ERRORS = zeros(100,1);
TRAIN_ERRORS = zeros(100,1);
for k = 1:100
    cur_cv_error = knncv(traindata, trainlabels, n, k, f);
    CV_ERRORS(k,1) = cur_cv_error;
    cur_train_error = calculate_train_error(traindata,trainlabels, k, f);
    TRAIN_ERRORS(k,1) = cur_train_error;
end
x = 1:k;
plot(x,CV_ERRORS,x,TRAIN_ERRORS);
legend('CV ERRORS','TRAIN ERRORS');
[M Indx] = min(CV_ERRORS);








