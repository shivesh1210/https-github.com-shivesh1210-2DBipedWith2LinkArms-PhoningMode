close all
clear all
clc

global poly polyp Tint vec_T impactindex xstep1 xstep2 violation_percent

% Go back to previous directory
cd ..
% Load an already optimised set of parameters for simulation
  load('Optimisation Parameters Results\Optim_Parameters11_V11.mat');

Walk_Speed = 1.1;    % Set this according to the file loaded

Hydroid_initialisation_2D

criteria = Hydroid_Trajec(Optim_Parameters);
[C, Ceq] = Hydroid_constraints(Optim_Parameters);
violation_percent

% Recording Animation 
% aviobj = avifile('Phoning.avi');
% xstart = 0;
% [xstep1 aviobj] = animation(poly(:,1:impactindex), xstart, aviobj);
% title('Impact');
% % pause(5);
% title('Step 2');
% [xstep2 aviobj] = animation(poly(:,impactindex+1:end), xstep1, aviobj);
% aviobj = close(aviobj);

% Animation 
xstart = 0;
zstart = 0;
[xstep1, zstep1] = animation(poly(:,1:impactindex), xstart, zstart);
title('Impact');
% pause(5);
title('Step 2');
[xstep2, zstep2] = animation(poly(:,impactindex+1:end), xstep1, zstep1);

Tint
figure;
hold on
x1 = [Tint Tint];
y1 = [-5 5];
line(x1,y1,'Color', 'k');
% plot(vec_T, polyp(:,:));
% legend('Tint','q1d','q2d','q3d','q4d','q5d','q6d','q7d','q8d','q9d','qp1d or qp2d');
plot(vec_T, polyp(1:5,:));
legend('Tint','q1d','q2d','q3d','q4d','q5d');
figure;
hold on
x1 = [Tint Tint];
y1 = [-pi/4 pi/4];
line(x1,y1,'Color','k');
plot(vec_T, poly(:,:));
legend('Tint','q1','q2','q3','q4','q5','q6','q7','q8','q9','qp1 or qp2');
% plot(vec_T, poly(1:5,:));
% legend('Tint','q1','q2','q3','q4','q5');

% Plot the joint position trajectory of the arm holding the phone
figure;
hold on
x1 = [Tint Tint];
y1 = [min([poly(8,:) poly(9,:)])-0.1 max([poly(8,:) poly(9,:)])+0.1];
line(x1,y1,'LineStyle','--', 'Color','k');
plot(vec_T, poly(8,:),'r');
plot(vec_T, poly(9,:));
xlabel('Time(s)');
ylabel('Shoulder and Elbow angles(q8 & q9 in rad)');
title('Shoulder and Elbow angles of the arm carrying smartphone');
legend('Impact', 'q8','q9');

% Plot the joint velocity trajectory of the arm holding the phone
figure;
hold on
x1 = [Tint Tint];
y1 = [min([polyp(8,:) polyp(9,:)])-0.1 max([polyp(8,:) polyp(9,:)])+0.1];
line(x1,y1,'LineStyle','--', 'Color','k');
plot(vec_T, polyp(8,:),'r');
plot(vec_T, polyp(9,:));
xlabel('Time(s)');
ylabel('Shoulder and Elbow joint vel(qd8 & qd9 in rad/s)');
title('Shoulder and Elbow joint velocities of the arm carrying smartphone');
legend('Impact','qd8','qd9');

% Plot the start, intermediate and final position of biped body
animation(poly(:,1), 0, 0);    % Start
[xstep1 zstep1] = animation(poly(:,impactindex), 0, 0);    % First Impact (i.e. Intermediate position)
[x z] = animation(poly(:,end), xstep1, zstep1);        % Second Impact (i.e. Final position) 

% Plot handheld device's acceleration characterstics
% phone_characteristics_numerical   % Plots phone's acceleration using numerical differentiation
phone_characteristics_analytical  % Plots phone's acceleration using analytical differentiation

% Come back Test directory after the program ends
cd('Test');