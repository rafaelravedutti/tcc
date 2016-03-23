#ifndef _CUGAUSSIANFILTERXY_CU_
#define _CUGAUSSIANFILTERXY_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<uchar, cudaTextureType1D, cudaReadModeElementType> _texinputXY;
const textureReference *_texinputXYRef;

extern "C" {
__global__ __launch_bounds__ (32*1) void cuGaussianFilterXYKernel(uchar * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int bh_start_left, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
    uchar _smeminput[12][97] __attribute__((shared));
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
        int _gid_x30 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y30 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x30 >= input_width)
            _gid_x30 = input_width - 1;
        if (_gid_y30 >= input_height)
            _gid_y30 = input_height - 1;
        if (_gid_x30 < 0)
            _gid_x30 = 0;
        if (_gid_y30 < 0)
            _gid_y30 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y30) * input_stride + _gid_x30);
        int _gid_x31 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y31 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x31 >= input_width)
            _gid_x31 = input_width - 1;
        if (_gid_y31 >= input_height)
            _gid_y31 = input_height - 1;
        if (_gid_x31 < 0)
            _gid_x31 = 0;
        if (_gid_y31 < 0)
            _gid_y31 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y31) * input_stride + _gid_x31);
        int _gid_x32 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y32 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x32 >= input_width)
            _gid_x32 = input_width - 1;
        if (_gid_y32 >= input_height)
            _gid_y32 = input_height - 1;
        if (_gid_x32 < 0)
            _gid_x32 = 0;
        if (_gid_y32 < 0)
            _gid_y32 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y32) * input_stride + _gid_x32);
        int _gid_x33 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y33 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x33 >= input_width)
            _gid_x33 = input_width - 1;
        if (_gid_y33 >= input_height)
            _gid_y33 = input_height - 1;
        if (_gid_x33 < 0)
            _gid_x33 = 0;
        if (_gid_y33 < 0)
            _gid_y33 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y33) * input_stride + _gid_x33);
        int _gid_x34 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y34 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x34 >= input_width)
            _gid_x34 = input_width - 1;
        if (_gid_y34 >= input_height)
            _gid_y34 = input_height - 1;
        if (_gid_x34 < 0)
            _gid_x34 = 0;
        if (_gid_y34 < 0)
            _gid_y34 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y34) * input_stride + _gid_x34);
        int _gid_x35 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y35 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x35 >= input_width)
            _gid_x35 = input_width - 1;
        if (_gid_y35 >= input_height)
            _gid_y35 = input_height - 1;
        if (_gid_x35 < 0)
            _gid_x35 = 0;
        if (_gid_y35 < 0)
            _gid_y35 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y35) * input_stride + _gid_x35);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp36 = 0.F;
                {
                    _tmp36 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp36 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp36 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp36 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp36 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp36 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp36 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp36 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp36 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp36 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp36 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp36 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp36 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp36 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp36 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp36 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp36 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp36 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp36 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp37 = 0.F;
                {
                    _tmp37 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp37 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp37 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp37 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp37 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp37 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp37 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp37 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp37 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp37 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp37 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp37 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp37 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp37 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp37 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp37 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp37 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp37 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp37 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp38 = 0.F;
                {
                    _tmp38 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp38 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp38 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp38 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp38 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp38 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp38 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp38 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp38 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp38 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp38 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp38 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp38 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp38 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp38 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp38 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp38 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp38 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp38 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp39 = 0.F;
                {
                    _tmp39 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp39 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp39 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp39 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp39 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp39 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp39 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp39 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp39 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp39 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp39 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp39 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp39 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp39 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp39 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp39 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp39 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp39 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp39 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp40 = 0.F;
                {
                    _tmp40 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp40 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp40 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp40 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp40 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp40 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp40 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp40 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp40 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp40 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp40 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp40 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp40 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp40 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp40 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp40 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp40 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp40 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp40 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp41 = 0.F;
                {
                    _tmp41 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp41 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp41 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp41 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp41 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp41 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp41 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp41 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp41 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp41 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp41 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp41 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp41 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp41 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp41 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp41 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp41 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp41 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp41 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp42 = 0.F;
                {
                    _tmp42 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp42 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp43 = 0.F;
                {
                    _tmp43 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp43 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_TL:
    {
        int _gid_x44 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y44 = gid_y + (-2);
        if (_gid_x44 < 0)
            _gid_x44 = 0;
        if (_gid_y44 < 0)
            _gid_y44 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y44) * input_stride + _gid_x44);
        int _gid_x45 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y45 = gid_y + (-2);
        if (_gid_x45 < 0)
            _gid_x45 = 0;
        if (_gid_y45 < 0)
            _gid_y45 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y45) * input_stride + _gid_x45);
        int _gid_x46 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y46 = gid_y + (-2);
        if (_gid_x46 < 0)
            _gid_x46 = 0;
        if (_gid_y46 < 0)
            _gid_y46 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y46) * input_stride + _gid_x46);
        int _gid_x47 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y47 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x47 < 0)
            _gid_x47 = 0;
        if (_gid_y47 < 0)
            _gid_y47 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y47) * input_stride + _gid_x47);
        int _gid_x48 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y48 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x48 < 0)
            _gid_x48 = 0;
        if (_gid_y48 < 0)
            _gid_y48 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y48) * input_stride + _gid_x48);
        int _gid_x49 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y49 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x49 < 0)
            _gid_x49 = 0;
        if (_gid_y49 < 0)
            _gid_y49 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y49) * input_stride + _gid_x49);
        int _gid_x50 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y50 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x50 < 0)
            _gid_x50 = 0;
        if (_gid_y50 < 0)
            _gid_y50 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y50) * input_stride + _gid_x50);
        int _gid_x51 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y51 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x51 < 0)
            _gid_x51 = 0;
        if (_gid_y51 < 0)
            _gid_y51 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y51) * input_stride + _gid_x51);
        int _gid_x52 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y52 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x52 < 0)
            _gid_x52 = 0;
        if (_gid_y52 < 0)
            _gid_y52 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y52) * input_stride + _gid_x52);
        int _gid_x53 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y53 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x53 < 0)
            _gid_x53 = 0;
        if (_gid_y53 < 0)
            _gid_y53 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y53) * input_stride + _gid_x53);
        int _gid_x54 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y54 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x54 < 0)
            _gid_x54 = 0;
        if (_gid_y54 < 0)
            _gid_y54 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y54) * input_stride + _gid_x54);
        int _gid_x55 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y55 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x55 < 0)
            _gid_x55 = 0;
        if (_gid_y55 < 0)
            _gid_y55 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y55) * input_stride + _gid_x55);
        int _gid_x56 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y56 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x56 < 0)
            _gid_x56 = 0;
        if (_gid_y56 < 0)
            _gid_y56 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y56) * input_stride + _gid_x56);
        int _gid_x57 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y57 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x57 < 0)
            _gid_x57 = 0;
        if (_gid_y57 < 0)
            _gid_y57 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y57) * input_stride + _gid_x57);
        int _gid_x58 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y58 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x58 < 0)
            _gid_x58 = 0;
        if (_gid_y58 < 0)
            _gid_y58 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y58) * input_stride + _gid_x58);
        int _gid_x59 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y59 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x59 < 0)
            _gid_x59 = 0;
        if (_gid_y59 < 0)
            _gid_y59 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y59) * input_stride + _gid_x59);
        int _gid_x60 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y60 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x60 < 0)
            _gid_x60 = 0;
        if (_gid_y60 < 0)
            _gid_y60 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y60) * input_stride + _gid_x60);
        int _gid_x61 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y61 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x61 < 0)
            _gid_x61 = 0;
        if (_gid_y61 < 0)
            _gid_y61 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y61) * input_stride + _gid_x61);
        int _gid_x62 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y62 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x62 < 0)
            _gid_x62 = 0;
        if (_gid_y62 < 0)
            _gid_y62 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y62) * input_stride + _gid_x62);
        int _gid_x63 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y63 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x63 < 0)
            _gid_x63 = 0;
        if (_gid_y63 < 0)
            _gid_y63 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y63) * input_stride + _gid_x63);
        int _gid_x64 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y64 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x64 < 0)
            _gid_x64 = 0;
        if (_gid_y64 < 0)
            _gid_y64 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y64) * input_stride + _gid_x64);
        int _gid_x65 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y65 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x65 < 0)
            _gid_x65 = 0;
        if (_gid_y65 < 0)
            _gid_y65 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y65) * input_stride + _gid_x65);
        int _gid_x66 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y66 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x66 < 0)
            _gid_x66 = 0;
        if (_gid_y66 < 0)
            _gid_y66 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y66) * input_stride + _gid_x66);
        int _gid_x67 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y67 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x67 < 0)
            _gid_x67 = 0;
        if (_gid_y67 < 0)
            _gid_y67 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y67) * input_stride + _gid_x67);
        int _gid_x68 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y68 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x68 < 0)
            _gid_x68 = 0;
        if (_gid_y68 < 0)
            _gid_y68 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y68) * input_stride + _gid_x68);
        int _gid_x69 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y69 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x69 < 0)
            _gid_x69 = 0;
        if (_gid_y69 < 0)
            _gid_y69 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y69) * input_stride + _gid_x69);
        int _gid_x70 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y70 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x70 < 0)
            _gid_x70 = 0;
        if (_gid_y70 < 0)
            _gid_y70 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y70) * input_stride + _gid_x70);
        int _gid_x71 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y71 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x71 < 0)
            _gid_x71 = 0;
        if (_gid_y71 < 0)
            _gid_y71 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y71) * input_stride + _gid_x71);
        int _gid_x72 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y72 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x72 < 0)
            _gid_x72 = 0;
        if (_gid_y72 < 0)
            _gid_y72 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y72) * input_stride + _gid_x72);
        int _gid_x73 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y73 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x73 < 0)
            _gid_x73 = 0;
        if (_gid_y73 < 0)
            _gid_y73 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y73) * input_stride + _gid_x73);
        int _gid_x74 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y74 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x74 < 0)
            _gid_x74 = 0;
        if (_gid_y74 < 0)
            _gid_y74 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y74) * input_stride + _gid_x74);
        int _gid_x75 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y75 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x75 < 0)
            _gid_x75 = 0;
        if (_gid_y75 < 0)
            _gid_y75 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y75) * input_stride + _gid_x75);
        int _gid_x76 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y76 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x76 < 0)
            _gid_x76 = 0;
        if (_gid_y76 < 0)
            _gid_y76 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y76) * input_stride + _gid_x76);
        int _gid_x77 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y77 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x77 < 0)
            _gid_x77 = 0;
        if (_gid_y77 < 0)
            _gid_y77 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y77) * input_stride + _gid_x77);
        int _gid_x78 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y78 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x78 < 0)
            _gid_x78 = 0;
        if (_gid_y78 < 0)
            _gid_y78 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y78) * input_stride + _gid_x78);
        int _gid_x79 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y79 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x79 < 0)
            _gid_x79 = 0;
        if (_gid_y79 < 0)
            _gid_y79 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y79) * input_stride + _gid_x79);
        __syncthreads();
        {
            float _tmp80 = 0.F;
            {
                _tmp80 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp80 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp80 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp80 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp80 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp80 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp80 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp80 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp80 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp80 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp80 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp80 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp80 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp80 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp80 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp80 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp80 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp80 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp80 + 0.5F);
        }
        {
            float _tmp81 = 0.F;
            {
                _tmp81 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp81 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp81 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp81 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp81 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp81 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp81 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp81 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp81 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp81 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp81 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp81 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp81 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp81 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp81 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp81 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp81 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp81 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp81 + 0.5F);
        }
        {
            float _tmp82 = 0.F;
            {
                _tmp82 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp82 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp82 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp82 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp82 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp82 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp82 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp82 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp82 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp82 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp82 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp82 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp82 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp82 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp82 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp82 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp82 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp82 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp82 + 0.5F);
        }
        {
            float _tmp83 = 0.F;
            {
                _tmp83 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp83 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp83 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp83 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp83 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp83 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp83 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp83 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp83 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp83 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp83 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp83 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp83 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp83 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp83 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp83 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp83 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp83 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp83 + 0.5F);
        }
        {
            float _tmp84 = 0.F;
            {
                _tmp84 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp84 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp84 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp84 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp84 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp84 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp84 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp84 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp84 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp84 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp84 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp84 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp84 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp84 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp84 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp84 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp84 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp84 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp84 + 0.5F);
        }
        {
            float _tmp85 = 0.F;
            {
                _tmp85 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp85 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp85 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp85 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp85 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp85 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp85 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp85 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp85 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp85 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp85 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp85 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp85 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp85 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp85 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp85 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp85 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp85 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp85 + 0.5F);
        }
        {
            float _tmp86 = 0.F;
            {
                _tmp86 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp86 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp86 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp86 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp86 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp86 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp86 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp86 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp86 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp86 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp86 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp86 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp86 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp86 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp86 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp86 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp86 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp86 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp86 + 0.5F);
        }
        {
            float _tmp87 = 0.F;
            {
                _tmp87 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp87 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp87 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp87 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp87 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp87 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp87 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp87 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp87 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp87 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp87 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp87 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp87 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp87 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp87 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp87 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp87 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp87 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp87 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_TR:
    {
        int _gid_x88 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y88 = gid_y + (-2);
        if (_gid_x88 >= input_width)
            _gid_x88 = input_width - 1;
        if (_gid_y88 < 0)
            _gid_y88 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y88) * input_stride + _gid_x88);
        int _gid_x89 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y89 = gid_y + (-2);
        if (_gid_x89 >= input_width)
            _gid_x89 = input_width - 1;
        if (_gid_y89 < 0)
            _gid_y89 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y89) * input_stride + _gid_x89);
        int _gid_x90 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y90 = gid_y + (-2);
        if (_gid_x90 >= input_width)
            _gid_x90 = input_width - 1;
        if (_gid_y90 < 0)
            _gid_y90 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y90) * input_stride + _gid_x90);
        int _gid_x91 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y91 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x91 >= input_width)
            _gid_x91 = input_width - 1;
        if (_gid_y91 < 0)
            _gid_y91 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y91) * input_stride + _gid_x91);
        int _gid_x92 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y92 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x92 >= input_width)
            _gid_x92 = input_width - 1;
        if (_gid_y92 < 0)
            _gid_y92 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y92) * input_stride + _gid_x92);
        int _gid_x93 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y93 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x93 >= input_width)
            _gid_x93 = input_width - 1;
        if (_gid_y93 < 0)
            _gid_y93 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y93) * input_stride + _gid_x93);
        int _gid_x94 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y94 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x94 >= input_width)
            _gid_x94 = input_width - 1;
        if (_gid_y94 < 0)
            _gid_y94 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y94) * input_stride + _gid_x94);
        int _gid_x95 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y95 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x95 >= input_width)
            _gid_x95 = input_width - 1;
        if (_gid_y95 < 0)
            _gid_y95 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y95) * input_stride + _gid_x95);
        int _gid_x96 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y96 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x96 >= input_width)
            _gid_x96 = input_width - 1;
        if (_gid_y96 < 0)
            _gid_y96 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y96) * input_stride + _gid_x96);
        int _gid_x97 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y97 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x97 >= input_width)
            _gid_x97 = input_width - 1;
        if (_gid_y97 < 0)
            _gid_y97 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y97) * input_stride + _gid_x97);
        int _gid_x98 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y98 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x98 >= input_width)
            _gid_x98 = input_width - 1;
        if (_gid_y98 < 0)
            _gid_y98 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y98) * input_stride + _gid_x98);
        int _gid_x99 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y99 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x99 >= input_width)
            _gid_x99 = input_width - 1;
        if (_gid_y99 < 0)
            _gid_y99 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y99) * input_stride + _gid_x99);
        int _gid_x100 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y100 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x100 >= input_width)
            _gid_x100 = input_width - 1;
        if (_gid_y100 < 0)
            _gid_y100 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y100) * input_stride + _gid_x100);
        int _gid_x101 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y101 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x101 >= input_width)
            _gid_x101 = input_width - 1;
        if (_gid_y101 < 0)
            _gid_y101 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y101) * input_stride + _gid_x101);
        int _gid_x102 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y102 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x102 >= input_width)
            _gid_x102 = input_width - 1;
        if (_gid_y102 < 0)
            _gid_y102 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y102) * input_stride + _gid_x102);
        int _gid_x103 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y103 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x103 >= input_width)
            _gid_x103 = input_width - 1;
        if (_gid_y103 < 0)
            _gid_y103 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y103) * input_stride + _gid_x103);
        int _gid_x104 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y104 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x104 >= input_width)
            _gid_x104 = input_width - 1;
        if (_gid_y104 < 0)
            _gid_y104 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y104) * input_stride + _gid_x104);
        int _gid_x105 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y105 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x105 >= input_width)
            _gid_x105 = input_width - 1;
        if (_gid_y105 < 0)
            _gid_y105 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y105) * input_stride + _gid_x105);
        int _gid_x106 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y106 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x106 >= input_width)
            _gid_x106 = input_width - 1;
        if (_gid_y106 < 0)
            _gid_y106 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y106) * input_stride + _gid_x106);
        int _gid_x107 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y107 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x107 >= input_width)
            _gid_x107 = input_width - 1;
        if (_gid_y107 < 0)
            _gid_y107 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y107) * input_stride + _gid_x107);
        int _gid_x108 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y108 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x108 >= input_width)
            _gid_x108 = input_width - 1;
        if (_gid_y108 < 0)
            _gid_y108 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y108) * input_stride + _gid_x108);
        int _gid_x109 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y109 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x109 >= input_width)
            _gid_x109 = input_width - 1;
        if (_gid_y109 < 0)
            _gid_y109 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y109) * input_stride + _gid_x109);
        int _gid_x110 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y110 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x110 >= input_width)
            _gid_x110 = input_width - 1;
        if (_gid_y110 < 0)
            _gid_y110 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y110) * input_stride + _gid_x110);
        int _gid_x111 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y111 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x111 >= input_width)
            _gid_x111 = input_width - 1;
        if (_gid_y111 < 0)
            _gid_y111 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y111) * input_stride + _gid_x111);
        int _gid_x112 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y112 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x112 >= input_width)
            _gid_x112 = input_width - 1;
        if (_gid_y112 < 0)
            _gid_y112 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y112) * input_stride + _gid_x112);
        int _gid_x113 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y113 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x113 >= input_width)
            _gid_x113 = input_width - 1;
        if (_gid_y113 < 0)
            _gid_y113 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y113) * input_stride + _gid_x113);
        int _gid_x114 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y114 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x114 >= input_width)
            _gid_x114 = input_width - 1;
        if (_gid_y114 < 0)
            _gid_y114 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y114) * input_stride + _gid_x114);
        int _gid_x115 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y115 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x115 >= input_width)
            _gid_x115 = input_width - 1;
        if (_gid_y115 < 0)
            _gid_y115 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y115) * input_stride + _gid_x115);
        int _gid_x116 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y116 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x116 >= input_width)
            _gid_x116 = input_width - 1;
        if (_gid_y116 < 0)
            _gid_y116 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y116) * input_stride + _gid_x116);
        int _gid_x117 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y117 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x117 >= input_width)
            _gid_x117 = input_width - 1;
        if (_gid_y117 < 0)
            _gid_y117 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y117) * input_stride + _gid_x117);
        int _gid_x118 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y118 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x118 >= input_width)
            _gid_x118 = input_width - 1;
        if (_gid_y118 < 0)
            _gid_y118 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y118) * input_stride + _gid_x118);
        int _gid_x119 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y119 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x119 >= input_width)
            _gid_x119 = input_width - 1;
        if (_gid_y119 < 0)
            _gid_y119 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y119) * input_stride + _gid_x119);
        int _gid_x120 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y120 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x120 >= input_width)
            _gid_x120 = input_width - 1;
        if (_gid_y120 < 0)
            _gid_y120 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y120) * input_stride + _gid_x120);
        int _gid_x121 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y121 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x121 >= input_width)
            _gid_x121 = input_width - 1;
        if (_gid_y121 < 0)
            _gid_y121 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y121) * input_stride + _gid_x121);
        int _gid_x122 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y122 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x122 >= input_width)
            _gid_x122 = input_width - 1;
        if (_gid_y122 < 0)
            _gid_y122 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y122) * input_stride + _gid_x122);
        int _gid_x123 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y123 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x123 >= input_width)
            _gid_x123 = input_width - 1;
        if (_gid_y123 < 0)
            _gid_y123 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y123) * input_stride + _gid_x123);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp124 = 0.F;
                {
                    _tmp124 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp124 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp124 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp124 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp124 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp124 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp124 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp124 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp124 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp124 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp124 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp124 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp124 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp124 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp124 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp124 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp124 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp124 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp124 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp125 = 0.F;
                {
                    _tmp125 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp125 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp125 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp125 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp125 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp125 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp125 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp125 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp125 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp125 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp125 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp125 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp125 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp125 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp125 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp125 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp125 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp125 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp125 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp126 = 0.F;
                {
                    _tmp126 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp126 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp126 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp126 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp126 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp126 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp126 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp126 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp126 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp126 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp126 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp126 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp126 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp126 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp126 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp126 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp126 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp126 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp126 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp127 = 0.F;
                {
                    _tmp127 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp127 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp127 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp127 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp127 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp127 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp127 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp127 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp127 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp127 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp127 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp127 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp127 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp127 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp127 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp127 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp127 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp127 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp127 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp128 = 0.F;
                {
                    _tmp128 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp128 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp128 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp128 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp128 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp128 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp128 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp128 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp128 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp128 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp128 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp128 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp128 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp128 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp128 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp128 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp128 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp128 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp128 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp129 = 0.F;
                {
                    _tmp129 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp129 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp129 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp129 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp129 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp129 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp129 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp129 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp129 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp129 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp129 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp129 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp129 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp129 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp129 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp129 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp129 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp129 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp129 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp130 = 0.F;
                {
                    _tmp130 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp130 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp130 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp130 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp130 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp130 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp130 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp130 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp130 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp130 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp130 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp130 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp130 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp130 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp130 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp130 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp130 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp130 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp130 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp131 = 0.F;
                {
                    _tmp131 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp131 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp131 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp131 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp131 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp131 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp131 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp131 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp131 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp131 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp131 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp131 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp131 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp131 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp131 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp131 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp131 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp131 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp131 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        int _gid_x132 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y132 = gid_y + (-2);
        if (_gid_y132 < 0)
            _gid_y132 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y132) * input_stride + _gid_x132);
        int _gid_x133 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y133 = gid_y + (-2);
        if (_gid_y133 < 0)
            _gid_y133 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y133) * input_stride + _gid_x133);
        int _gid_x134 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y134 = gid_y + (-2);
        if (_gid_y134 < 0)
            _gid_y134 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y134) * input_stride + _gid_x134);
        int _gid_x135 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y135 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y135 < 0)
            _gid_y135 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y135) * input_stride + _gid_x135);
        int _gid_x136 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y136 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y136 < 0)
            _gid_y136 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y136) * input_stride + _gid_x136);
        int _gid_x137 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y137 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y137 < 0)
            _gid_y137 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y137) * input_stride + _gid_x137);
        int _gid_x138 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y138 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y138 < 0)
            _gid_y138 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y138) * input_stride + _gid_x138);
        int _gid_x139 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y139 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y139 < 0)
            _gid_y139 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y139) * input_stride + _gid_x139);
        int _gid_x140 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y140 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y140 < 0)
            _gid_y140 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y140) * input_stride + _gid_x140);
        int _gid_x141 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y141 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y141 < 0)
            _gid_y141 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y141) * input_stride + _gid_x141);
        int _gid_x142 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y142 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y142 < 0)
            _gid_y142 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y142) * input_stride + _gid_x142);
        int _gid_x143 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y143 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y143 < 0)
            _gid_y143 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y143) * input_stride + _gid_x143);
        int _gid_x144 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y144 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y144 < 0)
            _gid_y144 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y144) * input_stride + _gid_x144);
        int _gid_x145 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y145 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y145 < 0)
            _gid_y145 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y145) * input_stride + _gid_x145);
        int _gid_x146 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y146 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y146 < 0)
            _gid_y146 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y146) * input_stride + _gid_x146);
        int _gid_x147 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y147 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y147 < 0)
            _gid_y147 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y147) * input_stride + _gid_x147);
        int _gid_x148 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y148 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y148 < 0)
            _gid_y148 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y148) * input_stride + _gid_x148);
        int _gid_x149 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y149 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y149 < 0)
            _gid_y149 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y149) * input_stride + _gid_x149);
        int _gid_x150 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y150 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y150 < 0)
            _gid_y150 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y150) * input_stride + _gid_x150);
        int _gid_x151 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y151 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y151 < 0)
            _gid_y151 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y151) * input_stride + _gid_x151);
        int _gid_x152 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y152 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y152 < 0)
            _gid_y152 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y152) * input_stride + _gid_x152);
        int _gid_x153 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y153 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y153 < 0)
            _gid_y153 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y153) * input_stride + _gid_x153);
        int _gid_x154 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y154 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y154 < 0)
            _gid_y154 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y154) * input_stride + _gid_x154);
        int _gid_x155 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y155 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y155 < 0)
            _gid_y155 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y155) * input_stride + _gid_x155);
        int _gid_x156 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y156 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y156 < 0)
            _gid_y156 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y156) * input_stride + _gid_x156);
        int _gid_x157 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y157 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y157 < 0)
            _gid_y157 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y157) * input_stride + _gid_x157);
        int _gid_x158 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y158 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y158 < 0)
            _gid_y158 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y158) * input_stride + _gid_x158);
        int _gid_x159 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y159 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y159 < 0)
            _gid_y159 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y159) * input_stride + _gid_x159);
        int _gid_x160 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y160 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y160 < 0)
            _gid_y160 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y160) * input_stride + _gid_x160);
        int _gid_x161 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y161 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y161 < 0)
            _gid_y161 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y161) * input_stride + _gid_x161);
        int _gid_x162 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y162 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y162 < 0)
            _gid_y162 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y162) * input_stride + _gid_x162);
        int _gid_x163 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y163 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y163 < 0)
            _gid_y163 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y163) * input_stride + _gid_x163);
        int _gid_x164 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y164 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y164 < 0)
            _gid_y164 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y164) * input_stride + _gid_x164);
        int _gid_x165 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y165 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y165 < 0)
            _gid_y165 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y165) * input_stride + _gid_x165);
        int _gid_x166 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y166 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y166 < 0)
            _gid_y166 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y166) * input_stride + _gid_x166);
        int _gid_x167 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y167 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y167 < 0)
            _gid_y167 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y167) * input_stride + _gid_x167);
        __syncthreads();
        {
            float _tmp168 = 0.F;
            {
                _tmp168 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp168 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp168 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp168 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp168 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp168 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp168 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp168 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp168 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp168 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp168 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp168 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp168 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp168 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp168 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp168 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp168 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp168 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp168 + 0.5F);
        }
        {
            float _tmp169 = 0.F;
            {
                _tmp169 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp169 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp169 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp169 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp169 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp169 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp169 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp169 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp169 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp169 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp169 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp169 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp169 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp169 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp169 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp169 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp169 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp169 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp169 + 0.5F);
        }
        {
            float _tmp170 = 0.F;
            {
                _tmp170 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp170 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp170 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp170 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp170 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp170 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp170 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp170 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp170 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp170 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp170 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp170 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp170 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp170 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp170 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp170 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp170 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp170 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp170 + 0.5F);
        }
        {
            float _tmp171 = 0.F;
            {
                _tmp171 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp171 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp171 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp171 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp171 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp171 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp171 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp171 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp171 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp171 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp171 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp171 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp171 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp171 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp171 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp171 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp171 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp171 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp171 + 0.5F);
        }
        {
            float _tmp172 = 0.F;
            {
                _tmp172 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp172 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp172 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp172 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp172 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp172 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp172 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp172 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp172 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp172 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp172 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp172 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp172 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp172 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp172 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp172 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp172 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp172 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp172 + 0.5F);
        }
        {
            float _tmp173 = 0.F;
            {
                _tmp173 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp173 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp173 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp173 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp173 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp173 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp173 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp173 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp173 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp173 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp173 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp173 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp173 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp173 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp173 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp173 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp173 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp173 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp173 + 0.5F);
        }
        {
            float _tmp174 = 0.F;
            {
                _tmp174 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp174 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp174 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp174 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp174 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp174 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp174 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp174 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp174 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp174 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp174 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp174 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp174 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp174 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp174 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp174 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp174 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp174 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp174 + 0.5F);
        }
        {
            float _tmp175 = 0.F;
            {
                _tmp175 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp175 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp175 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp175 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp175 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp175 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp175 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp175 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp175 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp175 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp175 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp175 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp175 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp175 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp175 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp175 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp175 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp175 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp175 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_BL:
    {
        int _gid_x176 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y176 = gid_y + (-2);
        if (_gid_y176 >= input_height)
            _gid_y176 = input_height - 1;
        if (_gid_x176 < 0)
            _gid_x176 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y176) * input_stride + _gid_x176);
        int _gid_x177 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y177 = gid_y + (-2);
        if (_gid_y177 >= input_height)
            _gid_y177 = input_height - 1;
        if (_gid_x177 < 0)
            _gid_x177 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y177) * input_stride + _gid_x177);
        int _gid_x178 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y178 = gid_y + (-2);
        if (_gid_y178 >= input_height)
            _gid_y178 = input_height - 1;
        if (_gid_x178 < 0)
            _gid_x178 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y178) * input_stride + _gid_x178);
        int _gid_x179 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y179 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y179 >= input_height)
            _gid_y179 = input_height - 1;
        if (_gid_x179 < 0)
            _gid_x179 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y179) * input_stride + _gid_x179);
        int _gid_x180 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y180 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y180 >= input_height)
            _gid_y180 = input_height - 1;
        if (_gid_x180 < 0)
            _gid_x180 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y180) * input_stride + _gid_x180);
        int _gid_x181 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y181 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y181 >= input_height)
            _gid_y181 = input_height - 1;
        if (_gid_x181 < 0)
            _gid_x181 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y181) * input_stride + _gid_x181);
        int _gid_x182 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y182 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y182 >= input_height)
            _gid_y182 = input_height - 1;
        if (_gid_x182 < 0)
            _gid_x182 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y182) * input_stride + _gid_x182);
        int _gid_x183 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y183 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y183 >= input_height)
            _gid_y183 = input_height - 1;
        if (_gid_x183 < 0)
            _gid_x183 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y183) * input_stride + _gid_x183);
        int _gid_x184 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y184 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y184 >= input_height)
            _gid_y184 = input_height - 1;
        if (_gid_x184 < 0)
            _gid_x184 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y184) * input_stride + _gid_x184);
        int _gid_x185 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y185 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y185 >= input_height)
            _gid_y185 = input_height - 1;
        if (_gid_x185 < 0)
            _gid_x185 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y185) * input_stride + _gid_x185);
        int _gid_x186 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y186 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y186 >= input_height)
            _gid_y186 = input_height - 1;
        if (_gid_x186 < 0)
            _gid_x186 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y186) * input_stride + _gid_x186);
        int _gid_x187 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y187 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y187 >= input_height)
            _gid_y187 = input_height - 1;
        if (_gid_x187 < 0)
            _gid_x187 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y187) * input_stride + _gid_x187);
        int _gid_x188 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y188 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y188 >= input_height)
            _gid_y188 = input_height - 1;
        if (_gid_x188 < 0)
            _gid_x188 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y188) * input_stride + _gid_x188);
        int _gid_x189 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y189 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y189 >= input_height)
            _gid_y189 = input_height - 1;
        if (_gid_x189 < 0)
            _gid_x189 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y189) * input_stride + _gid_x189);
        int _gid_x190 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y190 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y190 >= input_height)
            _gid_y190 = input_height - 1;
        if (_gid_x190 < 0)
            _gid_x190 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y190) * input_stride + _gid_x190);
        int _gid_x191 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y191 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y191 >= input_height)
            _gid_y191 = input_height - 1;
        if (_gid_x191 < 0)
            _gid_x191 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y191) * input_stride + _gid_x191);
        int _gid_x192 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y192 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y192 >= input_height)
            _gid_y192 = input_height - 1;
        if (_gid_x192 < 0)
            _gid_x192 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y192) * input_stride + _gid_x192);
        int _gid_x193 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y193 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y193 >= input_height)
            _gid_y193 = input_height - 1;
        if (_gid_x193 < 0)
            _gid_x193 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y193) * input_stride + _gid_x193);
        int _gid_x194 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y194 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y194 >= input_height)
            _gid_y194 = input_height - 1;
        if (_gid_x194 < 0)
            _gid_x194 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y194) * input_stride + _gid_x194);
        int _gid_x195 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y195 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y195 >= input_height)
            _gid_y195 = input_height - 1;
        if (_gid_x195 < 0)
            _gid_x195 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y195) * input_stride + _gid_x195);
        int _gid_x196 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y196 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y196 >= input_height)
            _gid_y196 = input_height - 1;
        if (_gid_x196 < 0)
            _gid_x196 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y196) * input_stride + _gid_x196);
        int _gid_x197 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y197 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y197 >= input_height)
            _gid_y197 = input_height - 1;
        if (_gid_x197 < 0)
            _gid_x197 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y197) * input_stride + _gid_x197);
        int _gid_x198 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y198 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y198 >= input_height)
            _gid_y198 = input_height - 1;
        if (_gid_x198 < 0)
            _gid_x198 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y198) * input_stride + _gid_x198);
        int _gid_x199 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y199 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y199 >= input_height)
            _gid_y199 = input_height - 1;
        if (_gid_x199 < 0)
            _gid_x199 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y199) * input_stride + _gid_x199);
        int _gid_x200 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y200 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y200 >= input_height)
            _gid_y200 = input_height - 1;
        if (_gid_x200 < 0)
            _gid_x200 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y200) * input_stride + _gid_x200);
        int _gid_x201 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y201 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y201 >= input_height)
            _gid_y201 = input_height - 1;
        if (_gid_x201 < 0)
            _gid_x201 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y201) * input_stride + _gid_x201);
        int _gid_x202 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y202 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y202 >= input_height)
            _gid_y202 = input_height - 1;
        if (_gid_x202 < 0)
            _gid_x202 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y202) * input_stride + _gid_x202);
        int _gid_x203 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y203 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y203 >= input_height)
            _gid_y203 = input_height - 1;
        if (_gid_x203 < 0)
            _gid_x203 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y203) * input_stride + _gid_x203);
        int _gid_x204 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y204 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y204 >= input_height)
            _gid_y204 = input_height - 1;
        if (_gid_x204 < 0)
            _gid_x204 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y204) * input_stride + _gid_x204);
        int _gid_x205 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y205 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y205 >= input_height)
            _gid_y205 = input_height - 1;
        if (_gid_x205 < 0)
            _gid_x205 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y205) * input_stride + _gid_x205);
        int _gid_x206 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y206 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y206 >= input_height)
            _gid_y206 = input_height - 1;
        if (_gid_x206 < 0)
            _gid_x206 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y206) * input_stride + _gid_x206);
        int _gid_x207 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y207 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y207 >= input_height)
            _gid_y207 = input_height - 1;
        if (_gid_x207 < 0)
            _gid_x207 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y207) * input_stride + _gid_x207);
        int _gid_x208 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y208 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y208 >= input_height)
            _gid_y208 = input_height - 1;
        if (_gid_x208 < 0)
            _gid_x208 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y208) * input_stride + _gid_x208);
        int _gid_x209 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y209 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y209 >= input_height)
            _gid_y209 = input_height - 1;
        if (_gid_x209 < 0)
            _gid_x209 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y209) * input_stride + _gid_x209);
        int _gid_x210 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y210 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y210 >= input_height)
            _gid_y210 = input_height - 1;
        if (_gid_x210 < 0)
            _gid_x210 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y210) * input_stride + _gid_x210);
        int _gid_x211 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y211 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y211 >= input_height)
            _gid_y211 = input_height - 1;
        if (_gid_x211 < 0)
            _gid_x211 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y211) * input_stride + _gid_x211);
        __syncthreads();
        if (gid_y < iter_height) {
            float _tmp212 = 0.F;
            {
                _tmp212 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp212 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp212 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp212 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp212 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp212 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp212 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp212 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp212 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp212 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp212 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp212 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp212 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp212 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp212 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp212 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp212 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp212 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp212 + 0.5F);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp213 = 0.F;
            {
                _tmp213 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp213 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp213 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp213 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp213 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp213 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp213 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp213 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp213 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp213 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp213 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp213 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp213 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp213 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp213 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp213 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp213 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp213 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp213 + 0.5F);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp214 = 0.F;
            {
                _tmp214 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp214 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp214 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp214 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp214 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp214 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp214 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp214 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp214 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp214 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp214 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp214 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp214 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp214 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp214 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp214 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp214 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp214 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp214 + 0.5F);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp215 = 0.F;
            {
                _tmp215 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp215 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp215 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp215 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp215 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp215 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp215 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp215 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp215 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp215 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp215 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp215 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp215 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp215 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp215 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp215 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp215 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp215 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp215 + 0.5F);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp216 = 0.F;
            {
                _tmp216 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp216 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp216 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp216 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp216 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp216 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp216 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp216 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp216 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp216 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp216 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp216 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp216 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp216 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp216 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp216 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp216 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp216 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp216 + 0.5F);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp217 = 0.F;
            {
                _tmp217 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp217 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp217 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp217 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp217 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp217 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp217 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp217 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp217 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp217 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp217 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp217 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp217 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp217 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp217 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp217 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp217 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp217 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp217 + 0.5F);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp218 = 0.F;
            {
                _tmp218 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp218 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp218 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp218 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp218 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp218 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp218 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp218 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp218 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp218 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp218 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp218 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp218 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp218 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp218 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp218 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp218 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp218 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp218 + 0.5F);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp219 = 0.F;
            {
                _tmp219 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp219 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp219 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp219 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp219 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp219 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp219 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp219 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp219 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp219 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp219 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp219 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp219 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp219 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp219 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp219 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp219 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp219 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp219 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_BR:
    {
        int _gid_x220 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y220 = gid_y + (-2);
        if (_gid_x220 >= input_width)
            _gid_x220 = input_width - 1;
        if (_gid_y220 >= input_height)
            _gid_y220 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y220) * input_stride + _gid_x220);
        int _gid_x221 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y221 = gid_y + (-2);
        if (_gid_x221 >= input_width)
            _gid_x221 = input_width - 1;
        if (_gid_y221 >= input_height)
            _gid_y221 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y221) * input_stride + _gid_x221);
        int _gid_x222 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y222 = gid_y + (-2);
        if (_gid_x222 >= input_width)
            _gid_x222 = input_width - 1;
        if (_gid_y222 >= input_height)
            _gid_y222 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y222) * input_stride + _gid_x222);
        int _gid_x223 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y223 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x223 >= input_width)
            _gid_x223 = input_width - 1;
        if (_gid_y223 >= input_height)
            _gid_y223 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y223) * input_stride + _gid_x223);
        int _gid_x224 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y224 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x224 >= input_width)
            _gid_x224 = input_width - 1;
        if (_gid_y224 >= input_height)
            _gid_y224 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y224) * input_stride + _gid_x224);
        int _gid_x225 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y225 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x225 >= input_width)
            _gid_x225 = input_width - 1;
        if (_gid_y225 >= input_height)
            _gid_y225 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y225) * input_stride + _gid_x225);
        int _gid_x226 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y226 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x226 >= input_width)
            _gid_x226 = input_width - 1;
        if (_gid_y226 >= input_height)
            _gid_y226 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y226) * input_stride + _gid_x226);
        int _gid_x227 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y227 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x227 >= input_width)
            _gid_x227 = input_width - 1;
        if (_gid_y227 >= input_height)
            _gid_y227 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y227) * input_stride + _gid_x227);
        int _gid_x228 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y228 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x228 >= input_width)
            _gid_x228 = input_width - 1;
        if (_gid_y228 >= input_height)
            _gid_y228 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y228) * input_stride + _gid_x228);
        int _gid_x229 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y229 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x229 >= input_width)
            _gid_x229 = input_width - 1;
        if (_gid_y229 >= input_height)
            _gid_y229 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y229) * input_stride + _gid_x229);
        int _gid_x230 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y230 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x230 >= input_width)
            _gid_x230 = input_width - 1;
        if (_gid_y230 >= input_height)
            _gid_y230 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y230) * input_stride + _gid_x230);
        int _gid_x231 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y231 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x231 >= input_width)
            _gid_x231 = input_width - 1;
        if (_gid_y231 >= input_height)
            _gid_y231 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y231) * input_stride + _gid_x231);
        int _gid_x232 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y232 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x232 >= input_width)
            _gid_x232 = input_width - 1;
        if (_gid_y232 >= input_height)
            _gid_y232 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y232) * input_stride + _gid_x232);
        int _gid_x233 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y233 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x233 >= input_width)
            _gid_x233 = input_width - 1;
        if (_gid_y233 >= input_height)
            _gid_y233 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y233) * input_stride + _gid_x233);
        int _gid_x234 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y234 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x234 >= input_width)
            _gid_x234 = input_width - 1;
        if (_gid_y234 >= input_height)
            _gid_y234 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y234) * input_stride + _gid_x234);
        int _gid_x235 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y235 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x235 >= input_width)
            _gid_x235 = input_width - 1;
        if (_gid_y235 >= input_height)
            _gid_y235 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y235) * input_stride + _gid_x235);
        int _gid_x236 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y236 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x236 >= input_width)
            _gid_x236 = input_width - 1;
        if (_gid_y236 >= input_height)
            _gid_y236 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y236) * input_stride + _gid_x236);
        int _gid_x237 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y237 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x237 >= input_width)
            _gid_x237 = input_width - 1;
        if (_gid_y237 >= input_height)
            _gid_y237 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y237) * input_stride + _gid_x237);
        int _gid_x238 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y238 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x238 >= input_width)
            _gid_x238 = input_width - 1;
        if (_gid_y238 >= input_height)
            _gid_y238 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y238) * input_stride + _gid_x238);
        int _gid_x239 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y239 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x239 >= input_width)
            _gid_x239 = input_width - 1;
        if (_gid_y239 >= input_height)
            _gid_y239 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y239) * input_stride + _gid_x239);
        int _gid_x240 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y240 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x240 >= input_width)
            _gid_x240 = input_width - 1;
        if (_gid_y240 >= input_height)
            _gid_y240 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y240) * input_stride + _gid_x240);
        int _gid_x241 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y241 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x241 >= input_width)
            _gid_x241 = input_width - 1;
        if (_gid_y241 >= input_height)
            _gid_y241 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y241) * input_stride + _gid_x241);
        int _gid_x242 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y242 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x242 >= input_width)
            _gid_x242 = input_width - 1;
        if (_gid_y242 >= input_height)
            _gid_y242 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y242) * input_stride + _gid_x242);
        int _gid_x243 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y243 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x243 >= input_width)
            _gid_x243 = input_width - 1;
        if (_gid_y243 >= input_height)
            _gid_y243 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y243) * input_stride + _gid_x243);
        int _gid_x244 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y244 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x244 >= input_width)
            _gid_x244 = input_width - 1;
        if (_gid_y244 >= input_height)
            _gid_y244 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y244) * input_stride + _gid_x244);
        int _gid_x245 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y245 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x245 >= input_width)
            _gid_x245 = input_width - 1;
        if (_gid_y245 >= input_height)
            _gid_y245 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y245) * input_stride + _gid_x245);
        int _gid_x246 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y246 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x246 >= input_width)
            _gid_x246 = input_width - 1;
        if (_gid_y246 >= input_height)
            _gid_y246 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y246) * input_stride + _gid_x246);
        int _gid_x247 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y247 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x247 >= input_width)
            _gid_x247 = input_width - 1;
        if (_gid_y247 >= input_height)
            _gid_y247 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y247) * input_stride + _gid_x247);
        int _gid_x248 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y248 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x248 >= input_width)
            _gid_x248 = input_width - 1;
        if (_gid_y248 >= input_height)
            _gid_y248 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y248) * input_stride + _gid_x248);
        int _gid_x249 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y249 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x249 >= input_width)
            _gid_x249 = input_width - 1;
        if (_gid_y249 >= input_height)
            _gid_y249 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y249) * input_stride + _gid_x249);
        int _gid_x250 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y250 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x250 >= input_width)
            _gid_x250 = input_width - 1;
        if (_gid_y250 >= input_height)
            _gid_y250 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y250) * input_stride + _gid_x250);
        int _gid_x251 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y251 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x251 >= input_width)
            _gid_x251 = input_width - 1;
        if (_gid_y251 >= input_height)
            _gid_y251 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y251) * input_stride + _gid_x251);
        int _gid_x252 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y252 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x252 >= input_width)
            _gid_x252 = input_width - 1;
        if (_gid_y252 >= input_height)
            _gid_y252 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y252) * input_stride + _gid_x252);
        int _gid_x253 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y253 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x253 >= input_width)
            _gid_x253 = input_width - 1;
        if (_gid_y253 >= input_height)
            _gid_y253 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y253) * input_stride + _gid_x253);
        int _gid_x254 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y254 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x254 >= input_width)
            _gid_x254 = input_width - 1;
        if (_gid_y254 >= input_height)
            _gid_y254 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y254) * input_stride + _gid_x254);
        int _gid_x255 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y255 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x255 >= input_width)
            _gid_x255 = input_width - 1;
        if (_gid_y255 >= input_height)
            _gid_y255 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y255) * input_stride + _gid_x255);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp256 = 0.F;
                {
                    _tmp256 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp256 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp256 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp256 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp256 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp256 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp256 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp256 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp256 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp256 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp256 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp256 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp256 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp256 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp256 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp256 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp256 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp256 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp256 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp257 = 0.F;
                {
                    _tmp257 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp257 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp257 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp257 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp257 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp257 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp257 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp257 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp257 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp257 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp257 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp257 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp257 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp257 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp257 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp257 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp257 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp257 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp257 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp258 = 0.F;
                {
                    _tmp258 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp258 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp258 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp258 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp258 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp258 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp258 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp258 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp258 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp258 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp258 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp258 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp258 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp258 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp258 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp258 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp258 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp258 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp258 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp259 = 0.F;
                {
                    _tmp259 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp259 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp259 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp259 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp259 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp259 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp259 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp259 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp259 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp259 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp259 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp259 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp259 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp259 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp259 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp259 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp259 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp259 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp259 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp260 = 0.F;
                {
                    _tmp260 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp260 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp260 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp260 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp260 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp260 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp260 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp260 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp260 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp260 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp260 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp260 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp260 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp260 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp260 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp260 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp260 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp260 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp260 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp261 = 0.F;
                {
                    _tmp261 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp261 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp261 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp261 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp261 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp261 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp261 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp261 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp261 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp261 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp261 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp261 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp261 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp261 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp261 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp261 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp261 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp261 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp261 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp262 = 0.F;
                {
                    _tmp262 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp262 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp262 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp262 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp262 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp262 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp262 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp262 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp262 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp262 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp262 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp262 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp262 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp262 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp262 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp262 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp262 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp262 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp262 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp263 = 0.F;
                {
                    _tmp263 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp263 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp263 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp263 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp263 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp263 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp263 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp263 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp263 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp263 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp263 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp263 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp263 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp263 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp263 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp263 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp263 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp263 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp263 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        int _gid_x264 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y264 = gid_y + (-2);
        if (_gid_y264 >= input_height)
            _gid_y264 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y264) * input_stride + _gid_x264);
        int _gid_x265 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y265 = gid_y + (-2);
        if (_gid_y265 >= input_height)
            _gid_y265 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y265) * input_stride + _gid_x265);
        int _gid_x266 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y266 = gid_y + (-2);
        if (_gid_y266 >= input_height)
            _gid_y266 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y266) * input_stride + _gid_x266);
        int _gid_x267 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y267 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y267 >= input_height)
            _gid_y267 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y267) * input_stride + _gid_x267);
        int _gid_x268 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y268 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y268 >= input_height)
            _gid_y268 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y268) * input_stride + _gid_x268);
        int _gid_x269 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y269 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_y269 >= input_height)
            _gid_y269 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y269) * input_stride + _gid_x269);
        int _gid_x270 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y270 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y270 >= input_height)
            _gid_y270 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y270) * input_stride + _gid_x270);
        int _gid_x271 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y271 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y271 >= input_height)
            _gid_y271 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y271) * input_stride + _gid_x271);
        int _gid_x272 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y272 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_y272 >= input_height)
            _gid_y272 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y272) * input_stride + _gid_x272);
        int _gid_x273 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y273 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y273 >= input_height)
            _gid_y273 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y273) * input_stride + _gid_x273);
        int _gid_x274 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y274 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y274 >= input_height)
            _gid_y274 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y274) * input_stride + _gid_x274);
        int _gid_x275 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y275 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_y275 >= input_height)
            _gid_y275 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y275) * input_stride + _gid_x275);
        int _gid_x276 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y276 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y276 >= input_height)
            _gid_y276 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y276) * input_stride + _gid_x276);
        int _gid_x277 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y277 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y277 >= input_height)
            _gid_y277 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y277) * input_stride + _gid_x277);
        int _gid_x278 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y278 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_y278 >= input_height)
            _gid_y278 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y278) * input_stride + _gid_x278);
        int _gid_x279 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y279 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y279 >= input_height)
            _gid_y279 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y279) * input_stride + _gid_x279);
        int _gid_x280 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y280 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y280 >= input_height)
            _gid_y280 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y280) * input_stride + _gid_x280);
        int _gid_x281 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y281 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_y281 >= input_height)
            _gid_y281 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y281) * input_stride + _gid_x281);
        int _gid_x282 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y282 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y282 >= input_height)
            _gid_y282 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y282) * input_stride + _gid_x282);
        int _gid_x283 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y283 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y283 >= input_height)
            _gid_y283 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y283) * input_stride + _gid_x283);
        int _gid_x284 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y284 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_y284 >= input_height)
            _gid_y284 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y284) * input_stride + _gid_x284);
        int _gid_x285 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y285 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y285 >= input_height)
            _gid_y285 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y285) * input_stride + _gid_x285);
        int _gid_x286 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y286 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y286 >= input_height)
            _gid_y286 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y286) * input_stride + _gid_x286);
        int _gid_x287 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y287 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_y287 >= input_height)
            _gid_y287 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y287) * input_stride + _gid_x287);
        int _gid_x288 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y288 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y288 >= input_height)
            _gid_y288 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y288) * input_stride + _gid_x288);
        int _gid_x289 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y289 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y289 >= input_height)
            _gid_y289 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y289) * input_stride + _gid_x289);
        int _gid_x290 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y290 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_y290 >= input_height)
            _gid_y290 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y290) * input_stride + _gid_x290);
        int _gid_x291 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y291 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y291 >= input_height)
            _gid_y291 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y291) * input_stride + _gid_x291);
        int _gid_x292 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y292 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y292 >= input_height)
            _gid_y292 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y292) * input_stride + _gid_x292);
        int _gid_x293 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y293 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_y293 >= input_height)
            _gid_y293 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y293) * input_stride + _gid_x293);
        int _gid_x294 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y294 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y294 >= input_height)
            _gid_y294 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y294) * input_stride + _gid_x294);
        int _gid_x295 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y295 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y295 >= input_height)
            _gid_y295 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y295) * input_stride + _gid_x295);
        int _gid_x296 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y296 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_y296 >= input_height)
            _gid_y296 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y296) * input_stride + _gid_x296);
        int _gid_x297 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y297 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y297 >= input_height)
            _gid_y297 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y297) * input_stride + _gid_x297);
        int _gid_x298 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y298 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y298 >= input_height)
            _gid_y298 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y298) * input_stride + _gid_x298);
        int _gid_x299 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y299 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_y299 >= input_height)
            _gid_y299 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y299) * input_stride + _gid_x299);
        __syncthreads();
        if (gid_y < iter_height) {
            float _tmp300 = 0.F;
            {
                _tmp300 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp300 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp300 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp300 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp300 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp300 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp300 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp300 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp300 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp300 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp300 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp300 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp300 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp300 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp300 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp300 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp300 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp300 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp300 + 0.5F);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp301 = 0.F;
            {
                _tmp301 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp301 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp301 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp301 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp301 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp301 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp301 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp301 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp301 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp301 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp301 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp301 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp301 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp301 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp301 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp301 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp301 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp301 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp301 + 0.5F);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp302 = 0.F;
            {
                _tmp302 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp302 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp302 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp302 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp302 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp302 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp302 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp302 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp302 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp302 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp302 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp302 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp302 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp302 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp302 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp302 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp302 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp302 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp302 + 0.5F);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp303 = 0.F;
            {
                _tmp303 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp303 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp303 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp303 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp303 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp303 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp303 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp303 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp303 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp303 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp303 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp303 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp303 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp303 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp303 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp303 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp303 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp303 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp303 + 0.5F);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp304 = 0.F;
            {
                _tmp304 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp304 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp304 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp304 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp304 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp304 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp304 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp304 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp304 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp304 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp304 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp304 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp304 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp304 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp304 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp304 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp304 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp304 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp304 + 0.5F);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp305 = 0.F;
            {
                _tmp305 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp305 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp305 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp305 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp305 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp305 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp305 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp305 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp305 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp305 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp305 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp305 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp305 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp305 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp305 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp305 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp305 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp305 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp305 + 0.5F);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp306 = 0.F;
            {
                _tmp306 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp306 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp306 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp306 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp306 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp306 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp306 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp306 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp306 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp306 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp306 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp306 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp306 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp306 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp306 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp306 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp306 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp306 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp306 + 0.5F);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp307 = 0.F;
            {
                _tmp307 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp307 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp307 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp307 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp307 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp307 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp307 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp307 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp307 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp307 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp307 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp307 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp307 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp307 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp307 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp307 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp307 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp307 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp307 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        int _gid_x308 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y308 = gid_y + (-2);
        if (_gid_x308 >= input_width)
            _gid_x308 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y308) * input_stride + _gid_x308);
        int _gid_x309 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y309 = gid_y + (-2);
        if (_gid_x309 >= input_width)
            _gid_x309 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y309) * input_stride + _gid_x309);
        int _gid_x310 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y310 = gid_y + (-2);
        if (_gid_x310 >= input_width)
            _gid_x310 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y310) * input_stride + _gid_x310);
        int _gid_x311 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y311 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x311 >= input_width)
            _gid_x311 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y311) * input_stride + _gid_x311);
        int _gid_x312 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y312 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x312 >= input_width)
            _gid_x312 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y312) * input_stride + _gid_x312);
        int _gid_x313 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y313 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x313 >= input_width)
            _gid_x313 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y313) * input_stride + _gid_x313);
        int _gid_x314 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y314 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x314 >= input_width)
            _gid_x314 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y314) * input_stride + _gid_x314);
        int _gid_x315 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y315 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x315 >= input_width)
            _gid_x315 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y315) * input_stride + _gid_x315);
        int _gid_x316 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y316 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x316 >= input_width)
            _gid_x316 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y316) * input_stride + _gid_x316);
        int _gid_x317 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y317 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x317 >= input_width)
            _gid_x317 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y317) * input_stride + _gid_x317);
        int _gid_x318 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y318 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x318 >= input_width)
            _gid_x318 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y318) * input_stride + _gid_x318);
        int _gid_x319 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y319 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x319 >= input_width)
            _gid_x319 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y319) * input_stride + _gid_x319);
        int _gid_x320 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y320 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x320 >= input_width)
            _gid_x320 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y320) * input_stride + _gid_x320);
        int _gid_x321 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y321 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x321 >= input_width)
            _gid_x321 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y321) * input_stride + _gid_x321);
        int _gid_x322 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y322 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x322 >= input_width)
            _gid_x322 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y322) * input_stride + _gid_x322);
        int _gid_x323 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y323 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x323 >= input_width)
            _gid_x323 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y323) * input_stride + _gid_x323);
        int _gid_x324 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y324 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x324 >= input_width)
            _gid_x324 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y324) * input_stride + _gid_x324);
        int _gid_x325 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y325 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x325 >= input_width)
            _gid_x325 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y325) * input_stride + _gid_x325);
        int _gid_x326 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y326 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x326 >= input_width)
            _gid_x326 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y326) * input_stride + _gid_x326);
        int _gid_x327 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y327 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x327 >= input_width)
            _gid_x327 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y327) * input_stride + _gid_x327);
        int _gid_x328 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y328 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x328 >= input_width)
            _gid_x328 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y328) * input_stride + _gid_x328);
        int _gid_x329 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y329 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x329 >= input_width)
            _gid_x329 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y329) * input_stride + _gid_x329);
        int _gid_x330 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y330 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x330 >= input_width)
            _gid_x330 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y330) * input_stride + _gid_x330);
        int _gid_x331 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y331 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x331 >= input_width)
            _gid_x331 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y331) * input_stride + _gid_x331);
        int _gid_x332 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y332 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x332 >= input_width)
            _gid_x332 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y332) * input_stride + _gid_x332);
        int _gid_x333 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y333 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x333 >= input_width)
            _gid_x333 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y333) * input_stride + _gid_x333);
        int _gid_x334 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y334 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x334 >= input_width)
            _gid_x334 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y334) * input_stride + _gid_x334);
        int _gid_x335 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y335 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x335 >= input_width)
            _gid_x335 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y335) * input_stride + _gid_x335);
        int _gid_x336 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y336 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x336 >= input_width)
            _gid_x336 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y336) * input_stride + _gid_x336);
        int _gid_x337 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y337 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x337 >= input_width)
            _gid_x337 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y337) * input_stride + _gid_x337);
        int _gid_x338 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y338 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x338 >= input_width)
            _gid_x338 = input_width - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y338) * input_stride + _gid_x338);
        int _gid_x339 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y339 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x339 >= input_width)
            _gid_x339 = input_width - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y339) * input_stride + _gid_x339);
        int _gid_x340 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y340 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x340 >= input_width)
            _gid_x340 = input_width - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y340) * input_stride + _gid_x340);
        int _gid_x341 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y341 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x341 >= input_width)
            _gid_x341 = input_width - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y341) * input_stride + _gid_x341);
        int _gid_x342 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y342 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x342 >= input_width)
            _gid_x342 = input_width - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y342) * input_stride + _gid_x342);
        int _gid_x343 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y343 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x343 >= input_width)
            _gid_x343 = input_width - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y343) * input_stride + _gid_x343);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp344 = 0.F;
                {
                    _tmp344 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp344 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp344 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp344 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp344 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp344 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp344 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp344 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp344 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp344 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp344 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp344 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp344 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp344 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp344 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp344 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp344 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp344 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp344 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp345 = 0.F;
                {
                    _tmp345 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp345 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp345 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp345 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp345 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp345 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp345 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp345 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp345 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp345 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp345 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp345 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp345 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp345 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp345 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp345 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp345 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp345 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp345 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp346 = 0.F;
                {
                    _tmp346 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp346 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp346 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp346 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp346 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp346 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp346 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp346 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp346 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp346 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp346 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp346 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp346 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp346 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp346 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp346 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp346 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp346 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp346 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp347 = 0.F;
                {
                    _tmp347 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp347 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp347 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp347 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp347 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp347 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp347 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp347 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp347 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp347 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp347 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp347 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp347 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp347 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp347 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp347 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp347 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp347 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp347 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp348 = 0.F;
                {
                    _tmp348 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp348 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp348 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp348 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp348 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp348 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp348 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp348 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp348 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp348 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp348 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp348 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp348 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp348 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp348 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp348 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp348 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp348 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp348 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp349 = 0.F;
                {
                    _tmp349 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp349 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp349 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp349 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp349 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp349 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp349 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp349 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp349 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp349 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp349 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp349 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp349 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp349 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp349 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp349 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp349 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp349 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp349 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp350 = 0.F;
                {
                    _tmp350 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp350 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp350 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp350 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp350 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp350 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp350 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp350 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp350 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp350 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp350 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp350 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp350 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp350 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp350 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp350 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp350 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp350 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp350 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp351 = 0.F;
                {
                    _tmp351 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp351 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp351 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp351 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp351 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp351 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp351 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp351 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp351 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp351 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp351 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp351 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp351 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp351 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp351 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp351 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp351 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp351 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp351 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_L:
    {
        int _gid_x352 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y352 = gid_y + (-2);
        if (_gid_x352 < 0)
            _gid_x352 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y352) * input_stride + _gid_x352);
        int _gid_x353 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y353 = gid_y + (-2);
        if (_gid_x353 < 0)
            _gid_x353 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y353) * input_stride + _gid_x353);
        int _gid_x354 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y354 = gid_y + (-2);
        if (_gid_x354 < 0)
            _gid_x354 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y354) * input_stride + _gid_x354);
        int _gid_x355 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y355 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x355 < 0)
            _gid_x355 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y355) * input_stride + _gid_x355);
        int _gid_x356 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y356 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x356 < 0)
            _gid_x356 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y356) * input_stride + _gid_x356);
        int _gid_x357 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y357 = gid_y + 1 * (int)blockDim.y + (-2);
        if (_gid_x357 < 0)
            _gid_x357 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y357) * input_stride + _gid_x357);
        int _gid_x358 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y358 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x358 < 0)
            _gid_x358 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y358) * input_stride + _gid_x358);
        int _gid_x359 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y359 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x359 < 0)
            _gid_x359 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y359) * input_stride + _gid_x359);
        int _gid_x360 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y360 = gid_y + 2 * (int)blockDim.y + (-2);
        if (_gid_x360 < 0)
            _gid_x360 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y360) * input_stride + _gid_x360);
        int _gid_x361 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y361 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x361 < 0)
            _gid_x361 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y361) * input_stride + _gid_x361);
        int _gid_x362 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y362 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x362 < 0)
            _gid_x362 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y362) * input_stride + _gid_x362);
        int _gid_x363 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y363 = gid_y + 3 * (int)blockDim.y + (-2);
        if (_gid_x363 < 0)
            _gid_x363 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y363) * input_stride + _gid_x363);
        int _gid_x364 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y364 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x364 < 0)
            _gid_x364 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y364) * input_stride + _gid_x364);
        int _gid_x365 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y365 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x365 < 0)
            _gid_x365 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y365) * input_stride + _gid_x365);
        int _gid_x366 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y366 = gid_y + 4 * (int)blockDim.y + (-2);
        if (_gid_x366 < 0)
            _gid_x366 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y366) * input_stride + _gid_x366);
        int _gid_x367 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y367 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x367 < 0)
            _gid_x367 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y367) * input_stride + _gid_x367);
        int _gid_x368 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y368 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x368 < 0)
            _gid_x368 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y368) * input_stride + _gid_x368);
        int _gid_x369 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y369 = gid_y + 5 * (int)blockDim.y + (-2);
        if (_gid_x369 < 0)
            _gid_x369 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y369) * input_stride + _gid_x369);
        int _gid_x370 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y370 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x370 < 0)
            _gid_x370 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y370) * input_stride + _gid_x370);
        int _gid_x371 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y371 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x371 < 0)
            _gid_x371 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y371) * input_stride + _gid_x371);
        int _gid_x372 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y372 = gid_y + 6 * (int)blockDim.y + (-2);
        if (_gid_x372 < 0)
            _gid_x372 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y372) * input_stride + _gid_x372);
        int _gid_x373 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y373 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x373 < 0)
            _gid_x373 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y373) * input_stride + _gid_x373);
        int _gid_x374 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y374 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x374 < 0)
            _gid_x374 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y374) * input_stride + _gid_x374);
        int _gid_x375 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y375 = gid_y + 7 * (int)blockDim.y + (-2);
        if (_gid_x375 < 0)
            _gid_x375 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y375) * input_stride + _gid_x375);
        int _gid_x376 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y376 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x376 < 0)
            _gid_x376 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y376) * input_stride + _gid_x376);
        int _gid_x377 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y377 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x377 < 0)
            _gid_x377 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y377) * input_stride + _gid_x377);
        int _gid_x378 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y378 = gid_y + 8 * (int)blockDim.y + (-2);
        if (_gid_x378 < 0)
            _gid_x378 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y378) * input_stride + _gid_x378);
        int _gid_x379 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y379 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x379 < 0)
            _gid_x379 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y379) * input_stride + _gid_x379);
        int _gid_x380 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y380 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x380 < 0)
            _gid_x380 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y380) * input_stride + _gid_x380);
        int _gid_x381 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y381 = gid_y + 9 * (int)blockDim.y + (-2);
        if (_gid_x381 < 0)
            _gid_x381 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y381) * input_stride + _gid_x381);
        int _gid_x382 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y382 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x382 < 0)
            _gid_x382 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y382) * input_stride + _gid_x382);
        int _gid_x383 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y383 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x383 < 0)
            _gid_x383 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y383) * input_stride + _gid_x383);
        int _gid_x384 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y384 = gid_y + 10 * (int)blockDim.y + (-2);
        if (_gid_x384 < 0)
            _gid_x384 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y384) * input_stride + _gid_x384);
        int _gid_x385 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y385 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x385 < 0)
            _gid_x385 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y385) * input_stride + _gid_x385);
        int _gid_x386 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y386 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x386 < 0)
            _gid_x386 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y386) * input_stride + _gid_x386);
        int _gid_x387 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y387 = gid_y + 11 * (int)blockDim.y + (-2);
        if (_gid_x387 < 0)
            _gid_x387 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y387) * input_stride + _gid_x387);
        __syncthreads();
        {
            float _tmp388 = 0.F;
            {
                _tmp388 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp388 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp388 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp388 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp388 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp388 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp388 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp388 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp388 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp388 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp388 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp388 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp388 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp388 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp388 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp388 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp388 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp388 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp388 + 0.5F);
        }
        {
            float _tmp389 = 0.F;
            {
                _tmp389 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp389 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp389 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp389 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp389 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp389 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp389 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp389 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp389 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp389 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp389 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp389 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp389 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp389 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp389 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp389 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp389 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp389 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp389 + 0.5F);
        }
        {
            float _tmp390 = 0.F;
            {
                _tmp390 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp390 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp390 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp390 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp390 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp390 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp390 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp390 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp390 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp390 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp390 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp390 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp390 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp390 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp390 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp390 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp390 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp390 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp390 + 0.5F);
        }
        {
            float _tmp391 = 0.F;
            {
                _tmp391 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp391 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp391 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp391 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp391 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp391 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp391 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp391 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp391 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp391 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp391 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp391 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp391 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp391 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp391 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp391 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp391 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp391 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp391 + 0.5F);
        }
        {
            float _tmp392 = 0.F;
            {
                _tmp392 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp392 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp392 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp392 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp392 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp392 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp392 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp392 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp392 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp392 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp392 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp392 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp392 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp392 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp392 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp392 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp392 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp392 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp392 + 0.5F);
        }
        {
            float _tmp393 = 0.F;
            {
                _tmp393 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp393 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp393 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp393 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp393 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp393 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp393 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp393 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp393 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp393 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp393 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp393 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp393 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp393 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp393 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp393 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp393 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp393 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp393 + 0.5F);
        }
        {
            float _tmp394 = 0.F;
            {
                _tmp394 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp394 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp394 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp394 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp394 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp394 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp394 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp394 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp394 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp394 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp394 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp394 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp394 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp394 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp394 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp394 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp394 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp394 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp394 + 0.5F);
        }
        {
            float _tmp395 = 0.F;
            {
                _tmp395 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp395 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp395 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp395 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp395 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp395 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp395 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp395 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp395 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp395 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp395 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp395 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp395 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp395 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp395 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp395 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp395 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp395 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp395 + 0.5F);
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
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 10 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 10 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 10 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 11 * (int)blockDim.y + (-2)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 11 * (int)blockDim.y + (-2)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 11 * (int)blockDim.y + (-2)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        __syncthreads();
        {
            float _tmp396 = 0.F;
            {
                _tmp396 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp396 += 0.0261509996F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp396 += 0.00500799995F * _smeminput[(int)threadIdx.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp396 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp396 += 0.0903389975F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp396 += 0.0597609989F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp396 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp396 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp396 += 0.136565F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp396 += 0.0903389975F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp396 += 0.0261509996F * _smeminput[(int)threadIdx.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp396 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp396 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp396 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp396 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp396 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp396 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp396 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp396 + 0.5F);
        }
        {
            float _tmp397 = 0.F;
            {
                _tmp397 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp397 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp397 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp397 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp397 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp397 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp397 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp397 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp397 += 0.136565F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp397 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp397 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp397 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp397 += 0.0903389975F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp397 += 0.0597609989F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp397 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp397 += 0.0261509996F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp397 += 0.0173000004F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp397 += 0.00500799995F * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp397 + 0.5F);
        }
        {
            float _tmp398 = 0.F;
            {
                _tmp398 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp398 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp398 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp398 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp398 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp398 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp398 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp398 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp398 += 0.136565F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp398 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp398 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp398 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp398 += 0.0903389975F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp398 += 0.0597609989F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp398 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp398 += 0.0261509996F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp398 += 0.0173000004F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp398 += 0.00500799995F * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp398 + 0.5F);
        }
        {
            float _tmp399 = 0.F;
            {
                _tmp399 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp399 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp399 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp399 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp399 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp399 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp399 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp399 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp399 += 0.136565F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp399 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp399 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp399 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp399 += 0.0903389975F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp399 += 0.0597609989F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp399 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp399 += 0.0261509996F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp399 += 0.0173000004F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp399 += 0.00500799995F * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp399 + 0.5F);
        }
        {
            float _tmp400 = 0.F;
            {
                _tmp400 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp400 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp400 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp400 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp400 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp400 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp400 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp400 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp400 += 0.136565F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp400 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp400 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp400 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp400 += 0.0903389975F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp400 += 0.0597609989F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp400 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp400 += 0.0261509996F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp400 += 0.0173000004F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp400 += 0.00500799995F * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp400 + 0.5F);
        }
        {
            float _tmp401 = 0.F;
            {
                _tmp401 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp401 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp401 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp401 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp401 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp401 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp401 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp401 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp401 += 0.136565F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp401 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp401 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp401 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp401 += 0.0903389975F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp401 += 0.0597609989F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp401 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp401 += 0.0261509996F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp401 += 0.0173000004F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp401 += 0.00500799995F * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp401 + 0.5F);
        }
        {
            float _tmp402 = 0.F;
            {
                _tmp402 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp402 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp402 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp402 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp402 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp402 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp402 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp402 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp402 += 0.136565F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp402 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp402 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp402 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp402 += 0.0903389975F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp402 += 0.0597609989F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp402 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp402 += 0.0261509996F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp402 += 0.0173000004F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp402 += 0.00500799995F * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp402 + 0.5F);
        }
        {
            float _tmp403 = 0.F;
            {
                _tmp403 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp403 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp403 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp403 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp403 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp403 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp403 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp403 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp403 += 0.136565F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp403 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp403 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp403 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp403 += 0.0903389975F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp403 += 0.0597609989F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 2][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp403 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp403 += 0.0261509996F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp403 += 0.0173000004F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp403 += 0.00500799995F * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 2][(int)threadIdx.x + 2 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp403 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERXY_CU_

