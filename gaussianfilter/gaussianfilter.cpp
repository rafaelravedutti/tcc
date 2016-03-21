#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <sys/time.h>
#include <opencv2/opencv.hpp>
//---
#include "hipacc.hpp"

using namespace hipacc;

// get time in milliseconds
double time_ms () {
    struct timeval tv;
    gettimeofday (&tv, NULL);

    return ((double)(tv.tv_sec) * 1e+3 + (double)(tv.tv_usec) * 1e-3);
}

// Gaussian blur filter in Hipacc
#ifdef NO_SEP

class GaussianFilter : public Kernel<uchar> {
    private:
        Accessor<uchar> &input;
        Mask<float> &mask;
        const int size_x, size_y;

    public:
        GaussianFilter(IterationSpace<uchar> &iter, Accessor<uchar>
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

class GaussianFilterRow : public Kernel<float> {
    private:
        Accessor<uchar> &input;
        Mask<float> &mask;
        const int size;

    public:
        GaussianFilterRow(IterationSpace<float> &iter, Accessor<uchar>
                &input, Mask<float> &mask, const int size) :
            Kernel(iter),
            input(input),
            mask(mask),
            size(size)
        { add_accessor(&input); }

        #ifdef USE_LAMBDA

        void kernel() {
            output() = convolve(mask, Reduce::SUM, [&] () -> float {
                    return mask() * input(mask);
                    });
        }

        #else

        void kernel() {
            const int anchor = size >> 1;
            float sum = 0.0f;

            for (int xf = -anchor; xf<=anchor; ++xf) {
                sum += mask(xf, 0) * input(xf, 0);
            }

            output() = sum;
        }

        #endif
};

class GaussianFilterColumn: public Kernel<uchar> {
    private:
        Accessor<float> &input;
        Mask<float> &mask;
        const int size;

    public:
        GaussianFilterColumn(IterationSpace<uchar> &iter,
                Accessor<float> &input, Mask<float> &mask, const int size) :
            Kernel(iter),
            input(input),
            mask(mask),
            size(size)
        { add_accessor(&input); }

        #ifdef USE_LAMBDA

        void kernel() {
            output() = (uchar)(convolve(mask, Reduce::SUM, [&] () -> float {
                    return mask() * input(mask);
                    }) + 0.5f);
        }

        #else

        void kernel() {
            const int anchor = size >> 1;
            float sum = 0.5f;

            for (int yf = -anchor; yf<=anchor; ++yf) {
                sum += mask(0, yf) * input(0, yf);
            }

            output() = (uchar) sum;
        }

        #endif
};

#endif

int main(int argc, const char *argv[]) {
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

    cv::Mat frame = cv::imread(argv[1], CV_LOAD_IMAGE_COLOR);

    const int width = frame.cols;
    const int height = frame.rows;
    float timing = 0;

    // input and output image of width x height pixels
    Image<uchar> input(width, height);
    Image<uchar> output(width, height);
    Image<float> tmp(width, height);

    input = frame.data;

    // filter mask
    Mask<float> mask(filter_xy);
    Mask<float> mask_x(filter_x);
    Mask<float> mask_y(filter_y);

    IterationSpace<uchar> iter_out(output);
    IterationSpace<float> iter_tmp(tmp);

    #ifdef NO_SEP

    BoundaryCondition<uchar> cond(input, mask, Boundary::CLAMP);
    Accessor<uchar> acc(cond);
    GaussianFilter XY(iter_out, acc, mask, size_x, size_y);

    XY.execute();
    timing = hipacc_last_kernel_timing();

    #else

    BoundaryCondition<uchar> cond_in(input, mask_x, Boundary::CLAMP);
    Accessor<uchar> acc(cond_in);
    GaussianFilterRow X(iter_tmp, acc, mask_x, size_x);

    BoundaryCondition<float> cond_tmp(tmp, mask_y, Boundary::CLAMP);
    Accessor<float> acc_tmp(cond_tmp);
    GaussianFilterColumn Y(iter_out, acc_tmp, mask_y, size_y);

    X.execute();
    timing = hipacc_last_kernel_timing();
    Y.execute();
    timing += hipacc_last_kernel_timing();

    #endif

    std::cerr << "Timing: " << timing << " ms, " << (width*height/timing)/1000 << " Mpixel/s" << std::endl;

    // OpenCV display image
    std::vector<int> compression_params;
    frame.data = output.data();

    compression_params.push_back(CV_IMWRITE_PNG_COMPRESSION);
    compression_params.push_back(9);

    try {
      cv::imwrite("result.png", frame, compression_params);
    } catch(std::runtime_error &ex) {
      fprintf(stderr, "PNG compression exception: %s\n", ex.what());
      return 1;
    }

    fprintf(stdout, "Done!\n");
    return 0;
}
