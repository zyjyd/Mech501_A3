function Defaults = mads_defaults(varargin)
%MADS_DEFAULTS  Set default values for MADS parameters and options.
%
%   Syntax:
%      DEFAULTS = mads_defaults(TYPEPROBLEM)
%
%   Description:
%      MADS_DEFAULTS assigns default values for all variables passed into the
%      MADS optimizer.  It stores these values in a structure named DEFAULTS.
%      This function is called by several different NOMADm functions.
%      TYPEPROBLEM is a string that is set to either "Truth" or "Surrogate",
%      the former being used in almost all cases.  The only time "Surrogate" is
%      used is when the MADS optimizer is called within its own search function
%      to optimize a surrogate problem.
%
%   Note:
%      It is strongly recommended that these variables not be edited, as it is
%      the only place where these defaults are set.  This function is not meant
%      to be run independently.
%
%   See also MADS, MADS_BATCH, NOMADM

%*******************************************************************************
%   Copyright (c) 2001-2007 by Mark A. Abramson
%
%   This file is part of the NOMADm software package.
%
%   NOMADm is free software; you can redistribute it and/or modify it under the
%   terms of the GNU General Public License as published by the Free Software
%   Foundation; either version 2 of the License, or (at your option) any later
%   version.
%
%   NOMADm is distributed in the hope that it will be useful, but WITHOUT ANY
%   WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
%   FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
%   details.
%
%   You should have received a copy of the GNU General Public License along with
%   NOMADm; if not, write to the Free Software Foundation, Inc., 
%   59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
% ------------------------------------------------------------------------------
%   Originally created, 2001.
%   Last modified, 8 January 2007
%
%   Author information:
%   Mark A. Abramson, LtCol, USAF, PhD
%   Air Force Institute of Technology
%   Department of Mathematics and Statistics
%   2950 Hobson Way
%   Wright-Patterson AFB, OH 45433
%   (937) 255-3636 x4524
%   Mark.Abramson@afit.edu
%*******************************************************************************

