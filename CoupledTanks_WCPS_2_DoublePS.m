clc;
clear all;
close all;
warning off

delta_t2 = 0.1; %FixedStep

Tf = 10;              % horizon
sensor_sampling_rate=5; %sampling rate
EMPeriod=1;        %step counter in emergency mode

delta_t=1/sensor_sampling_rate; %control period

step_count=Tf*sensor_sampling_rate; %total step count
%step_count=Tf/delta_t2; %total step count

sen_num = 4; % sensor number 
dtint = 100*delta_t; %





%Common constant
rho=1000;       %density of water£¬kg/m3
g=9.8;          %gravity constant, m/s


%parameters of Tank #1
A1=0.06;           %Area of tank 1,m2
L1up=10;       %Height of tank 1,m
%L1up=100;
R1=0.0005;        %resistantce of the pipe without tap
p12=1;          %pressure at the end of the pipe without tap
R1tap=0.001;    %resistantce of the pipe with tap
p2tap=1;        %pressure at the end of the pipe with tap


%parameters of Tank #2
A2=0.3;         %Area of tank,m2
%L2up=14;        %Height of tank,m
L2up=13;
R2=0.001;        %resistantce of the pipe 2
p22=1;          %pressure at the end of the pipe 2


%parameters of BASIN
AR=0.3;           %Area of basin,m2
LRup=9;        %Height of BASIN,m
%LRup=100;
LRdown=0;       %Minimal height above which the pump can get water


%parameters of Pump Motor
alpha1=10;       %pump motor constant
PumpMAX=60;     %Maximal voltage applied to the pump


% Initial Condition 1 for 2 plants
% L1ini=8;
% L2ini=10.1;
% LRini=4.9;

% Initial Condition 2 for 2 plants
% L1ini=0;
% L2ini=11;
% LRini=5.6;


% Initial Condition 3 for 2 plants
L1ini=9;
L2ini=9.15;
LRini=5.65;


% Initial Condition 4 for 2 plants
% L1ini=5.9;
% L2ini=11.2;
% LRini=4.22;



%parameters of controller
 L2sp=11.05;
 
 
%fixed by Humberto
kp=5;          %Coefficient P of PID controller
ki=0.5;           %Coefficient I of PID controller
kd=0;           %Coefficient D of PID controller,0.5



%parameter of emergency
L1H=90;         %Emergency HIGH level of Tank #1
L2H=115;         %Emergency HIGH level of Tank #2
LRH=57;         %Emergency HIGH level of BASIN
LRL=0;         %Emergency LOW level of BASIN

%L1H=9;         %Emergency HIGH level of Tank #1
%L2H=11.5;         %Emergency HIGH level of Tank #2
%LRH=5.7;         %Emergency HIGH level of BASIN
%LRL=0.2;         %Emergency LOW level of BASIN


%% RUN Wireless  Process Control Simulation
tic

Ydelay = zeros(step_count+1,sen_num);
Delay = 0;
ranD=[4 2 2 2 2]; %delayed time steps 

%last_emergency_instance=[0 0 0 0 0]';


for k=1:1
    clear L1OUT L2OUT TIME BASINOUT DOUT PumOUT
    clear L1OUT1 L2OUT1 BASINOUT1 DOUT1 PumOUT1
    
    delay1 = zeros(step_count+1,sen_num+1);
%     size(delay1)
%     size(Ydelay)
    
    %Ydelay = zeros(step_count+1,4);
    yin = [0 0 0 0 0 ];
    yin_d = [0 0 0 0 0]';
    ystore = Ydelay;
    count = 1;
    i = 0;

    structure.i = 0;
    structure.count = count;
    structure.yin = yin;
    structure.yin_d = yin_d;
    structure.delay1 = delay1;
    structure.ranD = ranD;

    last_emergency_instance=[0 0 0 0 0];
    RetransCounter=[0 0 0 0 0];
    
    option = simset('solver','ode4','FixedStep',delta_t2);
    sim('CoupledTanks_WCPS_v2_DoubleSD.mdl',[0 Tf]);

       filename=strcat('DoublePlant_PS_INI3_RSSI74_',num2str(k)); 
       save(filename);
%      

end


toc

zzz=[L1OUT,L2OUT,BASINOUT];
figure
plot(TIME,zzz)

%  figure
%  plot(TIME,DOUT)
% 
% figure
% plot(TIME,PumpOUT)


zzz1=[L1OUT1,L2OUT1,BASINOUT1];
figure
plot(TIME,zzz1)

%  figure
%  plot(TIME,DOUT1)
% 
% figure
% plot(TIME,PumpOUT1)


% 
% 
% max(L1OUT)
% max(L2OUT)
% max(BASINOUT)

