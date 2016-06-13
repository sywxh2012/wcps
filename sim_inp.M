% SIMULATION INPUT FILE

% LOAD MODELS
load eval_mod

% FORM KANAI-TAJIMI FILTER 
% Note: wg and zg must be previously defined)
% S0 	= 0.03*zg/(pi*wg*(4*zg^2+1));
% numeq	= sqrt(S0)*[2*zg*wg wg^2];
% deneq	= [1 2*zg*wg wg^2];

% SET UP STATE-SPACE SYSTEM FOR PLANT
%     INPUTS:      
%          1) Ground Acceleration
%          2) Control Signal (Actuator Command)
%
%     OUTPUTS:	
%          1-12) Z vector (see paper)
%          13) Ground Acceleration (directly fed through)
%
[At] = [A];
[Bt] = [E B];
[Ct] = [Cz;zeros(1,length(At))];
[Dt] = [[Fz Dz];[1 0]];

% LOAD CONTROLLER
load smp_ctrl			% see smp_des.m

% SET SIMULATION PARAMETERS
dtint   = 0.0001;		% integration step
dts 	= 0.005;		% time increment for saving data
Tf   	= 10.0;                 % max time for the El Centro earthquake
n    	= 1e7;			% number of samples saved
tol  	= 1e-6;			% tolerance
qint 	= 6/(2^12);		% quantizer interval


