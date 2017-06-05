clear;clc;
%������Ե�ͼ��
image = imread('Test.bmp');
%��ʾԭʼ��ͼ��
figure(1);
imshow(image);
image = double(image);

temp = image - 128;
[m,n] = size(temp);
%���Ƚ���fft2�ļ���
DFT2 = my_fft2(temp);
%Ϊ�˷�����ʾ������Ҫ������λ
%DFT2SHIFT = DFT2;
DFT2SHIFT = my_fft2shift(DFT2);

%����������
figure(2);
imshow(abs(DFT2SHIFT),[]);
%Ϊʹ�÷����׵���Ϣ�������������Ի����������ʾ
figure(3);
imshow(log10(1+abs(DFT2SHIFT)),[]);
%������λ��
figure(4);
imshow(angle(DFT2SHIFT),[]);