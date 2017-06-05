function dstimg = InverseHarmonicMeans(srcimg, n, Q)
%srcimgΪԭʼ��ͼ�� nΪ��ֵ�˲���ģ��Ĵ�С
%�ú�����ͼ�������г����ֵ�˲�����
[rows, cols] = size(srcimg);
dstimg = zeros(rows, cols);

for i = ceil(n / 2): rows - floor(n / 2)
    for j = ceil(n / 2) : cols - floor(n / 2)
        count1 = 0;
        count2 = 0;
        for mm = i - floor(n/2):i + floor(n/2)
            for nn = j - floor(n/2): j + floor(n/2)
                count1  = count1 + srcimg(mm, nn)^(Q+1);
                count2  = count2 + srcimg(mm, nn)^(Q);
            end
        end
        dstimg(i, j) = count1 / count2;
    end
end