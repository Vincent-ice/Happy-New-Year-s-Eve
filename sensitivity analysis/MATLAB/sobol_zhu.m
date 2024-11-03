figure  %弹出figure窗口
% figure('visible','off'); % 不弹出figure窗口，由于最后我把结果保存了下来，所以选择不弹出窗口，直接保存
X =[0.0082 0.1302 0.6110 0.1898 0.0111];
hold on
color_matrix = [1,0.38,0.27;0,0.75,1;0.9290,0.6940,0.1250;0.4940,0.1840,0.5560;0.4660,0.6740,0.1880];  %每个柱子的颜色设置
%一个个添加柱子，用b记录，此时调用b(i)的facecolor就可以用来修改颜色               
for i = 1:5
    b = bar(i,X(i),0.8,'stacked');  %0.75是柱形图的宽，可以更改
    set(b(1),'facecolor',color_matrix(i,:))
end
box on
Xlabel = {'1','2','3','4','5'};
set(gca,'XTick',[1 2 3 4 5]);
set(gca,'XTickLabel',Xlabel);%设置柱状图每个柱子的横坐标
set(gca,'YLim',[0 1]);%设置纵坐标的数值间隔
ylabel('Sensitivity') 
%xlabel(str) %设置横坐标的名字 
set(gca,'FontSize',15,'Fontname', 'Arial');
% saveas(b,".\results\" + str + "_acc.jpg");%保存画出来的图

