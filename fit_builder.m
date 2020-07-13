function [ betaFitting ] = fit_builder(City,p,node,mov,n_variables)

    function fit_out = fitfun(betas,t)
        global shifts
        t = t(end);
        [T,Y] = runfun(City,p,node,t*shifts,betas,mov,n_variables);
        fit_out = sum(Y(:,16:35),2);
        
        idx = 1:length(fit_out);
        idxq = linspace(min(idx),max(idx),t);
        fit_out = interp1(idx,fit_out,idxq);
        
    end

betaFitting=@fitfun;
end

