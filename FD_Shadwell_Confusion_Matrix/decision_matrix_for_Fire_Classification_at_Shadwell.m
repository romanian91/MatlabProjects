% g1 = [1 1 2 2 3 3]';		% Known groups
% g2 = [1 1 2 3 4 NaN]';	% Predicted groups
% 
% [C,order] = confusionmat(g1,g2)

%read data example: Import columns as column vectors 
%[W X Y Z] = csvimport('shadwell_2014_11_06_04_33_.csv', 'columns', {'Predicted_class', 'Predicted', 'Truth_class','Truth'});
[W X Y Z] = xlsread('shadwell_2014_11_06_04_33_.csv');
%remove headers
W(1) = [];
X(1) = [];
Y(1) = [];
Z(1) = [];
