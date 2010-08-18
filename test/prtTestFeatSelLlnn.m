function result = prtTestFeatSelLlnn

%%
result = true;
%%



%%
% Check basic operation
try
dataSet = prtDataCircles;
featSel = prtFeatSelLlnn; 
featSel = featSel.train(dataSet);
outDataSet = featSel.run(dataSet);
catch
    disp('Error #1, basic feature selection fail')
    result = false;
end

% Should always give 2 features ere.
if outDataSet.nFeatures ~=2
    disp('Error #2, wrong # of features')
    result = false;
end

if featSel.isTrained ~= 1
    disp('Error #2a, should be trained')
    result = false;
end




% check param/value constructor
try
    featSel = prtFeatSelLlnn('nMaxIterations',24);
catch
    disp('Error #4, param/val constructor fail')
    result = false;
end

% check help example, should wind up with 2 features
dataSet = prtDataSpiral;   % Create a 2 dimensional data set
nNoiseFeatures = 100;      % Append 100 irrelevant features
dataSet = prtDataSetClass(cat(2,dataSet.getObservations,randn([dataSet.nObservations, nNoiseFeatures])), dataSet.getTargets);
featSel = prtFeatSelLlnn;  % Create the feature
% selection object.
featSel.nMaxIterations = 10;                   % Set the max # of
% iterations.
featSel = featSel.train(dataSet);              % Train

if ~isequal(featSel.selectedFeatures, [1 2]')
    disp('Error #4a, wrong number of selected features')
    result = false;
end

%% Stuff that should error
error = true;
dataSet = prtDataSpiral3;
featSel = prtFeatSelLlnn; 


try
    R = featSel.run(dataSet);
    disp('Error# x , run before train')
    error = false;
end

result = result & error;


