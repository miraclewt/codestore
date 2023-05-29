% ********************
% 程序名称: 
% 功能描述: 
% 输入参数: 
%    - 参数1: 参数1的描述
%    - 参数2: 参数2的描述
% 输出参数: 
%    - 参数1: 参数1的描述
%    - 参数2: 参数2的描述
% 备注: 
%    - 备注信息
% ********************

% 程序正文
% ...

% ********************
% 程序名称: 
% 功能描述: matlab导出谷歌地球数据文件
% 经度和纬度数据
longitudes = [116.397, 116.405, 116.391, 116.405];
latitudes = [39.908, 39.907, 39.904, 39.906];

% 创建地理点对象
geoPoints = geopoint(latitudes', longitudes');

% 创建KML文件
kmlFileName = 'data.kml';
kmlwrite(kmlFileName, geoPoints, 'name', 'My Data');

% 打开KML文件
web(kmlFileName);


% ********************
% 程序名称: 导出高清图片
% 功能描述: 
export_fig high_res_figure.png -m4 -transparent -r600 % 导出高清图形