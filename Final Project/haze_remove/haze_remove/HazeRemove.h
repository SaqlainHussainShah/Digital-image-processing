#ifndef HazeRemove_h
#define HazeRemove_h

#include <opencv2/opencv.hpp>
using namespace cv;

class HazeRemove
{
private:
    int patchRadius;
    int globalAtmosphericLight[3];
    float w0;
    static const float T0;
    void getPatchPosAndSize(Rect &rect, int rows, int cols, int x, int y);
public:
    Mat srcImg;
    Mat darkChannelImg;
    Mat transmissionMap;
    Mat guidedfilterTransmissionMap;
    Mat estimatedTransmissionMap;
    HazeRemove(Mat img,int radius,float coffecient);
    ~HazeRemove();
    void getDarkChannelPrior();
    void getTransmissionMap(bool isUseAverage=true);
    void getEstimatedTransmissionMap(bool isUseAverage=true);
    void getGlobalAtmosphericLight(bool isUseAverage);
    Mat getHazeRemoveImg(Mat transmissionMat);
    Mat guidedFilter(cv::Mat I, cv::Mat p, int r, double eps);
};


struct Pixel
{
    int posX;
    int posY;
    int val;
};

#endif