%*******************************************************************************
% madsDefaults:  Sets default values for most of the MADS parameters
% ------------------------------------------------------------------------------
% Called by: NOMADm, nomadm_functions, mads, madsBatch
% VARIABLES:
%  Defaults            = structure containing all the default values
%  Labels              = long text labels for Search and Poll parameters
%    .file             =   labels for types of user files
%    .scale            =   labels for types of mesh direction scaling
%    .sensor           =   labels for sensor dimension in sensor placement
%    .filter           =   labels for types of filters
%    .degeneracyScheme =   labels for degenerate linear constraints schemes
%    .search           =   labels for types of Searches
%    .daceRegression   =   labels for types of DACE regression functions
%    .daceCorrelation  =   labels for types of DACE correlation functions
%    .nwKernel         =   labels for types of Nadaraya-Watson kernel functions
%    .pollStrategy     =   labels for types of Poll strategies
%    .pollOrder        =   labels for types of Poll order strategies
%    .pollCenter       =   labels for types of Poll centers
%    .Parameters       =   labels for MADS parameters
%      .mesh           =     labels for mesh parameters
%      .term           =     labels for termination criteria parameters
%      .other          =     labels for other MADS parameters
%      .RS             =     labels for ranking and selection parameters
%  Types               = short text codes for Search and Poll choices
%    .file             =   types of user files
%    .degeneracyScheme =   types of schemes for degenerate linear constraints
%    .search           =   types of Searches
%    .daceRegression   =   types of DACE regression functions
%    .daceCorrelation  =   types of DACE correlation functions
%    .nwKernel         =   types of Nadaraya-Watson kernel functions
%    .pollStrategy     =   types of Poll strategies
%    .pollOrder        =   types of Poll order strategies
%  FileExt             = string file name suffixes
%    .F                =   functions file suffix
%    .X                =   closed constraints file
%    .O                =   Omega file suffix
%    .I                =   initial points file suffix
%    .N                =   discrete neighbor file suffix
%    .P                =   user parameter file suffix
%    .C                =   cache file suffix
%    .S                =   session file suffix
%    .D                =   diary or debug suffix
%  maxSearches         = maximum number of different Search types in a run
%  Choice              = integer choices of allowable strategies
%    .search           =   choice of Search type 
%    .daceRegr         =   choice of DACE regression function
%    .daceCorr         =   choice of DACE correlation function
%    .pollStrategy     =   choice of Poll strategy
%    .pollOrder        =   choice of Poll order strategy
%    .pollCenter       =   choice of Poll center
%    .degeneracyScheme =   choice of scheme for degenerate linear constraints
%  Options             = values for the MADS Options structure
%    .nSearches        =   number of different Search types used
%    .Search           =   Search parameters
%    .dace             =   DACE parameters
%      .reg            =     regression function handle 
%      .corr           =     correlation function handle
%      .theta          =     initial guess of the theta fitting parameter
%      .lower          =     lower bound for the theta parameter
%      .upper          =     upper bound for the theta parameter
%      .isotropic      =     flag indicating isotropic theta values
%    .nw               =   NW parameters
%      .kernel         =     string name of NW kernel function 
%      .sigma          =     initial guess of the sigma fitting parameter
%      .lower          =     lower bound for the sigma parameter
%      .upper          =     upper bound for the sigma parameter
%    .pollStrategy     =   short text code for default Poll strategy
%    .pollOrder        =   short text code for default Poll order
%    .pollCenter       =   numeric code for default choice of Poll center
%    .pollComplete     =   turns on/off complete Polling
%    .NPollComplete    =   turns on/off complete discrete neighbor Polling
%    .SurOptimizer     =   string identifying the surrogate optimizer
%    .Term             =   values for termination criteria
%      .delta          =     minimum mesh size
%      .nIter          =     maximum number of iterations
%      .nFunc          =     maximum number of function evaluations
%      .time           =     maximum CPU time
%      .nFails         =     maximum number of consecutive Poll failures
%    .TermFlag         =   flags to turn on/off termination criteria
%      .nIter          =     turns on/off number of iterations
%      .nFunc          =     turns on/off number of function evaluations
%      .time           =     turns on/off CPU time
%      .nFails         =     turns on/off number of consecutive Poll failures
%    .loadCache        =   turns on/off loading of a pre-existing Cache
%    .countCache       =   flag for counting Cache points as function calls
%    .useFilter        =   turns on/off filter for nonlinear constraints
%    .degeneracyScheme =   scheme for handling degenerate linear constraints
%    .removeRedundancy =   removes redundant linear constraints
%    .runSensor        =   sensor dimension, if a sensor placement problem
%    .runStochastic    =   flag for running as stochastic optimization problem
%    .accelerate       =   flag for accelerating mesh refinement
%    .scale            =   base for logarithmic scaling (0 = no scaling)
%    .plotFilter       =   turns on/off real-time filter plot
%    .plotHistory      =   turns on/off history and real-time history plot
%    .delta0           =   initial mesh size
%    .deltaMax         =   maximum mesh size
%    .meshRefine       =   mesh refinement factor
%    .meshCoarsen      =   mesh coarsening factor
%    .tolCache         =   tolerance for ID-ing points already in Cache
%    .hmin             =   minimum h-value of an infeasible point
%    .hmax             =   maximum h-value of a filter point
%    .ePollTriggerF    =   f-value Extended Poll trigger
%    .ePollTriggerH    =   h-value Extended Poll trigger
%    .runOneIteration  =   flag for running MADS one iteration at a time
%    .runUntilFeasible =   flag for running MADS only unitl feasible
%    .runCount         =   run counter
%    .TermRel          =   flag for multiplying Term.delta by initial delta
%    .tolBind          =   tolerance for ID-ing active linear constraints
%    .RS               =   structure of ranking & selection options
%      .s0             =     initial sample size
%      .iz_const       =     initial value of the indifference zone parameter
%      .iz_rho         =     decay rate of the indifference zone parameter
%      .alpha_const    =     initial value of the alpha parameter
%      .alpha_rho      =     decay rate of the alpha parameter
%    .hplothandle      =   handle for history plot axes
%    .fplothandle      =   handle for filter plot axes
%    .stophandle       =   handle for Stop Run pushbutton
%  Sur                 = structure with the same fields as Defaults.Options
%  typeProblem         = string ID: "Truth" or "Surrogate"
%*******************************************************************************

