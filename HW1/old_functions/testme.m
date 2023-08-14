% Nearest Neighbor script to run knncv.m and knn.m inline


% Predict labels
%%
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
% Add path and load data
addpath('/home/nogalesc/MATLAB/HW1/k-NN/k-NN')
S = load('SceneCateg.mat')
traindata = S.trainfeatgist;
trainlabels = S.trainlabels;
testdata = S.testfeatgist;
% Choose k,f (D is optional)
k = 11
f = 'sqeuclidean';
% Hint: precompute the distances b/t all pairs of points
D = distEucSq(traindata, traindata);                 % 800x800
%predlabels = knn(traindata, trainlabels, testdata, k, f);
%       sum_of_D = sum(D);
%       % Sort column-wise each of the 800 columns
%       [k_distances, index] = sort(D,'ascend');
%       % Delete distances after k
%       index = delete_after_k(index);
%       k_distances = delete_after_k(k_distances);
%       
      % Create matrix of half Gaussian values
      w = gausswin(k*2)
      nw = cut_in_half(w);
      % Repeat this half Gaussian
      nw = repmat(nw,1,size(index,2));
      
      % No weights, k nearest neighbor
      % Just count...and take the class of the
      % most common neighbor.
      % k = number of neighbors to look at.
      % 
      why = histcounts(D,size(D,2));
      histogram(D,size(D,2))
      % Weighted majority vote
      % (Closest neighbors get more weight.)
      % TRAIN DATA = 800x512 features
      %predlabels = nw*
     
      
%       fprintf('Using squared euclidean distance.')
%   otherwise
%       disp('Error, no distance function! Try again!') 
% end
%   % Nested fuctions
%     function Data_out = delete_after_k(Data_in)
%       % Delete the first row (distances of 0)
%       Data_in(1,:)=[];
%       % Delete all but the first k rows (closest neighbors class indexes)
%       Data_in(k+1:end,:) = [];
%       Data_out = Data_in;
%     end
% 
    function nw = cut_in_half(w)
      if(size(w,1) > 1) 
        nw = w((size(w,1)/2)+1:end);
      end
    end
% 
%     end

    %Im = mat2gray(D);
%imshow(Im)
