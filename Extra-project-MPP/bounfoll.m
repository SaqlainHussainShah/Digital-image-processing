clc;clear
I = imread('1.png');
figure(1)
subplot(1,3,1);imshow(I);title('The original image');
%change the image into binary image
threshold=graythresh(I);       
I=im2bw(I, threshold);  
subplot(1,3,2);imshow(I);title('The binary image');
%boundary following
[m n]=size(I);
boundary=zeros(m,n);        
ed=[-1 0;-1 -1;0 -1;1 -1;1 0;1 1;0 1;-1 1]; %��������أ���ʱ������
for i=2:m-1
    for j=2:n-1
        if I(i,j)==1 && boundary(i,j)==0      %��ǰ��û��ǵİ�ɫ����
            sum_temp = sum(sum(I(i-1:i+1,j-1:j+1)));
            if sum_temp~=9 && sum_temp~=0   
                a=i;         
                b=j;              
                for k=1:8           %��ʱ�����������
                   tmpi=a+ed(k,1);       
                   tmpj=b+ed(k,2);
                   if I(tmpi,tmpj)==0 && boundary(tmpi,tmpj) == 0 
                       a=tmpi;        
                       b=tmpj;
                       boundary(a,b)=1;  
                       break;
                   end
                end
                
            end
        end
    end
end
boundary=boundary==1;
subplot(1,3,3);imshow(boundary);title('The final result');
figure(2);
imshow(boundary);
return 