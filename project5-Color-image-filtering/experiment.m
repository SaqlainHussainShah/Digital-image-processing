srcimg = imread('test.jpg');
%�������������ʹ��������ֵ�˲�������ƽ��
%[dstimg,  noiseImage] = ColorMeanFilter(srcimg);

%�������������ʹ�ü��ξ�ֵ�˲�������ƽ��
[dstimg,  noiseImage] = ColorgeoMeanFilter(srcimg);
