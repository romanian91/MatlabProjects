% Machine Learning
clc;
clear;
% First extract data
load('hw3_raw_data.mat');   

% Choose C
C = 10;
% Extract labels
y = traindata(:,29);
traindata(:,29) = [];
% We have 28 features, 10,000 samples, last col is label
ntrain = size(traindata,1);  % matrix 10000x28
ndim = size(traindata,2);
% What is z? A really big matrix. [w w0 ei]
my_z = [zeros(ndim,1); zeros(1); zeros(ntrain,1)];
sz_z = ndim + ntrain + 1;      % 10,029
sz_dim = ndim;
sz_samples = ntrain;
sz_bias = 1;
% construct H, f A, b, and lb
H = zeros(sz_z);
H(1:ndim,1:ndim) = eye(ndim);
% construct f
f = [zeros(ndim,1); zeros(1); C*ones(ntrain,1)]';
% construct A
A_1 = zeros(size(traindata));
for i = 1:size(y,1)
    A_1(i) = y(i).*(traindata(i));
end
A_2 = eye(ntrain);
A_3 = y;
A = horzcat(A_1,A_2,A_3);
b = (-1)*ones(size(y));
% lb = Represents the lower bounds elementwise in lb ≤ x ≤ ub.
lb = zeros(size(y));
% 
% f = [0 0 C];
% A = 
% b = 1;
% lb = zeros(2,1);
% 
% 
tic
z = quadprog(H,f,A,b,[],[],lb);
toc


