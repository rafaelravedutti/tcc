#include "hipacc_cu.hpp"

#include "cuGaussianBlurFilterMaskColumnGFCConst.cu"
#include "cuGaussianBlurFilterMaskRowGFRM.cu"
#include "cuGaussianBlurFilterMaskRowGFRR.cu"
#include "cuGaussianBlurFilterMaskColumnGFCC.cu"
#include "cuGaussianBlurFilterMaskRowGFRC.cu"
#include "cuGaussianBlurFilterMaskRowGFRConst.cu"
#include "cuGaussianBlurFilterMaskColumnGFCM.cu"
#include "cuGaussianBlurFilterMaskColumnGFCR.cu"
//
// Copyright (c) 2012, University of Erlangen-Nuremberg
// Copyright (c) 2012, Siemens AG
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>

#include <sys/time.h>

#ifdef OPENCV
#include <opencv2/opencv.hpp>
#include <opencv2/core/cuda.hpp>
#include <opencv2/core/ocl.hpp>
#ifdef OPENCV_CUDA_FOUND
#include <opencv2/cudafilters.hpp>
#endif
#endif


// variables set by Makefile
//#define SIZE_X 5
//#define SIZE_Y 5
//#define WIDTH 4096
//#define HEIGHT 4096

// code variants
#define CONST_MASK
#define USE_LAMBDA
//#define RUN_UNDEF
//#define NO_SEP



// get time in milliseconds
double time_ms () {
    struct timeval tv;
    gettimeofday (&tv, NULL);

    return ((double)(tv.tv_sec) * 1e+3 + (double)(tv.tv_usec) * 1e-3);
}


// Gaussian blur filter reference
void gaussian_filter(uchar *in, uchar *out, float *filter, int size_x, int size_y, int width, int height) {
    int anchor_x = size_x >> 1;
    int anchor_y = size_y >> 1;
    int upper_x = width  - anchor_x;
    int upper_y = height - anchor_y;

    for (int y=anchor_y; y<upper_y; ++y) {
        for (int x=anchor_x; x<upper_x; ++x) {
            float sum = 0.5f;

            for (int yf = -anchor_y; yf<=anchor_y; ++yf) {
                for (int xf = -anchor_x; xf<=anchor_x; ++xf) {
                    sum += filter[(yf+anchor_y)*size_x + xf+anchor_x] * in[(y+yf)*width + x + xf];
                }
            }
            out[y*width + x] = (uchar) (sum);
        }
    }
}
void gaussian_filter_row(uchar *in, float *out, float *filter, int size_x, int width, int height) {
    int anchor_x = size_x >> 1;
    int upper_x = width - anchor_x;

    for (int y=0; y<height; ++y) {
        //for (int x=0; x<anchor_x; ++x) out[y*width + x] = in[y*width + x];
        for (int x=anchor_x; x<upper_x; ++x) {
            float sum = 0;

            for (int xf = -anchor_x; xf<=anchor_x; ++xf) {
                sum += filter[xf+anchor_x] * in[(y)*width + x + xf];
            }
            out[y*width + x] = sum;
        }
        //for (int x=upper_x; x<width; ++x) out[y*width + x] = in[y*width + x];
    }
}
void gaussian_filter_column(float *in, uchar *out, float *filter, int size_y, int width, int height) {
    int anchor_y = size_y >> 1;
    int upper_y = height - anchor_y;

    //for (int y=0; y<anchor_y; ++y) {
    //    for (int x=0; x<width; ++x) {
    //        out[y*width + x] = (uchar) in[y*width + x];
    //    }
    //}
    for (int y=anchor_y; y<upper_y; ++y) {
        for (int x=0; x<width; ++x) {
            float sum = 0.5f;

            for (int yf = -anchor_y; yf<=anchor_y; ++yf) {
                sum += filter[yf + anchor_y] * in[(y + yf)*width + x];
            }
            out[y*width + x] = (uchar) (sum);
        }
    }
    //for (int y=upper_y; y<height; ++y) {
    //    for (int x=0; x<width; ++x) {
    //        out[y*width + x] = (uchar) in[y*width + x];
    //    }
    //}
}


// Gaussian blur filter in Hipacc
#ifdef NO_SEP
class GaussianBlurFilterMask : public Kernel<uchar> {
    private:
        Accessor<uchar> &input;
        Mask<float> &mask;
        const int size_x, size_y;

