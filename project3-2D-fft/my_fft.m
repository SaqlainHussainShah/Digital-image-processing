function [y] = my_fft(x,n)
%fft������,ʵ��һά��fft����
%������Ҫ���㼶��
m = log2(n);  

%��������е�λ��Ĵ���
x = order(x,n);

%������������������źŴ���dsp�еĹ�ʽ���б�д��
for l = 1:m
    b = 2^(l-1);
    for t = 0:b-1
        %��b����ͬ��ϵ��
        p = t*(2^(m-l));
        for k = t:2^l:n-1
            %�����ν��������2^L��
            
            %��������Ҫ���е��μ���Ĳ���
            temp  = x(k+1) + x(k+1+b) * exp(-j*2*pi*p/n);
            temp1 = x(k+1) - x(k+1+b) * exp(-j*2*pi*p/n);
            x(k+1)   = temp;
            x(k+b+1) = temp1;
        end
    end
end
y = x;

