function [sys,x0,str,ts,simStateCompliance] = PIDControllersfun(t,x,u,flag,L2sp,kp,ki,kd,PumpMAX,delta_t,EMPeriod,L2ini)
%SFUNTMPL General MATLAB S-Function Template
%   With MATLAB S-functions, you can define you own ordinary differential
%   equations (ODEs), discrete system equations, and/or just about
%   any type of algorithm to be used within a Simulink block diagram.
%
%   The general form of an MATLAB S-function syntax is:
%       [SYS,X0,STR,TS,SIMSTATECOMPLIANCE] = SFUNC(T,X,U,FLAG,P1,...,Pn)
%
%   What is returned by SFUNC at a given point in time, T, depends on the
%   value of the FLAG, the current state vector, X, and the current
%   input vector, U.
%
%   FLAG   RESULT             DESCRIPTION
%   -----  ------             --------------------------------------------
%   0      [SIZES,X0,STR,TS]  Initialization, return system sizes in SYS,
%                             initial state in X0, state ordering strings
%                             in STR, and sample times in TS.
%   1      DX                 Return continuous state derivatives in SYS.
%   2      DS                 Update discrete states SYS = X(n+1)
%   3      Y                  Return outputs in SYS.
%   4      TNEXT              Return next time hit for variable step sample
%                             time in SYS.
%   5                         Reserved for future (root finding).
%   9      []                 Termination, perform any cleanup SYS=[].
%
%
%   The state vectors, X and X0 consists of continuous states followed
%   by discrete states.
%
%   Optional parameters, P1,...,Pn can be provided to the S-function and
%   used during any FLAG operation.
%
%   When SFUNC is called with FLAG = 0, the following information
%   should be returned:
%
%      SYS(1) = Number of continuous states.
%      SYS(2) = Number of discrete states.
%      SYS(3) = Number of outputs.
%      SYS(4) = Number of inputs.
%               Any of the first four elements in SYS can be specified
%               as -1 indicating that they are dynamically sized. The
%               actual length for all other flags will be equal to the
%               length of the input, U.
%      SYS(5) = Reserved for root finding. Must be zero.
%      SYS(6) = Direct feedthrough flag (1=yes, 0=no). The s-function
%               has direct feedthrough if U is used during the FLAG=3
%               call. Setting this to 0 is akin to making a promise that
%               U will not be used during FLAG=3. If you break the promise
%               then unpredictable results will occur.
%      SYS(7) = Number of sample times. This is the number of rows in TS.
%
%
%      X0     = Initial state conditions or [] if no states.
%
%      STR    = State ordering strings which is generally specified as [].
%
%      TS     = An m-by-2 matrix containing the sample time
%               (period, offset) information. Where m = number of sample
%               times. The ordering of the sample times must be:
%
%               TS = [0      0,      : Continuous sample time.
%                     0      1,      : Continuous, but fixed in minor step
%                                      sample time.
%                     PERIOD OFFSET, : Discrete sample time where
%                                      PERIOD > 0 & OFFSET < PERIOD.
%                     -2     0];     : Variable step discrete sample time
%                                      where FLAG=4 is used to get time of
%                                      next hit.
%
%               There can be more than one sample time providing
%               they are ordered such that they are monotonically
%               increasing. Only the needed sample times should be
%               specified in TS. When specifying more than one
%               sample time, you must check for sample hits explicitly by
%               seeing if
%                  abs(round((T-OFFSET)/PERIOD) - (T-OFFSET)/PERIOD)
%               is within a specified tolerance, generally 1e-8. This
%               tolerance is dependent upon your model's sampling times
%               and simulation time.
%
%               You can also specify that the sample time of the S-function
%               is inherited from the driving block. For functions which
%               change during minor steps, this is done by
%               specifying SYS(7) = 1 and TS = [-1 0]. For functions which
%               are held during minor steps, this is done by specifying
%               SYS(7) = 1 and TS = [-1 1].
%
%      SIMSTATECOMPLIANCE = Specifices how to handle this block when saving and
%                           restoring the complete simulation state of the
%                           model. The allowed values are: 'DefaultSimState',
%                           'HasNoSimState' or 'DisallowSimState'. If this value
%                           is not speficified, then the block's compliance with
%                           simState feature is set to 'UknownSimState'.


%   Copyright 1990-2010 The MathWorks, Inc.
%   $Revision: 1.18.2.5 $

