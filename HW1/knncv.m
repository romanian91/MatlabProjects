function cv_error = knncv(traindata, trainlabels, n, k, f)
      % NUMBER OF CLASSES = 8 (labels in 'trainlabels' for 800)
      % NUMBER OF NEAREST NEIGHBORS = k
      % NUMBER OF TRAINING EXAMPLES = 800
      % NUMBER OF FEATURES = 512
      % NUMBER OF PARTITIONS OF TRAINING LABLES = n
%% Partition training data into n parts of ~approx equal size
    [divided_D,divided_L] = divide_training_into_n(traindata,trainlabels,n);
%% Compute Errors for several rounds leaving one fold out each time.
% Step 1. Use n-1 of these parts as training data
% Step 2. Make predictions on the held-out part
% Step 3. Repeat for all held out folds. Call the error of these predictions our cross-val error.
add_errors = 0;
    for ROUND = 1:n           
        % Take out desired fold
        cur_testdata = divided_D(:,:,ROUND);
        cur_testlabels = divided_L(:,:,ROUND);
        cur_traindata = giant_matrix_but_one(divided_D,ROUND);
        cur_trainlabels = giant_matrix_but_one(divided_L,ROUND);
        cur_predlabels = knn(cur_traindata, cur_trainlabels, cur_testdata, k, f);
        % FIX THIS LATER: 
        cur_predlabels = cur_predlabels';
        % Compare predicted labels to the ground truth for the test labels
        cur_error = calculate_error(cur_predlabels,cur_testlabels);
        disp(['ROUND = ' num2str(ROUND) '  Error this round = ' num2str(cur_error)]);
        add_errors = add_errors + cur_error;
    end
    % Cross validation error is the average error.
    cv_error = add_errors/n;
    %--nested functions--%
    function B = giant_matrix_but_one(A, delete_me)
        % Delete the i'th matrix
        A(:,:,delete_me)=[];
        % Create a giant matrix that stacks dimensions vertically
        B = permute(A,[1 3 2]);
        B = reshape(B,{},size(A,2),1);
    end
    function error = calculate_error(prediction_in, truth_in)
        % Ask if they are not equal, then count how many are not equal.
        num_missed = sum(prediction_in ~= truth_in);
        error = num_missed/size(truth_in,1);
    end
    function [Multi_A_test,Multi_L] = divide_training_into_n(T_data, L_data, n)
        % Assumption 1: Number of rows is the number of training examples
        % Assumption 2: Number of rows is evenly divisible by n.
        div = size(T_data,1)/n;
        diff = div - 1;
        % Create multidimensional array                  
        Multi_A_test = zeros(div,size(T_data,2),n);          % 80x512x10
        for j = 1:n
            up = j*div;
            low = up-diff;
            % disp(['low = ' num2str(low) '  up = ' num2str(up)]); 
            cur_matrix = T_data(low:up,:);
            size(cur_matrix);
            Multi_A_test(:,:,j) = cur_matrix;
        end
        % Also separate the labels
        Multi_L = reshape(L_data,div,1,n);
    end
end


% Extra:
%     % Useful for checking equality of multi-dim array to original array.
%     if(divided_D(:,:,2) == traindata(81:160,:))
%         disp('both equal');
%     end
%     if(divided_D(:,:,1) == traindata(1:80,:))
%         disp('both equal');
%     end


