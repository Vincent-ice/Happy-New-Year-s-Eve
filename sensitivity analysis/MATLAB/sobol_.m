% sobol ���������Է���

%% ��ʼ��
clc;
clear all;
close all;
%% �趨���������������͸��������ķ�Χ

% % 1-�Զ����Ӻ���1
% D=3;% ά��3,��������
% nPop=4:500:5000;% ���������,Ҳ���ǲ���ˮƽ�� ,ȡ���˺ã�����4000������
% VarMin=[-pi -pi -pi ];%������������  SALib ��S1: [ 0.30797549  0.44776661 -0.00425452] ��ST: [0.56013728 0.4387225  0.24284474]
% VarMax=[pi pi pi];%������������
% myFunction=@(x) Ishigami(x);%Ŀ�꺯����Ҳ�����Ǹ��ں���

% % 1-�Զ����Ӻ���2
D=3;% ά��3,��������
nPop=4:50:1000;% ���������,Ҳ���ǲ���ˮƽ�� ,ȡ���˺ã�����4000������
VarMin=[1 2 3 ];%������������
VarMax=[3 4 5];%������������
myFunction=@(x) myx2(x);

% % 1-�Զ����Ӻ���3
% D=4;% ά��3,��������
% nPop=4:50:1000;% ���������,Ҳ���ǲ���ˮƽ�� ,ȡ���˺ã�����4000������
% VarMin=[1 2 3 4];%������������
% VarMax=[3 4 5 5];%������������
% myFunction=@(x) myx3(x);


%% ��ʼ����
numnPop=numel(nPop);
SAll=zeros(numnPop,D+1);%�ֱ��Ǹ����������жȣ����һ���Ǹ��������ж�֮��
STAll=zeros(numnPop,D+1);
for i=1:numnPop
    [S,ST]=sobol(D,nPop(i),VarMin,VarMax,myFunction);
    SAll(i,1:D)=S';
    SAll(i,D+1)=sum(SAll(i,1:D));
    STAll(i,1:D)=ST';
    STAll(i,D+1)=sum(STAll(i,1:D));
end
%% ��ͼ
color=[1 0 0;0 1 0;0 0 1;0.5 0.1 0;0 0.3 0.4;0.6 0.7 0.2;0.5 0.8 0.9;0 0.2 0.1;0.1 0.5 0;0.1 0 0.5;0.5 0 0.1];%12����ɫ һ����ɫ��һ��
marker=['o','+','*','.','x','s','d','^','v','>','<','p','h'];%13�ֱ�� һ����Ҳ��һ��; �ַ����飬ÿ���ַ�ռ1��λ��
linestyle=[string('-'),string('--'),string(':'),string('-.'),string('none')];
useL=1;

figure(1)
for i=1:D+1
plot(nPop,SAll(:,i),'Marker',marker(i),'LineStyle',char(linestyle(useL)),'Color',color(i,:),'LineWidth',1);
hold on
end
title('Sobol-S');
whichPara=sprintfc('%g',repmat(1:D+1,1,2));%����������ת�����ַ�������
legend(whichPara,'Location','bestoutside');%��ͼ��


figure(2)
for i=1:D+1
plot(nPop,STAll(:,i),'Marker',marker(i),'LineStyle',char(linestyle(useL)),'Color',color(i,:),'LineWidth',1);
hold on
end
title('Sobol-ST');
whichPara=sprintfc('%g',repmat(1:D+1,1,2));%����������ת�����ַ�������
legend(whichPara,'Location','bestoutside');%��ͼ��

disp('һ��Ӱ��ָ��������������1��Sobol-S��');
disp(S);
disp('��ЧӦָ�������ڵ���1���ҽ���myfun�Ǵ����ʱȡ�Ⱥţ�Sobol-ST��');
disp(ST);
disp(datetime);
disp('parameter sensitive analyse success use sobol method!');
%% ��������ʾ�Ѿ�������
load train
sound(y,Fs)



