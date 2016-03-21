#ifndef _CUGAUSSIANFILTERXY_CU_
#define _CUGAUSSIANFILTERXY_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<uchar, cudaTextureType1D, cudaReadModeElementType> _texinputXY;
const textureReference *_texinputXYRef;
__device__ __constant__ float _constmaskXY[5][5];


extern "C" {
__global__ __launch_bounds__ (32*2) void cuGaussianFilterXYKernel(uchar * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int size_x, int size_y, int bh_start_left, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
    uchar _smeminput[20][97] __attribute__((shared));
    if (bh_fall_back)
        goto BH_FB;
    if (blockIdx.x < bh_start_left && blockIdx.y < bh_start_top)
        goto BH_TL;
    if (blockIdx.x >= bh_start_right && blockIdx.y < bh_start_top)
        goto BH_TR;
    if (blockIdx.y < bh_start_top)
        goto BH_T;
    if (blockIdx.y >= bh_start_bottom && blockIdx.x < bh_start_left)
        goto BH_BL;
    if (blockIdx.y >= bh_start_bottom && blockIdx.x >= bh_start_right)
        goto BH_BR;
    if (blockIdx.y >= bh_start_bottom)
        goto BH_B;
    if (blockIdx.x >= bh_start_right)
        goto BH_R;
    if (blockIdx.x < bh_start_left)
        goto BH_L;
    goto BH_NO;
  BH_FB:
    {
        int _gid_x0 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y0 = gid_y + (-2);
        if (_gid_x0 >= input_width)
            _gid_x0 = input_width - 1;
        if (_gid_y0 >= input_height)
            _gid_y0 = input_height - 1;
        if (_gid_x0 < 0)
            _gid_x0 = 0;
        if (_gid_y0 < 0)
            _gid_y0 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y0) * input_stride + _gid_x0);
        int _gid_x1 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y1 = gid_y + (-2);
        if (_gid_x1 >= input_width)
            _gid_x1 = input_width - 1;
        if (_gid_y1 >= input_height)
            _gid_y1 = input_height - 1;
        if (_gid_x1 < 0)
            _gid_x1 = 0;
        if (_gid_y1 < 0)
            _gid_y1 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y1) * input_stride + _gid_x1);
        int _gid_x2 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y2 = gid_y + (-2);
        if (_gid_x2 >= input_width)
            _gid_x2 = input_width - 1;
        if (_gid_y2 >= input_height)
            _gid_y2 = input_height - 1;
        if (_gid_x2 < 0)
            _gid_x2 = 0;
        if (_gid_y2 < 0)
            _gid_y2 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y2) * input_stride + _gid_x2);
        int _gid_x3 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y3 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x3 >= input_width)
            _gid_x3 = input_width - 1;
        if (_gid_y3 >= input_height)
            _gid_y3 = input_height - 1;
        if (_gid_x3 < 0)
            _gid_x3 = 0;
        if (_gid_y3 < 0)
            _gid_y3 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y3) * input_stride + _gid_x3);
        int _gid_x4 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y4 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x4 >= input_width)
            _gid_x4 = input_width - 1;
        if (_gid_y4 >= input_height)
            _gid_y4 = input_height - 1;
        if (_gid_x4 < 0)
            _gid_x4 = 0;
        if (_gid_y4 < 0)
            _gid_y4 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y4) * input_stride + _gid_x4);
        int _gid_x5 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y5 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x5 >= input_width)
            _gid_x5 = input_width - 1;
        if (_gid_y5 >= input_height)
            _gid_y5 = input_height - 1;
        if (_gid_x5 < 0)
            _gid_x5 = 0;
        if (_gid_y5 < 0)
            _gid_y5 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y5) * input_stride + _gid_x5);
        int _gid_x6 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y6 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x6 >= input_width)
            _gid_x6 = input_width - 1;
        if (_gid_y6 >= input_height)
            _gid_y6 = input_height - 1;
        if (_gid_x6 < 0)
            _gid_x6 = 0;
        if (_gid_y6 < 0)
            _gid_y6 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y6) * input_stride + _gid_x6);
        int _gid_x7 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y7 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x7 >= input_width)
            _gid_x7 = input_width - 1;
        if (_gid_y7 >= input_height)
            _gid_y7 = input_height - 1;
        if (_gid_x7 < 0)
            _gid_x7 = 0;
        if (_gid_y7 < 0)
            _gid_y7 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y7) * input_stride + _gid_x7);
        int _gid_x8 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y8 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x8 >= input_width)
            _gid_x8 = input_width - 1;
        if (_gid_y8 >= input_height)
            _gid_y8 = input_height - 1;
        if (_gid_x8 < 0)
            _gid_x8 = 0;
        if (_gid_y8 < 0)
            _gid_y8 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y8) * input_stride + _gid_x8);
        int _gid_x9 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y9 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x9 >= input_width)
            _gid_x9 = input_width - 1;
        if (_gid_y9 >= input_height)
            _gid_y9 = input_height - 1;
        if (_gid_x9 < 0)
            _gid_x9 = 0;
        if (_gid_y9 < 0)
            _gid_y9 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y9) * input_stride + _gid_x9);
        int _gid_x10 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y10 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x10 >= input_width)
            _gid_x10 = input_width - 1;
        if (_gid_y10 >= input_height)
            _gid_y10 = input_height - 1;
        if (_gid_x10 < 0)
            _gid_x10 = 0;
        if (_gid_y10 < 0)
            _gid_y10 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y10) * input_stride + _gid_x10);
        int _gid_x11 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y11 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x11 >= input_width)
            _gid_x11 = input_width - 1;
        if (_gid_y11 >= input_height)
            _gid_y11 = input_height - 1;
        if (_gid_x11 < 0)
            _gid_x11 = 0;
        if (_gid_y11 < 0)
            _gid_y11 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y11) * input_stride + _gid_x11);
        int _gid_x12 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y12 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x12 >= input_width)
            _gid_x12 = input_width - 1;
        if (_gid_y12 >= input_height)
            _gid_y12 = input_height - 1;
        if (_gid_x12 < 0)
            _gid_x12 = 0;
        if (_gid_y12 < 0)
            _gid_y12 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y12) * input_stride + _gid_x12);
        int _gid_x13 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y13 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x13 >= input_width)
            _gid_x13 = input_width - 1;
        if (_gid_y13 >= input_height)
            _gid_y13 = input_height - 1;
        if (_gid_x13 < 0)
            _gid_x13 = 0;
        if (_gid_y13 < 0)
            _gid_y13 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y13) * input_stride + _gid_x13);
        int _gid_x14 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y14 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x14 >= input_width)
            _gid_x14 = input_width - 1;
        if (_gid_y14 >= input_height)
            _gid_y14 = input_height - 1;
        if (_gid_x14 < 0)
            _gid_x14 = 0;
        if (_gid_y14 < 0)
            _gid_y14 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y14) * input_stride + _gid_x14);
        int _gid_x15 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y15 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x15 >= input_width)
            _gid_x15 = input_width - 1;
        if (_gid_y15 >= input_height)
            _gid_y15 = input_height - 1;
        if (_gid_x15 < 0)
            _gid_x15 = 0;
        if (_gid_y15 < 0)
            _gid_y15 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y15) * input_stride + _gid_x15);
        int _gid_x16 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y16 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x16 >= input_width)
            _gid_x16 = input_width - 1;
        if (_gid_y16 >= input_height)
            _gid_y16 = input_height - 1;
        if (_gid_x16 < 0)
            _gid_x16 = 0;
        if (_gid_y16 < 0)
            _gid_y16 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y16) * input_stride + _gid_x16);
        int _gid_x17 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y17 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x17 >= input_width)
            _gid_x17 = input_width - 1;
        if (_gid_y17 >= input_height)
            _gid_y17 = input_height - 1;
        if (_gid_x17 < 0)
            _gid_x17 = 0;
        if (_gid_y17 < 0)
            _gid_y17 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y17) * input_stride + _gid_x17);
        int _gid_x18 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y18 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x18 >= input_width)
            _gid_x18 = input_width - 1;
        if (_gid_y18 >= input_height)
            _gid_y18 = input_height - 1;
        if (_gid_x18 < 0)
            _gid_x18 = 0;
        if (_gid_y18 < 0)
            _gid_y18 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y18) * input_stride + _gid_x18);
        int _gid_x19 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y19 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x19 >= input_width)
            _gid_x19 = input_width - 1;
        if (_gid_y19 >= input_height)
            _gid_y19 = input_height - 1;
        if (_gid_x19 < 0)
            _gid_x19 = 0;
        if (_gid_y19 < 0)
            _gid_y19 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y19) * input_stride + _gid_x19);
        int _gid_x20 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y20 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x20 >= input_width)
            _gid_x20 = input_width - 1;
        if (_gid_y20 >= input_height)
            _gid_y20 = input_height - 1;
        if (_gid_x20 < 0)
            _gid_x20 = 0;
        if (_gid_y20 < 0)
            _gid_y20 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y20) * input_stride + _gid_x20);
        int _gid_x21 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y21 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x21 >= input_width)
            _gid_x21 = input_width - 1;
        if (_gid_y21 >= input_height)
            _gid_y21 = input_height - 1;
        if (_gid_x21 < 0)
            _gid_x21 = 0;
        if (_gid_y21 < 0)
            _gid_y21 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y21) * input_stride + _gid_x21);
        int _gid_x22 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y22 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x22 >= input_width)
            _gid_x22 = input_width - 1;
        if (_gid_y22 >= input_height)
            _gid_y22 = input_height - 1;
        if (_gid_x22 < 0)
            _gid_x22 = 0;
        if (_gid_y22 < 0)
            _gid_y22 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y22) * input_stride + _gid_x22);
        int _gid_x23 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y23 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x23 >= input_width)
            _gid_x23 = input_width - 1;
        if (_gid_y23 >= input_height)
            _gid_y23 = input_height - 1;
        if (_gid_x23 < 0)
            _gid_x23 = 0;
        if (_gid_y23 < 0)
            _gid_y23 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y23) * input_stride + _gid_x23);
        int _gid_x24 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y24 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x24 >= input_width)
            _gid_x24 = input_width - 1;
        if (_gid_y24 >= input_height)
            _gid_y24 = input_height - 1;
        if (_gid_x24 < 0)
            _gid_x24 = 0;
        if (_gid_y24 < 0)
            _gid_y24 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y24) * input_stride + _gid_x24);
        int _gid_x25 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y25 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x25 >= input_width)
            _gid_x25 = input_width - 1;
        if (_gid_y25 >= input_height)
            _gid_y25 = input_height - 1;
        if (_gid_x25 < 0)
            _gid_x25 = 0;
        if (_gid_y25 < 0)
            _gid_y25 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y25) * input_stride + _gid_x25);
        int _gid_x26 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y26 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x26 >= input_width)
            _gid_x26 = input_width - 1;
        if (_gid_y26 >= input_height)
            _gid_y26 = input_height - 1;
        if (_gid_x26 < 0)
            _gid_x26 = 0;
        if (_gid_y26 < 0)
            _gid_y26 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y26) * input_stride + _gid_x26);
        int _gid_x27 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y27 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x27 >= input_width)
            _gid_x27 = input_width - 1;
        if (_gid_y27 >= input_height)
            _gid_y27 = input_height - 1;
        if (_gid_x27 < 0)
            _gid_x27 = 0;
        if (_gid_y27 < 0)
            _gid_y27 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y27) * input_stride + _gid_x27);
        int _gid_x28 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y28 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x28 >= input_width)
            _gid_x28 = input_width - 1;
        if (_gid_y28 >= input_height)
            _gid_y28 = input_height - 1;
        if (_gid_x28 < 0)
            _gid_x28 = 0;
        if (_gid_y28 < 0)
            _gid_y28 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y28) * input_stride + _gid_x28);
        int _gid_x29 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y29 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x29 >= input_width)
            _gid_x29 = input_width - 1;
        if (_gid_y29 >= input_height)
            _gid_y29 = input_height - 1;
        if (_gid_x29 < 0)
            _gid_x29 = 0;
        if (_gid_y29 < 0)
            _gid_y29 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y29) * input_stride + _gid_x29);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
    }
    goto BH_EXIT;
  BH_TL:
    {
        int _gid_x30 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y30 = gid_y + (-2);
        if (_gid_x30 < 0)
            _gid_x30 = 0;
        if (_gid_y30 < 0)
            _gid_y30 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y30) * input_stride + _gid_x30);
        int _gid_x31 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y31 = gid_y + (-2);
        if (_gid_x31 < 0)
            _gid_x31 = 0;
        if (_gid_y31 < 0)
            _gid_y31 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y31) * input_stride + _gid_x31);
        int _gid_x32 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y32 = gid_y + (-2);
        if (_gid_x32 < 0)
            _gid_x32 = 0;
        if (_gid_y32 < 0)
            _gid_y32 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y32) * input_stride + _gid_x32);
        int _gid_x33 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y33 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x33 < 0)
            _gid_x33 = 0;
        if (_gid_y33 < 0)
            _gid_y33 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y33) * input_stride + _gid_x33);
        int _gid_x34 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y34 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x34 < 0)
            _gid_x34 = 0;
        if (_gid_y34 < 0)
            _gid_y34 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y34) * input_stride + _gid_x34);
        int _gid_x35 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y35 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x35 < 0)
            _gid_x35 = 0;
        if (_gid_y35 < 0)
            _gid_y35 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y35) * input_stride + _gid_x35);
        int _gid_x36 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y36 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x36 < 0)
            _gid_x36 = 0;
        if (_gid_y36 < 0)
            _gid_y36 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y36) * input_stride + _gid_x36);
        int _gid_x37 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y37 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x37 < 0)
            _gid_x37 = 0;
        if (_gid_y37 < 0)
            _gid_y37 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y37) * input_stride + _gid_x37);
        int _gid_x38 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y38 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x38 < 0)
            _gid_x38 = 0;
        if (_gid_y38 < 0)
            _gid_y38 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y38) * input_stride + _gid_x38);
        int _gid_x39 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y39 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x39 < 0)
            _gid_x39 = 0;
        if (_gid_y39 < 0)
            _gid_y39 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y39) * input_stride + _gid_x39);
        int _gid_x40 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y40 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x40 < 0)
            _gid_x40 = 0;
        if (_gid_y40 < 0)
            _gid_y40 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y40) * input_stride + _gid_x40);
        int _gid_x41 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y41 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x41 < 0)
            _gid_x41 = 0;
        if (_gid_y41 < 0)
            _gid_y41 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y41) * input_stride + _gid_x41);
        int _gid_x42 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y42 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x42 < 0)
            _gid_x42 = 0;
        if (_gid_y42 < 0)
            _gid_y42 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y42) * input_stride + _gid_x42);
        int _gid_x43 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y43 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x43 < 0)
            _gid_x43 = 0;
        if (_gid_y43 < 0)
            _gid_y43 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y43) * input_stride + _gid_x43);
        int _gid_x44 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y44 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x44 < 0)
            _gid_x44 = 0;
        if (_gid_y44 < 0)
            _gid_y44 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y44) * input_stride + _gid_x44);
        int _gid_x45 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y45 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x45 < 0)
            _gid_x45 = 0;
        if (_gid_y45 < 0)
            _gid_y45 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y45) * input_stride + _gid_x45);
        int _gid_x46 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y46 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x46 < 0)
            _gid_x46 = 0;
        if (_gid_y46 < 0)
            _gid_y46 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y46) * input_stride + _gid_x46);
        int _gid_x47 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y47 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x47 < 0)
            _gid_x47 = 0;
        if (_gid_y47 < 0)
            _gid_y47 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y47) * input_stride + _gid_x47);
        int _gid_x48 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y48 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x48 < 0)
            _gid_x48 = 0;
        if (_gid_y48 < 0)
            _gid_y48 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y48) * input_stride + _gid_x48);
        int _gid_x49 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y49 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x49 < 0)
            _gid_x49 = 0;
        if (_gid_y49 < 0)
            _gid_y49 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y49) * input_stride + _gid_x49);
        int _gid_x50 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y50 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x50 < 0)
            _gid_x50 = 0;
        if (_gid_y50 < 0)
            _gid_y50 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y50) * input_stride + _gid_x50);
        int _gid_x51 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y51 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x51 < 0)
            _gid_x51 = 0;
        if (_gid_y51 < 0)
            _gid_y51 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y51) * input_stride + _gid_x51);
        int _gid_x52 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y52 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x52 < 0)
            _gid_x52 = 0;
        if (_gid_y52 < 0)
            _gid_y52 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y52) * input_stride + _gid_x52);
        int _gid_x53 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y53 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x53 < 0)
            _gid_x53 = 0;
        if (_gid_y53 < 0)
            _gid_y53 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y53) * input_stride + _gid_x53);
        int _gid_x54 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y54 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x54 < 0)
            _gid_x54 = 0;
        if (_gid_y54 < 0)
            _gid_y54 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y54) * input_stride + _gid_x54);
        int _gid_x55 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y55 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x55 < 0)
            _gid_x55 = 0;
        if (_gid_y55 < 0)
            _gid_y55 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y55) * input_stride + _gid_x55);
        int _gid_x56 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y56 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x56 < 0)
            _gid_x56 = 0;
        if (_gid_y56 < 0)
            _gid_y56 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y56) * input_stride + _gid_x56);
        int _gid_x57 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y57 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x57 < 0)
            _gid_x57 = 0;
        if (_gid_y57 < 0)
            _gid_y57 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y57) * input_stride + _gid_x57);
        int _gid_x58 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y58 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x58 < 0)
            _gid_x58 = 0;
        if (_gid_y58 < 0)
            _gid_y58 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y58) * input_stride + _gid_x58);
        int _gid_x59 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y59 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x59 < 0)
            _gid_x59 = 0;
        if (_gid_y59 < 0)
            _gid_y59 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y59) * input_stride + _gid_x59);
        __syncthreads();
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
    }
    goto BH_EXIT;
  BH_TR:
    {
        int _gid_x60 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y60 = gid_y + (-2);
        if (_gid_x60 >= input_width)
            _gid_x60 = input_width - 1;
        if (_gid_y60 < 0)
            _gid_y60 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y60) * input_stride + _gid_x60);
        int _gid_x61 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y61 = gid_y + (-2);
        if (_gid_x61 >= input_width)
            _gid_x61 = input_width - 1;
        if (_gid_y61 < 0)
            _gid_y61 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y61) * input_stride + _gid_x61);
        int _gid_x62 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y62 = gid_y + (-2);
        if (_gid_x62 >= input_width)
            _gid_x62 = input_width - 1;
        if (_gid_y62 < 0)
            _gid_y62 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y62) * input_stride + _gid_x62);
        int _gid_x63 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y63 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x63 >= input_width)
            _gid_x63 = input_width - 1;
        if (_gid_y63 < 0)
            _gid_y63 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y63) * input_stride + _gid_x63);
        int _gid_x64 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y64 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x64 >= input_width)
            _gid_x64 = input_width - 1;
        if (_gid_y64 < 0)
            _gid_y64 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y64) * input_stride + _gid_x64);
        int _gid_x65 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y65 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x65 >= input_width)
            _gid_x65 = input_width - 1;
        if (_gid_y65 < 0)
            _gid_y65 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y65) * input_stride + _gid_x65);
        int _gid_x66 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y66 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x66 >= input_width)
            _gid_x66 = input_width - 1;
        if (_gid_y66 < 0)
            _gid_y66 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y66) * input_stride + _gid_x66);
        int _gid_x67 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y67 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x67 >= input_width)
            _gid_x67 = input_width - 1;
        if (_gid_y67 < 0)
            _gid_y67 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y67) * input_stride + _gid_x67);
        int _gid_x68 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y68 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x68 >= input_width)
            _gid_x68 = input_width - 1;
        if (_gid_y68 < 0)
            _gid_y68 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y68) * input_stride + _gid_x68);
        int _gid_x69 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y69 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x69 >= input_width)
            _gid_x69 = input_width - 1;
        if (_gid_y69 < 0)
            _gid_y69 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y69) * input_stride + _gid_x69);
        int _gid_x70 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y70 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x70 >= input_width)
            _gid_x70 = input_width - 1;
        if (_gid_y70 < 0)
            _gid_y70 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y70) * input_stride + _gid_x70);
        int _gid_x71 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y71 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x71 >= input_width)
            _gid_x71 = input_width - 1;
        if (_gid_y71 < 0)
            _gid_y71 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y71) * input_stride + _gid_x71);
        int _gid_x72 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y72 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x72 >= input_width)
            _gid_x72 = input_width - 1;
        if (_gid_y72 < 0)
            _gid_y72 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y72) * input_stride + _gid_x72);
        int _gid_x73 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y73 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x73 >= input_width)
            _gid_x73 = input_width - 1;
        if (_gid_y73 < 0)
            _gid_y73 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y73) * input_stride + _gid_x73);
        int _gid_x74 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y74 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x74 >= input_width)
            _gid_x74 = input_width - 1;
        if (_gid_y74 < 0)
            _gid_y74 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y74) * input_stride + _gid_x74);
        int _gid_x75 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y75 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x75 >= input_width)
            _gid_x75 = input_width - 1;
        if (_gid_y75 < 0)
            _gid_y75 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y75) * input_stride + _gid_x75);
        int _gid_x76 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y76 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x76 >= input_width)
            _gid_x76 = input_width - 1;
        if (_gid_y76 < 0)
            _gid_y76 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y76) * input_stride + _gid_x76);
        int _gid_x77 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y77 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x77 >= input_width)
            _gid_x77 = input_width - 1;
        if (_gid_y77 < 0)
            _gid_y77 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y77) * input_stride + _gid_x77);
        int _gid_x78 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y78 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x78 >= input_width)
            _gid_x78 = input_width - 1;
        if (_gid_y78 < 0)
            _gid_y78 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y78) * input_stride + _gid_x78);
        int _gid_x79 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y79 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x79 >= input_width)
            _gid_x79 = input_width - 1;
        if (_gid_y79 < 0)
            _gid_y79 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y79) * input_stride + _gid_x79);
        int _gid_x80 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y80 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x80 >= input_width)
            _gid_x80 = input_width - 1;
        if (_gid_y80 < 0)
            _gid_y80 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y80) * input_stride + _gid_x80);
        int _gid_x81 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y81 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x81 >= input_width)
            _gid_x81 = input_width - 1;
        if (_gid_y81 < 0)
            _gid_y81 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y81) * input_stride + _gid_x81);
        int _gid_x82 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y82 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x82 >= input_width)
            _gid_x82 = input_width - 1;
        if (_gid_y82 < 0)
            _gid_y82 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y82) * input_stride + _gid_x82);
        int _gid_x83 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y83 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x83 >= input_width)
            _gid_x83 = input_width - 1;
        if (_gid_y83 < 0)
            _gid_y83 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y83) * input_stride + _gid_x83);
        int _gid_x84 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y84 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x84 >= input_width)
            _gid_x84 = input_width - 1;
        if (_gid_y84 < 0)
            _gid_y84 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y84) * input_stride + _gid_x84);
        int _gid_x85 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y85 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x85 >= input_width)
            _gid_x85 = input_width - 1;
        if (_gid_y85 < 0)
            _gid_y85 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y85) * input_stride + _gid_x85);
        int _gid_x86 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y86 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x86 >= input_width)
            _gid_x86 = input_width - 1;
        if (_gid_y86 < 0)
            _gid_y86 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y86) * input_stride + _gid_x86);
        int _gid_x87 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y87 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x87 >= input_width)
            _gid_x87 = input_width - 1;
        if (_gid_y87 < 0)
            _gid_y87 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y87) * input_stride + _gid_x87);
        int _gid_x88 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y88 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x88 >= input_width)
            _gid_x88 = input_width - 1;
        if (_gid_y88 < 0)
            _gid_y88 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y88) * input_stride + _gid_x88);
        int _gid_x89 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y89 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x89 >= input_width)
            _gid_x89 = input_width - 1;
        if (_gid_y89 < 0)
            _gid_y89 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y89) * input_stride + _gid_x89);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        int _gid_x90 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y90 = gid_y + (-2);
        if (_gid_y90 < 0)
            _gid_y90 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y90) * input_stride + _gid_x90);
        int _gid_x91 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y91 = gid_y + (-2);
        if (_gid_y91 < 0)
            _gid_y91 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y91) * input_stride + _gid_x91);
        int _gid_x92 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y92 = gid_y + (-2);
        if (_gid_y92 < 0)
            _gid_y92 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y92) * input_stride + _gid_x92);
        int _gid_x93 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y93 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y93 < 0)
            _gid_y93 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y93) * input_stride + _gid_x93);
        int _gid_x94 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y94 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y94 < 0)
            _gid_y94 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y94) * input_stride + _gid_x94);
        int _gid_x95 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y95 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y95 < 0)
            _gid_y95 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y95) * input_stride + _gid_x95);
        int _gid_x96 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y96 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y96 < 0)
            _gid_y96 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y96) * input_stride + _gid_x96);
        int _gid_x97 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y97 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y97 < 0)
            _gid_y97 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y97) * input_stride + _gid_x97);
        int _gid_x98 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y98 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y98 < 0)
            _gid_y98 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y98) * input_stride + _gid_x98);
        int _gid_x99 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y99 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y99 < 0)
            _gid_y99 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y99) * input_stride + _gid_x99);
        int _gid_x100 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y100 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y100 < 0)
            _gid_y100 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y100) * input_stride + _gid_x100);
        int _gid_x101 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y101 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y101 < 0)
            _gid_y101 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y101) * input_stride + _gid_x101);
        int _gid_x102 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y102 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y102 < 0)
            _gid_y102 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y102) * input_stride + _gid_x102);
        int _gid_x103 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y103 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y103 < 0)
            _gid_y103 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y103) * input_stride + _gid_x103);
        int _gid_x104 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y104 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y104 < 0)
            _gid_y104 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y104) * input_stride + _gid_x104);
        int _gid_x105 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y105 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y105 < 0)
            _gid_y105 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y105) * input_stride + _gid_x105);
        int _gid_x106 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y106 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y106 < 0)
            _gid_y106 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y106) * input_stride + _gid_x106);
        int _gid_x107 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y107 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y107 < 0)
            _gid_y107 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y107) * input_stride + _gid_x107);
        int _gid_x108 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y108 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y108 < 0)
            _gid_y108 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y108) * input_stride + _gid_x108);
        int _gid_x109 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y109 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y109 < 0)
            _gid_y109 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y109) * input_stride + _gid_x109);
        int _gid_x110 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y110 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y110 < 0)
            _gid_y110 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y110) * input_stride + _gid_x110);
        int _gid_x111 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y111 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y111 < 0)
            _gid_y111 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y111) * input_stride + _gid_x111);
        int _gid_x112 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y112 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y112 < 0)
            _gid_y112 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y112) * input_stride + _gid_x112);
        int _gid_x113 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y113 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y113 < 0)
            _gid_y113 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y113) * input_stride + _gid_x113);
        int _gid_x114 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y114 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y114 < 0)
            _gid_y114 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y114) * input_stride + _gid_x114);
        int _gid_x115 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y115 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y115 < 0)
            _gid_y115 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y115) * input_stride + _gid_x115);
        int _gid_x116 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y116 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y116 < 0)
            _gid_y116 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y116) * input_stride + _gid_x116);
        int _gid_x117 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y117 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y117 < 0)
            _gid_y117 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y117) * input_stride + _gid_x117);
        int _gid_x118 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y118 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y118 < 0)
            _gid_y118 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y118) * input_stride + _gid_x118);
        int _gid_x119 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y119 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y119 < 0)
            _gid_y119 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y119) * input_stride + _gid_x119);
        __syncthreads();
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
    }
    goto BH_EXIT;
  BH_BL:
    {
        int _gid_x120 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y120 = gid_y + (-2);
        if (_gid_y120 >= input_height)
            _gid_y120 = input_height - 1;
        if (_gid_x120 < 0)
            _gid_x120 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y120) * input_stride + _gid_x120);
        int _gid_x121 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y121 = gid_y + (-2);
        if (_gid_y121 >= input_height)
            _gid_y121 = input_height - 1;
        if (_gid_x121 < 0)
            _gid_x121 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y121) * input_stride + _gid_x121);
        int _gid_x122 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y122 = gid_y + (-2);
        if (_gid_y122 >= input_height)
            _gid_y122 = input_height - 1;
        if (_gid_x122 < 0)
            _gid_x122 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y122) * input_stride + _gid_x122);
        int _gid_x123 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y123 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y123 >= input_height)
            _gid_y123 = input_height - 1;
        if (_gid_x123 < 0)
            _gid_x123 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y123) * input_stride + _gid_x123);
        int _gid_x124 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y124 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y124 >= input_height)
            _gid_y124 = input_height - 1;
        if (_gid_x124 < 0)
            _gid_x124 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y124) * input_stride + _gid_x124);
        int _gid_x125 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y125 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y125 >= input_height)
            _gid_y125 = input_height - 1;
        if (_gid_x125 < 0)
            _gid_x125 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y125) * input_stride + _gid_x125);
        int _gid_x126 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y126 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y126 >= input_height)
            _gid_y126 = input_height - 1;
        if (_gid_x126 < 0)
            _gid_x126 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y126) * input_stride + _gid_x126);
        int _gid_x127 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y127 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y127 >= input_height)
            _gid_y127 = input_height - 1;
        if (_gid_x127 < 0)
            _gid_x127 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y127) * input_stride + _gid_x127);
        int _gid_x128 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y128 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y128 >= input_height)
            _gid_y128 = input_height - 1;
        if (_gid_x128 < 0)
            _gid_x128 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y128) * input_stride + _gid_x128);
        int _gid_x129 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y129 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y129 >= input_height)
            _gid_y129 = input_height - 1;
        if (_gid_x129 < 0)
            _gid_x129 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y129) * input_stride + _gid_x129);
        int _gid_x130 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y130 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y130 >= input_height)
            _gid_y130 = input_height - 1;
        if (_gid_x130 < 0)
            _gid_x130 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y130) * input_stride + _gid_x130);
        int _gid_x131 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y131 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y131 >= input_height)
            _gid_y131 = input_height - 1;
        if (_gid_x131 < 0)
            _gid_x131 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y131) * input_stride + _gid_x131);
        int _gid_x132 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y132 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y132 >= input_height)
            _gid_y132 = input_height - 1;
        if (_gid_x132 < 0)
            _gid_x132 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y132) * input_stride + _gid_x132);
        int _gid_x133 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y133 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y133 >= input_height)
            _gid_y133 = input_height - 1;
        if (_gid_x133 < 0)
            _gid_x133 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y133) * input_stride + _gid_x133);
        int _gid_x134 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y134 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y134 >= input_height)
            _gid_y134 = input_height - 1;
        if (_gid_x134 < 0)
            _gid_x134 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y134) * input_stride + _gid_x134);
        int _gid_x135 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y135 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y135 >= input_height)
            _gid_y135 = input_height - 1;
        if (_gid_x135 < 0)
            _gid_x135 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y135) * input_stride + _gid_x135);
        int _gid_x136 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y136 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y136 >= input_height)
            _gid_y136 = input_height - 1;
        if (_gid_x136 < 0)
            _gid_x136 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y136) * input_stride + _gid_x136);
        int _gid_x137 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y137 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y137 >= input_height)
            _gid_y137 = input_height - 1;
        if (_gid_x137 < 0)
            _gid_x137 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y137) * input_stride + _gid_x137);
        int _gid_x138 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y138 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y138 >= input_height)
            _gid_y138 = input_height - 1;
        if (_gid_x138 < 0)
            _gid_x138 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y138) * input_stride + _gid_x138);
        int _gid_x139 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y139 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y139 >= input_height)
            _gid_y139 = input_height - 1;
        if (_gid_x139 < 0)
            _gid_x139 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y139) * input_stride + _gid_x139);
        int _gid_x140 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y140 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y140 >= input_height)
            _gid_y140 = input_height - 1;
        if (_gid_x140 < 0)
            _gid_x140 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y140) * input_stride + _gid_x140);
        int _gid_x141 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y141 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y141 >= input_height)
            _gid_y141 = input_height - 1;
        if (_gid_x141 < 0)
            _gid_x141 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y141) * input_stride + _gid_x141);
        int _gid_x142 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y142 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y142 >= input_height)
            _gid_y142 = input_height - 1;
        if (_gid_x142 < 0)
            _gid_x142 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y142) * input_stride + _gid_x142);
        int _gid_x143 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y143 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y143 >= input_height)
            _gid_y143 = input_height - 1;
        if (_gid_x143 < 0)
            _gid_x143 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y143) * input_stride + _gid_x143);
        int _gid_x144 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y144 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y144 >= input_height)
            _gid_y144 = input_height - 1;
        if (_gid_x144 < 0)
            _gid_x144 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y144) * input_stride + _gid_x144);
        int _gid_x145 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y145 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y145 >= input_height)
            _gid_y145 = input_height - 1;
        if (_gid_x145 < 0)
            _gid_x145 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y145) * input_stride + _gid_x145);
        int _gid_x146 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y146 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y146 >= input_height)
            _gid_y146 = input_height - 1;
        if (_gid_x146 < 0)
            _gid_x146 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y146) * input_stride + _gid_x146);
        int _gid_x147 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y147 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y147 >= input_height)
            _gid_y147 = input_height - 1;
        if (_gid_x147 < 0)
            _gid_x147 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y147) * input_stride + _gid_x147);
        int _gid_x148 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y148 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y148 >= input_height)
            _gid_y148 = input_height - 1;
        if (_gid_x148 < 0)
            _gid_x148 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y148) * input_stride + _gid_x148);
        int _gid_x149 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y149 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y149 >= input_height)
            _gid_y149 = input_height - 1;
        if (_gid_x149 < 0)
            _gid_x149 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y149) * input_stride + _gid_x149);
        __syncthreads();
        if (gid_y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
    }
    goto BH_EXIT;
  BH_BR:
    {
        int _gid_x150 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y150 = gid_y + (-2);
        if (_gid_x150 >= input_width)
            _gid_x150 = input_width - 1;
        if (_gid_y150 >= input_height)
            _gid_y150 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y150) * input_stride + _gid_x150);
        int _gid_x151 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y151 = gid_y + (-2);
        if (_gid_x151 >= input_width)
            _gid_x151 = input_width - 1;
        if (_gid_y151 >= input_height)
            _gid_y151 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y151) * input_stride + _gid_x151);
        int _gid_x152 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y152 = gid_y + (-2);
        if (_gid_x152 >= input_width)
            _gid_x152 = input_width - 1;
        if (_gid_y152 >= input_height)
            _gid_y152 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y152) * input_stride + _gid_x152);
        int _gid_x153 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y153 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x153 >= input_width)
            _gid_x153 = input_width - 1;
        if (_gid_y153 >= input_height)
            _gid_y153 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y153) * input_stride + _gid_x153);
        int _gid_x154 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y154 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x154 >= input_width)
            _gid_x154 = input_width - 1;
        if (_gid_y154 >= input_height)
            _gid_y154 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y154) * input_stride + _gid_x154);
        int _gid_x155 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y155 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x155 >= input_width)
            _gid_x155 = input_width - 1;
        if (_gid_y155 >= input_height)
            _gid_y155 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y155) * input_stride + _gid_x155);
        int _gid_x156 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y156 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x156 >= input_width)
            _gid_x156 = input_width - 1;
        if (_gid_y156 >= input_height)
            _gid_y156 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y156) * input_stride + _gid_x156);
        int _gid_x157 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y157 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x157 >= input_width)
            _gid_x157 = input_width - 1;
        if (_gid_y157 >= input_height)
            _gid_y157 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y157) * input_stride + _gid_x157);
        int _gid_x158 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y158 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x158 >= input_width)
            _gid_x158 = input_width - 1;
        if (_gid_y158 >= input_height)
            _gid_y158 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y158) * input_stride + _gid_x158);
        int _gid_x159 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y159 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x159 >= input_width)
            _gid_x159 = input_width - 1;
        if (_gid_y159 >= input_height)
            _gid_y159 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y159) * input_stride + _gid_x159);
        int _gid_x160 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y160 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x160 >= input_width)
            _gid_x160 = input_width - 1;
        if (_gid_y160 >= input_height)
            _gid_y160 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y160) * input_stride + _gid_x160);
        int _gid_x161 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y161 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x161 >= input_width)
            _gid_x161 = input_width - 1;
        if (_gid_y161 >= input_height)
            _gid_y161 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y161) * input_stride + _gid_x161);
        int _gid_x162 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y162 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x162 >= input_width)
            _gid_x162 = input_width - 1;
        if (_gid_y162 >= input_height)
            _gid_y162 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y162) * input_stride + _gid_x162);
        int _gid_x163 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y163 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x163 >= input_width)
            _gid_x163 = input_width - 1;
        if (_gid_y163 >= input_height)
            _gid_y163 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y163) * input_stride + _gid_x163);
        int _gid_x164 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y164 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x164 >= input_width)
            _gid_x164 = input_width - 1;
        if (_gid_y164 >= input_height)
            _gid_y164 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y164) * input_stride + _gid_x164);
        int _gid_x165 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y165 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x165 >= input_width)
            _gid_x165 = input_width - 1;
        if (_gid_y165 >= input_height)
            _gid_y165 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y165) * input_stride + _gid_x165);
        int _gid_x166 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y166 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x166 >= input_width)
            _gid_x166 = input_width - 1;
        if (_gid_y166 >= input_height)
            _gid_y166 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y166) * input_stride + _gid_x166);
        int _gid_x167 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y167 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x167 >= input_width)
            _gid_x167 = input_width - 1;
        if (_gid_y167 >= input_height)
            _gid_y167 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y167) * input_stride + _gid_x167);
        int _gid_x168 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y168 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x168 >= input_width)
            _gid_x168 = input_width - 1;
        if (_gid_y168 >= input_height)
            _gid_y168 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y168) * input_stride + _gid_x168);
        int _gid_x169 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y169 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x169 >= input_width)
            _gid_x169 = input_width - 1;
        if (_gid_y169 >= input_height)
            _gid_y169 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y169) * input_stride + _gid_x169);
        int _gid_x170 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y170 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x170 >= input_width)
            _gid_x170 = input_width - 1;
        if (_gid_y170 >= input_height)
            _gid_y170 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y170) * input_stride + _gid_x170);
        int _gid_x171 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y171 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x171 >= input_width)
            _gid_x171 = input_width - 1;
        if (_gid_y171 >= input_height)
            _gid_y171 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y171) * input_stride + _gid_x171);
        int _gid_x172 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y172 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x172 >= input_width)
            _gid_x172 = input_width - 1;
        if (_gid_y172 >= input_height)
            _gid_y172 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y172) * input_stride + _gid_x172);
        int _gid_x173 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y173 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x173 >= input_width)
            _gid_x173 = input_width - 1;
        if (_gid_y173 >= input_height)
            _gid_y173 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y173) * input_stride + _gid_x173);
        int _gid_x174 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y174 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x174 >= input_width)
            _gid_x174 = input_width - 1;
        if (_gid_y174 >= input_height)
            _gid_y174 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y174) * input_stride + _gid_x174);
        int _gid_x175 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y175 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x175 >= input_width)
            _gid_x175 = input_width - 1;
        if (_gid_y175 >= input_height)
            _gid_y175 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y175) * input_stride + _gid_x175);
        int _gid_x176 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y176 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x176 >= input_width)
            _gid_x176 = input_width - 1;
        if (_gid_y176 >= input_height)
            _gid_y176 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y176) * input_stride + _gid_x176);
        int _gid_x177 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y177 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x177 >= input_width)
            _gid_x177 = input_width - 1;
        if (_gid_y177 >= input_height)
            _gid_y177 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y177) * input_stride + _gid_x177);
        int _gid_x178 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y178 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x178 >= input_width)
            _gid_x178 = input_width - 1;
        if (_gid_y178 >= input_height)
            _gid_y178 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y178) * input_stride + _gid_x178);
        int _gid_x179 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y179 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x179 >= input_width)
            _gid_x179 = input_width - 1;
        if (_gid_y179 >= input_height)
            _gid_y179 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y179) * input_stride + _gid_x179);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        int _gid_x180 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y180 = gid_y + (-2);
        if (_gid_y180 >= input_height)
            _gid_y180 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y180) * input_stride + _gid_x180);
        int _gid_x181 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y181 = gid_y + (-2);
        if (_gid_y181 >= input_height)
            _gid_y181 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y181) * input_stride + _gid_x181);
        int _gid_x182 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y182 = gid_y + (-2);
        if (_gid_y182 >= input_height)
            _gid_y182 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y182) * input_stride + _gid_x182);
        int _gid_x183 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y183 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y183 >= input_height)
            _gid_y183 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y183) * input_stride + _gid_x183);
        int _gid_x184 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y184 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y184 >= input_height)
            _gid_y184 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y184) * input_stride + _gid_x184);
        int _gid_x185 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y185 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y185 >= input_height)
            _gid_y185 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y185) * input_stride + _gid_x185);
        int _gid_x186 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y186 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y186 >= input_height)
            _gid_y186 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y186) * input_stride + _gid_x186);
        int _gid_x187 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y187 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y187 >= input_height)
            _gid_y187 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y187) * input_stride + _gid_x187);
        int _gid_x188 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y188 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y188 >= input_height)
            _gid_y188 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y188) * input_stride + _gid_x188);
        int _gid_x189 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y189 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y189 >= input_height)
            _gid_y189 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y189) * input_stride + _gid_x189);
        int _gid_x190 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y190 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y190 >= input_height)
            _gid_y190 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y190) * input_stride + _gid_x190);
        int _gid_x191 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y191 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y191 >= input_height)
            _gid_y191 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y191) * input_stride + _gid_x191);
        int _gid_x192 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y192 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y192 >= input_height)
            _gid_y192 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y192) * input_stride + _gid_x192);
        int _gid_x193 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y193 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y193 >= input_height)
            _gid_y193 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y193) * input_stride + _gid_x193);
        int _gid_x194 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y194 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y194 >= input_height)
            _gid_y194 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y194) * input_stride + _gid_x194);
        int _gid_x195 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y195 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y195 >= input_height)
            _gid_y195 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y195) * input_stride + _gid_x195);
        int _gid_x196 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y196 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y196 >= input_height)
            _gid_y196 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y196) * input_stride + _gid_x196);
        int _gid_x197 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y197 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y197 >= input_height)
            _gid_y197 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y197) * input_stride + _gid_x197);
        int _gid_x198 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y198 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y198 >= input_height)
            _gid_y198 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y198) * input_stride + _gid_x198);
        int _gid_x199 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y199 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y199 >= input_height)
            _gid_y199 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y199) * input_stride + _gid_x199);
        int _gid_x200 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y200 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y200 >= input_height)
            _gid_y200 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y200) * input_stride + _gid_x200);
        int _gid_x201 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y201 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y201 >= input_height)
            _gid_y201 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y201) * input_stride + _gid_x201);
        int _gid_x202 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y202 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y202 >= input_height)
            _gid_y202 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y202) * input_stride + _gid_x202);
        int _gid_x203 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y203 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y203 >= input_height)
            _gid_y203 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y203) * input_stride + _gid_x203);
        int _gid_x204 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y204 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y204 >= input_height)
            _gid_y204 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y204) * input_stride + _gid_x204);
        int _gid_x205 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y205 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y205 >= input_height)
            _gid_y205 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y205) * input_stride + _gid_x205);
        int _gid_x206 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y206 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y206 >= input_height)
            _gid_y206 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y206) * input_stride + _gid_x206);
        int _gid_x207 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y207 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y207 >= input_height)
            _gid_y207 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y207) * input_stride + _gid_x207);
        int _gid_x208 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y208 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y208 >= input_height)
            _gid_y208 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y208) * input_stride + _gid_x208);
        int _gid_x209 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y209 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y209 >= input_height)
            _gid_y209 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y209) * input_stride + _gid_x209);
        __syncthreads();
        if (gid_y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        int _gid_x210 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y210 = gid_y + (-2);
        if (_gid_x210 >= input_width)
            _gid_x210 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y210) * input_stride + _gid_x210);
        int _gid_x211 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y211 = gid_y + (-2);
        if (_gid_x211 >= input_width)
            _gid_x211 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y211) * input_stride + _gid_x211);
        int _gid_x212 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y212 = gid_y + (-2);
        if (_gid_x212 >= input_width)
            _gid_x212 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y212) * input_stride + _gid_x212);
        int _gid_x213 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y213 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x213 >= input_width)
            _gid_x213 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y213) * input_stride + _gid_x213);
        int _gid_x214 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y214 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x214 >= input_width)
            _gid_x214 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y214) * input_stride + _gid_x214);
        int _gid_x215 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y215 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x215 >= input_width)
            _gid_x215 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y215) * input_stride + _gid_x215);
        int _gid_x216 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y216 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x216 >= input_width)
            _gid_x216 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y216) * input_stride + _gid_x216);
        int _gid_x217 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y217 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x217 >= input_width)
            _gid_x217 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y217) * input_stride + _gid_x217);
        int _gid_x218 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y218 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x218 >= input_width)
            _gid_x218 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y218) * input_stride + _gid_x218);
        int _gid_x219 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y219 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x219 >= input_width)
            _gid_x219 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y219) * input_stride + _gid_x219);
        int _gid_x220 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y220 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x220 >= input_width)
            _gid_x220 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y220) * input_stride + _gid_x220);
        int _gid_x221 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y221 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x221 >= input_width)
            _gid_x221 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y221) * input_stride + _gid_x221);
        int _gid_x222 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y222 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x222 >= input_width)
            _gid_x222 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y222) * input_stride + _gid_x222);
        int _gid_x223 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y223 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x223 >= input_width)
            _gid_x223 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y223) * input_stride + _gid_x223);
        int _gid_x224 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y224 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x224 >= input_width)
            _gid_x224 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y224) * input_stride + _gid_x224);
        int _gid_x225 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y225 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x225 >= input_width)
            _gid_x225 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y225) * input_stride + _gid_x225);
        int _gid_x226 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y226 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x226 >= input_width)
            _gid_x226 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y226) * input_stride + _gid_x226);
        int _gid_x227 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y227 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x227 >= input_width)
            _gid_x227 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y227) * input_stride + _gid_x227);
        int _gid_x228 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y228 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x228 >= input_width)
            _gid_x228 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y228) * input_stride + _gid_x228);
        int _gid_x229 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y229 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x229 >= input_width)
            _gid_x229 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y229) * input_stride + _gid_x229);
        int _gid_x230 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y230 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x230 >= input_width)
            _gid_x230 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y230) * input_stride + _gid_x230);
        int _gid_x231 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y231 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x231 >= input_width)
            _gid_x231 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y231) * input_stride + _gid_x231);
        int _gid_x232 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y232 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x232 >= input_width)
            _gid_x232 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y232) * input_stride + _gid_x232);
        int _gid_x233 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y233 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x233 >= input_width)
            _gid_x233 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y233) * input_stride + _gid_x233);
        int _gid_x234 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y234 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x234 >= input_width)
            _gid_x234 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y234) * input_stride + _gid_x234);
        int _gid_x235 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y235 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x235 >= input_width)
            _gid_x235 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y235) * input_stride + _gid_x235);
        int _gid_x236 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y236 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x236 >= input_width)
            _gid_x236 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y236) * input_stride + _gid_x236);
        int _gid_x237 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y237 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x237 >= input_width)
            _gid_x237 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y237) * input_stride + _gid_x237);
        int _gid_x238 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y238 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x238 >= input_width)
            _gid_x238 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y238) * input_stride + _gid_x238);
        int _gid_x239 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y239 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x239 >= input_width)
            _gid_x239 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y239) * input_stride + _gid_x239);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
        if (gid_x < iter_width) {
            {
                const int anchor_x = size_x >> 1;
                const int anchor_y = size_y >> 1;
                float sum = 0.5F;
                for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                    for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                        sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                    }
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
            }
        }
    }
    goto BH_EXIT;
  BH_L:
    {
        int _gid_x240 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y240 = gid_y + (-2);
        if (_gid_x240 < 0)
            _gid_x240 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y240) * input_stride + _gid_x240);
        int _gid_x241 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y241 = gid_y + (-2);
        if (_gid_x241 < 0)
            _gid_x241 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y241) * input_stride + _gid_x241);
        int _gid_x242 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y242 = gid_y + (-2);
        if (_gid_x242 < 0)
            _gid_x242 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y242) * input_stride + _gid_x242);
        int _gid_x243 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y243 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x243 < 0)
            _gid_x243 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y243) * input_stride + _gid_x243);
        int _gid_x244 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y244 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x244 < 0)
            _gid_x244 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y244) * input_stride + _gid_x244);
        int _gid_x245 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y245 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x245 < 0)
            _gid_x245 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y245) * input_stride + _gid_x245);
        int _gid_x246 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y246 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x246 < 0)
            _gid_x246 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y246) * input_stride + _gid_x246);
        int _gid_x247 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y247 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x247 < 0)
            _gid_x247 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y247) * input_stride + _gid_x247);
        int _gid_x248 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y248 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x248 < 0)
            _gid_x248 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y248) * input_stride + _gid_x248);
        int _gid_x249 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y249 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x249 < 0)
            _gid_x249 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y249) * input_stride + _gid_x249);
        int _gid_x250 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y250 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x250 < 0)
            _gid_x250 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y250) * input_stride + _gid_x250);
        int _gid_x251 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y251 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x251 < 0)
            _gid_x251 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y251) * input_stride + _gid_x251);
        int _gid_x252 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y252 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x252 < 0)
            _gid_x252 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y252) * input_stride + _gid_x252);
        int _gid_x253 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y253 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x253 < 0)
            _gid_x253 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y253) * input_stride + _gid_x253);
        int _gid_x254 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y254 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x254 < 0)
            _gid_x254 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y254) * input_stride + _gid_x254);
        int _gid_x255 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y255 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x255 < 0)
            _gid_x255 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y255) * input_stride + _gid_x255);
        int _gid_x256 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y256 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x256 < 0)
            _gid_x256 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y256) * input_stride + _gid_x256);
        int _gid_x257 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y257 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x257 < 0)
            _gid_x257 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y257) * input_stride + _gid_x257);
        int _gid_x258 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y258 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x258 < 0)
            _gid_x258 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y258) * input_stride + _gid_x258);
        int _gid_x259 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y259 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x259 < 0)
            _gid_x259 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y259) * input_stride + _gid_x259);
        int _gid_x260 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y260 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x260 < 0)
            _gid_x260 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y260) * input_stride + _gid_x260);
        int _gid_x261 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y261 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x261 < 0)
            _gid_x261 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y261) * input_stride + _gid_x261);
        int _gid_x262 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y262 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x262 < 0)
            _gid_x262 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y262) * input_stride + _gid_x262);
        int _gid_x263 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y263 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x263 < 0)
            _gid_x263 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y263) * input_stride + _gid_x263);
        int _gid_x264 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y264 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x264 < 0)
            _gid_x264 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y264) * input_stride + _gid_x264);
        int _gid_x265 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y265 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x265 < 0)
            _gid_x265 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y265) * input_stride + _gid_x265);
        int _gid_x266 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y266 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x266 < 0)
            _gid_x266 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y266) * input_stride + _gid_x266);
        int _gid_x267 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y267 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x267 < 0)
            _gid_x267 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y267) * input_stride + _gid_x267);
        int _gid_x268 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y268 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x268 < 0)
            _gid_x268 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y268) * input_stride + _gid_x268);
        int _gid_x269 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y269 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x269 < 0)
            _gid_x269 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y269) * input_stride + _gid_x269);
        __syncthreads();
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 1 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 1 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 1 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 2 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 2 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 2 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 3 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 3 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 3 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 4 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 4 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 4 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 5 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 5 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 5 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 6 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 6 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 6 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 7 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 7 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 7 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 8 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 8 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 8 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 9 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 9 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 9 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        __syncthreads();
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
        {
            const int anchor_x = size_x >> 1;
            const int anchor_y = size_y >> 1;
            float sum = 0.5F;
            for (int yf = -anchor_y; yf <= anchor_y; ++yf) {
                for (int xf = -anchor_x; xf <= anchor_x; ++xf) {
                    sum += _constmaskXY[yf + 2][xf + 2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + yf + 2][(int)threadIdx.x + xf + 32];
                }
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)sum;
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERXY_CU_

