function train_error = calculate_train_error(traindata,trainlabels,k,f)
    % calculate the error on only using training data
    predlabels = knn(traindata, trainlabels, traindata, k, f);
    % FIX THIS LATER: 
    predlabels = predlabels';
    train_error = calculate_error(trainlabels,predlabels);
    % nested function
    function error = calculate_error(prediction_in, truth_in)
        % Ask if they are not equal, then count how many are not equal.
        num_missed = sum(prediction_in ~= truth_in);
        error = num_missed/size(truth_in,1);
    end

end