% Labels for Search, Poll, and MADS Parameters
Labels.version          = '4.5';
Labels.newMATLAB        = 14;
Labels.file             = {'Functions'; 'Initial Points'; 'Closed Constraints';
                           'Linear Constraints'; 'Neighbors'; 'Parameter'};
Labels.scale            = {'No Scaling';
                           'Logarithmic Base-2 Scaling';
                           'Logarithmic Base-10 Scaling'};
Labels.sensor           = {'Off';'1-D';'2-D';'3-D'};
Labels.debug            = {'Off';'Level 1';'Level 2';'Level 3'};
Labels.plotHistory      = {'Off';'On';'Plot Real-Time'};
Labels.degeneracyScheme = {'Sequential Selection';
                           'Random Selection';
                           'Proximity to Constraint Boundary';
                           'Full Enumeration'};
Labels.filter           = {'No Filter';
                           'Traditional Multipoint Filter';
                           'Two-Point Filter'};
Labels.search           = {'None';
                           'Latin Hypercube Sampling';
                           'Deterministic Sampling on coarse mesh';
                           'Particle Swarm';
                           'Genetic Algorithm';
                           'Standard Poll around first N filter points';
                           'Gradient Poll around first N filter points';
                           'DACE Toolbox Surrogate';
                           'Nadaraya-Watson Surrogate';
                           'Radial Basis Function Surrogate';
                           'SPS with DACE Toolbox Surrogate';
                           'SPS with Nadaraya-Watson Surrogate';
                           'SPS with Radial Basis Function Surrogate';
                           'Custom Search Function';
                           'Custom Surrogate Function'};
Labels.daceRegression   = {'Zero Order Polynomial';
                           'First Order Polynomial';
                           'Second Order Polynomial'};
Labels.daceCorrelation  = {'Exponential';
                           'General Exponential';
                           'Gaussian';
                           'Local Support, Linear';
                           'Local Support, Spherical';
                           'Local support, Cubic Polynomial';
                           'Local Support, Cubic Spline'};
Labels.nwKernel         = {'Gaussian';
                           'Uniform';
                           'Triangle';
                           'Epanechnikov';
                           'Quartic';
                           'Tri-weight';
                           'Cosinus'};
Labels.rbfKernel        = {'Bi-harmonic'};
Labels.recalibration    = {'Only the initial surrogate';
                           'Only at unsuccessful iterations';
                           'At every iteration'};
Labels.pollStrategy     = {'Standard 2n e-directions';
                           'Standard n+1 directions';
                           'Custom 2n directions';
                           'Custom n+1 directions';
                           'MADS Random 2n directions';
                           'MADS Random n+1 directions';
                           'Gradient-pruned 2n e-directions';
                           'Gradient-pruned n+1 directions';
                           'Gradient-pruned 3^n using L-1 gradient';
                           'Gradient-pruned 3^n using L-2 gradient';
                           'Gradient-pruned 3^n using L-Inf gradient';
                           'Gradient-pruned 3^n Descent Vectors'};
Labels.pollOrder        = {'Consecutive';
                           'Alternating';
                           'Random';
                           'Dynamic';
                           'Dynamic Ranked';
                           'Simplex Gradient';
                           'Surrogate Ranked';
                           'Custom'};
