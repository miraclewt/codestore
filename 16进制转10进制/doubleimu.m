%

clear;
% function readdata_new(filename_in,filename_out)
filename_in = 'C:\Users\47154\Desktop\20948前后加计.txt';
filename_out = 'C:\Users\47154\Desktop\20948前后加计.csv';
delimiter = ' ';
opts = delimitedTextImportOptions('Delimiter',delimiter);
opts = setvartype(opts,'string');
DATA_INIT = readmatrix(filename_in,opts);
 col_ax1_h = 1;col_ax1_l = 2;col_ay1_h = 3;col_ay1_l = 4;col_az1_h = 5;col_az1_l = 6;
 col_gx1_h = 7;col_gx1_l = 8;col_gy1_h = 9;col_gy1_l = 10;col_gz1_h = 11;col_gz1_l = 12;
 col_mx1_h = 14;col_mx1_l = 13;col_my1_h = 16;col_my1_l = 15;col_mz1_h = 18;col_mz1_l = 17;
 
 
 col_ax2_h = 19;col_ax2_l = 20;col_ay2_h = 21;col_ay2_l = 22;col_az2_h = 23;col_az2_l = 24;
 col_gx2_h = 25;col_gx2_l = 26;col_gy2_h = 27;col_gy2_l = 28;col_gz2_h = 29;col_gz2_l = 30;
 col_mx2_h = 32;col_mx2_l = 31;col_my2_h = 34;col_my2_l = 33;col_mz2_h = 36;col_mz2_l = 35;
 
 N = length(DATA_INIT);
 j = 1;
 frame_length = 38;
rx_error_num = 0;
 end_flag_1 = 37;

delete_pos = 0;

 for m = (frame_length+1):(N-1)
     if((DATA_INIT(m) == "0D") && (DATA_INIT(m+1) == "0A"))
         end_flag_2 = m;
         if((end_flag_2-end_flag_1) ~= frame_length)
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
 
 % 数据帧长度为20