%
% The following outlines the general structure of an S-function.
%
switch flag,

  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  case 0,
    [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(L2sp,PumpMAX,L2ini);

  %%%%%%%%%%%%%%%
  % Derivatives %
  %%%%%%%%%%%%%%%
  case 1,
    sys=mdlDerivatives(t,x,u);

  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,
    sys=mdlUpdate(t,x,u,L2sp,kp,ki,kd,PumpMAX,delta_t,EMPeriod);

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  case 3,
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%%%%%
  % GetTimeOfNextVarHit %
  %%%%%%%%%%%%%%%%%%%%%%%
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %%%%%%%%%%%%%
  % Terminate %
  %%%%%%%%%%%%%
  case 9,
    sys=mdlTerminate(t,x,u);

  %%%%%%%%%%%%%%%%%%%%
  % Unexpected flags %
  %%%%%%%%%%%%%%%%%%%%
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end

% end sfuntmpl

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(L2sp,PumpMAX,L2ini)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 9;   %last error£¬last last error£¬last voltage£¬current voltage£¬tap ON/OFF,emergency state(>0, in emergency),last tap ON/OFF,pump before emergency,stepcounter
sizes.NumOutputs     = 2;   %voltage applied to pump, tap ON/OFF
sizes.NumInputs      = 5;   %L1H,  LRL, LRH,L2H, L2
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
%10 is the initial value in tank #2
x0  = [L2sp-L2ini; L2sp-L2ini; PumpMAX; 0;0;0;0;0;0];

%x0  = [L2sp-L2ini;L2sp-L2ini;0;0;0;0;0;0;0];

%x0  = [0;0;0;0;0;0;0];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';

% end mdlInitializeSizes

%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys=mdlDerivatives(t,x,u)

sys = [];

% end mdlDerivatives

%
%=============================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=============================================================================
%
function sys=mdlUpdate(t,x,u,L2sp,kp,ki,kd,PumpMAX,delta_t,EMPeriod)
%define the control period of control loop
PeriodEm=1; %emergency period, multiple of simulation period
PeriodRg=2; %regular period

%PID control logic

%initialize parameters
ecurrent=0;
deltaP=0;
deltaI=0;
deltaD=0;

ecurrent=L2sp-u(5); % compute current error

%output x(4) is updated only when the control logic is triggered
if mod(x(9),PeriodRg)==0
    
    deltaP=kp*(ecurrent-x(1));
    deltaI=ki*ecurrent*delta_t; %sample time 
    deltaD=kd*(ecurrent-x(1) - x(1)+x(2))/delta_t;    %sample time 
    x(4)=x(3)+deltaP+deltaI+deltaD;

    %u1 is limited 
    if x(4)>PumpMAX 
        x(4)=PumpMAX;
    end

    if x(4)<0
        x(4)=0;
    end
else
    %reuse the last one
   x(4)=x(3);
end

%Tap ON/OFF, default OFF
x(5)=0;

%Implementing rule for emergency situation

if ((u(1)==1) || (u(2)==1) ||(u(3)==1)||(u(4)==1)) && (x(6)==0)
    x(6)=EMPeriod; %enter into emergency state
    x(8)=x(3);%record the pump before emergency
end

if x(6)>0
    if x(6)==EMPeriod  %just enter emergency mode, control according to rule
        %rule 1, L1H=1, LRH=0
        if ((u(1)==1)&&(u(3)==0))
            x(5)=1;
            x(4)=0;    
        end

        %rule 2,L2H=1,LRH=0
        if ((u(4)==1)&&(u(3)==0))
            x(5)=1;
            x(4)=0;
        end

        %rule 3,LRL=1
        if u(2)==1
            x(5)=1;
            x(4)=0;
        end

        %rule 4,L1H=0,L2H=0,LRH=1
        if ((u(1)==0) && (u(4)==0) &&(u(3)==1))
            %u(3)
            x(5)=0;
            x(4)=PumpMAX;
        end

        %rule 6,L1H=1 or L2H=1, LRH=1
        if (((u(1)==1) || (u(4)==1)) &&(u(3)==1))
            x(5)=1;
            x(4)=0;
        end    
    else
        %Stay in emergency mode and not just enter, keep last output
        x(4)=x(3);
        x(5)=x(7);
    end    
end

%decrease emergency mode counter
if x(6)>=1
    x(6)=x(6)-1;
    if  x(6)==0  % timeout
      if ((u(1)==1) || (u(2)==1) ||(u(3)==1)||(u(4)==1))
        %still in emergency mode,reset counter
        x(6)=EMPeriod; %enter into emergency state
      else
          x(3)=x(8); %find the pump value before emergency and use it as control output
          x(4)=x(3); %igore deltaP, deltaI and deltaD
          x(5)=0;       %close the tap because it is only use for emergency
      end
    end
end

%update the state recursively

%x(1) and x(2) are updated when regular control is triggered
if mod(x(9),PeriodRg)==0
    x(2)=x(1);
    x(1)=ecurrent;
end

x(3)=x(4);
x(7)=x(5);

%step counter increase by 1
x(9)=x(9)+1;

% eml.extrinsic('disp');
% disp('PID S-function called')
% [x(4) x(5)]

sys = [x];

% end mdlUpdate

%
%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys=mdlOutputs(t,x,u)

sys = [x(4);x(5)];

% end mdlOutputs

%
%=============================================================================
% mdlGetTimeOfNextVarHit
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%=============================================================================
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;

% end mdlGetTimeOfNextVarHit

%
%=============================================================================
% mdlTerminate
% Perform any end of simulation tasks.
%=============================================================================
%
function sys=mdlTerminate(t,x,u)

sys = [];

% end mdlTerminate
