function [dstimg, eta, result] = Otsu(srcimg)
%�ú���������ʵ��Otsuȫ����ֵ�ָ��
%����Ϊһ��ͼ��srcimg
%���dstimgΪ��ֵ�ָ�֮���ͼ��eta�ǿɷ��Զ�����result����ѵ���ֵ
if length(size(srcimg))==3
    srcimg = rgb2gray(srcimg);
end
%����ͳ��ֱ��ͼ����������һ��
Number=imhist(srcimg);
S = sum(Number);
Number = Number/S;

%ͳ���ۻ����Լ��ۻ���ֵ
P1 = zeros(length(Number), 1);
M1 = zeros(length(Number), 1);
for k = 1:length(Number)
    P = 0;
    M = 0;
    for i = 1:k
        P = P + Number(i);
        M = M + (i-1)*Number(i);
    end
    P1(k) = P;
    M1(k) = M;
end
%����ȫ�ֻҶȾ�ֵ
mg = M1(length(Number));

%������䷽���ȫ�ַ���
sigmaB = zeros(length(Number), 1);
sigmaG = 0;
for k = 1:length(Number)
    sigmaG = sigmaG + (k- 1 - mg)^2 * Number(i);
    sigmaB(k) = ((mg * P1(k) - M1(k))^2) / (P1(k) * (1-P1(k)));
end

%�ҳ�����k�������������ֵ
maxnum = max(sigmaB);
result = find(sigmaB == maxnum);
result = mean(result);

%����ɷ��Զ���
eta = sigmaB(result) / sigmaG;

%������ֵ�ָ�
[m ,n] = size(srcimg);
dstimg = zeros(m, n);
for i = 1:m
    for j = 1:n
        if srcimg(i,j) > result
            dstimg(i,j) = 1;
        else
            dstimg(i,j) = 0;
        end
    end
end

end



    
    



