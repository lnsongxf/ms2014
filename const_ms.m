function cS = const_ms(setNo)

cS = const_lh;


%% Miscellaneous

cS.setNo = setNo;

% No of country groups
cS.nGroups = 10;


%% Calibrated parameters

cS.pvector = pvectorLH(10, [0, 1]);

pS = pstructLH('zH', 'zH', 'h productivity', 0.334, 0.05, 2, 1);
cS.pvector.add(pS);

pS = pstructLH('deltaH', 'deltaH', 'h depreciation', 0.027, 0, 0.2, 1);
cS.pvector.add(pS);

pS = pstructLH('gamma', 'gamma', 'curvature', 0.486 + 0.4, 0.3, 0.98, 1);
cS.pvector.add(pS);

pS = pstructLH('g1g', 'g1OverGamma', 'gamma1 / gamma', 0.486 / 0.886, 0.1, 0.9, 1);
cS.pvector.add(pS);

pS = pstructLH('v', 'v', 'h productivity', 0.618, 0.1, 0.9, 1);
cS.pvector.add(pS);



%% Fixed model parameters
% NOT including those calibrated by MS

cS.taxRate = 0;

techS.deltaK = 0.075;
techS.capShare = 0.33;
techS.zUS = 1;
cS.techS = techS;

hTechS.capShare = 0.2;
% hTechS.deltaH = 0.027;
% hTechS.zH = 0.334;
% hTechS.gamma1 = 0.486;
% hTechS.gamma2 = 0.4;

hTechS.hB = 1;
% hTechS.v = 0.618;
cS.hTechS = hTechS;

% Age at which people have kids
demogS.B = 25;
demogS.T_US = 78.8;
demogS.Rmax = 64;
cS.demogS = demogS;

%% US calibration targets

tgS.KY = 2.52;
tgS.intRate = 0.055;
tgS.w55_25 = 2;
tgS.w64_55 = 0.79;
tgS.sUS = 12.05;
tgS.sSpendY = 0.045;
tgS.childSpendY = 0.011;
% Fertility rate. Population growth rate is f/B (0.2% for the US)
tgS.fertility = log(2.1)-log(2);

% Target wage growth between these ages
tgS.wageGrowthAgeV = [25 55 64];
   % tgS.wageGrowthAgeV(1) = 26;   % +++++

cS.tgS = tgS;


%% Cases

if setNo == 1
   cS.descrStr = 'Default';
elseif setNo == 2
   cS.descrStr = 'beta = theta';
   cS.hTechS.capShare = cS.techS.capShare;
else
   error('Invalid');
end


%% Implied parameters

cS.outputTechS = OutputTechMs(cS.techS.capShare);

cS.schoolTechS = OutputTechMs(cS.hTechS.capShare);

% cS.demogS.popGrowthUS = cS.tgS.fertility / cS.demogS.B;


%% Directories

dirS.baseDir = '/users/lutz/dropbox/hc/ms2014/';
dirS.progDir = fullfile(dirS.baseDir, 'prog');
dirS.dataDir = fullfile(dirS.baseDir, 'data');
dirS.matDir  = fullfile(dirS.baseDir, 'mat');
dirS.outDir  = fullfile(dirS.baseDir, 'out');

% File with MS results
dirS.resultFile = fullfile(dirS.dataDir, 'result_table.xlsx');
cS.dirS = dirS;


end