% for i = 46:frame_length:(N)
for i = 38:frame_length:(N)    
    ax1_hex = DATA_INIT(col_ax1_h)+DATA_INIT(col_ax1_l);
    ay1_hex = DATA_INIT(col_ay1_h)+DATA_INIT(col_ay1_l);
    az1_hex = DATA_INIT(col_az1_h)+DATA_INIT(col_az1_l);
    
    ax2_hex = DATA_INIT(col_ax2_h)+DATA_INIT(col_ax2_l);
    ay2_hex = DATA_INIT(col_ay2_h)+DATA_INIT(col_ay2_l);
    az2_hex = DATA_INIT(col_az2_h)+DATA_INIT(col_az2_l);
    
    
    gx1_hex = DATA_INIT(col_gx1_h)+DATA_INIT(col_gx1_l);
    gy1_hex = DATA_INIT(col_gy1_h)+DATA_INIT(col_gy1_l);
    gz1_hex = DATA_INIT(col_gz1_h)+DATA_INIT(col_gz1_l);
    
    gx2_hex = DATA_INIT(col_gx2_h)+DATA_INIT(col_gx2_l);
    gy2_hex = DATA_INIT(col_gy2_h)+DATA_INIT(col_gy2_l);
    gz2_hex = DATA_INIT(col_gz2_h)+DATA_INIT(col_gz2_l);
    
    
    mx1_hex = DATA_INIT(col_mx1_h)+DATA_INIT(col_mx1_l);
    my1_hex = DATA_INIT(col_my1_h)+DATA_INIT(col_my1_l);
    mz1_hex = DATA_INIT(col_mz1_h)+DATA_INIT(col_mz1_l);
    
    mx2_hex = DATA_INIT(col_mx2_h)+DATA_INIT(col_mx2_l);
    my2_hex = DATA_INIT(col_my2_h)+DATA_INIT(col_my2_l);
    mz2_hex = DATA_INIT(col_mz2_h)+DATA_INIT(col_mz2_l);
    
  
    col_ax1_h = col_ax1_h + frame_length; col_ax1_l = col_ax1_l + frame_length; col_ay1_h = col_ay1_h + frame_length; col_ay1_l = col_ay1_l + frame_length; col_az1_h = col_az1_h + frame_length; col_az1_l = col_az1_l + frame_length;
    col_gx1_h = col_gx1_h + frame_length; col_gx1_l = col_gx1_l + frame_length; col_gy1_h = col_gy1_h + frame_length; col_gy1_l = col_gy1_l + frame_length; col_gz1_h = col_gz1_h + frame_length; col_gz1_l = col_gz1_l + frame_length;
    col_mx1_h = col_mx1_h + frame_length; col_mx1_l = col_mx1_l + frame_length; col_my1_h = col_my1_h + frame_length; col_my1_l = col_my1_l + frame_length; col_mz1_h = col_mz1_h + frame_length; col_mz1_l = col_mz1_l + frame_length;
    
    col_ax2_h = col_ax2_h + frame_length; col_ax2_l = col_ax2_l + frame_length; col_ay2_h = col_ay2_h + frame_length; col_ay2_l = col_ay2_l + frame_length; col_az2_h = col_az2_h + frame_length; col_az2_l = col_az2_l + frame_length;
    col_gx2_h = col_gx2_h + frame_length; col_gx2_l = col_gx2_l + frame_length; col_gy2_h = col_gy2_h + frame_length; col_gy2_l = col_gy2_l + frame_length; col_gz2_h = col_gz2_h + frame_length; col_gz2_l = col_gz2_l + frame_length;
    col_mx2_h = col_mx2_h + frame_length; col_mx2_l = col_mx2_l + frame_length; col_my2_h = col_my2_h + frame_length; col_my2_l = col_my2_l + frame_length; col_mz2_h = col_mz2_h + frame_length; col_mz2_l = col_mz2_l + frame_length;
    
    ax_dec_buf1(j) = hex2dec(ax1_hex);ay_dec_buf1(j) = hex2dec(ay1_hex);az_dec_buf1(j) = hex2dec(az1_hex); 
    gx_dec_buf1(j) = hex2dec(gx1_hex);gy_dec_buf1(j) = hex2dec(gy1_hex);gz_dec_buf1(j) = hex2dec(gz1_hex);
    mx_dec_buf1(j) = hex2dec(mx1_hex);my_dec_buf1(j) = hex2dec(my1_hex);mz_dec_buf1(j) = hex2dec(mz1_hex);
    
    ax_dec_buf2(j) = hex2dec(ax2_hex);ay_dec_buf2(j) = hex2dec(ay2_hex);az_dec_buf2(j) = hex2dec(az2_hex);   
    gx_dec_buf2(j) = hex2dec(gx2_hex);gy_dec_buf2(j) = hex2dec(gy2_hex);gz_dec_buf2(j) = hex2dec(gz2_hex);
    mx_dec_buf2(j) = hex2dec(mx2_hex);my_dec_buf2(j) = hex2dec(my2_hex);mz_dec_buf2(j) = hex2dec(mz2_hex);
    
 
    sign_flag_ax1 = bitget(ax_dec_buf1(j),16:16); sign_flag_ay1 = bitget(ay_dec_buf1(j),16:16);sign_flag_az1 = bitget(az_dec_buf1(j),16:16);
    sign_flag_gx1 = bitget(gx_dec_buf1(j),16:16); sign_flag_gy1 = bitget(gy_dec_buf1(j),16:16);sign_flag_gz1 = bitget(gz_dec_buf1(j),16:16);
    sign_flag_mx1 = bitget(mx_dec_buf1(j),16:16); sign_flag_my1 = bitget(my_dec_buf1(j),16:16);sign_flag_mz1 = bitget(mz_dec_buf1(j),16:16);
    
    sign_flag_ax2 = bitget(ax_dec_buf2(j),16:16);sign_flag_ay2 = bitget(ay_dec_buf2(j),16:16);sign_flag_az2 = bitget(az_dec_buf2(j),16:16);
    sign_flag_gx2 = bitget(gx_dec_buf2(j),16:16);sign_flag_gy2 = bitget(gy_dec_buf2(j),16:16);sign_flag_gz2 = bitget(gz_dec_buf2(j),16:16);
    sign_flag_mx2 = bitget(mx_dec_buf2(j),16:16);sign_flag_my2 = bitget(my_dec_buf2(j),16:16);sign_flag_mz2 = bitget(mz_dec_buf2(j),16:16);
    
 
    
    %      加速度符号判断
    if sign_flag_ax1 == 1
        ax_dec1(j) = -int16(65536-ax_dec_buf1(j));
    else
        ax_dec1(j) = ax_dec_buf1(j);
    end
    
    if sign_flag_ay1 == 1
        ay_dec1(j) = -int16(65536-ay_dec_buf1(j));
    else
        ay_dec1(j) = ay_dec_buf1(j);
    end
    
    if sign_flag_az1 == 1
        az_dec1(j) = -int16(65536-az_dec_buf1(j));
    else
        az_dec1(j) = az_dec_buf1(j);
    end
    
    %      角速度符号判断
    if sign_flag_gx1 == 1
        gx_dec1(j) = -int16(65536-gx_dec_buf1(j));
    else
        gx_dec1(j) = gx_dec_buf1(j);
    end
    
    if sign_flag_gy1 == 1
        gy_dec1(j) = -int16(65536-gy_dec_buf1(j));
    else
        gy_dec1(j) = gy_dec_buf1(j);
    end
    
    if sign_flag_gz1 == 1
        gz_dec1(j) = -int16(65536-gz_dec_buf1(j));
    else
        gz_dec1(j) = gz_dec_buf1(j);
    end
    
    
    %      磁强计符号判断
    if sign_flag_mx1 == 1
        mx_dec1(j) = -int16(65536-mx_dec_buf1(j));
    else
        mx_dec1(j) = mx_dec_buf1(j);
    end
    
    if sign_flag_my1 == 1
        my_dec1(j) = -int16(65536-my_dec_buf1(j));
    else
        my_dec1(j) = my_dec_buf1(j);
    end
    
    if sign_flag_mz1 == 1
        mz_dec1(j) = -int16(65536-mz_dec_buf1(j));
    else
        mz_dec1(j) = mz_dec_buf1(j);
    end
