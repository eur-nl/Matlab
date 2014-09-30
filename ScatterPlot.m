function ScatterPlot(varX,varY,nameVarX,nameVarY)

scatter(varX,varY);
lsline;
FILENAME = strcat(nameVarX,'_',nameVarY,'scatter.tikz');
matlab2tikz('filename',FILENAME)



end