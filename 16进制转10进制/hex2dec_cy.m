
function output_data = hex2dec_cy(raw_data,bitnum)
% ���ܣ���16��32λ��ʮ����������ת��Ϊʮ���ƣ��з��ţ�
% matlab�Դ����� hex2dec ֻ��ת��Ϊ�޷�����
% ���룺raw_data��ʮ���������ݣ�char���ͣ�bitnum����������λ����e.g. 16,32
% �����output_data
% clear;
% bitnum = 32;
% raw_data = 'C129A3F6';
% raw_data = 'CA00710F';
if ~(ischar(raw_data) || isstring(raw_data))
    error('Error. \nInput must be a char or string, not a %s.',class(raw_data));
end

if bitnum == 16
    % data = dec2bin(hex2dec(raw_data),16); % ����������
    data_dec = hex2dec(raw_data);
    % d = double(data)-48; % char����������assii���ʾ������0��Ӧ48������Ҫ��ȥ48.
    s = bitget(data_dec,16);
    
    if s == 0
        output_data = data_dec;
    else
        output_data = -(2^bitnum-data_dec);
    end
    
elseif bitnum == 32
    % data = dec2bin(hex2dec(raw_data),16); % ����������
    data_dec = hex2dec(raw_data); % �޷�������
    % d = double(data)-48; % char����������assii���ʾ������0��Ӧ48������Ҫ��ȥ48.
    s = bitget(data_dec,32);
    
    if s == 0
        output_data = data_dec; % �з�������
    else
        output_data = -(2^bitnum-data_dec); % �з�������
    end
    
    
else
    error('Error. Input parameters are not right.');   
end






% L = length(data);
% D = 16-L;
% % ����16λʱ����16λ����λΪ0�������
% for i = 1:D
%     d = [i-i,d];
% end

% b = char(d+48); % b��ֵΪ������ֵ
% a = d(1,2:9);  %aָ���ǽ����Ķ�����
% c = bin2dec(char(a+48));%cָ���ǽ�����ʮ����













