% SMP_DES.m
% This program was used to design the controller
% provided with the Benchmark Problem. The controller
% is an H2/LQG design which was designed by weighting the
% 3 absolute accelerations of the test building equally.
% 
%     Written by Shirley Dyke 
%     Last Modified: 11/29/95
%

echo on
% LOAD CONTROL DESIGN MODEL
load des_mod

Ar2=Ar; Br2=[Er Br]; Cr2=Cyr; Dr2=[Fyr Dyr];

% DEFINE WEIGHTINGS FOR CONTROL DESIGN
R	= [50];
Q 	= diag([1 1 1 0]);

% CONTROL DESIGN
C1	= [[Cyr(2:4,:)];[Cyr(5,:)]];	
D1	= [[Dyr(2:4,:)];[Dyr(5,:)]];
K	= lqry(Ar2,Br2(:,2),C1,D1,Q,R);
SW	= 25;
SV	= eye(4);
L	= lqew(Ar2,Er,Cyr(2:5,:),Fyr(2:5,:),SW,SV);

% FORM CONTINUOUS STATE-SPACE CONTROLLER
Ac	= Ar2 - Br2(:,2)*K - L*Cyr(2:5,:) + L*Dyr(2:5,:)*K;
Bc	= L;
Cc	= -K;
Dc	= zeros(1,4);

% CHECK STABILITY OF CONTROLLER
if (max(real(eig(Ac))) > 0) 
	disp(' ')
	disp('UNSTABLE CONTROLLER !')
end

% CONVERT TO DISCRETE FORM
[Ad,Bd,Cd,Dd] = c2dm(Ac,Bc,Cc,Dc,0.001,'tustin');
    % 0.001 is the sampling rate of the DSP Board

save smp_ctrl Ad Bd Cd Dd
echo off
