clear all; close all; clc;
C1 = xlsread('condition1.csv');
C2 = xlsread('condition2.csv');
C3 = xlsread('condition3.csv');
C4 = xlsread('condition4.2.csv');
C5 = xlsread('condition5.csv');
% Question 2
% We plotted 10s - 20s of data from each condition
% Most graphs for each question that have legends also
have offsets so
% each graph is better displayed.
figure(2) % Question 1 is associated with figure 1
title('Voltage Vs. Time for each condition');
xlabel('time(s)');
ylabel('Voltage(mV)');
% used 'C1' for condition 2 because when we
transferred the data, C2 only
% saved 20s of data. We recorded all of C1 when our
team member for
% calmly resting, so for the rest of the data we will be
using the C1
% shoulder to ankle values saved in the 9th and 10th
rows.
y2 = C1(2501:5001, 10) + 4;
plot(C1(2501:5001, 9), y2, 'g');
hold on
plot(C3(2501:5001, 1), C3(2501:5001, 2), 'r');
hold on
y4 = C4(2501:5001, 2) - 4;
plot(C4(2501:5001, 1), y4, 'b');
hold on
y5 = C5(51:101, 2) - 8;
plot(C5(51:101, 1), y5, 'y');
legend('Condition 2 (offset = +4)', 'Condition 3 (offset =
0)', 'Condition 4 (offset = -4)', 'Condition 5 (offset = -8)')
legend('location', 'southoutside');
hold off
% Question 3
% Plot voltages at intervals of 20 seconds in Conditions
2 and 3. Count
% beats in the interval by hand. Multiply # of beats by 3
to get bpm.
% Divide bpm by 60 to get frequency of heart beats in
Hz.
figure(3)
title('Voltage Vs. Time for 20 second intervals');
xlabel('time(s)');
ylabel('Voltage(mV)');
% Plot of first 20 seconds of Condition 2 voltages
% We plotted this instead on the last 20 seconds of
Condition 3 voltages
% because we accidently didn't save the last 40 seconds
of data for
% Condition 3
h1 = C1(1:5001, 10) + 2;
plot(C1(1:5001, 9), h1, 'r');
% Found 32 beats.
% Plot of second 20 seconds of Condition 2 voltages
hold on
h2 = C1(5001:10001, 10);
plot(C1(5001:10001, 9), h2, 'g');
% Found 34 beats.
% Plot of third 20 seconds of Condition 2 voltages
hold on
h3 = C1(10001:15001, 10) - 2;
plot(C1(10001:15001, 9), h3, 'm');
% Found 30 beats.
% Plot of first 20 seconds of Condition 3 voltages
hold on
h4 = C3(1:5001, 2) - 4;
plot(C3(1:5001, 1), h4, 'y');
% Found 38 beats.
legend('Condition 2 (offset = +2)', 'Condition 2 (offset =
0)', 'Condition 2 (offset = -2)', 'Condition 3 (offset = -4)');
legend('location', 'southoutside');
hold off
% Max heart beat = 38 beats. Maximum = 3 * 38 = 114
bpm.
% Frequency = 114/60 = 1.9 Hz.
% Min heart beat = 30 beats. Minimum = 3 * 30 = 90
bpm.
% Frequency = 90/60 = 1.5 Hz.
MinimumHeartBeat_bpm = 90
MinimumHeartBeatFrequency_Hz = 1.5
MaximumHeartBeat_bpm = 114
MaximumHeartBeatFrequency_Hz = 1.9
% Question 4
% Plot to observe the Valsalva Maneuver
figure(4)
title('Voltage Vs. Time during Valsalva Maneuver');
xlabel('time(s)');
ylabel('Voltage(mV)');
plot(C4(:,1) ,C4(:,2));
% Question 6
% Noisiest Signal is produced during Condition 4
% This figure will show the signal at various running
average windows
figure(5)
% remove offset by subtracting the average of all
voltages in the array
new = C4(:,2) - mean(C4(:,2));
% running average is over 0.5 seconds. First index
values I'll average over
% are 1 - 126. So, all the values below index 64 don't
recieve an averaged
% value, and won't be processed.
analyC4 = zeros(15001,1);
for k = 1:15001
if k <= 64 || k > 14937
analyC4(k, 1) = new(k, 1);
else
avg = mean(new(k-64:k+64), 1);
analyC4(k, 1) = new(k, 1) - avg;
end
end
subplot(3,1,1);
plot(C4(:,1) ,analyC4);
title('Condition 4 signal - window of 0.5s');
xlabel('time(s)');
ylabel('Voltage(mV)');
% changed running average to over 0.2 seconds. First
index values I'll average over
% are 1 - 51. So, all the values below index 26 don't
recieve an averaged
% value, and won't be processed.
analy2C4 = zeros(15001,1);
for k = 1:(15001-25)
if k <= 25 || k > 14976
analy2C4(k, 1) = new(k, 1);
else
avg = mean(new(k-25:k+25), 1);
analy2C4(k, 1) = new(k, 1) - avg;
end
end
subplot(3,1,2);
plot(C4(:,1) ,analy2C4);
title('Condition 4 signal - window of 0.2s');
xlabel('time(s)');
ylabel('Voltage(mV)');
% changed running average to over 0.1 seconds. First
index values I'll average over
% are 1 - 26. So, all the values below index 14 don't
recieve an averaged
% value, and won't be processed.
analy3C4 = zeros(15001,1);
for k = 1:15001
if k <= 14 || k > 14987
analy3C4(k, 1) = new(k, 1);
else
avg = mean(new(k-14:k+14), 1);
analy3C4(k, 1) = new(k, 1) - avg;
end
end
subplot(3,1,3);
plot(C4(:,1) ,analy3C4);
title('Condition 4 signal - window of 0.1s');
xlabel('time(s)');
ylabel('Voltage(mV)');
% Below code displays pre- and post- processing
signals
figure(6)
subplot(2,1,1);
plot(C4(:,1) ,C4(:,2));
title('Condition 4 Pre-processed Signal');
xlabel('time(s)');
ylabel('Voltage(mV)');
subplot(2,1,2);
plot(C4(:,1) ,analy3C4);
title('Condition 4 Processed Signal');
xlabel('time(s)');
ylabel('Voltage(mV)');
Part Two
signal = csvread('condition2.csv',3862,0,[3862 0 3925
1]);
plot(signal(1:64,1),signal(1:64,2));
hold on
f = 250;
A = mean(signal(1:64,2))-0.28;
t_sampling = 1/f;
offset = (abs(max(signal(1:64,2))) +
abs(min(signal(1:64,2))))/2;
y_sample = zeros(64,1);
y_sample(1) = A*sin(17.800) + offset;
for n =1:63
y_sample(n+1) = A*sin((2*pi)*(1/0.252)*n*t_sampling +
17.800) + offset;
end
plot(signal(1:64,1),y_sample(1:64))
title('ECG Signal & Sine Wave Comparison')
xlabel('Time(s)')
ylabel('Voltage(mV)')
legend('ECG Signal','Sine wave')
