#include <opencv.hpp>
#include <iostream>
#include <math.h>

using namespace std;
using namespace cv;


//�������Ǹ�˹�ͱ�����Ϊ����ͼ���������
double generateGaussianNoise(double mu, double sigma)
{
	const double epsilon = numeric_limits<double>::min();
	static double z0, z1;
	static bool flag = false;

	flag = !flag;
	//���flagΪ�٣������˹�������  
	if (!flag)
		return z1*sigma + mu;
	double u1, u2;

	do
	{
		u1 = rand()*(1.0 / RAND_MAX);
		u2 = rand()*(1.0 / RAND_MAX);
	} while (u1 <= epsilon);

	//flagΪ�湹���˹�������X  
	z0 = sqrt(-2.0*log(u1))*cos(2 * CV_PI * u2);
	z1 = sqrt(-2.0*log(u1))*sin(2 * CV_PI * u2);
	return z1*sigma + mu;
}


//Ϊͼ����Ӹ�˹����  
void AddGaussianNoise(Mat& srcImage)
{
	
	int channels = srcImage.channels();   
	//��ȡͼ���ͨ����Ŀ
	int nRows = srcImage.rows;    
	//��ȡͼ�������  
	int nCols = srcImage.cols*channels;   
	//��ȡͼ�������  


	//�ж�ͼ��������ԣ��������������൱��ֻ��Ҫ����һ��һά����
	if (srcImage.isContinuous())   
	{
		//����Ϊ����
		nCols *= nRows;
		nRows = 1;
	}

	for (int i = 0; i < nRows; i++)
	{
		for (int j = 0; j < nCols; j++)
		{  
			//��Ӹ�˹����  
			int val = srcImage.ptr<uchar>(i)[j] + generateGaussianNoise(0.1, 0.8) * 32;
			if (val < 0)
				val = 0;

			if (val > 255)
				val = 255;
			//���ǲ��ܳ����Ҷȷ�Χ

			srcImage.ptr<uchar>(i)[j] = (uchar)val;
		}
	}
}


//��ӽ�������
void salt(Mat& image, int n) 
{
	int temp;
	for (int k = 0; k<n; k++) 
	{
		int i = rand() % image.cols;
		int j = rand() % image.rows;
		temp = rand() % 2;
		if (temp == 0)
			image.at<uchar>(j, i) = 255;
		else
			image.at<uchar>(j, i) = 0;
	}
}

//��ֵ�˲���ʵ�֣�srcImage����������ͼƬ��size���˲����ĳߴ�
void meanFilter(Mat& srcImage, int size)
{
	Size m_Size = srcImage.size();
	//��չͼ��,�Խ��к�����˲�,��Ҫ����
	Mat temimage = Mat::zeros(m_Size.height + size, m_Size.width + size, srcImage.type());
	srcImage.copyTo(temimage(Range(size / 2, m_Size.height + size / 2), Range(size / 2, m_Size.width + size / 2)));


	int rows = temimage.rows, cols = temimage.cols;
	int start = size /2 ;

	for (int m = start; m <rows - start; m++) 
	{
		for (int n = start; n < cols - start; n++) 
		{
			int sum = 0;
			//ģ��ʵ���˲�
			for (int i = -start + m; i <= start + m; i++)
			{
				for (int j = -start + n; j <= start + n; j++) 
				{
					sum += temimage.at<uchar>(i, j);
				}
			}
			//��ƽ��
			temimage.at<uchar>(m, n) = uchar(sum / (size * size));
		}
	}
	temimage(Range(size / 2, m_Size.height + size / 2), Range(size / 2, m_Size.width + size / 2)).copyTo(srcImage);
}


//��ֵ�˲���ʵ�֣�srcImage����������ͼƬ��size���˲����ĳߴ�
void medeanFilter(Mat& srcImage, int size) 
{
	Size m_Size = srcImage.size();
	//��չͼ��,�Խ��к�����˲�,��Ҫ����
	Mat temimage = Mat::zeros(m_Size.height + size, m_Size.width + size, srcImage.type());
	srcImage.copyTo(temimage(Range(size / 2, m_Size.height + size / 2), Range(size / 2, m_Size.width + size / 2)));

	int rows = temimage.rows, cols = temimage.cols;
	int start = size / 2;

	for (int m = start; m <rows - start; m++) 
	{
		for (int n = start; n < cols - start; n++) 
		{
			vector<uchar> model;
			for (int i = -start + m; i <= start + m; i++) 
			{
				for (int j = -start + n; j <= start + n; j++) 
				{
					model.push_back(temimage.at<uchar>(i, j));
				}
			}

			sort(model.begin(), model.end());     
			//���ÿ������������ֵ��ѡ��ѡ����ֵ��Ϊ�����ص�ֵ
			temimage.at<uchar>(m, n) = model[size * size / 2];
		}
	}
	temimage(Range(size / 2, m_Size.height + size / 2), Range(size / 2, m_Size.width + size / 2)).copyTo(srcImage);
}

int main(void)
{
	Mat image;
	Mat dst;
	image = imread("ocean.bmp", 1);
	//��ȡͼƬ
	cvtColor(image, image, CV_BGR2GRAY);
	image.convertTo(dst, CV_8UC1);
	//�����ｫͼƬת�����Ҷ�ͼ���Ա��ں�����˲���������Ҫ�����㷨˼·

	//ԭʼͼ��
	namedWindow("Origin image", WINDOW_AUTOSIZE);
	imshow("Origin image", dst);
	imwrite("Origin.jpg", dst);

	//��˹������ͼƬ
	//AddGaussianNoise(dst);

	//Ϊͼ����ӽ�������
	salt(dst, 3000);
	namedWindow("Noisy image", WINDOW_AUTOSIZE); 
	imshow("Noisy image", dst); 
	imwrite("salt_noise.jpg", dst);
	//imwrite("gaussian_noise.jpg", dst);


	//����������ͼ����о�ֵ�˲����������3 * 3��ģ��
	Mat image1;
	dst.copyTo(image1);
	meanFilter(image1, 3);
	namedWindow("meanFilter", WINDOW_AUTOSIZE);
	imshow("meanFilter", image1);
	imwrite("meanFilter.jpg", image1);
	//imwrite("meanFilter_gaussian.jpg", image1);

	//����������ͼ�������ֵ�˲����������3 * 3��ģ��
	Mat image2;
	dst.copyTo(image2);
	medeanFilter(image2, 3);
	namedWindow("medeanFilter", WINDOW_AUTOSIZE);
	imshow("medeanFilter", image2);
	imwrite("medeanFilter.jpg", image2);
	//imwrite("medeanFilter_gaussian.jpg", image2);

	waitKey(0);
	return 0;

}