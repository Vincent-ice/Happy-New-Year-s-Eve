figure  %����figure����
% figure('visible','off'); % ������figure���ڣ���������Ұѽ������������������ѡ�񲻵������ڣ�ֱ�ӱ���
X =[0.0082 0.1302 0.6110 0.1898 0.0111];
hold on
color_matrix = [1,0.38,0.27;0,0.75,1;0.9290,0.6940,0.1250;0.4940,0.1840,0.5560;0.4660,0.6740,0.1880];  %ÿ�����ӵ���ɫ����
%һ����������ӣ���b��¼����ʱ����b(i)��facecolor�Ϳ��������޸���ɫ               
for i = 1:5
    b = bar(i,X(i),0.8,'stacked');  %0.75������ͼ�Ŀ����Ը���
    set(b(1),'facecolor',color_matrix(i,:))
end
box on
Xlabel = {'1','2','3','4','5'};
set(gca,'XTick',[1 2 3 4 5]);
set(gca,'XTickLabel',Xlabel);%������״ͼÿ�����ӵĺ�����
set(gca,'YLim',[0 1]);%�������������ֵ���
ylabel('Sensitivity') 
%xlabel(str) %���ú���������� 
set(gca,'FontSize',15,'Fontname', 'Arial');
% saveas(b,".\results\" + str + "_acc.jpg");%���滭������ͼ