Labels.pollCenter       = {'Best Feasible Point';
                           'Least Infeasible Point';
                           '2nd Least Infeasible Filter Point';
                           '3rd Least Infeasible Filter Point';
                           '4th Least Infeasible Filter Point';
                           '5th Least Infeasible Filter Point'};
Labels.Parameters.term  = {'Convergence Tolerance (Mesh Size):';
                           'Maximum Number of Iterations:';
                           'Maximum Number of Function Calls:';
                           'Maximum CPU Time:';
                           'Maximum Number of Consecutive Poll Failures:'};
Labels.Parameters.mesh  = {'Initial Mesh Size:';
                           'Maximum Mesh Size:';
                           'Mesh Refinement Factor:';
                           'Mesh Coarsening Factor:';
                           'Cache Tolerance:'};
Labels.Parameters.other = {'Minimum Filter Constraint Violation:';
                           'Maximum Filter Constraint Violation:';
                           'MVP Objective Extended Poll Trigger:';
                           'MVP Constraints Extended Poll Trigger:'};
Labels.Parameters.RS    = {'R&S Initial Sample Size:';
                           'R&S Initial Alpha Parameter:';
                           'R&S Initial Indifference Zone Parameter:';
                           'R&S Alpha Decay Factor:';
                           'R&S Indifference Zone Decay Factor:';
                           'R&S Terminal Alpha Parameter:';
                           'R&S Terminal Indifference Zone Noise Threshold:'};
Labels.coolCats         = {'Charles Audet', 'Keith Berrier','Olga Brezhneva',...
                           'Gilles Couture','Ana Custodio', 'John Dennis',   ...
                           'Thierry Dalon', 'John Dunlap', ...
                           'Arantzazu Garcia-Lekue', 'Alison Marsden',...
                           'Rachael Pingel','Jacob Sondergaard', ...
                           'Todd Sriver',   'Luis Vicente'};

% Surrogate optimizer labels
Labels.optimizer        = {'FMINCON (MATLAB Optimization Toolbox)';
                           'MADS';
                           'Particle Swarm Optimizer';
                           'CMA-ES (Genetic Algorithm)';
                           'Custom'};
if ~license('test','Optimization_Toolbox'), Labels.optimizer(1) = []; end

% Names of help files 
HelpDoc = struct('nomadm', 'nomadm_help.pdf', ...
                 'dace',   'dace.pdf',        ...
                 'nw',     'nw_help.pdf',     ...
                 'rbf',    'rbf_help.pdf',    ...
                 'cmaes',  'es_READ.ME',      ...
                 'changes','nomadm.txt',      ...
                 'license','gpl.txt');

% Short text codes for Search, DACE Surrogates, and Poll parameters
Types.file      = {'','_x0','_X','_Omega','_N','_Param'};
Types.search    = {'None','LHS','Mesh','PS','GA','SPollI','GPollI', ...
                   'DACE','NW','RBF','SPS-DACE','SPS-NW','SPS-RBF',...
                   'Custom','CustomS'};
Types.daceRegr  = {'regpoly0','regpoly1','regpoly2'};
Types.daceCorr  = {'correxp','correxpg','corrgauss','corrlin',...
                   'corrspherical','corrcubic','corrspline'};
Types.nwKernel  = {'gaussian','uniform','triangle','Epanechnikov','quartic', ...
                   'triweight','cosinus'};
Types.rbfKernel = {'bi-harmonic'};
Types.optimizer = {'fmincon','mads','ps','cmaes','custom'};
Types.poll      = {'Standard_2n',     'Standard_n+1',   ...
                   'Custom_2n',       'Custom_n+1',     ...
                   'MADS_2n',         'MADS_n+1',       ...
                   'Gradient_2n',     'Gradient_n+1',   ...
                   'Gradient_3n_L1',  'Gradient_3n_L2', ...
                   'Gradient_3n_LInf','Gradient_3n2n'};
Types.pollOrder = {'Consecutive',  'Alternating',    'Random',   'Dynamic', ...
                   'DynamicRanked','SimplexGradient','Surrogate','Custom'};
