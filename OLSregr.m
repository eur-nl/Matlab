function Results = OLSregr(Yvariables,Xvariables,intercept,WhiteHCSEs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: regresses each Yvariable on Xvariables using OLS
%
% Inputs
% - Yvariables: Matrix where each column represents a dependent variable
% - Xvariables: Matrix where each column represents an independent variable
% - The number of rows should be equal in Yvariables and Xvariables
% - A logical indicating whether an intercept should be included
% - A logical indicating whether White's HC standard errors should be used
%
% Outputs
% - Results: struct with
% 	- .coeffs: Coefficient estimates
% 	- .residuals: Regression residuals
% 	- .SEs: Standard errors
% 	- .tstats: t-values
% 	- .Rsquared: R-squared statistic
% 	- .NumberOfObs: Number of observations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[T,N] = size(Yvariables);
Results.NumberOfObs = T;
if intercept == 1
    X = [ones(T,1) Xvariables];
else
    X = Xvariables;
end
for i = 1:N
    Y = Yvariables(:,i);
    Results.coeffs(:,i) = (X'*X)\(X'*Y);
    Results.residuals = Y - X*Results.coeffs(:,i);
    Results.Rsquared = 1-(var(Results.residuals)/var(Y));
    if WhiteHCSEs == 0
        Results.SEs(:,i) = diag(var(Results.residuals)*inv(X'*X)).^0.5;
    else
        VarBeta = (X'*X)\(X'*diag(Results.residuals.^2)*X)/(X'*X);
        Results.SEs(:,i) = diag(VarBeta).^0.5;
    end
    Results.tstats(:,i) = Results.coeffs(:,i)./Results.SEs(:,i);
end


end
