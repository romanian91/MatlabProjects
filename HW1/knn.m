% Author: Chris Nogales
function predlabels = knn(traindata, trainlabels, testdata, k, f)
predlabels = size(trainlabels);
      % NUMBER OF CLASSES = 8 (labels in 'trainlabels' for 800)
      % NUMBER OF NEAREST NEIGHBORS = k
      % NUMBER OF TRAINING EXAMPLES = 800
      % NUMBER OF FEATURES = 512
switch f
    case char('default')
      fprintf('Using euclidean distance.  ')
    case char('sqeuclidean')
      fprintf('Using squared euclidean distance.  ')
      D = distEucSq(traindata, testdata);                 % 800x800
      % Sort column-wise each of the 800 columns by distance
      [~, index] = sort(D,'ascend');
      % Ignore all neighbors after k nearest neighbors
      index = delete_after_k(index);
      % Find index replace with class #
      a = create_matrix_of_classes(index,trainlabels);
      % Tell me what is the most common class in each column
      predlabels = mode(a,1);
      % Make predlabels into a column vector.
      % predlabels = predlabels';
    otherwise
      disp('Error, no distance function! Try again!') 
end
    %--Nested fuctions--%
    % Delete all but the first k rows (closest neighbors class indexes)
    function Data_out = delete_after_k(Data_in)
      Data_in(k+1:end,:) = [];
      Data_out = Data_in;
    end
    % Find index of each near neighbor and replace with class #
    function indices_of_k = create_matrix_of_classes(indices_of_k,class_labels)
        for r = 1:size(indices_of_k,1)
            for c = 1:size(indices_of_k,2)
              cur_index = indices_of_k(r,c);
              cur_class = class_labels(cur_index);
              indices_of_k(r,c) = cur_class;
            end 
        end     
    end
end