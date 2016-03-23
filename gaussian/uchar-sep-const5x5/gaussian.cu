#include "hipacc_cu.hpp"

#include "cuGaussianFilterRowX.cu"
#include "cuGaussianFilterColumnY.cu"
#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <sys/time.h>
#include <opencv2/opencv.hpp>
//---

#ifndef BH_MODE
#  define BH_MODE           CLAMP
#endif

#define PIXEL_CAST(a)       (pixel_t)(a)
#define TMP_PIXEL_CAST(a)   (tmp_pixel_t)(a)

#define pixel_t             uchar
#define tmp_pixel_t         float

#define USE_LAMBDA


// get time in milliseconds
double time_ms () {
    struct timeval tv;
    gettimeofday (&tv, NULL);

    return ((double)(tv.tv_sec) * 1e+3 + (double)(tv.tv_usec) * 1e-3);
}

// Gaussian blur filter in Hipacc
#ifdef NO_SEP

class GaussianFilter : public Kernel<pixel_t> {
    private:
        Accessor<pixel_t> &input;
        Mask<float> &mask;
        const int size_x, size_y;

    public:
        GaussianFilter(IterationSpace<pixel_t> &iter, Accessor<pixel_t>
                &input, Mask<float> &mask, const int size_x, const int size_y) :
            Kernel(iter),
            input(input),
            mask(mask),
            size_x(size_x),
            size_y(size_y)
        { add_accessor(&input); }

        #ifdef USE_LAMBDA

        void kernel() {
            output() = PIXEL_CAST(convolve(mask, Reduce::SUM, [&] () -> float {
                    return mask() * input(mask);
                    }) + 0.5f);
        }

        #else

        void kernel() {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5f;

            for (int yf = -anchor_y; yf<=anchor_y; ++yf) {
                for (int xf = -anchor_x; xf<=anchor_x; ++xf) {
                    sum += mask(xf, yf) * input(xf, yf);
                }
            }

            output() = PIXEL_CAST(sum);
        }

        #endif
};

#else



#endif