    public:
        GaussianBlurFilterMask(IterationSpace<uchar> &iter, Accessor<uchar>
                &input, Mask<float> &mask, const int size_x, const int size_y) :
            Kernel(iter),
            input(input),
            mask(mask),
            size_x(size_x),
            size_y(size_y)
        { add_accessor(&input); }

        #ifdef USE_LAMBDA
        void kernel() {
            output() = (uchar)(convolve(mask, Reduce::SUM, [&] () -> float {
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

            output() = (uchar) sum;
        }
        #endif
};
#else
#endif


/*************************************************************************
 * Main function                                                         *
 *************************************************************************/
int main(int argc, const char **argv) {
    hipaccInitCUDA();
    
    const int width = WIDTH;
    const int height = HEIGHT;
    const int size_x = SIZE_X;
    const int size_y = SIZE_Y;
    const int offset_x = size_x >> 1;
    const int offset_y = size_y >> 1;
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

    // host memory for image of width x height pixels
    uchar *input = new uchar[width*height];
    uchar *reference_in = new uchar[width*height];
    uchar *reference_out = new uchar[width*height];
    float *reference_tmp = new float[width*height];

    // initialize data
    for (int y=0; y<height; ++y) {
        for (int x=0; x<width; ++x) {
            input[y*width + x] = (uchar)(y*width + x) % 256;
            reference_in[y*width + x] = (uchar)(y*width + x) % 256;
            reference_out[y*width + x] = 0;
            reference_tmp[y*width + x] = 0;
        }
    }


    // input and output image of width x height pixels
    HipaccImage IN = hipaccCreateMemory<uchar>(input, width, height, 256);
    HipaccImage OUT = hipaccCreateMemory<uchar>(NULL, width, height, 256);
    HipaccImage TMP = hipaccCreateMemory<float>(NULL, width, height, 256);

    // filter mask
    
    
    

    HipaccAccessor IsOut(OUT);
    HipaccAccessor IsTmp(TMP);


    #ifndef OPENCV
    std::cerr << "Calculating Hipacc Gaussian filter ..." << std::endl;
    std::vector<float> timings_hipacc;
    float timing = 0;

    // UNDEFINED
    #ifdef RUN_UNDEF
    #ifdef NO_SEP
    BoundaryCondition<uchar> BcInUndef2(IN, M, Boundary::UNDEFINED);
    Accessor<uchar> AccInUndef2(BcInUndef2);
    GaussianBlurFilterMask GFU(IsOut, AccInUndef2, M, size_x, size_y);

    GFU.execute();
    timing = hipacc_last_kernel_timing();
    #else
    BoundaryCondition<uchar> BcInUndef(IN, MX, Boundary::UNDEFINED);
    Accessor<uchar> AccInUndef(BcInUndef);
    GaussianBlurFilterMaskRow GFRU(IsTmp, AccInUndef, MX, size_x);

    BoundaryCondition<float> BcTmpUndef(TMP, MY, Boundary::UNDEFINED);
    Accessor<float> AccTmpUndef(BcTmpUndef);
    GaussianBlurFilterMaskColumn GFCU(IsOut, AccTmpUndef, MY, size_y);

    GFRU.execute();
    timing = hipacc_last_kernel_timing();
    GFCU.execute();
    timing += hipacc_last_kernel_timing();
    #endif
    #endif
    timings_hipacc.push_back(timing);
    std::cerr << "Hipacc (UNDEFINED): " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;


    // CLAMP
    #ifdef NO_SEP
    BoundaryCondition<uchar> BcInClamp2(IN, M, Boundary::CLAMP);
    Accessor<uchar> AccInClamp2(BcInClamp2);
    GaussianBlurFilterMask GFC(IsOut, AccInClamp2, M, size_x, size_y);

    GFC.execute();
    timing = hipacc_last_kernel_timing();
    #else
    
    HipaccAccessor AccInClamp(IN);
    

    
    HipaccAccessor AccTmpClamp(TMP);
    

    hipacc_launch_info GFRC_info0(2, 0, IsTmp, 1, 1);
    dim3 block0(128, 1);
    dim3 grid0(hipaccCalcGridFromBlock(GFRC_info0, block0));

    hipaccPrepareKernelLaunch(GFRC_info0, block0);
    hipaccConfigureCall(grid0, block0);

    size_t offset0 = 0;
    hipaccSetupArgument(&IsTmp.img.mem, sizeof(float *), offset0);
    hipaccSetupArgument(&IsTmp.width, sizeof(const int), offset0);
    hipaccSetupArgument(&IsTmp.img.stride, sizeof(const int), offset0);
    hipaccSetupArgument(&AccInClamp.img.mem, sizeof(uchar *), offset0);
    hipaccSetupArgument(&AccInClamp.width, sizeof(const int), offset0);
    hipaccSetupArgument(&AccInClamp.height, sizeof(const int), offset0);
    hipaccSetupArgument(&AccInClamp.img.stride, sizeof(const int), offset0);
    hipaccSetupArgument(&GFRC_info0.bh_start_left, sizeof(const int), offset0);
    hipaccSetupArgument(&GFRC_info0.bh_start_right, sizeof(const int), offset0);
    hipaccSetupArgument(&GFRC_info0.bh_fall_back, sizeof(const int), offset0);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskRowGFRCKernel, "cuGaussianBlurFilterMaskRowGFRCKernel", grid0, block0);
    timing = hipacc_last_kernel_timing();
    hipacc_launch_info GFCC_info0(0, 2, IsOut, 1, 1);
    dim3 block1(128, 1);
    dim3 grid1(hipaccCalcGridFromBlock(GFCC_info0, block1));

    hipaccPrepareKernelLaunch(GFCC_info0, block1);
    hipaccConfigureCall(grid1, block1);

    size_t offset1 = 0;
    hipaccSetupArgument(&IsOut.img.mem, sizeof(uchar *), offset1);
    hipaccSetupArgument(&IsOut.width, sizeof(const int), offset1);
    hipaccSetupArgument(&IsOut.img.stride, sizeof(const int), offset1);
    hipaccSetupArgument(&AccTmpClamp.img.mem, sizeof(float *), offset1);
    hipaccSetupArgument(&AccTmpClamp.width, sizeof(const int), offset1);
    hipaccSetupArgument(&AccTmpClamp.height, sizeof(const int), offset1);
    hipaccSetupArgument(&AccTmpClamp.img.stride, sizeof(const int), offset1);
    hipaccSetupArgument(&GFCC_info0.bh_start_right, sizeof(const int), offset1);
    hipaccSetupArgument(&GFCC_info0.bh_start_top, sizeof(const int), offset1);
    hipaccSetupArgument(&GFCC_info0.bh_start_bottom, sizeof(const int), offset1);
    hipaccSetupArgument(&GFCC_info0.bh_fall_back, sizeof(const int), offset1);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskColumnGFCCKernel, "cuGaussianBlurFilterMaskColumnGFCCKernel", grid1, block1);
    timing += hipacc_last_kernel_timing();
    #endif
    timings_hipacc.push_back(timing);
    std::cerr << "Hipacc (CLAMP): " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;


    // REPEAT
    #ifdef NO_SEP
    BoundaryCondition<uchar> BcInRepeat2(IN, M, Boundary::REPEAT);
    Accessor<uchar> AccInRepeat2(BcInRepeat2);
    GaussianBlurFilterMask GFR(IsOut, AccInRepeat2, M, size_x, size_y);

    GFR.execute();
    timing = hipacc_last_kernel_timing();
    #else
    
    HipaccAccessor AccInRepeat(IN);
    

    
    HipaccAccessor AccTmpRepeat(TMP);
    

    hipacc_launch_info GFRR_info0(2, 0, IsTmp, 1, 1);
    dim3 block2(128, 1);
    dim3 grid2(hipaccCalcGridFromBlock(GFRR_info0, block2));

    hipaccPrepareKernelLaunch(GFRR_info0, block2);
    hipaccConfigureCall(grid2, block2);

    size_t offset2 = 0;
    hipaccSetupArgument(&IsTmp.img.mem, sizeof(float *), offset2);
    hipaccSetupArgument(&IsTmp.width, sizeof(const int), offset2);
    hipaccSetupArgument(&IsTmp.img.stride, sizeof(const int), offset2);
    hipaccSetupArgument(&AccInRepeat.img.mem, sizeof(uchar *), offset2);
    hipaccSetupArgument(&AccInRepeat.width, sizeof(const int), offset2);
    hipaccSetupArgument(&AccInRepeat.height, sizeof(const int), offset2);
    hipaccSetupArgument(&AccInRepeat.img.stride, sizeof(const int), offset2);
    hipaccSetupArgument(&GFRR_info0.bh_start_left, sizeof(const int), offset2);
    hipaccSetupArgument(&GFRR_info0.bh_start_right, sizeof(const int), offset2);
    hipaccSetupArgument(&GFRR_info0.bh_fall_back, sizeof(const int), offset2);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskRowGFRRKernel, "cuGaussianBlurFilterMaskRowGFRRKernel", grid2, block2);
    timing = hipacc_last_kernel_timing();
    hipacc_launch_info GFCR_info0(0, 2, IsOut, 1, 1);
    dim3 block3(128, 1);
    dim3 grid3(hipaccCalcGridFromBlock(GFCR_info0, block3));

