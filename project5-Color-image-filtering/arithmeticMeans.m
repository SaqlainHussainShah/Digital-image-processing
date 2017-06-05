function dstimg = arithmeticMeans(srcimg, n)
%srcimgΪԭʼ��ͼ�� nΪ��ֵ�˲���ģ��Ĵ�С
%�ú�����ͼ�����������ֵ�˲�����
srcimg = double(srcimg);
[rows, cols] = size(srcimg);
dstimg = zeros(rows, cols);

for i = ceil(n / 2): rows - floor(n / 2)
    for j = ceil(n / 2) : cols - floor(n / 2)
        count = 0;
        number = 0;
        for mm = i - floor(n/2):i + floor(n/2)
            for nn = j - floor(n/2): j + floor(n/2)
                count  = count + srcimg(mm, nn);
                number = number +1;
            end
        end
        dstimg(i, j) = count *1.0 / number;
    end
end


