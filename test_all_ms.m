function test_all_ms

import matlab.unittest.TestSuite

progDir = fileparts(mfilename('fullpath'));

displayV = [TestSuite.fromFolder(progDir)];
%   TestSuite.fromPackage('param_nisimp')];

run(displayV);


end


% assert(setNo > 0);
% 
% cS = const_ms(setNo);
% paramS = param_set_ms(setNo);
% paramS = param_derived_ms(paramS, cS);
% ageRetire = cS.demogS.Rmax;
% TFP = 1;
% pk = 1;
% 
% % Factor prices
% priceS = factor_prices_ms(TFP, pk, cS);
% 
% 
% 
% %% Household
% 
% % Solve job training problem
% experV = linspace(0.01, ageRetire, 20);
% hS = 9.43;
% ojt_solve_ms(experV, priceS.wage, priceS.pW, ageRetire, hS, paramS, cS);
% 
% 
% 
% %% Equilibrium
% 
% hbar_test_ms(setNo)
% equilibrium_test_ms(setNo);
% cal_dev_test_ms(setNo);
% 
% 
% %% Helpers
% 
% param_load_ms(setNo);


% end