    hipaccPrepareKernelLaunch(GFCR_info0, block3);
    hipaccConfigureCall(grid3, block3);

    size_t offset3 = 0;
    hipaccSetupArgument(&IsOut.img.mem, sizeof(uchar *), offset3);
    hipaccSetupArgument(&IsOut.width, sizeof(const int), offset3);
    hipaccSetupArgument(&IsOut.img.stride, sizeof(const int), offset3);
    hipaccSetupArgument(&AccTmpRepeat.img.mem, sizeof(float *), offset3);
    hipaccSetupArgument(&AccTmpRepeat.width, sizeof(const int), offset3);
    hipaccSetupArgument(&AccTmpRepeat.height, sizeof(const int), offset3);
    hipaccSetupArgument(&AccTmpRepeat.img.stride, sizeof(const int), offset3);
    hipaccSetupArgument(&GFCR_info0.bh_start_right, sizeof(const int), offset3);
    hipaccSetupArgument(&GFCR_info0.bh_start_top, sizeof(const int), offset3);
    hipaccSetupArgument(&GFCR_info0.bh_start_bottom, sizeof(const int), offset3);
    hipaccSetupArgument(&GFCR_info0.bh_fall_back, sizeof(const int), offset3);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskColumnGFCRKernel, "cuGaussianBlurFilterMaskColumnGFCRKernel", grid3, block3);
    timing += hipacc_last_kernel_timing();
    #endif
    timings_hipacc.push_back(timing);
    std::cerr << "Hipacc (REPEAT): " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;


    // MIRROR
    #ifdef NO_SEP
    BoundaryCondition<uchar> BcInMirror2(IN, M, Boundary::MIRROR);
    Accessor<uchar> AccInMirror2(BcInMirror2);
    GaussianBlurFilterMask GFM(IsOut, AccInMirror2, M, size_x, size_y);

    GFM.execute();
    timing = hipacc_last_kernel_timing();
    #else
    
    HipaccAccessor AccInMirror(IN);
    

    
    HipaccAccessor AccTmpMirror(TMP);
    

    hipacc_launch_info GFRM_info0(2, 0, IsTmp, 1, 1);
    dim3 block4(128, 1);
    dim3 grid4(hipaccCalcGridFromBlock(GFRM_info0, block4));

    hipaccPrepareKernelLaunch(GFRM_info0, block4);
    hipaccConfigureCall(grid4, block4);

    size_t offset4 = 0;
    hipaccSetupArgument(&IsTmp.img.mem, sizeof(float *), offset4);
    hipaccSetupArgument(&IsTmp.width, sizeof(const int), offset4);
    hipaccSetupArgument(&IsTmp.img.stride, sizeof(const int), offset4);
    hipaccSetupArgument(&AccInMirror.img.mem, sizeof(uchar *), offset4);
    hipaccSetupArgument(&AccInMirror.width, sizeof(const int), offset4);
    hipaccSetupArgument(&AccInMirror.height, sizeof(const int), offset4);
    hipaccSetupArgument(&AccInMirror.img.stride, sizeof(const int), offset4);
    hipaccSetupArgument(&GFRM_info0.bh_start_left, sizeof(const int), offset4);
    hipaccSetupArgument(&GFRM_info0.bh_start_right, sizeof(const int), offset4);
    hipaccSetupArgument(&GFRM_info0.bh_fall_back, sizeof(const int), offset4);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskRowGFRMKernel, "cuGaussianBlurFilterMaskRowGFRMKernel", grid4, block4);
    timing = hipacc_last_kernel_timing();
    hipacc_launch_info GFCM_info0(0, 2, IsOut, 1, 1);
    dim3 block5(128, 1);
    dim3 grid5(hipaccCalcGridFromBlock(GFCM_info0, block5));

    hipaccPrepareKernelLaunch(GFCM_info0, block5);
    hipaccConfigureCall(grid5, block5);

    size_t offset5 = 0;
    hipaccSetupArgument(&IsOut.img.mem, sizeof(uchar *), offset5);
    hipaccSetupArgument(&IsOut.width, sizeof(const int), offset5);
    hipaccSetupArgument(&IsOut.img.stride, sizeof(const int), offset5);
    hipaccSetupArgument(&AccTmpMirror.img.mem, sizeof(float *), offset5);
    hipaccSetupArgument(&AccTmpMirror.width, sizeof(const int), offset5);
    hipaccSetupArgument(&AccTmpMirror.height, sizeof(const int), offset5);
    hipaccSetupArgument(&AccTmpMirror.img.stride, sizeof(const int), offset5);
    hipaccSetupArgument(&GFCM_info0.bh_start_right, sizeof(const int), offset5);
    hipaccSetupArgument(&GFCM_info0.bh_start_top, sizeof(const int), offset5);
    hipaccSetupArgument(&GFCM_info0.bh_start_bottom, sizeof(const int), offset5);
    hipaccSetupArgument(&GFCM_info0.bh_fall_back, sizeof(const int), offset5);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskColumnGFCMKernel, "cuGaussianBlurFilterMaskColumnGFCMKernel", grid5, block5);
    timing += hipacc_last_kernel_timing();
    #endif
    timings_hipacc.push_back(timing);
    std::cerr << "Hipacc (MIRROR): " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;


    // CONSTANT
    #ifdef NO_SEP
    BoundaryCondition<uchar> BcInConst2(IN, M, Boundary::CONSTANT, '1');
    Accessor<uchar> AccInConst2(BcInConst2);
    GaussianBlurFilterMask GFConst(IsOut, AccInConst2, M, size_x, size_y);

    GFConst.execute();
    timing = hipacc_last_kernel_timing();
    #else
    
    HipaccAccessor AccInConst(IN);
    

    
    HipaccAccessor AccTmpConst(TMP);
    

    hipacc_launch_info GFRConst_info0(2, 0, IsTmp, 1, 1);
    dim3 block6(128, 1);
    dim3 grid6(hipaccCalcGridFromBlock(GFRConst_info0, block6));

    hipaccPrepareKernelLaunch(GFRConst_info0, block6);
    hipaccConfigureCall(grid6, block6);

    size_t offset6 = 0;
    hipaccSetupArgument(&IsTmp.img.mem, sizeof(float *), offset6);
    hipaccSetupArgument(&IsTmp.width, sizeof(const int), offset6);
    hipaccSetupArgument(&IsTmp.img.stride, sizeof(const int), offset6);
    hipaccSetupArgument(&AccInConst.img.mem, sizeof(uchar *), offset6);
    hipaccSetupArgument(&AccInConst.width, sizeof(const int), offset6);
    hipaccSetupArgument(&AccInConst.height, sizeof(const int), offset6);
    hipaccSetupArgument(&AccInConst.img.stride, sizeof(const int), offset6);
    hipaccSetupArgument(&GFRConst_info0.bh_start_left, sizeof(const int), offset6);
    hipaccSetupArgument(&GFRConst_info0.bh_start_right, sizeof(const int), offset6);
    hipaccSetupArgument(&GFRConst_info0.bh_fall_back, sizeof(const int), offset6);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskRowGFRConstKernel, "cuGaussianBlurFilterMaskRowGFRConstKernel", grid6, block6);
    timing = hipacc_last_kernel_timing();
    hipacc_launch_info GFCConst_info0(0, 2, IsOut, 1, 1);
    dim3 block7(128, 1);
    dim3 grid7(hipaccCalcGridFromBlock(GFCConst_info0, block7));

    hipaccPrepareKernelLaunch(GFCConst_info0, block7);
    hipaccConfigureCall(grid7, block7);

    size_t offset7 = 0;
    hipaccSetupArgument(&IsOut.img.mem, sizeof(uchar *), offset7);
    hipaccSetupArgument(&IsOut.width, sizeof(const int), offset7);
    hipaccSetupArgument(&IsOut.img.stride, sizeof(const int), offset7);
    hipaccSetupArgument(&AccTmpConst.img.mem, sizeof(float *), offset7);
    hipaccSetupArgument(&AccTmpConst.width, sizeof(const int), offset7);
    hipaccSetupArgument(&AccTmpConst.height, sizeof(const int), offset7);
    hipaccSetupArgument(&AccTmpConst.img.stride, sizeof(const int), offset7);
    hipaccSetupArgument(&GFCConst_info0.bh_start_right, sizeof(const int), offset7);
    hipaccSetupArgument(&GFCConst_info0.bh_start_top, sizeof(const int), offset7);
    hipaccSetupArgument(&GFCConst_info0.bh_start_bottom, sizeof(const int), offset7);
    hipaccSetupArgument(&GFCConst_info0.bh_fall_back, sizeof(const int), offset7);
    
    hipaccLaunchKernel((const void *)&cuGaussianBlurFilterMaskColumnGFCConstKernel, "cuGaussianBlurFilterMaskColumnGFCConstKernel", grid7, block7);
    timing += hipacc_last_kernel_timing();
    #endif
    timings_hipacc.push_back(timing);
    std::cerr << "Hipacc (CONSTANT): " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;


    // get pointer to result data
    uchar *output = hipaccReadMemory<uchar>(OUT);

    if (timings_hipacc.size()) {
        std::cerr << "Hipacc:";
        for (std::vector<float>::const_iterator it = timings_hipacc.begin(); it != timings_hipacc.end(); ++it)
            std::cerr << "\t" << *it;
        std::cerr << std::endl;
    }
    #endif


    #ifdef OPENCV
    auto opencv_bench = [] (std::function<void(int)> init, std::function<void(int)> launch, std::function<void(float)> finish) {
        for (int brd_type=0; brd_type<5; ++brd_type) {
            init(brd_type);

            std::vector<float> timings;
            try {
                for (int nt=0; nt<10; ++nt) {
                    auto start = time_ms();
                    launch(brd_type);
                    auto end = time_ms();
                    timings.push_back(end - start);
                }
            } catch (const cv::Exception &ex) {
                std::cerr << ex.what();
                timings.push_back(0);
            }

            std::cerr << "OpenCV (";
            switch (brd_type) {
                case IPL_BORDER_CONSTANT:    std::cerr << "CONSTANT";   break;
                case IPL_BORDER_REPLICATE:   std::cerr << "CLAMP";      break;
                case IPL_BORDER_REFLECT:     std::cerr << "MIRROR";     break;
                case IPL_BORDER_WRAP:        std::cerr << "REPEAT";     break;
                case IPL_BORDER_REFLECT_101: std::cerr << "MIRROR_101"; break;
                default: break;
            }
            std::sort(timings.begin(), timings.end());
            float time = timings[timings.size()/2];
            std::cerr << "): " << time << " ms, " << (width*height/time)/1000 << " Mpixel/s" << std::endl;

            finish(time);
        }
    };

    cv::Mat cv_data_src(height, width, CV_8UC1, input);
    cv::Mat cv_data_dst(height, width, CV_8UC1, cv::Scalar(0));
    cv::Size ksize(size_x, size_y);
    std::vector<float> timings_cpu;
    std::vector<float> timings_ocl;
    std::vector<float> timings_cuda;

    // OpenCV - CPU
    cv::ocl::setUseOpenCL(false);
    std::cerr << std::endl
              << "Calculating OpenCV-CPU Gaussian filter" << std::endl;

    cv::UMat dev_src, dev_dst;
    opencv_bench(
        [&] (int brd_type) {
            cv_data_src.copyTo(dev_src);
        },
        [&] (int brd_type) {
            cv::GaussianBlur(dev_src, dev_dst, ksize, sigma1, sigma2, brd_type);
        },
        [&] (float timing) {
            timings_cpu.push_back(timing);
            dev_dst.copyTo(cv_data_dst);
        }
    );

    // OpenCV - OpenCL
    if (cv::ocl::haveOpenCL()) {
        cv::ocl::setUseOpenCL(true);
        std::cerr << std::endl
                  << "Calculating OpenCV-OCL Gaussian filter on "
                  << cv::ocl::Device::getDefault().vendorName().c_str()
                  << " "  << cv::ocl::Device::getDefault().name().c_str()
                  << std::endl;

        cv::UMat dev_src, dev_dst;
        opencv_bench(
            [&] (int) {
                cv_data_src.copyTo(dev_src);
            },
            [&] (int brd_type) {
                cv::GaussianBlur(dev_src, dev_dst, ksize, sigma1, sigma2, brd_type);
                cv::ocl::finish();
            },
            [&] (float timing) {
                timings_ocl.push_back(timing);
                dev_dst.copyTo(cv_data_dst);
            }
        );
    }

    // OpenCV - CUDA
    if (cv::cuda::getCudaEnabledDeviceCount()) {
        #ifdef OPENCV_CUDA_FOUND
        std::cerr << std::endl
                  << "Calculating OpenCV-CUDA Gaussian filter" << std::endl;
        cv::cuda::printShortCudaDeviceInfo(cv::cuda::getDevice());

        cv::cuda::GpuMat dev_src, dev_dst;
        cv::Ptr<cv::cuda::Filter> gaussian;

        opencv_bench(
            [&] (int brd_type) {
                dev_src.upload(cv_data_src);
                gaussian = cv::cuda::createGaussianFilter(dev_src.type(), -1, ksize, sigma1, sigma2, brd_type);
            },
            [&] (int) {
                gaussian->apply(dev_src, dev_dst);
            },
            [&] (float timing) {
                timings_cuda.push_back(timing);
                dev_dst.download(cv_data_dst);
            }
        );
        #endif
    }

    // get pointer to result data
    uchar *output = (uchar *)cv_data_dst.data;

    if (timings_cpu.size()) {
        std::cerr << "CV-CPU: ";
        for (auto time : timings_cpu)
            std::cerr << "\t" << time;
        std::cerr << std::endl;
    }
    if (timings_ocl.size()) {
        std::cerr << "CV-OCL: ";
        for (auto time : timings_ocl)
            std::cerr << "\t" << time;
        std::cerr << std::endl;
    }
    if (timings_cuda.size()) {
        std::cerr << "CV-CUDA:";
        for (auto time : timings_cuda)
            std::cerr << "\t" << time;
        std::cerr << std::endl;
    }
    #endif


    std::cerr << "Calculating reference ..." << std::endl;
    std::vector<float> timings_reference;
    for (int nt=0; nt<3; ++nt) {
        double start = time_ms();

        #ifdef NO_SEP
        gaussian_filter(reference_in, reference_out, (float *)filter_xy, size_x, size_y, width, height);
        #else
        gaussian_filter_row(reference_in, reference_tmp, (float *)filter_x, size_x, width, height);
        gaussian_filter_column(reference_tmp, reference_out, (float *)filter_y, size_y, width, height);
        #endif

        double end = time_ms();
        timings_reference.push_back(end - start);
    }
    std::sort(timings_reference.begin(), timings_reference.end());
    float time = timings_reference[timings_reference.size()/2];
    std::cerr << "Reference: " << time << " ms, " << (width*height/time)/1000 << " Mpixel/s" << std::endl;


    std::cerr << "Comparing results ..." << std::endl
              << "Warning: The CPU, OCL, and CUDA modules in OpenCV use different implementations and yield inconsistent results." << std::endl
              << "         This is the case even for different filter sizes within the same module!" << std::endl;
    for (int y=offset_y; y<height-offset_y; ++y) {
        for (int x=offset_x; x<width-offset_x; ++x) {
            if (reference_out[y*width + x] != output[y*width + x]) {
                std::cerr << "Test FAILED, at (" << x << "," << y << "): "
                          << (int)reference_out[y*width + x] << " vs. "
                          << (int)output[y*width + x] << std::endl;
                exit(EXIT_FAILURE);
            }
        }
    }
    std::cerr << "Test PASSED" << std::endl;

    // free memory
    delete[] input;
    delete[] reference_in;
    delete[] reference_tmp;
    delete[] reference_out;

    hipaccReleaseMemory(OUT);
    hipaccReleaseMemory(IN);
    hipaccReleaseMemory(TMP);
    return EXIT_SUCCESS;
}

