% 将读取的十六进制文本转化为对应的十进制格式，处理imu数据
% 加入删除开始的不正确数据，确保第一帧数据正确 +20210312
% 处理TCP&UDP测试工具的数据或XCOM数据时，需注意及时更改end_string_1,end_string_2 +20210417
% 换用tcp工具，无需更改end_string_1,end_string_2 +20210426
% 添加数据转换子函数，增加代码复用性 +20210430
% 数据特性：imu数据分为200Hz和50Hz两种，高采样率的数据为acc和gyro，低采样率的为acc、gyro和mag，采集3个高速数据后采集一个低速数据 +2021/05/13
% 1uT = 0.01Gauss
% imu为icm20948，最后的数据输出系数需按照手册选取
% 作者：cy
% 编写于 2021/05/13


clear;
clc;

filename_in = 'C:\Users\47154\Desktop\111.txt';
filename_out = 'C:\Users\47154\Desktop\111.csv';
filename_out_2 = 'C:\Users\47154\Desktop\1112.csv';
delimiter = ' ';
opts = delimitedTextImportOptions('Delimiter',delimiter);
opts = setvartype(opts,'string');
DATA_INIT = readmatrix(filename_in,opts);

N = length(DATA_INIT);
data_start_num = 0;
frame_length_1 = 14; % 包含0x0d,0x0a
frame_length_2 = 20; % 包含0x0d,0x0a
g = 9.80665;

end_string_1 = "0D";
end_string_2 = "0A";

% 查找到第一个OD OA，删除此时的OD OA及其之前的数据
for i = 1:(N-1)
    if (DATA_INIT(i) == end_string_1 && DATA_INIT(i+1) == end_string_2)
        data_start_num_ = i + 1; % 0A位置
        if (data_start_num_ - data_start_num) == frame_length_1 ...
                || (data_start_num_ - data_start_num) == frame_length_2 % 这一帧数据正确，退出循环，数据正确位置从(data_start_num + 1)开始
            break;
        else
            data_start_num = data_start_num_;
        end
    end
end
DATA_INIT(1:data_start_num) = [];

col_ax_h = 1; col_ax_l = 2; col_ay_h = 3; col_ay_l = 4; col_az_h = 5; col_az_l = 6; % acc
col_gx_h = 7; col_gx_l = 8; col_gy_h = 9; col_gy_l = 10;col_gz_h = 11; col_gz_l = 12; % gyro
% col_mx_h = 13; col_mx_l = 14; col_my_h = 15; col_my_l = 16;col_mz_h = 17; col_mz_l = 18; % mag
col_mx_h = 14; col_mx_l = 13; col_my_h = 16; col_my_l = 15;col_mz_h = 18; col_mz_l = 17; % mag

col_ax_h_2 = 1; col_ax_l_2 = 2; col_ay_h_2 = 3; col_ay_l_2 = 4; col_az_h_2 = 5; col_az_l_2 = 6; % acc
col_gx_h_2 = 7; col_gx_l_2 = 8; col_gy_h_2 = 9; col_gy_l_2 = 10;col_gz_h_2 = 11; col_gz_l_2 = 12; % gyro

N = length(DATA_INIT);
j = 1;

rx_error_num = 0; % 显示中间数据出现错误的次数
end_flag_1 = frame_length_1 - 1; % 0D位置
delete_pos = 0;

% 删除错误数据
for m = (frame_length_1+1):(N-1)
    if((DATA_INIT(m) == end_string_1) && (DATA_INIT(m+1) == end_string_2))
        end_flag_2 = m;
        if((end_flag_2-end_flag_1) ~= frame_length_1 && (end_flag_2-end_flag_1) ~= frame_length_2)
            rx_error_num = rx_error_num+1;
            delete_pos = [delete_pos,(end_flag_1+2):(end_flag_2+1)];
            % TODO
            % 当换行回车符不完整时，会将紧邻的下一组正常数据删除
        end
        end_flag_1 = end_flag_2;
    end
    
    
end
DATA_INIT(delete_pos(2:end)) = [];

N = length(DATA_INIT);

