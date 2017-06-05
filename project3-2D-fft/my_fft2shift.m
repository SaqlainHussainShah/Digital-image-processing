function dstimg = my_fft2shift(srcimg)
%��ʹ��fft2�㷨֮����Ҫ����Ƶ�׵��ƶ�

[m,n] = size(srcimg);
dstimg = zeros(m,n);
%��ȡͼ��ĳߴ粢�Ҵ����µ�ͼ��

%��x�����Ͻ����ƶ�
for i = 1:m
    x = srcimg(i,:);
    temp1 = x;
    temp1(1:n/2) = x(n/2+1:n);
    temp1(n/2+1:n) = x(1:n/2);
    dstimg(i,:) = temp1;
end

%��y�����Ͻ����ƶ�
for j = 1:n
    x = dstimg(:,j);
    temp2 = x;
    temp2(1:n/2) = x(n/2+1:n);
    temp2(n/2+1:n) = x(1:n/2);
    dstimg(:,j) = temp2;
end