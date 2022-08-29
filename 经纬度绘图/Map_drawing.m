 %根据经纬度绘制地图
close all, clear all, clc, dbstop if error
fpni='C:\Users\WuTong\Desktop\gadm36_CHN_shp\gadm36_CHN_3.shp';%大陆地图shp文件所在路径
fpno='C:\Users\WuTong\Desktop\gadm36_CHN_shp\gadm36_HKG_1.shp';%香港地图
fpnh='C:\Users\WuTong\Desktop\gadm36_CHN_shp\gadm36_TWN_2.shp';%
China=shaperead(fpni);
HongKong=shaperead(fpno);
TW=shaperead(fpnh);
boux=[China(:).X];bouy=[China(:).Y];%分别是获取经度X信息和纬度Y信息
hkx=[HongKong(:).X];hky=[HongKong(:).Y];
twx=[TW(:).X];twy=[TW(:).Y];
set(gcf,'position',[0 0 1440 780]);%设置图形窗口位置和大小
m_proj('Mercator','lon',[112.5 115],'lat',[22 24]);%设置投影方式为：墨卡托，地图显示范围
% m_proj('Mercator')
m_plot(boux,bouy,'k');%最关键的一句，绘制地图
hold on 
m_plot(hkx,hky,'k');
m_plot(twx,twy,'k');
%下面这句设置图形横纵坐标为经纬度格式
m_grid('linestyle','none','linewidth',2,'tickdir','out','xaxisloc','bottom','yaxisloc','left','fontsize',12);
hold on;
[data,txt,raw]=xlsread('C:\Users\WuTong\Desktop\附件一：已结束项目任务数据.xls');
% Index=data(:,5);
lon=data(1:313,2);lat=data(1:313,1);
Lon=data(314:816,2);Lat=data(314:816,1);
h1=m_scatter(lon,lat,20,'r', 'filled', 'MarkerFaceColor', 'flat', 'MarkerEdgeColor', 'w','linewi',0.1) ;
% legend('未完成')
hold on
h2=m_scatter(Lon,Lat,20,'g', 'filled', 'MarkerFaceColor', 'flat', 'MarkerEdgeColor', 'w','linewi',0.1);%画实心点图
legend([h1(1),h2(1)],'未完成任务', '已完成任务','location', 'northeast');
% m_scatter(lon,lat,50, dataco, 'MarkerFaceColor', w','linewi',2) ;%画空心点图
% contourcmap( 'jet', [-1:0.1:1], 'colorbar', 'on','location', 'vertical', 'fontsize', 13);%显示图例
title('任务分布情况图', 'Rotation', 0, 'FontSize', 14);%显示图标题