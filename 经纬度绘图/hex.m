%16进制转化为10进制
a=textread('C:\Users\WuTong\Desktop\bin951.txt','%s');%以字符串的形式打开文件
alpha=hex2dec(a);%16进制转化为10进制，存入alpha矩阵
dlmwrite('filename.txt', alpha, 'delimiter', '\t');