Types.degeneracyScheme = {'sequential','random','closest','full'};
Types.plotColors       = 'kbrmgkbrmg';

% File Extentions
FileExt.F = '';
FileExt.I = '_x0';
FileExt.X = '_X';
FileExt.O = '_Omega';
FileExt.N = '_N';
FileExt.P = '_Param';
FileExt.C = '_Cache.mat';
FileExt.S = '_Session.mat';
FileExt.H = '_History';
FileExt.D = '_Debug.txt';

% Choices for Search and Poll
maxSearches = 8;
Options.nSearches = 2;
Choice.optimizer = 1;
Options.SurOptimizer = Types.optimizer{Choice.optimizer};
Options.mvp1Surrogate         = 1;
for k = 1:maxSearches
   Choice.search(k)           = 1;
   Choice.daceRegr(k)         = 1;
   Choice.daceCorr(k)         = 3;
   Choice.nwKernel(k)         = 1;
   Choice.rbfKernel(k)        = 1;
   Options.Search(k).type     = Types.search{Choice.search(k)};
   Options.Search(k).label    = Labels.search{Choice.search(k)};
   Options.Search(k).nIter    = 1;
   Options.Search(k).nPoints  = 1;
   Options.Search(k).complete = 1;
   Options.Search(k).sfile    = '';
   Options.Search(k).file     = '';
   Options.Search(k).local    = 0;
   Options.Search(k).merit    = 0;
   Options.Search(k).param    = 0;
   Options.Search(k).recal    = 1;
   Options.dace(k).reg        = Types.daceRegr{Choice.daceRegr(k)};
   Options.dace(k).corr       = Types.daceCorr{Choice.daceCorr(k)};
   Options.dace(k).theta      = 10.0;
   Options.dace(k).lower      = 0.01;
   Options.dace(k).upper      = 20;
   Options.dace(k).isotropic  = 0;
   Options.dace(k).setBounds  = 1;
   Options.nw(k).kernel       = Types.nwKernel{Choice.nwKernel(k)};
   Options.nw(k).sigma        = 0.5;
   Options.nw(k).lower        = 0.1;
   Options.nw(k).upper        = 3;
   Options.rbf(k).kernel      = Types.rbfKernel{Choice.rbfKernel(k)};
end
Options.Search(Options.nSearches).nIter = Inf;
Choice.pollStrategy      = 1;
Choice.pollOrder         = 1;
Choice.pollCenter        = 1;
Choice.degeneracyScheme  = 1;
Options.pollStrategy     = Types.poll{Choice.pollStrategy};
Options.pollOrder        = Types.pollOrder{Choice.pollOrder};
Options.pollCenter       = Choice.pollCenter - 1;
Options.pollComplete     = 0;
Options.NPollComplete    = 0;
Options.EPollComplete    = 0;
Options.degeneracyScheme = Types.degeneracyScheme{Choice.degeneracyScheme};
Options.lhsStrength      = 2;

% MADS Parameter Values
Options.Term.delta        = 1e-4;
Options.Term.nIter        = 1000;
Options.Term.nFunc        = 50000;
Options.Term.time         = 3600;
Options.Term.nFails       = 50;
Options.TermFlag.delta    = 1;
Options.TermFlag.nIter    = 0;
Options.TermFlag.nFunc    = 1;
Options.TermFlag.time     = 0;
Options.TermFlag.nFails   = 0;
Options.TermFlag.relative = 0;
Options.loadCache         = 1;
Options.countCache        = 1;
Options.useFilter         = 1;   % Traditional multipoint filter
Options.removeRedundancy  = 1;
Options.dimSensor         = 0;   % Dimension of each sensor
Options.runStochastic     = 0;
Options.accelerate        = 0;
Options.scale             = 2;   % Base of logarithmic scaling (0 = none)
Options.saveHistory       = 0;
Options.plotHistory       = 1;
Options.plotFilter        = 1;
Options.plotColor         = Types.plotColors(1);
Options.lhsBinFactor      = 1;
Options.delta0            = 1.0;
Options.deltaMax          = Inf;
Options.meshRefine        = 0.5;
Options.meshCoarsen       = 1.0;
Options.tolCache          = Options.Term.delta;
Options.hmin              = 0.0;
Options.hmax              = 1.0;
Options.ePollTriggerF     = 0.01;
Options.ePollTriggerH     = 0.05;
Options.runOneIteration   = 0;
Options.runUntilFeasible  = 0;
Options.tolBind           = 0.05;
Options.debug             = 0;
Options.abortFile         = 'ABORT.txt';

% R&S options
Options.RS.s0            = 5;
Options.RS.alpha_const   = 0.80;
Options.RS.alpha_rho     = 0.95;
Options.RS.iz_const      = 100;
Options.RS.iz_rho        = 0.95;
Options.Term.RS_alpha    = 0.05;
Options.Term.RS_noise    = 1;
Options.RSTermFlag.alpha = 0;
Options.RSTermFlag.noise = 0;

% Plot handles
Options.hplothandle = [];
Options.fplothandle = [];
Options.stophandle  = [];

% Surrogate defaults
Sur.Options = Options;
Sur.Options.nSearches         = 0;
Sur.Options.Search            = [];
Sur.Options.pollStrategy      = 'Standard_2n';
Sur.Options.pollOrder         = 'Consecutive';
Sur.Options.pollCenter        = 0;
Sur.Options.pollComplete      = 0;
Sur.Options.NPollComplete     = 0;
Sur.Options.EPollComplete     = 0;
Sur.Options.Term.delta        = 1e-3;
Sur.Options.Term.nIter        = 50;
Sur.Options.Term.nFunc        = 5000;
Sur.Options.Term.time         = Inf;
Sur.Options.Term.nFails       = Inf;
Sur.Options.TermFlag.delta    = 1;
Sur.Options.TermFlag.nIter    = 1;
Sur.Options.TermFlag.nFunc    = 1;
Sur.Options.TermFlag.time     = 0;
Sur.Options.TermFlag.nFails   = 0;
Sur.Options.TermFlag.relative = 0;
Sur.Options.loadCache         = 0;
Sur.Options.countCache        = 0;
Sur.Options.plotFilter        = 0;
Sur.Options.plotHistory       = 0;
Sur.Options.delta0            = 1.0;
Sur.Options.deltaMax          = Inf;
Sur.Options.meshCoarsen       = 1.0;
Sur.Options.ePollTriggerF     = 0.01;
Sur.Options.ePollTriggerH     = 0.05;
Sur.Options.runOneIteration   = 0;
Sur.Options.runUntilFeasible  = 0;
Sur.Options.useFilter         = 0;
Sur.Options.tolBind           = sqrt(Sur.Options.Term.delta);
Sur.Options.tolCache          = Sur.Options.Term.delta;
Sur.Options.debug             = Options.debug;

% Construct Default structure
Defaults.Labels      = Labels;
Defaults.Types       = Types;
Defaults.FileExt     = FileExt;
Defaults.Choice      = Choice;
Defaults.HelpDoc     = HelpDoc;
Defaults.maxSearches = maxSearches;

% Determine if a "Truth" or "Surrogate" function is to be optimized 
if nargin > 0,
   Defaults.typeProblem = varargin{1};
else
   Defaults.typeProblem = 'TRUTH';
end

% Assign either Truth or Surrogate default values
switch upper(Defaults.typeProblem)
case 'TRUTH'
   Defaults.Options   = Options;
   Defaults.nameCache = 'CACHE';
case 'SURROGATE'
   Defaults.Options   = Sur.Options;
   Defaults.nameCache = 'sCACHE';
otherwise
   error('mads:defaults', ...
         'Bad argument for mads_defaults: Must be "TRUTH" or "SURROGATE"');
end
Defaults.Options.Sur = Sur.Options;
return
