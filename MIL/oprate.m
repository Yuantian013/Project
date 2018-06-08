
r_init=[[1,0,0,0,0,-1,0,0],[0,-1,0,1,0,0,0,0]] ;%<---this is guessed value
% optimize
    gs=GlobalSearch('NumTrialPoints',200);
    lb=[];
    ub=[];
    options = optimoptions('fmincon','MaxFunctionEvaluations', 1000); 
    Aeq=[];
    beq=[]; %there is no constraints
    problem=createOptimProblem('fmincon','Aeq',Aeq,'beq',beq,'lb',lb,'objective',@lossfunc,...
    'options',options,'ub',ub,'x0',r_init);
    [x,~,~,~] = run(gs,problem);
    % optimization end
    r=x;


