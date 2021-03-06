% MATLAB code to perform forward kinematics and simulate the working of
% a 3 DOF robotic arm, given the joint angles.

% Taking input before showing initial positions.
fprintf('Enter theta 1, theta 2, theta 3 in degrees\n');
% Parameters t1, t2, t3 are the joint angles.
t1 = input('');
t2 = input('');
t3 = input('');

% Initial positions of the joints of the 3 arms
x = [0 2 3.5 4.5];
y = [0 0 0 0];

% Draw lines in initial positions
grid on;
l = line(x, y);
hold on;
l1 = plot(x(1), y(1), '-');
l2 = plot(x(2), y(2), '-');
l3 = plot(x(3), y(3), '-');
l4 = plot(x(4), y(4), '-');
l5 = plot(x(1), y(1), 's');
l6 = plot(x(2), y(2), 's');
l7 = plot(x(3), y(3), 's');
l8 = plot(x(4), y(4), 's');

% Fix axes
axis([-5 5 -5 5]);

% I am assuming the reference frames' x axes along the length of
% the links for each link.

t1 = t1 * (pi / 180);
t2 = t2 * (pi / 180);
t3 = t3 * (pi / 180);

% angles between previous and next x axes are denoted by theta.
theta1 = t1;
theta2 = t2;
theta3 = t3;

% Product of all 3 angles will be a multiple of LCM of 3 angles
theta = theta1 * theta2 * theta3;

% Accounting for negative values of angles.
if theta < 0
    theta = -theta;
end

% Running a for loop to obtain animation

for i = 0 : 0.003 : theta
    
    tt1 = (i * theta1) ./ (theta);
    tt2 = (i * theta2) ./ (theta);
    tt3 = (i * theta3) ./ (theta);

    % transformation matrices

    % rotation matrices
    R1 = Rotate(tt1);
    R2 = Rotate(tt2);
    R3 = Rotate(tt3);

    % translation matrices
    % parameters are link lengths
    T2 = Translate(2);
    T3 = Translate(1.5);
    T4 = Translate(1);

    % finding second point
    
    % transformation matrix
    Y = R1 * T2;
    
    % Finding new coordinates
    Y1 = Y * [0; 0; 0; 1];
    x(2) = Y1(1);
    y(2) = Y1(2);

    % finding third point
    
    % transformation matrix
    Y = R1 * T2 * R2 * T3;
    
    % Finding new coordinates
    Y1 = Y * [0; 0; 0; 1];
    x(3) = Y1(1);
    y(3) = Y1(2);

    % finding fourth point
    
    % transformation matrix
    Y = R1 * T2 * R2 * T3 * R3 * T4;
    
    % Finding new coordinates
    Y1 = Y * [0; 0; 0; 1];
    x(4) = Y1(1);
    y(4) = Y1(2);

    % display points and lengths of arms
    % to verify that joint length does not change.
    
    % length1 = (((x(1) - x(2)) .^ 2) + ((y(1) - y(2)) .^ 2)) .^ (0.5);
    % length2 = (((x(3) - x(2)) .^ 2) + ((y(3) - y(2)) .^ 2)) .^ (0.5);
    % length3 = (((x(3) - x(4)) .^ 2) + ((y(3) - y(4)) .^ 2)) .^ (0.5);
    % disp(length1);
    % disp(length2);
    % disp(length3);
    
    % delete the line already drawn so that it is not seen when next
    % line gets drawn.
    delete(l);
    delete(l5);
    delete(l6);
    delete(l7);
    delete(l8);
    % draw line and fix axes
    l = line(x, y);
    hold on;
    l1 = plot(x(1), y(1), 'r.');
    l2 = plot(x(2), y(2), 'r.');
    l3 = plot(x(3), y(3), 'r.');
    l4 = plot(x(4), y(4), 'ro');
    l1.MarkerSize = 1;
    l2.MarkerSize = 1;
    l3.MarkerSize = 1;
    l4.MarkerSize = 5;
    l5 = plot(x(1), y(1), 'gs');
    l6 = plot(x(2), y(2), 'gs');
    l7 = plot(x(3), y(3), 'gs');
    l8 = plot(x(4), y(4), 'gs');
    axis([-5 5 -5 5]);
    % wait for 0.01 seconds before moving to next iteration.
    pause(0.01);
end