k1 = frame_length_1-1;
k2 = frame_length_2-1;
j_m = 1;
for i = 1:N
    if ismissing(DATA_INIT)
        break;
    end
    
    if (DATA_INIT(k1) == end_string_1) && (DATA_INIT(k1+1) == end_string_2)
        ax_hex_2 = DATA_INIT(col_ax_h_2)+DATA_INIT(col_ax_l_2);
        ay_hex_2 = DATA_INIT(col_ay_h_2)+DATA_INIT(col_ay_l_2);
        az_hex_2 = DATA_INIT(col_az_h_2)+DATA_INIT(col_az_l_2);
        gx_hex_2 = DATA_INIT(col_gx_h_2)+DATA_INIT(col_gx_l_2);
        gy_hex_2 = DATA_INIT(col_gy_h_2)+DATA_INIT(col_gy_l_2);
        gz_hex_2 = DATA_INIT(col_gz_h_2)+DATA_INIT(col_gz_l_2);
        
        ax_dec(j) = hex2dec_cy(ax_hex_2,16); ay_dec(j) = hex2dec_cy(ay_hex_2,16); az_dec(j) = hex2dec_cy(az_hex_2,16);
        gx_dec(j) = hex2dec_cy(gx_hex_2,16); gy_dec(j) = hex2dec_cy(gy_hex_2,16); gz_dec(j) = hex2dec_cy(gz_hex_2,16);
        
        DATA_INIT(1:(k1+1)) = [];
        
    elseif (DATA_INIT(k2) == end_string_1) && (DATA_INIT(k2+1) == end_string_2)
        ax_hex = DATA_INIT(col_ax_h)+DATA_INIT(col_ax_l);
        ay_hex = DATA_INIT(col_ay_h)+DATA_INIT(col_ay_l);
        az_hex = DATA_INIT(col_az_h)+DATA_INIT(col_az_l);
        gx_hex = DATA_INIT(col_gx_h)+DATA_INIT(col_gx_l);
        gy_hex = DATA_INIT(col_gy_h)+DATA_INIT(col_gy_l);
        gz_hex = DATA_INIT(col_gz_h)+DATA_INIT(col_gz_l);
        mx_hex = DATA_INIT(col_mx_h)+DATA_INIT(col_mx_l);
        my_hex = DATA_INIT(col_my_h)+DATA_INIT(col_my_l);
        mz_hex = DATA_INIT(col_mz_h)+DATA_INIT(col_mz_l);
        
        ax_dec(j) = hex2dec_cy(ax_hex,16); ay_dec(j) = hex2dec_cy(ay_hex,16); az_dec(j) = hex2dec_cy(az_hex,16);
        gx_dec(j) = hex2dec_cy(gx_hex,16); gy_dec(j) = hex2dec_cy(gy_hex,16); gz_dec(j) = hex2dec_cy(gz_hex,16);
        mx_dec(j) = hex2dec_cy(mx_hex,16); my_dec(j) = hex2dec_cy(my_hex,16); mz_dec(j) = hex2dec_cy(mz_hex,16);
        mx_dec_2(j_m) = hex2dec_cy(mx_hex,16); my_dec_2(j_m) = hex2dec_cy(my_hex,16); mz_dec_2(j_m) = hex2dec_cy(mz_hex,16);
        
        j_m = j_m + 1;
        DATA_INIT(1:(k2+1)) = [];
        
    end
    j = j + 1;
    
    
end

% 依据数据手册选择相应系数，icm20948

% 单位 m/s^2，+-4g
ax = double(ax_dec)'/8192 * g;
ay = double(ay_dec')/8192 * g;
az = double(az_dec')/8192 * g;

%  deg/s，+-2000dps
gx = double(gx_dec')/65536 * 2000;
gy = double(gy_dec')/65536 * 2000;
gz = double(gz_dec')/65536 * 2000;

% uT
mx = double(mx_dec') * 0.15;
my = double(my_dec') * 0.15;
mz = double(mz_dec') * 0.15;
mx_2 = double(mx_dec_2') * 0.15;
my_2 = double(my_dec_2') * 0.15;
mz_2 = double(mz_dec_2') * 0.15;

max_length = max(length(ax),length(mz));
min_length = min(length(ax),length(mz));
% DATA = zeros(max_length,9);
DATA = zeros(min_length,9);

DATA = [ax(1:min_length),ay(1:min_length),az(1:min_length),gx(1:min_length),gy(1:min_length),gz(1:min_length),mx(1:min_length),my(1:min_length),mz(1:min_length)];
fprintf('错误接收数据个数：%d\n',rx_error_num);

DATA_MAG = [mx_2,my_2,mz_2];

%  确定输出文件名称
writematrix(DATA,filename_out);
writematrix(DATA_MAG,filename_out_2);
