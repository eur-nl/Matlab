function [X,RegrVar] = MatrixMerge(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check whether the variables are different from zero, remove linear 
% dependent variables and merge the remaining variables into one matrix.
%
% Inputs:
% - Variablename-variable pairs (e.g. 'Earnings', Earnings), where there
% variables are column vectors or matrices.
%
% Outputs:
% - X: Matrix of full rank consisting of linearly independent variables
% - RegrVar: cell array of variable names
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cStr = 1;
X = [];
for i = 1:2:size(varargin,2);
    if ~ischar(varargin{i})
        error('Please include only variablename-variable pairs')
    end
    if ~isnumeric(varargin{i+1})
        error('Please include only variablename-variable pairs')
    end
    % Augment the cell array RegrVar with the variable name and
    % matrix X with the variable, given that the variable has non-zero
    % elements
    for j = 1:size(varargin{i+1},2)
        % Check if the variable has some non-zero elements.
        if sum(varargin{i+1}(:,j)) ~= 0
            if size(varargin{i+1},2) > 1
                RegrVar{cStr,1} = strcat(varargin{i},num2str(j));
                cStr = cStr+1;
                X = [X varargin{i+1}(:,j)];
                
            else
                RegrVar{cStr,1} = varargin{i};
                cStr = cStr+1;
                X = [X varargin{i+1}(:,j)];
            end
        end
    end
end

% Remove those variables that are linearly dependent
i = 1;
while i <= size(X,2)
    if rank(X(:,1:i))==i
        i = i+1;
    else
        X(:,i) = [];
        RegrVar(i,:) = [];
    end
end
end