int main(int argc, const char *argv[]) {
    hipaccInitCUDA();
    
    const int size_x = SIZE_X;
    const int size_y = SIZE_Y;
    const double sigma1 = ((size_x-1)*0.5 - 1)*0.3 + 0.8;
    const double sigma2 = ((size_y-1)*0.5 - 1)*0.3 + 0.8;

    // filter coefficients
    #ifdef CONST_MASK

    // only filter kernel sizes 3x3, 5x5, and 7x7 implemented
    if (size_x != size_y || !(size_x == 3 || size_x == 5 || size_x == 7)) {
        std::cerr << "Wrong filter kernel size. Currently supported values: 3x3, 5x5, and 7x7!" << std::endl;
        exit(EXIT_FAILURE);
    }

    // convolution filter mask
    const float filter_x[1][SIZE_X] = {
        #if SIZE_X == 3
        { 0.238994f, 0.522011f, 0.238994f }
        #endif
        #if SIZE_X == 5
        { 0.070766f, 0.244460f, 0.369546f, 0.244460f, 0.070766f }
        #endif
        #if SIZE_X == 7
        { 0.028995f, 0.103818f, 0.223173f, 0.288026f, 0.223173f, 0.103818f, 0.028995f }
        #endif
    };

    const float filter_y[SIZE_Y][1] = {
        #if SIZE_Y == 3
        { 0.238994f }, { 0.522011f }, { 0.238994f }
        #endif
        #if SIZE_Y == 5
        { 0.070766f }, { 0.244460f }, { 0.369546f }, { 0.244460f }, { 0.070766f }
        #endif
        #if SIZE_Y == 7
        { 0.028995f }, { 0.103818f }, { 0.223173f }, { 0.288026f }, { 0.223173f }, { 0.103818f }, { 0.028995f }
        #endif
    };

    const float filter_xy[SIZE_Y][SIZE_X] = {
        #if SIZE_X == 3
        { 0.057118f, 0.124758f, 0.057118f },
        { 0.124758f, 0.272496f, 0.124758f },
        { 0.057118f, 0.124758f, 0.057118f }
        #endif
        #if SIZE_X == 5
        { 0.005008f, 0.017300f, 0.026151f, 0.017300f, 0.005008f },
        { 0.017300f, 0.059761f, 0.090339f, 0.059761f, 0.017300f },
        { 0.026151f, 0.090339f, 0.136565f, 0.090339f, 0.026151f },
        { 0.017300f, 0.059761f, 0.090339f, 0.059761f, 0.017300f },
        { 0.005008f, 0.017300f, 0.026151f, 0.017300f, 0.005008f }
        #endif
        #if SIZE_X == 7
        { 0.000841, 0.003010, 0.006471, 0.008351, 0.006471, 0.003010, 0.000841 },
        { 0.003010, 0.010778, 0.023169, 0.029902, 0.023169, 0.010778, 0.003010 },
        { 0.006471, 0.023169, 0.049806, 0.064280, 0.049806, 0.023169, 0.006471 },
        { 0.008351, 0.029902, 0.064280, 0.082959, 0.064280, 0.029902, 0.008351 },
        { 0.006471, 0.023169, 0.049806, 0.064280, 0.049806, 0.023169, 0.006471 },
        { 0.003010, 0.010778, 0.023169, 0.029902, 0.023169, 0.010778, 0.003010 },
        { 0.000841, 0.003010, 0.006471, 0.008351, 0.006471, 0.003010, 0.000841 }
        #endif
    };

    #else

    float filter_x[1][SIZE_X];
    float filter_y[SIZE_Y][1];
    float filter_xy[SIZE_Y][SIZE_X];

    double scale2X = -0.5/(sigma1*sigma1);
    double scale2Y = -0.5/(sigma2*sigma2);
    double sum_x = 0;
    double sum_y = 0;

    for (int i=0; i < size_x; ++i) {
        double x = i - (size_x-1)*0.5;
        double t = std::exp(scale2X*x*x);

        filter_x[0][i] = (float)t;
        sum_x += filter_x[0][i];
    }
    for (int i=0; i < size_y; ++i) {
        double x = i - (size_y-1)*0.5;
        double t = std::exp(scale2Y*x*x);

        filter_y[i][0] = (float)t;
        sum_y += filter_y[i][0];
    }

    sum_x = 1./sum_x;
    sum_y = 1./sum_y;
    for (int i=0; i < size_x; ++i) {
        filter_x[0][i] = (float)(filter_x[0][i]*sum_x);
    }
    for (int i=0; i < size_y; ++i) {
        filter_y[i][0] = (float)(filter_y[i][0]*sum_y);
    }

    for (int y=0; y < size_y; ++y) {
        for (int x=0; x < size_x; ++x) {
            filter_xy[y][x] = filter_x[0][x]*filter_y[y][0];
        }
    }

    #endif

    cv::Mat frame, frame_colored;

    frame_colored = cv::imread(argv[1], CV_LOAD_IMAGE_COLOR);
    cvtColor(frame_colored, frame, CV_BGR2GRAY);

    const int width = frame.cols;
    const int height = frame.rows;
    float timing = 0;

    // input and output image of width x height pixels
    HipaccImage input = hipaccCreateMemory<uchar>(NULL, width, height, 256);
    HipaccImage output = hipaccCreateMemory<uchar>(NULL, width, height, 256);
    HipaccImage tmp = hipaccCreateMemory<float>(NULL, width, height, 256);

    hipaccWriteMemory(input, frame.data);

    // filter mask
    
    
    

    HipaccAccessor iter_out(output);
    HipaccAccessor iter_tmp(tmp);

    #ifdef NO_SEP

    BoundaryCondition<pixel_t> cond(input, mask, Boundary::BH_MODE);
    Accessor<pixel_t> acc(cond);
    GaussianFilter XY(iter_out, acc, mask, size_x, size_y);

    XY.execute();
    timing = hipacc_last_kernel_timing();

    #else

    
    HipaccAccessor acc(input);
    

    
    HipaccAccessor acc_tmp(tmp);
    

    hipacc_launch_info X_info0(2, 0, iter_tmp, 8, 1);
    dim3 block0(64, 1);
    dim3 grid0(hipaccCalcGridFromBlock(X_info0, block0));

    hipaccPrepareKernelLaunch(X_info0, block0);
    hipaccConfigureCall(grid0, block0);

    size_t offset0 = 0;
    cudaGetTextureReference(&_texinputXRef, &_texinputX);
    hipaccBindTexture<uchar>(Linear1D, _texinputXRef, acc.img);
    hipaccSetupArgument(&iter_tmp.img.mem, sizeof(float *), offset0);
    hipaccSetupArgument(&iter_tmp.width, sizeof(const int), offset0);
    hipaccSetupArgument(&iter_tmp.height, sizeof(const int), offset0);
    hipaccSetupArgument(&iter_tmp.img.stride, sizeof(const int), offset0);
    hipaccSetupArgument(&acc.width, sizeof(const int), offset0);
    hipaccSetupArgument(&acc.height, sizeof(const int), offset0);
    hipaccSetupArgument(&acc.img.stride, sizeof(const int), offset0);
    hipaccSetupArgument(&X_info0.bh_start_left, sizeof(const int), offset0);
    hipaccSetupArgument(&X_info0.bh_start_right, sizeof(const int), offset0);
    hipaccSetupArgument(&X_info0.bh_start_bottom, sizeof(const int), offset0);
    hipaccSetupArgument(&X_info0.bh_fall_back, sizeof(const int), offset0);
    
    hipaccLaunchKernel((const void *)&cuGaussianFilterRowXKernel, "cuGaussianFilterRowXKernel", grid0, block0);
    timing = hipacc_last_kernel_timing();
    hipacc_launch_info Y_info0(0, 2, iter_out, 8, 1);
    dim3 block1(32, 2);
    dim3 grid1(hipaccCalcGridFromBlock(Y_info0, block1));

    hipaccPrepareKernelLaunch(Y_info0, block1);
    hipaccConfigureCall(grid1, block1);

    size_t offset1 = 0;
    cudaGetTextureReference(&_texinputYRef, &_texinputY);
    hipaccBindTexture<float>(Linear1D, _texinputYRef, acc_tmp.img);
    hipaccSetupArgument(&iter_out.img.mem, sizeof(uchar *), offset1);
    hipaccSetupArgument(&iter_out.width, sizeof(const int), offset1);
    hipaccSetupArgument(&iter_out.height, sizeof(const int), offset1);
    hipaccSetupArgument(&iter_out.img.stride, sizeof(const int), offset1);
    hipaccSetupArgument(&acc_tmp.width, sizeof(const int), offset1);
    hipaccSetupArgument(&acc_tmp.height, sizeof(const int), offset1);
    hipaccSetupArgument(&acc_tmp.img.stride, sizeof(const int), offset1);
    hipaccSetupArgument(&Y_info0.bh_start_right, sizeof(const int), offset1);
    hipaccSetupArgument(&Y_info0.bh_start_top, sizeof(const int), offset1);
    hipaccSetupArgument(&Y_info0.bh_start_bottom, sizeof(const int), offset1);
    hipaccSetupArgument(&Y_info0.bh_fall_back, sizeof(const int), offset1);
    
    hipaccLaunchKernel((const void *)&cuGaussianFilterColumnYKernel, "cuGaussianFilterColumnYKernel", grid1, block1);
    timing += hipacc_last_kernel_timing();

    #endif

    std::cerr << "Timing: " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;

    // OpenCV display image
    std::string outputfn;
    std::vector<int> compression_params;

    frame.data = hipaccReadMemory<uchar>(output);
    outputfn = argv[1];
    outputfn = outputfn.substr(0, outputfn.find_last_of(".")) + "-filtered.jpg";
    compression_params.push_back(CV_IMWRITE_JPEG_QUALITY);
    compression_params.push_back(100);

    try {
      cv::imwrite(outputfn, frame, compression_params);
    } catch(std::runtime_error &ex) {
      fprintf(stderr, "JPEG compression exception: %s\n", ex.what());
      return 1;
    }

    cv::namedWindow("Result", cv::WINDOW_NORMAL);
    cv::imshow("Result", frame);
    cv::waitKey(0);

    fprintf(stdout, "Done!\n");
    hipaccReleaseMemory<uchar>(input);
    hipaccReleaseMemory<uchar>(output);
    hipaccReleaseMemory<float>(tmp);
    return 0;
}
