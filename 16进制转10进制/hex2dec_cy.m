
function output_data = hex2dec_cy(raw_data,bitnum)
% 功能：将16，32位的十六进制数据转换为十进制（有符号）
% matlab自带函数 hex2dec 只是转换为无符号数
% 输入：raw_data，十六进制数据，char类型；bitnum，输入数据位数，e.g. 16,32
% 输出：output_data
% clear;
% bitnum = 32;
% raw_data = 'C129A3F6';
% raw_data = 'CA00710F';
if ~(ischar(raw_data) || isstring(raw_data))
    error('Error. \nInput must be a char or string, not a %s.',class(raw_data));
end

if bitnum == 16
    % data = dec2bin(hex2dec(raw_data),16); % 二进制数据
    data_dec = hex2dec(raw_data);
    % d = double(data)-48; % char类型数字用assii码表示，数字0对应48，所以要减去48.
    s = bitget(data_dec,16);
    
    if s == 0
        output_data = data_dec;
    else
        output_data = -(2^bitnum-data_dec);
    end
    
elseif bitnum == 32
    % data = dec2bin(hex2dec(raw_data),16); % 二进制数据
    data_dec = hex2dec(raw_data); % 无符号整数
    % d = double(data)-48; % char类型数字用assii码表示，数字0对应48，所以要减去48.
    s = bitget(data_dec,32);
    
    if s == 0
        output_data = data_dec; % 有符号整数
    else
        output_data = -(2^bitnum-data_dec); % 有符号整数
    end
    
    
else
    error('Error. Input parameters are not right.');   
end






% L = length(data);
% D = 16-L;
% % 不足16位时补足16位（高位为0的情况）
% for i = 1:D
%     d = [i-i,d];
% end

% b = char(d+48); % b的值为二进制值
% a = d(1,2:9);  %a指的是阶数的二进制
% c = bin2dec(char(a+48));%c指的是阶数的十进制