if sign_flag_ax2 == 1
        ax_dec2(j) = -int16(65536-ax_dec_buf2(j));
    else
        ax_dec2(j) = ax_dec_buf2(j);
    end
    
    if sign_flag_ay2 == 1
        ay_dec2(j) = -int16(65536-ay_dec_buf2(j));
    else
        ay_dec2(j) = ay_dec_buf2(j);
    end
    
    if sign_flag_az2 == 1
        az_dec2(j) = -int16(65536-az_dec_buf2(j));
    else
        az_dec2(j) = az_dec_buf2(j);
    end
    
    %      角速度符号判断
    if sign_flag_gx2 == 1
        gx_dec2(j) = -int16(65536-gx_dec_buf2(j));
    else
        gx_dec2(j) = gx_dec_buf2(j);
    end
    
    if sign_flag_gy2 == 1
        gy_dec2(j) = -int16(65536-gy_dec_buf2(j));
    else
        gy_dec2(j) = gy_dec_buf2(j);
    end
    
    if sign_flag_gz2 == 1
        gz_dec2(j) = -int16(65536-gz_dec_buf2(j));
    else
        gz_dec2(j) = gz_dec_buf2(j);
    end
    
    
    %      磁强计符号判断
    if sign_flag_mx2 == 1
        mx_dec2(j) = -int16(65536-mx_dec_buf2(j));
    else
        mx_dec2(j) = mx_dec_buf2(j);
    end
    
    if sign_flag_my2 == 1
        my_dec2(j) = -int16(65536-my_dec_buf2(j));
    else
        my_dec2(j) = my_dec_buf2(j);
    end
    
    if sign_flag_mz2 == 1
        mz_dec2(j) = -int16(65536-mz_dec_buf2(j));
    else
        mz_dec2(j) = mz_dec_buf2(j);
    end
    
    j = j + 1;
    

    
    
end

%  依据数据手册选择相应系数
% 单位 m/s^2
ax1 = double(ax_dec1')/65536*9.8*8;
ay1 = double(ay_dec1')/65536*9.8*8;
az1 = double(az_dec1')/65536*9.8*8;

%  dec/s
gx1 = double(gx_dec1')/65536*2000;
gy1 = double(gy_dec1')/65536*2000;
gz1 = double(gz_dec1')/65536*2000;
% mx = double(mx_dec') * 65536*2000 ;
% my = double(my_dec') * 0.0015;
% mz = double(mz_dec') * 0.0015;


mx1 = double(mx_dec1')  ;
my1 = double(my_dec1')  ;
mz1 = double(mz_dec1')  ;


ax2 = double(ax_dec2)'/65536*9.8*8;
ay2 = double(ay_dec2')/65536*9.8*8;
az2 = double(az_dec2')/65536*9.8*8;

%  dec/s
gx2 = double(gx_dec2')/65536*2000;
gy2 = double(gy_dec2')/65536*2000;
gz2 = double(gz_dec2')/65536*2000;
% %  gauss 1uT = 0.01Gauss
% mx = double(mx_dec') * 0.0015 ;
% my = double(my_dec') * 0.0015;
% mz = double(mz_dec') * 0.0015;


mx2 = double(mx_dec2')  ;
my2 = double(my_dec2')  ;
mz2 = double(mz_dec2')  ;


DATA = [ax1,ay1,az1,gx1,gy1,gz1,mx1,my1,mz1,ax2,ay2,az2,gx2,gy2,gz2,mx2,my2,mz2];

%  确定输出文件名称
 writematrix(DATA,filename_out);


% end