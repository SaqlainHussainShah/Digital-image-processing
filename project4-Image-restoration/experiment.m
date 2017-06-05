%�������ͼ��ٶ����������Ŀ�϶��10�����ҿ�϶���ɫ����֮��ľ���һ��Ϊ17
cols = 7*9 + 17*10;
rows = 210 + 10*2;
original = zeros(210 + 10*2, 7*9 + 17*10);
for i = 17+7 : 17+7 : cols
    original(11 : rows-10, i - 6:i) = 1;
end
figure(1);
imshow(original);
title('Original map');

%ʹ��������ֵ�˲�����
figure(2);  
subplot(1,3,1);
dstimg = arithmeticMeans(original, 3);
imshow(dstimg);
title('arithmetic filter n = 3');

subplot(1,3,2);
dstimg = arithmeticMeans(original, 5);
imshow(dstimg);
title('arithmetic filter n = 5');

subplot(1,3,3);
dstimg = arithmeticMeans(original, 9);
imshow(dstimg);
title('arithmetic filter n = 9');

%ʹ�ü��ξ�ֵ�˲���
figure(3);
subplot(1,3,1);
dstimg =  geometricMeans(original, 3);
imshow(dstimg);
title('Geometric filter n = 3');

subplot(1,3,2);
dstimg =  geometricMeans(original, 5);
imshow(dstimg);
title('Geometric filter n = 5');

subplot(1,3,3);
dstimg =  geometricMeans(original, 9);
imshow(dstimg);
title('Geometric filter n = 9');

%ʹ��г����ֵ�˲���
figure(4);
subplot(1,3,1);
dstimg = HarmonicMeans(original, 3);
imshow(dstimg);
title('Harmonic filter n = 3');

subplot(1,3,2);
dstimg = HarmonicMeans(original, 5);
imshow(dstimg);
title('Harmonic filter n = 5');

subplot(1,3,3);
dstimg = HarmonicMeans(original, 9);
imshow(dstimg);
title('Harmonic filter n = 9');

%ʹ����г����ֵ�˲���Q = 1.5
figure(5);
subplot(1,3,1);
dstimg = InverseHarmonicMeans(original, 3, 1.5);
imshow(dstimg);
title('Inverse Q = 1.5 n = 3');

subplot(1,3,2);
dstimg = InverseHarmonicMeans(original, 5, 1.5);
imshow(dstimg);
title('Inverse Q = 1.5 n = 5');

subplot(1,3,3);
dstimg = InverseHarmonicMeans(original, 9, 1.5);
imshow(dstimg);
title('Inverse Q = 1.5 n = 9');

%ʹ����г����ֵ�˲���Q = -1.5
figure(6);
subplot(1,3,1);
dstimg = InverseHarmonicMeans(original, 3, -1.5);
imshow(dstimg);
title('Inverse Q = -1.5 n = 3');

subplot(1,3,2);
dstimg = InverseHarmonicMeans(original, 5, -1.5);
imshow(dstimg);
title('Inverse Q = -1.5 n = 5');

subplot(1,3,3);
dstimg = InverseHarmonicMeans(original, 9, -1.5);
imshow(dstimg);
title('Inverse Q = -1.5 n = 9');






