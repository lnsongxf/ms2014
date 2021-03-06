function [devV, outS, paramS] = cal_dev_ms(countryS, paramS, cS)
% Deviation from calibration targets

assert(isa(countryS, 'CountryParamsMs'));
tgS = cS.tgS;

paramS = param_derived_ms(paramS, cS);


%% Household: solve given s

outS = equilibrium_ms(countryS, paramS, cS);

% This does not produce the right result - why not??
% outS.priceS = factor_prices_ms(countryS.TFP, countryS.pk, cS);
% [outS.hhS, dev28] = hh_solve_given_s_ms(tgS.sUS, countryS.ageRetire, outS.priceS, paramS, cS);
% outS.equilS = equil_ms.solve_given_hh(outS.hhS, countryS, outS.priceS, paramS, cS);



%% ***** Wage growth targets
% wages are computed for a grid of ages; interpolate

assert(isequal(length(tgS.wageGrowthAgeV), 3));
wageV = interp1(outS.hhS.experV + cS.demogS.startAge + outS.hhS.s, outS.hhS.wageV, tgS.wageGrowthAgeV, 'linear');

% Wages age 55 / 25
wGrowth = wageV(2) / max(1e-4, wageV(1));
devWage1 = 1 * (wGrowth - tgS.w55_25) ./ tgS.w55_25;

% Wages 
wGrowth2 = wageV(3) / max(1e-4, wageV(2));
devWage2 = 1 * (wGrowth2 - tgS.w64_55) ./ tgS.w64_55;


%% Schooling

devSchool = 1 * (outS.hhS.s - tgS.sUS) ./ tgS.sUS;
% devSchool = dev28;

devSSpend = 1 * (outS.equilS.sSpendGdp - tgS.sSpendY) ./ tgS.sSpendY;

devChildSpend = 1 * (outS.equilS.childSpendGdp - tgS.childSpendY) ./ tgS.childSpendY;


%% Deviation

devV = [devWage1, devWage2, devSchool, devSSpend, devChildSpend];
validateattributes(devV, {'double'}, {'finite', 'nonnan', 'nonempty', 'real', 'size', [1, 5]})

if 1
   fprintf('dev = %.2f    ',  norm(devV));
   fprintf('s = %.2f    wGrowth: %.2f  %.2f     ys/y: %.1f    ye/y: %.1f \n', ...
      outS.hhS.s, wGrowth, wGrowth2,  100 .* outS.equilS.sSpendGdp, 100 .* outS.equilS.childSpendGdp);
end


end