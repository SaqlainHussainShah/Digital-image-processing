
img = imread('test.jpg');
srcimg = rgb2gray(img);
dilateimg = dilate(srcimg);
erodeimg = erode(srcimg);
gradientimg = dilateimg - erodeimg;
%���ʹ���֮���ͼ��
figure(1);
imshow(dilateimg);

%��ʴ����֮���ͼ��
figure(2);
imshow(erodeimg);

%������ȡ����̬ѧ�ݶ�
figure(3);
imshow(gradientimg);

%ԭʼͼ��ĻҶ�ͼ
figure(4);
imshow(srcimg);