% sobol 参数敏感性分析

%% 初始化
clc;
clear all;
close all;
%% 设定：给定参数个数和各个参数的范围

% % 1-自定义子函数1
% D=3;% 维度3,几个参数
% nPop=4:500:5000;% 采样点个数,也就是参数水平数 ,取大了好，比如4000，但慢
% VarMin=[-pi -pi -pi ];%各个参数下限  SALib ：S1: [ 0.30797549  0.44776661 -0.00425452] ；ST: [0.56013728 0.4387225  0.24284474]
% VarMax=[pi pi pi];%各个参数上限
% myFunction=@(x) Ishigami(x);%目标函数，也可以是个黑盒子

% % 1-自定义子函数2
D=3;% 维度3,几个参数
nPop=4:50:1000;% 采样点个数,也就是参数水平数 ,取大了好，比如4000，但慢
VarMin=[1 2 3 ];%各个参数下限
VarMax=[3 4 5];%各个参数上限
myFunction=@(x) myx2(x);

% % 1-自定义子函数3
% D=4;% 维度3,几个参数
% nPop=4:50:1000;% 采样点个数,也就是参数水平数 ,取大了好，比如4000，但慢
% VarMin=[1 2 3 4];%各个参数下限
% VarMax=[3 4 5 5];%各个参数上限
% myFunction=@(x) myx3(x);


%% 开始计算
numnPop=numel(nPop);
SAll=zeros(numnPop,D+1);%分别是各参数的敏感度，最后一列是各参数敏感度之和
STAll=zeros(numnPop,D+1);
for i=1:numnPop
    [S,ST]=sobol(D,nPop(i),VarMin,VarMax,myFunction);
    SAll(i,1:D)=S';
    SAll(i,D+1)=sum(SAll(i,1:D));
    STAll(i,1:D)=ST';
    STAll(i,D+1)=sum(STAll(i,1:D));
end
%% 绘图
color=[1 0 0;0 1 0;0 0 1;0.5 0.1 0;0 0.3 0.4;0.6 0.7 0.2;0.5 0.8 0.9;0 0.2 0.1;0.1 0.5 0;0.1 0 0.5;0.5 0 0.1];%12种颜色 一般颜色不一样
marker=['o','+','*','.','x','s','d','^','v','>','<','p','h'];%13种标记 一般标记也不一样; 字符数组，每个字符占1个位置
linestyle=[string('-'),string('--'),string(':'),string('-.'),string('none')];
useL=1;

figure(1)
for i=1:D+1
plot(nPop,SAll(:,i),'Marker',marker(i),'LineStyle',char(linestyle(useL)),'Color',color(i,:),'LineWidth',1);
hold on
end
title('Sobol-S');
whichPara=sprintfc('%g',repmat(1:D+1,1,2));%把数字数组转化成字符串数组
legend(whichPara,'Location','bestoutside');%加图例


figure(2)
for i=1:D+1
plot(nPop,STAll(:,i),'Marker',marker(i),'LineStyle',char(linestyle(useL)),'Color',color(i,:),'LineWidth',1);
hold on
end
title('Sobol-ST');
whichPara=sprintfc('%g',repmat(1:D+1,1,2));%把数字数组转化成字符串数组
legend(whichPara,'Location','bestoutside');%加图例

disp('一阶影响指数（左方向收敛于1）Sobol-S：');
disp(S);
disp('总效应指数（大于等于1，且仅当myfun是纯相加时取等号）Sobol-ST：');
disp(ST);
disp(datetime);
disp('parameter sensitive analyse success use sobol method!');
%% 火车声音提示已经算完了
load train
sound(y,Fs)



%% -------------------------子函数 ----------------------------
% 1-自定义子函数1（3个参数）Ishigami  
function y=Ishigami(x)
y=sin(x(1))+7*(sin(x(2)))^2+0.1*x(3)^4*sin(x(1));% SALib用的这个
% y=sin(x(1))+7*(sin(x(2)))^2+0.05*x(3)^4*sin(x(1));
end

% 1-自定义子函数2 （3个参数）
function y=myx2(x)
t=-5:1:5;%与此处有t范围和步距有关系
% t=-5:0.1:5;%与此处有t范围和步距有关系
ylab=2*t.^2+3*t+4;
ytheory=x(1)*t.^2+x(2)*t+x(3);
y=sum((ylab-ytheory).^2);%残差平方和SSR作为目标函数
% y=sum((ylab-ytheory).^2)/numel(t);%各参数灵敏度与上式相同
end


% 1-自定义子函数3（4个参数）
function y=myx3(x)
t=-5:1:5;
ylab=2*t.^3+3*t.^2+4*t+5;
ytheory=x(1)*t.^3+x(2)*t.^2+x(3)*t+x(4);
y=sum((ylab-ytheory).^2);
end



%% 2-求sobol敏感度
function [S,ST]=sobol(D,nPop,VarMin,VarMax,myFunction)
M=D*2;%
%% 产生所需的各水平参数
VarMin=[VarMin,VarMin];
VarMax=[VarMax,VarMax];
p= sobolset(M);
% R=p(1:nPop,:);% 我只用前nPop个
R=[];
for i=1:nPop
    r=p(i,:);
    r=VarMin+r.*(VarMax-VarMin);
    R=[R; r];
end
% plot(R(:,1),'b*')
% 拆分为A B
A=R(:,1:D);% 每行代表一组参数，其中每列代表每组参数的一个参数；行数就代表共有几组参数
B=R(:,D+1:end);
% 根据A B 产生矩阵AB
AB=zeros(nPop,D,D);
for i=1:D
    tempA=A;
    tempA(:,i)=B(:,i);
    AB(1:nPop,1:D,i)=tempA;
end
%% 求各参数解
YA=zeros(nPop,1);% 解
YB=zeros(nPop,1);
YAB=zeros(nPop,D);%分别代表YAB1,YAB2,YAB3，YAB(:,D)就代表YABD
for i=1:nPop
    YA(i)=myFunction(A(i,:));
    YB(i)=myFunction(B(i,:));
    for j=1:D
        YAB(i,j)=myFunction(AB(i,:,j));
    end
end
%%  根据一阶影响指数公式：
VarX=zeros(D,1);% S的分子
S=zeros(D,1);

% 0: 估算基于给定样本的方差(EXCEL var.p) ;   1:计算基于给定的样本总体的方差(EXCEL var.p())
% var([2.091363878    1.110366059    3.507651769    1.310950363    2.091363878    3.507651769    1.110366059    1.7066512],1);
VarY=var([YA;YB],1,'omitnan');% S的分母。 计算基于给定的样本总体的方差(EXCEL var.p())
for i=1:D
    for j=1:nPop
         VarX(i)=VarX(i)+YB(j)*(YAB(j,i)-YA(j));
    end
     VarX(i)=1/nPop*VarX(i);% 蒙特卡罗估计量
     S(i)=VarX(i)/VarY;
end

%% 总效应指数
EX=zeros(D,1);
ST=zeros(D,1);
for i=1:D
    for j=1:nPop
         EX(i)=EX(i)+(YA(j)-YAB(j,i))^2;
    end
      EX(i)=1/(2*nPop)* EX(i);% 蒙特卡罗估计量
     ST(i)=EX(i)/VarY;
end
end