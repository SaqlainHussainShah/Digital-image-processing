function dstimg = my_fft2(srcimg)
%fft2������������ʹ��fft2��ʱ�򣬿��������������Ϸֱ�ʹ��fft���㷨
[m, n] = size(srcimg);

%����DFT�Ǿ��пɷ��Եģ����Կ�������x�������fft�ĺ���������ʵ��
for x = 1:m
    srcimg(x,:) = my_fft(srcimg(x,:),n);
end

%����y�����Ͻ��е���
for y = 1:n
    srcimg(:,y) = my_fft(srcimg(:,y),m);
end

dstimg = srcimg;