clc
clear
tic
data = readmatrix("C:\Users\19076\Desktop\ʱ������\Dataset3SA(1��1��00��00-2��23��23��30.xlsx");

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
% �����������ߵĿ��Ϊ2
% set(gca, 'LineWidth', 2);

% ������������ֵ������Ϊ����
% set(gca, 'FontWeight', 'bold');

% legend('Original data','Denoised data', 'FontWeight', 'bold')
% U = u'
% 
% jieguo = jieguo'


elapsedTime = toc;
disp(['����ִ��ʱ��', num2str(elapsedTime), ' ��']);


