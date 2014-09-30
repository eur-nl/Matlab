function SumStats = CalcSumStats(X,varname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate summary statistics and create a histogram of the variable X.
% 
%
% Inputs
% - X: Variable for which to calculate the sumstats
% - varname: Variablename to be used in creating the output
%
% Output
% - LaTeX table with sumstats (filename = 'sumstats_<varname>.tex')
% - Tikz histogram (filename = '<varname>histogram.tikz')
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SumStats.mean = mean(X);
SumStats.stdev = var(X).^0.5;
SumStats.min = min(X);
SumStats.prctile25 = PercentileCalc(X,25);
SumStats.median = median(X);
SumStats.prctile75 = PercentileCalc(X,75);
SumStats.max = max(X);


% Create vertical labels
vlabels = cell(11,1);
vlabels(1) = {'$mean$'};
vlabels(2) = {'$stdev$'};
vlabels(3) = {'$min$'};
vlabels(4) = {'$5th$ $percentile$'};
vlabels(5) = {'$10th$ $percentile$'};
vlabels(6) = {'$25th$ $percentile$'};
vlabels(7) = {'$median$'};
vlabels(8) = {'$75th$ $percentile$'};
vlabels(9) = {'$90th$ $percentile$'};
vlabels(10) = {'$95th$ $percentile$'};
vlabels(11) = {'$max$'};

% Create horizontal labels
k = size(X,2);
if k==1
    hlabels = cellstr(varname);
else
    hlabels = cell(2,k);
    hlabels(1,round(k/2)) = cellstr(varname);
    for i = 1:k
        hlabels(2,i) = {num2str(i-2)};
    end
end

% Create content
Content = cell(11,k);
for i = 1:k
    Content(1,i) = num2cell(mean(X(:,i)));
    Content(2,i) = num2cell((var(X(:,i)).^0.5));
    Content(3,i) = num2cell(min(X(:,i)));
    Content(4,i) = num2cell(PercentileCalc(X(:,i),5));
    Content(5,i) = num2cell(PercentileCalc(X(:,i),10));
    Content(6,i) = num2cell(PercentileCalc(X(:,i),25));
    Content(7,i) = num2cell(median(X(:,i)));
    Content(8,i) = num2cell(PercentileCalc(X(:,i),75));
    Content(9,i) = num2cell(PercentileCalc(X(:,i),90));
    Content(10,i) = num2cell(PercentileCalc(X(:,i),95));
    Content(11,i) = num2cell(max(X(:,i)));
end

% Create output name
outputname = strcat('sumstats_',varname,'.tex');

% Set location horizontal lines
if k == 1
    hline = [0,1,12];
else
    hline = [0,2,13];
end

% Create Latex Table
latextable(Content,'Horiz',hlabels,'Vert',vlabels,'name',outputname,'Hline',hline)

% Create histogram
hist(X(:,1),20);
set(gcf,'visible','off')
FILENAME = strcat(varname,'histogram.tikz');
matlab2tikz('filename',FILENAME)
end