function [ betas ] = COVIDfitting(City)

global daysToLD daysInLD daysRelaxed shifts Tshifts

betaToFit = fit_builder(City,City.init,City.node,City.mov,8);

betasInit = [0.4/2];

t = daysToLD+daysInLD+daysRelaxed;

Tshifts = t*shifts;

[betas, xnorm] = lsqcurvefit(betaToFit,betasInit,1:t,City.Prevalence(1:t)');
end

