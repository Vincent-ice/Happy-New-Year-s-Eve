clc
clear
tic
data = readmatrix("C:\Users\19076\Desktop\时间序列\Dataset3SA(1月1日00：00-2月23日23：30.xlsx");

data1 = data(:, 1);

[u, u_hat, omega] = VMD(data1, 500, 0, 8, 0,1,1e-6)

figure

subplot(8,1,1);
plot(u(1,:))
axis off;
subplot(8,1,2);
plot(u(2,:))
axis off;
subplot(8,1,3);
plot(u(3,:))
axis off;
subplot(8,1,4);
plot(u(4,:))
axis off;
subplot(8,1,5);
plot(u(5,:))
axis off;
subplot(8,1,6);
plot(u(6,:))
axis off;
subplot(8,1,7);
plot(u(7,:))
axis off;
subplot(8,1,8);
plot(u(8,:))
axis off;
% 
% 
% 
u(8,:) = []
jieguo = sum(u)
% 
% figure
% plot(jieguo,'color', '#A30000', 'LineWidth', 2)
% axis off;
%plot(data, 'LineWidth', 2)
% hold on
% plot(jieguo, 'LineWidth', 2)
% 设置坐标轴线的宽度为2
% set(gca, 'LineWidth', 2);

% 设置坐标轴数值的字体为粗体
% set(gca, 'FontWeight', 'bold');

% legend('Original data','Denoised data', 'FontWeight', 'bold')
% U = u'
% 
% jieguo = jieguo'


elapsedTime = toc;
disp(['程序执行时间', num2str(elapsedTime), ' 秒']);


