 %���ݾ�γ�Ȼ��Ƶ�ͼ
close all, clear all, clc, dbstop if error
fpni='C:\Users\WuTong\Desktop\gadm36_CHN_shp\gadm36_CHN_3.shp';%��½��ͼshp�ļ�����·��
fpno='C:\Users\WuTong\Desktop\gadm36_CHN_shp\gadm36_HKG_1.shp';%��۵�ͼ
fpnh='C:\Users\WuTong\Desktop\gadm36_CHN_shp\gadm36_TWN_2.shp';%
China=shaperead(fpni);
HongKong=shaperead(fpno);
TW=shaperead(fpnh);
boux=[China(:).X];bouy=[China(:).Y];%�ֱ��ǻ�ȡ����X��Ϣ��γ��Y��Ϣ
hkx=[HongKong(:).X];hky=[HongKong(:).Y];
twx=[TW(:).X];twy=[TW(:).Y];
set(gcf,'position',[0 0 1440 780]);%����ͼ�δ���λ�úʹ�С
m_proj('Mercator','lon',[112.5 115],'lat',[22 24]);%����ͶӰ��ʽΪ��ī���У���ͼ��ʾ��Χ
% m_proj('Mercator')
m_plot(boux,bouy,'k');%��ؼ���һ�䣬���Ƶ�ͼ
hold on 
m_plot(hkx,hky,'k');
m_plot(twx,twy,'k');
%�����������ͼ�κ�������Ϊ��γ�ȸ�ʽ
m_grid('linestyle','none','linewidth',2,'tickdir','out','xaxisloc','bottom','yaxisloc','left','fontsize',12);
hold on;
[data,txt,raw]=xlsread('C:\Users\WuTong\Desktop\����һ���ѽ�����Ŀ��������.xls');
% Index=data(:,5);
lon=data(1:313,2);lat=data(1:313,1);
Lon=data(314:816,2);Lat=data(314:816,1);
h1=m_scatter(lon,lat,20,'r', 'filled', 'MarkerFaceColor', 'flat', 'MarkerEdgeColor', 'w','linewi',0.1) ;
% legend('δ���')
hold on
h2=m_scatter(Lon,Lat,20,'g', 'filled', 'MarkerFaceColor', 'flat', 'MarkerEdgeColor', 'w','linewi',0.1);%��ʵ�ĵ�ͼ
legend([h1(1),h2(1)],'δ�������', '���������','location', 'northeast');
% m_scatter(lon,lat,50, dataco, 'MarkerFaceColor', w','linewi',2) ;%�����ĵ�ͼ
% contourcmap( 'jet', [-1:0.1:1], 'colorbar', 'on','location', 'vertical', 'fontsize', 13);%��ʾͼ��
title('����ֲ����ͼ', 'Rotation', 0, 'FontSize', 14);%��ʾͼ����