%% -------------------------�Ӻ��� ----------------------------
% 1-�Զ����Ӻ���1��3��������Ishigami  
function y=Ishigami(x)
y=sin(x(1))+7*(sin(x(2)))^2+0.1*x(3)^4*sin(x(1));% SALib�õ����
% y=sin(x(1))+7*(sin(x(2)))^2+0.05*x(3)^4*sin(x(1));
end

% 1-�Զ����Ӻ���2 ��3��������
function y=myx2(x)
t=-5:1:5;%��˴���t��Χ�Ͳ����й�ϵ
% t=-5:0.1:5;%��˴���t��Χ�Ͳ����й�ϵ
ylab=2*t.^2+3*t+4;
ytheory=x(1)*t.^2+x(2)*t+x(3);
y=sum((ylab-ytheory).^2);%�в�ƽ����SSR��ΪĿ�꺯��
% y=sum((ylab-ytheory).^2)/numel(t);%����������������ʽ��ͬ
end


% 1-�Զ����Ӻ���3��4��������
function y=myx3(x)
t=-5:1:5;
ylab=2*t.^3+3*t.^2+4*t+5;
ytheory=x(1)*t.^3+x(2)*t.^2+x(3)*t+x(4);
y=sum((ylab-ytheory).^2);
end



%% 2-��sobol���ж�
function [S,ST]=sobol(D,nPop,VarMin,VarMax,myFunction)
M=D*2;%
%% ��������ĸ�ˮƽ����
VarMin=[VarMin,VarMin];
VarMax=[VarMax,VarMax];
p= sobolset(M);
% R=p(1:nPop,:);% ��ֻ��ǰnPop��
R=[];
for i=1:nPop
    r=p(i,:);
    r=VarMin+r.*(VarMax-VarMin);
    R=[R; r];
end
% plot(R(:,1),'b*')
% ���ΪA B
A=R(:,1:D);% ÿ�д���һ�����������ÿ�д���ÿ�������һ�������������ʹ����м������
B=R(:,D+1:end);
% ����A B ��������AB
AB=zeros(nPop,D,D);
for i=1:D
    tempA=A;
    tempA(:,i)=B(:,i);
    AB(1:nPop,1:D,i)=tempA;
end
%% ���������
YA=zeros(nPop,1);% ��
YB=zeros(nPop,1);
YAB=zeros(nPop,D);%�ֱ����YAB1,YAB2,YAB3��YAB(:,D)�ʹ���YABD
for i=1:nPop
    YA(i)=myFunction(A(i,:));
    YB(i)=myFunction(B(i,:));
    for j=1:D
        YAB(i,j)=myFunction(AB(i,:,j));
    end
end
%%  ����һ��Ӱ��ָ����ʽ��
VarX=zeros(D,1);% S�ķ���
S=zeros(D,1);

% 0: ������ڸ��������ķ���(EXCEL var.p) ;   1:������ڸ�������������ķ���(EXCEL var.p())
% var([2.091363878    1.110366059    3.507651769    1.310950363    2.091363878    3.507651769    1.110366059    1.7066512],1);
VarY=var([YA;YB],1,'omitnan');% S�ķ�ĸ�� ������ڸ�������������ķ���(EXCEL var.p())
for i=1:D
    for j=1:nPop
         VarX(i)=VarX(i)+YB(j)*(YAB(j,i)-YA(j));
    end
     VarX(i)=1/nPop*VarX(i);% ���ؿ��޹�����
     S(i)=VarX(i)/VarY;
end

%% ��ЧӦָ��
EX=zeros(D,1);
ST=zeros(D,1);
for i=1:D
    for j=1:nPop
         EX(i)=EX(i)+(YA(j)-YAB(j,i))^2;
    end
      EX(i)=1/(2*nPop)* EX(i);% ���ؿ��޹�����
     ST(i)=EX(i)/VarY;
end
end