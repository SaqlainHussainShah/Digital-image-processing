function [out, p2] = GLCM(image) 
%image�����ǵ�����ͼ��
%out�����Ǹ��ݻҶȹ���������ȡ������ͼ��������ӣ���Ҫ����6��������:
%�����ʣ���أ��Աȶȣ�һ���ԣ�ͬ���ԣ���
%p2���ص������Ǽ�������Ľ��й�һ��֮��ĻҶȹ�������

%������Ҷ�ͼ��ļ������Ե�256���ʶ��Ҷȹ�������Ĵ�СΪ256 * 256
gray=256; 
if length(size(image)) == 3
    image = rgb2gray(image);
end
[R,C]=size(image);  
 
p1=zeros(gray); 
%p1�ǻҶȹ�������ļ�����
%������λ������Q����������������������ߵ�����

for M=1:R 
    for N=1:(C-1) 
        p1(image(M,N)+1,image(M,N+1)+1)= p1(image(M,N)+1,image(M,N+1)+1)+1; 
        p1(image(M,N+1)+1,image(M,N)+1)= p1(image(M,N+1)+1,image(M,N)+1)+1; 
    end 
end 

p2=p1; 
%��ʾ�Ҷȹ�������
figure(1);
imshow(p2); 
 
%���Ҷȹ��������һ��
p2=double(p2)/(M*N); 
 
%һ����
f1=p2.^2; 
f1=sum(f1(:)); 
 
% ������ض�f2 
mr = 0;
mc = 0;
sigmar = 0;
sigmac = 0;
for i = 1:256
    mr = mr + i * sum(p2(i,:));
end
for j = 1:256
    mc = mc + j * sum(p2(:,j));
end
for i = 1:256
    sigmar = sigmar + (i-mr)^2 * sum(p2(i,:));
end
for j = 1:256
    sigmac = sigmac + (j-mc)^2 * sum(p2(:,j));
end

f2 = 0;
for i = 1:256
    for j = 1:256
        f2 = f2 + ((i - mr) * (j - mc) * p2(i,j))...
            / (sqrt(sigmar) * sqrt(sigmac));
    end
end

%������f3 
pp=(p2.*log2(p2+eps)); 
f3=-sum(pp(:)); 
  
%ͬ���Լ���f4
f4=0; 
for k=1:gray 
    for j=1:gray 
        f4=f4+p2(k,j)/(1+abs(j-k)); 
    end 
end 
 
%����Աȶ�f5
f5=0; 
for k=2:2*gray 
    for i=1:k-1 
        j=k-i; 
        if j<=gray && i<gray 
        f5=f5+(i-j)^2*p2(i,j); 
        end 
    end 
end 
 
%����������f6
f6 = max(max(p2));
 
out(1,1)=f1; 
out(1,2)=f2; 
out(1,3)=f3; 
out(1,4)=f4; 
out(1,5)=f5; 
out(1,6)=f6; 
end
