close all, clear all, clc, dbstop if error
data=xlsread('1.xlsx');
boux=data(:,3);bouy=data(:,4);%分别是获取经度X信息和纬度Y信息
m_proj('Mercator','lon',[116.3340 116.3365],'lat',[40.0010 40.0032]);
m_plot(boux,bouy,'k');%最关键的一句，绘制地图
%下面这句设置图形横纵坐标为经纬度格式
m_grid('linestyle','none','linewidth',2,'tickdir','out','xaxisloc','bottom','yaxisloc','left','fontsize',12);
