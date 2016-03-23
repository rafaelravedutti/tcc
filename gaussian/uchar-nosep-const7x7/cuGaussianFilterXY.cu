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
    uchar _smeminput[14][97] __attribute__((shared));
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
        int _gid_y0 = gid_y + (-3);
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
        int _gid_y1 = gid_y + (-3);
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
        int _gid_y2 = gid_y + (-3);
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
        int _gid_y3 = gid_y + 1 * (int)blockDim.y + (-3);
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
        int _gid_y4 = gid_y + 1 * (int)blockDim.y + (-3);
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
        int _gid_y5 = gid_y + 1 * (int)blockDim.y + (-3);
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
        int _gid_y6 = gid_y + 2 * (int)blockDim.y + (-3);
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
        int _gid_y7 = gid_y + 2 * (int)blockDim.y + (-3);
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
        int _gid_y8 = gid_y + 2 * (int)blockDim.y + (-3);
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
        int _gid_y9 = gid_y + 3 * (int)blockDim.y + (-3);
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
        int _gid_y10 = gid_y + 3 * (int)blockDim.y + (-3);
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
        int _gid_y11 = gid_y + 3 * (int)blockDim.y + (-3);
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
        int _gid_y12 = gid_y + 4 * (int)blockDim.y + (-3);
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
        int _gid_y13 = gid_y + 4 * (int)blockDim.y + (-3);
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
        int _gid_y14 = gid_y + 4 * (int)blockDim.y + (-3);
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
        int _gid_y15 = gid_y + 5 * (int)blockDim.y + (-3);
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
        int _gid_y16 = gid_y + 5 * (int)blockDim.y + (-3);
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
        int _gid_y17 = gid_y + 5 * (int)blockDim.y + (-3);
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
        int _gid_y18 = gid_y + 6 * (int)blockDim.y + (-3);
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
        int _gid_y19 = gid_y + 6 * (int)blockDim.y + (-3);
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
        int _gid_y20 = gid_y + 6 * (int)blockDim.y + (-3);
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
        int _gid_y21 = gid_y + 7 * (int)blockDim.y + (-3);
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
        int _gid_y22 = gid_y + 7 * (int)blockDim.y + (-3);
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
        int _gid_y23 = gid_y + 7 * (int)blockDim.y + (-3);
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
        int _gid_y24 = gid_y + 8 * (int)blockDim.y + (-3);
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
        int _gid_y25 = gid_y + 8 * (int)blockDim.y + (-3);
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
        int _gid_y26 = gid_y + 8 * (int)blockDim.y + (-3);
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
        int _gid_y27 = gid_y + 9 * (int)blockDim.y + (-3);
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
        int _gid_y28 = gid_y + 9 * (int)blockDim.y + (-3);
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
        int _gid_y29 = gid_y + 9 * (int)blockDim.y + (-3);
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
        int _gid_y30 = gid_y + 10 * (int)blockDim.y + (-3);
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
        int _gid_y31 = gid_y + 10 * (int)blockDim.y + (-3);
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
        int _gid_y32 = gid_y + 10 * (int)blockDim.y + (-3);
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
        int _gid_y33 = gid_y + 11 * (int)blockDim.y + (-3);
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
        int _gid_y34 = gid_y + 11 * (int)blockDim.y + (-3);
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
        int _gid_y35 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x35 >= input_width)
            _gid_x35 = input_width - 1;
        if (_gid_y35 >= input_height)
            _gid_y35 = input_height - 1;
        if (_gid_x35 < 0)
            _gid_x35 = 0;
        if (_gid_y35 < 0)
            _gid_y35 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y35) * input_stride + _gid_x35);
        int _gid_x36 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y36 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x36 >= input_width)
            _gid_x36 = input_width - 1;
        if (_gid_y36 >= input_height)
            _gid_y36 = input_height - 1;
        if (_gid_x36 < 0)
            _gid_x36 = 0;
        if (_gid_y36 < 0)
            _gid_y36 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y36) * input_stride + _gid_x36);
        int _gid_x37 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y37 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x37 >= input_width)
            _gid_x37 = input_width - 1;
        if (_gid_y37 >= input_height)
            _gid_y37 = input_height - 1;
        if (_gid_x37 < 0)
            _gid_x37 = 0;
        if (_gid_y37 < 0)
            _gid_y37 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y37) * input_stride + _gid_x37);
        int _gid_x38 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y38 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x38 >= input_width)
            _gid_x38 = input_width - 1;
        if (_gid_y38 >= input_height)
            _gid_y38 = input_height - 1;
        if (_gid_x38 < 0)
            _gid_x38 = 0;
        if (_gid_y38 < 0)
            _gid_y38 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y38) * input_stride + _gid_x38);
        int _gid_x39 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y39 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x39 >= input_width)
            _gid_x39 = input_width - 1;
        if (_gid_y39 >= input_height)
            _gid_y39 = input_height - 1;
        if (_gid_x39 < 0)
            _gid_x39 = 0;
        if (_gid_y39 < 0)
            _gid_y39 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y39) * input_stride + _gid_x39);
        int _gid_x40 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y40 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x40 >= input_width)
            _gid_x40 = input_width - 1;
        if (_gid_y40 >= input_height)
            _gid_y40 = input_height - 1;
        if (_gid_x40 < 0)
            _gid_x40 = 0;
        if (_gid_y40 < 0)
            _gid_y40 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y40) * input_stride + _gid_x40);
        int _gid_x41 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y41 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x41 >= input_width)
            _gid_x41 = input_width - 1;
        if (_gid_y41 >= input_height)
            _gid_y41 = input_height - 1;
        if (_gid_x41 < 0)
            _gid_x41 = 0;
        if (_gid_y41 < 0)
            _gid_y41 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y41) * input_stride + _gid_x41);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp42 = 0.F;
                {
                    _tmp42 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp42 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp42 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp42 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp42 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp42 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp42 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp42 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp43 = 0.F;
                {
                    _tmp43 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp43 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp43 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp43 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp43 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp43 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp43 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp43 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp44 = 0.F;
                {
                    _tmp44 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp44 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp44 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp44 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp44 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp44 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp44 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp44 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp45 = 0.F;
                {
                    _tmp45 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp45 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp45 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp45 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp45 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp45 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp45 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp45 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp46 = 0.F;
                {
                    _tmp46 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp46 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp46 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp46 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp46 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp46 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp46 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp46 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp47 = 0.F;
                {
                    _tmp47 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp47 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp47 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp47 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp47 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp47 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp47 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp47 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp48 = 0.F;
                {
                    _tmp48 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp48 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp48 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp48 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp48 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp48 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp48 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp48 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp49 = 0.F;
                {
                    _tmp49 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp49 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp49 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp49 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp49 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp49 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp49 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp49 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_TL:
    {
        int _gid_x50 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y50 = gid_y + (-3);
        if (_gid_x50 < 0)
            _gid_x50 = 0;
        if (_gid_y50 < 0)
            _gid_y50 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y50) * input_stride + _gid_x50);
        int _gid_x51 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y51 = gid_y + (-3);
        if (_gid_x51 < 0)
            _gid_x51 = 0;
        if (_gid_y51 < 0)
            _gid_y51 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y51) * input_stride + _gid_x51);
        int _gid_x52 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y52 = gid_y + (-3);
        if (_gid_x52 < 0)
            _gid_x52 = 0;
        if (_gid_y52 < 0)
            _gid_y52 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y52) * input_stride + _gid_x52);
        int _gid_x53 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y53 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x53 < 0)
            _gid_x53 = 0;
        if (_gid_y53 < 0)
            _gid_y53 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y53) * input_stride + _gid_x53);
        int _gid_x54 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y54 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x54 < 0)
            _gid_x54 = 0;
        if (_gid_y54 < 0)
            _gid_y54 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y54) * input_stride + _gid_x54);
        int _gid_x55 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y55 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x55 < 0)
            _gid_x55 = 0;
        if (_gid_y55 < 0)
            _gid_y55 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y55) * input_stride + _gid_x55);
        int _gid_x56 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y56 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x56 < 0)
            _gid_x56 = 0;
        if (_gid_y56 < 0)
            _gid_y56 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y56) * input_stride + _gid_x56);
        int _gid_x57 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y57 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x57 < 0)
            _gid_x57 = 0;
        if (_gid_y57 < 0)
            _gid_y57 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y57) * input_stride + _gid_x57);
        int _gid_x58 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y58 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x58 < 0)
            _gid_x58 = 0;
        if (_gid_y58 < 0)
            _gid_y58 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y58) * input_stride + _gid_x58);
        int _gid_x59 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y59 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x59 < 0)
            _gid_x59 = 0;
        if (_gid_y59 < 0)
            _gid_y59 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y59) * input_stride + _gid_x59);
        int _gid_x60 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y60 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x60 < 0)
            _gid_x60 = 0;
        if (_gid_y60 < 0)
            _gid_y60 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y60) * input_stride + _gid_x60);
        int _gid_x61 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y61 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x61 < 0)
            _gid_x61 = 0;
        if (_gid_y61 < 0)
            _gid_y61 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y61) * input_stride + _gid_x61);
        int _gid_x62 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y62 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x62 < 0)
            _gid_x62 = 0;
        if (_gid_y62 < 0)
            _gid_y62 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y62) * input_stride + _gid_x62);
        int _gid_x63 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y63 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x63 < 0)
            _gid_x63 = 0;
        if (_gid_y63 < 0)
            _gid_y63 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y63) * input_stride + _gid_x63);
        int _gid_x64 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y64 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x64 < 0)
            _gid_x64 = 0;
        if (_gid_y64 < 0)
            _gid_y64 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y64) * input_stride + _gid_x64);
        int _gid_x65 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y65 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x65 < 0)
            _gid_x65 = 0;
        if (_gid_y65 < 0)
            _gid_y65 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y65) * input_stride + _gid_x65);
        int _gid_x66 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y66 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x66 < 0)
            _gid_x66 = 0;
        if (_gid_y66 < 0)
            _gid_y66 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y66) * input_stride + _gid_x66);
        int _gid_x67 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y67 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x67 < 0)
            _gid_x67 = 0;
        if (_gid_y67 < 0)
            _gid_y67 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y67) * input_stride + _gid_x67);
        int _gid_x68 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y68 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x68 < 0)
            _gid_x68 = 0;
        if (_gid_y68 < 0)
            _gid_y68 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y68) * input_stride + _gid_x68);
        int _gid_x69 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y69 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x69 < 0)
            _gid_x69 = 0;
        if (_gid_y69 < 0)
            _gid_y69 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y69) * input_stride + _gid_x69);
        int _gid_x70 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y70 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x70 < 0)
            _gid_x70 = 0;
        if (_gid_y70 < 0)
            _gid_y70 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y70) * input_stride + _gid_x70);
        int _gid_x71 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y71 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x71 < 0)
            _gid_x71 = 0;
        if (_gid_y71 < 0)
            _gid_y71 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y71) * input_stride + _gid_x71);
        int _gid_x72 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y72 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x72 < 0)
            _gid_x72 = 0;
        if (_gid_y72 < 0)
            _gid_y72 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y72) * input_stride + _gid_x72);
        int _gid_x73 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y73 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x73 < 0)
            _gid_x73 = 0;
        if (_gid_y73 < 0)
            _gid_y73 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y73) * input_stride + _gid_x73);
        int _gid_x74 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y74 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x74 < 0)
            _gid_x74 = 0;
        if (_gid_y74 < 0)
            _gid_y74 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y74) * input_stride + _gid_x74);
        int _gid_x75 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y75 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x75 < 0)
            _gid_x75 = 0;
        if (_gid_y75 < 0)
            _gid_y75 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y75) * input_stride + _gid_x75);
        int _gid_x76 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y76 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x76 < 0)
            _gid_x76 = 0;
        if (_gid_y76 < 0)
            _gid_y76 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y76) * input_stride + _gid_x76);
        int _gid_x77 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y77 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x77 < 0)
            _gid_x77 = 0;
        if (_gid_y77 < 0)
            _gid_y77 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y77) * input_stride + _gid_x77);
        int _gid_x78 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y78 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x78 < 0)
            _gid_x78 = 0;
        if (_gid_y78 < 0)
            _gid_y78 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y78) * input_stride + _gid_x78);
        int _gid_x79 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y79 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x79 < 0)
            _gid_x79 = 0;
        if (_gid_y79 < 0)
            _gid_y79 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y79) * input_stride + _gid_x79);
        int _gid_x80 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y80 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x80 < 0)
            _gid_x80 = 0;
        if (_gid_y80 < 0)
            _gid_y80 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y80) * input_stride + _gid_x80);
        int _gid_x81 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y81 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x81 < 0)
            _gid_x81 = 0;
        if (_gid_y81 < 0)
            _gid_y81 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y81) * input_stride + _gid_x81);
        int _gid_x82 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y82 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x82 < 0)
            _gid_x82 = 0;
        if (_gid_y82 < 0)
            _gid_y82 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y82) * input_stride + _gid_x82);
        int _gid_x83 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y83 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x83 < 0)
            _gid_x83 = 0;
        if (_gid_y83 < 0)
            _gid_y83 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y83) * input_stride + _gid_x83);
        int _gid_x84 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y84 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x84 < 0)
            _gid_x84 = 0;
        if (_gid_y84 < 0)
            _gid_y84 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y84) * input_stride + _gid_x84);
        int _gid_x85 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y85 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x85 < 0)
            _gid_x85 = 0;
        if (_gid_y85 < 0)
            _gid_y85 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y85) * input_stride + _gid_x85);
        int _gid_x86 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y86 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x86 < 0)
            _gid_x86 = 0;
        if (_gid_y86 < 0)
            _gid_y86 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y86) * input_stride + _gid_x86);
        int _gid_x87 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y87 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x87 < 0)
            _gid_x87 = 0;
        if (_gid_y87 < 0)
            _gid_y87 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y87) * input_stride + _gid_x87);
        int _gid_x88 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y88 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x88 < 0)
            _gid_x88 = 0;
        if (_gid_y88 < 0)
            _gid_y88 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y88) * input_stride + _gid_x88);
        int _gid_x89 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y89 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x89 < 0)
            _gid_x89 = 0;
        if (_gid_y89 < 0)
            _gid_y89 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y89) * input_stride + _gid_x89);
        int _gid_x90 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y90 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x90 < 0)
            _gid_x90 = 0;
        if (_gid_y90 < 0)
            _gid_y90 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y90) * input_stride + _gid_x90);
        int _gid_x91 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y91 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x91 < 0)
            _gid_x91 = 0;
        if (_gid_y91 < 0)
            _gid_y91 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y91) * input_stride + _gid_x91);
        __syncthreads();
        {
            float _tmp92 = 0.F;
            {
                _tmp92 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp92 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp92 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp92 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp92 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp92 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp92 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp92 + 0.5F);
        }
        {
            float _tmp93 = 0.F;
            {
                _tmp93 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp93 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp93 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp93 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp93 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp93 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp93 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp93 + 0.5F);
        }
        {
            float _tmp94 = 0.F;
            {
                _tmp94 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp94 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp94 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp94 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp94 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp94 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp94 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp94 + 0.5F);
        }
        {
            float _tmp95 = 0.F;
            {
                _tmp95 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp95 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp95 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp95 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp95 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp95 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp95 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp95 + 0.5F);
        }
        {
            float _tmp96 = 0.F;
            {
                _tmp96 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp96 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp96 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp96 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp96 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp96 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp96 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp96 + 0.5F);
        }
        {
            float _tmp97 = 0.F;
            {
                _tmp97 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp97 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp97 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp97 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp97 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp97 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp97 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp97 + 0.5F);
        }
        {
            float _tmp98 = 0.F;
            {
                _tmp98 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp98 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp98 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp98 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp98 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp98 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp98 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp98 + 0.5F);
        }
        {
            float _tmp99 = 0.F;
            {
                _tmp99 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp99 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp99 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp99 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp99 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp99 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp99 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp99 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_TR:
    {
        int _gid_x100 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y100 = gid_y + (-3);
        if (_gid_x100 >= input_width)
            _gid_x100 = input_width - 1;
        if (_gid_y100 < 0)
            _gid_y100 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y100) * input_stride + _gid_x100);
        int _gid_x101 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y101 = gid_y + (-3);
        if (_gid_x101 >= input_width)
            _gid_x101 = input_width - 1;
        if (_gid_y101 < 0)
            _gid_y101 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y101) * input_stride + _gid_x101);
        int _gid_x102 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y102 = gid_y + (-3);
        if (_gid_x102 >= input_width)
            _gid_x102 = input_width - 1;
        if (_gid_y102 < 0)
            _gid_y102 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y102) * input_stride + _gid_x102);
        int _gid_x103 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y103 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x103 >= input_width)
            _gid_x103 = input_width - 1;
        if (_gid_y103 < 0)
            _gid_y103 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y103) * input_stride + _gid_x103);
        int _gid_x104 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y104 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x104 >= input_width)
            _gid_x104 = input_width - 1;
        if (_gid_y104 < 0)
            _gid_y104 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y104) * input_stride + _gid_x104);
        int _gid_x105 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y105 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x105 >= input_width)
            _gid_x105 = input_width - 1;
        if (_gid_y105 < 0)
            _gid_y105 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y105) * input_stride + _gid_x105);
        int _gid_x106 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y106 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x106 >= input_width)
            _gid_x106 = input_width - 1;
        if (_gid_y106 < 0)
            _gid_y106 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y106) * input_stride + _gid_x106);
        int _gid_x107 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y107 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x107 >= input_width)
            _gid_x107 = input_width - 1;
        if (_gid_y107 < 0)
            _gid_y107 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y107) * input_stride + _gid_x107);
        int _gid_x108 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y108 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x108 >= input_width)
            _gid_x108 = input_width - 1;
        if (_gid_y108 < 0)
            _gid_y108 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y108) * input_stride + _gid_x108);
        int _gid_x109 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y109 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x109 >= input_width)
            _gid_x109 = input_width - 1;
        if (_gid_y109 < 0)
            _gid_y109 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y109) * input_stride + _gid_x109);
        int _gid_x110 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y110 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x110 >= input_width)
            _gid_x110 = input_width - 1;
        if (_gid_y110 < 0)
            _gid_y110 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y110) * input_stride + _gid_x110);
        int _gid_x111 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y111 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x111 >= input_width)
            _gid_x111 = input_width - 1;
        if (_gid_y111 < 0)
            _gid_y111 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y111) * input_stride + _gid_x111);
        int _gid_x112 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y112 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x112 >= input_width)
            _gid_x112 = input_width - 1;
        if (_gid_y112 < 0)
            _gid_y112 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y112) * input_stride + _gid_x112);
        int _gid_x113 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y113 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x113 >= input_width)
            _gid_x113 = input_width - 1;
        if (_gid_y113 < 0)
            _gid_y113 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y113) * input_stride + _gid_x113);
        int _gid_x114 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y114 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x114 >= input_width)
            _gid_x114 = input_width - 1;
        if (_gid_y114 < 0)
            _gid_y114 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y114) * input_stride + _gid_x114);
        int _gid_x115 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y115 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x115 >= input_width)
            _gid_x115 = input_width - 1;
        if (_gid_y115 < 0)
            _gid_y115 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y115) * input_stride + _gid_x115);
        int _gid_x116 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y116 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x116 >= input_width)
            _gid_x116 = input_width - 1;
        if (_gid_y116 < 0)
            _gid_y116 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y116) * input_stride + _gid_x116);
        int _gid_x117 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y117 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x117 >= input_width)
            _gid_x117 = input_width - 1;
        if (_gid_y117 < 0)
            _gid_y117 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y117) * input_stride + _gid_x117);
        int _gid_x118 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y118 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x118 >= input_width)
            _gid_x118 = input_width - 1;
        if (_gid_y118 < 0)
            _gid_y118 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y118) * input_stride + _gid_x118);
        int _gid_x119 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y119 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x119 >= input_width)
            _gid_x119 = input_width - 1;
        if (_gid_y119 < 0)
            _gid_y119 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y119) * input_stride + _gid_x119);
        int _gid_x120 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y120 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x120 >= input_width)
            _gid_x120 = input_width - 1;
        if (_gid_y120 < 0)
            _gid_y120 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y120) * input_stride + _gid_x120);
        int _gid_x121 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y121 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x121 >= input_width)
            _gid_x121 = input_width - 1;
        if (_gid_y121 < 0)
            _gid_y121 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y121) * input_stride + _gid_x121);
        int _gid_x122 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y122 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x122 >= input_width)
            _gid_x122 = input_width - 1;
        if (_gid_y122 < 0)
            _gid_y122 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y122) * input_stride + _gid_x122);
        int _gid_x123 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y123 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x123 >= input_width)
            _gid_x123 = input_width - 1;
        if (_gid_y123 < 0)
            _gid_y123 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y123) * input_stride + _gid_x123);
        int _gid_x124 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y124 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x124 >= input_width)
            _gid_x124 = input_width - 1;
        if (_gid_y124 < 0)
            _gid_y124 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y124) * input_stride + _gid_x124);
        int _gid_x125 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y125 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x125 >= input_width)
            _gid_x125 = input_width - 1;
        if (_gid_y125 < 0)
            _gid_y125 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y125) * input_stride + _gid_x125);
        int _gid_x126 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y126 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x126 >= input_width)
            _gid_x126 = input_width - 1;
        if (_gid_y126 < 0)
            _gid_y126 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y126) * input_stride + _gid_x126);
        int _gid_x127 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y127 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x127 >= input_width)
            _gid_x127 = input_width - 1;
        if (_gid_y127 < 0)
            _gid_y127 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y127) * input_stride + _gid_x127);
        int _gid_x128 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y128 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x128 >= input_width)
            _gid_x128 = input_width - 1;
        if (_gid_y128 < 0)
            _gid_y128 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y128) * input_stride + _gid_x128);
        int _gid_x129 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y129 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x129 >= input_width)
            _gid_x129 = input_width - 1;
        if (_gid_y129 < 0)
            _gid_y129 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y129) * input_stride + _gid_x129);
        int _gid_x130 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y130 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x130 >= input_width)
            _gid_x130 = input_width - 1;
        if (_gid_y130 < 0)
            _gid_y130 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y130) * input_stride + _gid_x130);
        int _gid_x131 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y131 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x131 >= input_width)
            _gid_x131 = input_width - 1;
        if (_gid_y131 < 0)
            _gid_y131 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y131) * input_stride + _gid_x131);
        int _gid_x132 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y132 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x132 >= input_width)
            _gid_x132 = input_width - 1;
        if (_gid_y132 < 0)
            _gid_y132 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y132) * input_stride + _gid_x132);
        int _gid_x133 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y133 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x133 >= input_width)
            _gid_x133 = input_width - 1;
        if (_gid_y133 < 0)
            _gid_y133 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y133) * input_stride + _gid_x133);
        int _gid_x134 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y134 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x134 >= input_width)
            _gid_x134 = input_width - 1;
        if (_gid_y134 < 0)
            _gid_y134 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y134) * input_stride + _gid_x134);
        int _gid_x135 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y135 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x135 >= input_width)
            _gid_x135 = input_width - 1;
        if (_gid_y135 < 0)
            _gid_y135 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y135) * input_stride + _gid_x135);
        int _gid_x136 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y136 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x136 >= input_width)
            _gid_x136 = input_width - 1;
        if (_gid_y136 < 0)
            _gid_y136 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y136) * input_stride + _gid_x136);
        int _gid_x137 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y137 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x137 >= input_width)
            _gid_x137 = input_width - 1;
        if (_gid_y137 < 0)
            _gid_y137 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y137) * input_stride + _gid_x137);
        int _gid_x138 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y138 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x138 >= input_width)
            _gid_x138 = input_width - 1;
        if (_gid_y138 < 0)
            _gid_y138 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y138) * input_stride + _gid_x138);
        int _gid_x139 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y139 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x139 >= input_width)
            _gid_x139 = input_width - 1;
        if (_gid_y139 < 0)
            _gid_y139 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y139) * input_stride + _gid_x139);
        int _gid_x140 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y140 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x140 >= input_width)
            _gid_x140 = input_width - 1;
        if (_gid_y140 < 0)
            _gid_y140 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y140) * input_stride + _gid_x140);
        int _gid_x141 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y141 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x141 >= input_width)
            _gid_x141 = input_width - 1;
        if (_gid_y141 < 0)
            _gid_y141 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y141) * input_stride + _gid_x141);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp142 = 0.F;
                {
                    _tmp142 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp142 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp142 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp142 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp142 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp142 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp142 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp142 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp143 = 0.F;
                {
                    _tmp143 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp143 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp143 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp143 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp143 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp143 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp143 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp143 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp144 = 0.F;
                {
                    _tmp144 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp144 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp144 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp144 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp144 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp144 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp144 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp144 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp145 = 0.F;
                {
                    _tmp145 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp145 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp145 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp145 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp145 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp145 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp145 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp145 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp146 = 0.F;
                {
                    _tmp146 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp146 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp146 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp146 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp146 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp146 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp146 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp146 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp147 = 0.F;
                {
                    _tmp147 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp147 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp147 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp147 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp147 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp147 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp147 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp147 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp148 = 0.F;
                {
                    _tmp148 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp148 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp148 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp148 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp148 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp148 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp148 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp148 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp149 = 0.F;
                {
                    _tmp149 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp149 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp149 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp149 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp149 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp149 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp149 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp149 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        int _gid_x150 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y150 = gid_y + (-3);
        if (_gid_y150 < 0)
            _gid_y150 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y150) * input_stride + _gid_x150);
        int _gid_x151 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y151 = gid_y + (-3);
        if (_gid_y151 < 0)
            _gid_y151 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y151) * input_stride + _gid_x151);
        int _gid_x152 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y152 = gid_y + (-3);
        if (_gid_y152 < 0)
            _gid_y152 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y152) * input_stride + _gid_x152);
        int _gid_x153 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y153 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y153 < 0)
            _gid_y153 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y153) * input_stride + _gid_x153);
        int _gid_x154 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y154 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y154 < 0)
            _gid_y154 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y154) * input_stride + _gid_x154);
        int _gid_x155 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y155 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y155 < 0)
            _gid_y155 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y155) * input_stride + _gid_x155);
        int _gid_x156 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y156 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y156 < 0)
            _gid_y156 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y156) * input_stride + _gid_x156);
        int _gid_x157 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y157 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y157 < 0)
            _gid_y157 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y157) * input_stride + _gid_x157);
        int _gid_x158 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y158 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y158 < 0)
            _gid_y158 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y158) * input_stride + _gid_x158);
        int _gid_x159 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y159 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y159 < 0)
            _gid_y159 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y159) * input_stride + _gid_x159);
        int _gid_x160 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y160 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y160 < 0)
            _gid_y160 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y160) * input_stride + _gid_x160);
        int _gid_x161 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y161 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y161 < 0)
            _gid_y161 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y161) * input_stride + _gid_x161);
        int _gid_x162 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y162 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y162 < 0)
            _gid_y162 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y162) * input_stride + _gid_x162);
        int _gid_x163 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y163 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y163 < 0)
            _gid_y163 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y163) * input_stride + _gid_x163);
        int _gid_x164 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y164 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y164 < 0)
            _gid_y164 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y164) * input_stride + _gid_x164);
        int _gid_x165 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y165 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y165 < 0)
            _gid_y165 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y165) * input_stride + _gid_x165);
        int _gid_x166 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y166 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y166 < 0)
            _gid_y166 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y166) * input_stride + _gid_x166);
        int _gid_x167 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y167 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y167 < 0)
            _gid_y167 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y167) * input_stride + _gid_x167);
        int _gid_x168 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y168 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y168 < 0)
            _gid_y168 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y168) * input_stride + _gid_x168);
        int _gid_x169 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y169 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y169 < 0)
            _gid_y169 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y169) * input_stride + _gid_x169);
        int _gid_x170 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y170 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y170 < 0)
            _gid_y170 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y170) * input_stride + _gid_x170);
        int _gid_x171 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y171 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y171 < 0)
            _gid_y171 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y171) * input_stride + _gid_x171);
        int _gid_x172 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y172 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y172 < 0)
            _gid_y172 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y172) * input_stride + _gid_x172);
        int _gid_x173 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y173 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y173 < 0)
            _gid_y173 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y173) * input_stride + _gid_x173);
        int _gid_x174 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y174 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y174 < 0)
            _gid_y174 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y174) * input_stride + _gid_x174);
        int _gid_x175 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y175 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y175 < 0)
            _gid_y175 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y175) * input_stride + _gid_x175);
        int _gid_x176 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y176 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y176 < 0)
            _gid_y176 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y176) * input_stride + _gid_x176);
        int _gid_x177 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y177 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y177 < 0)
            _gid_y177 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y177) * input_stride + _gid_x177);
        int _gid_x178 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y178 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y178 < 0)
            _gid_y178 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y178) * input_stride + _gid_x178);
        int _gid_x179 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y179 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y179 < 0)
            _gid_y179 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y179) * input_stride + _gid_x179);
        int _gid_x180 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y180 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y180 < 0)
            _gid_y180 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y180) * input_stride + _gid_x180);
        int _gid_x181 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y181 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y181 < 0)
            _gid_y181 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y181) * input_stride + _gid_x181);
        int _gid_x182 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y182 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y182 < 0)
            _gid_y182 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y182) * input_stride + _gid_x182);
        int _gid_x183 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y183 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y183 < 0)
            _gid_y183 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y183) * input_stride + _gid_x183);
        int _gid_x184 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y184 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y184 < 0)
            _gid_y184 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y184) * input_stride + _gid_x184);
        int _gid_x185 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y185 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y185 < 0)
            _gid_y185 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y185) * input_stride + _gid_x185);
        int _gid_x186 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y186 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y186 < 0)
            _gid_y186 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y186) * input_stride + _gid_x186);
        int _gid_x187 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y187 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y187 < 0)
            _gid_y187 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y187) * input_stride + _gid_x187);
        int _gid_x188 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y188 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y188 < 0)
            _gid_y188 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y188) * input_stride + _gid_x188);
        int _gid_x189 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y189 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y189 < 0)
            _gid_y189 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y189) * input_stride + _gid_x189);
        int _gid_x190 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y190 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y190 < 0)
            _gid_y190 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y190) * input_stride + _gid_x190);
        int _gid_x191 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y191 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y191 < 0)
            _gid_y191 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y191) * input_stride + _gid_x191);
        __syncthreads();
        {
            float _tmp192 = 0.F;
            {
                _tmp192 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp192 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp192 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp192 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp192 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp192 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp192 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp192 + 0.5F);
        }
        {
            float _tmp193 = 0.F;
            {
                _tmp193 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp193 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp193 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp193 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp193 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp193 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp193 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp193 + 0.5F);
        }
        {
            float _tmp194 = 0.F;
            {
                _tmp194 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp194 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp194 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp194 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp194 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp194 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp194 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp194 + 0.5F);
        }
        {
            float _tmp195 = 0.F;
            {
                _tmp195 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp195 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp195 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp195 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp195 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp195 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp195 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp195 + 0.5F);
        }
        {
            float _tmp196 = 0.F;
            {
                _tmp196 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp196 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp196 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp196 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp196 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp196 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp196 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp196 + 0.5F);
        }
        {
            float _tmp197 = 0.F;
            {
                _tmp197 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp197 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp197 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp197 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp197 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp197 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp197 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp197 + 0.5F);
        }
        {
            float _tmp198 = 0.F;
            {
                _tmp198 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp198 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp198 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp198 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp198 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp198 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp198 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp198 + 0.5F);
        }
        {
            float _tmp199 = 0.F;
            {
                _tmp199 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp199 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp199 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp199 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp199 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp199 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp199 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp199 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_BL:
    {
        int _gid_x200 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y200 = gid_y + (-3);
        if (_gid_y200 >= input_height)
            _gid_y200 = input_height - 1;
        if (_gid_x200 < 0)
            _gid_x200 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y200) * input_stride + _gid_x200);
        int _gid_x201 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y201 = gid_y + (-3);
        if (_gid_y201 >= input_height)
            _gid_y201 = input_height - 1;
        if (_gid_x201 < 0)
            _gid_x201 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y201) * input_stride + _gid_x201);
        int _gid_x202 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y202 = gid_y + (-3);
        if (_gid_y202 >= input_height)
            _gid_y202 = input_height - 1;
        if (_gid_x202 < 0)
            _gid_x202 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y202) * input_stride + _gid_x202);
        int _gid_x203 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y203 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y203 >= input_height)
            _gid_y203 = input_height - 1;
        if (_gid_x203 < 0)
            _gid_x203 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y203) * input_stride + _gid_x203);
        int _gid_x204 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y204 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y204 >= input_height)
            _gid_y204 = input_height - 1;
        if (_gid_x204 < 0)
            _gid_x204 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y204) * input_stride + _gid_x204);
        int _gid_x205 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y205 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y205 >= input_height)
            _gid_y205 = input_height - 1;
        if (_gid_x205 < 0)
            _gid_x205 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y205) * input_stride + _gid_x205);
        int _gid_x206 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y206 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y206 >= input_height)
            _gid_y206 = input_height - 1;
        if (_gid_x206 < 0)
            _gid_x206 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y206) * input_stride + _gid_x206);
        int _gid_x207 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y207 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y207 >= input_height)
            _gid_y207 = input_height - 1;
        if (_gid_x207 < 0)
            _gid_x207 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y207) * input_stride + _gid_x207);
        int _gid_x208 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y208 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y208 >= input_height)
            _gid_y208 = input_height - 1;
        if (_gid_x208 < 0)
            _gid_x208 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y208) * input_stride + _gid_x208);
        int _gid_x209 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y209 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y209 >= input_height)
            _gid_y209 = input_height - 1;
        if (_gid_x209 < 0)
            _gid_x209 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y209) * input_stride + _gid_x209);
        int _gid_x210 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y210 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y210 >= input_height)
            _gid_y210 = input_height - 1;
        if (_gid_x210 < 0)
            _gid_x210 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y210) * input_stride + _gid_x210);
        int _gid_x211 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y211 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y211 >= input_height)
            _gid_y211 = input_height - 1;
        if (_gid_x211 < 0)
            _gid_x211 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y211) * input_stride + _gid_x211);
        int _gid_x212 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y212 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y212 >= input_height)
            _gid_y212 = input_height - 1;
        if (_gid_x212 < 0)
            _gid_x212 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y212) * input_stride + _gid_x212);
        int _gid_x213 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y213 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y213 >= input_height)
            _gid_y213 = input_height - 1;
        if (_gid_x213 < 0)
            _gid_x213 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y213) * input_stride + _gid_x213);
        int _gid_x214 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y214 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y214 >= input_height)
            _gid_y214 = input_height - 1;
        if (_gid_x214 < 0)
            _gid_x214 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y214) * input_stride + _gid_x214);
        int _gid_x215 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y215 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y215 >= input_height)
            _gid_y215 = input_height - 1;
        if (_gid_x215 < 0)
            _gid_x215 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y215) * input_stride + _gid_x215);
        int _gid_x216 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y216 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y216 >= input_height)
            _gid_y216 = input_height - 1;
        if (_gid_x216 < 0)
            _gid_x216 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y216) * input_stride + _gid_x216);
        int _gid_x217 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y217 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y217 >= input_height)
            _gid_y217 = input_height - 1;
        if (_gid_x217 < 0)
            _gid_x217 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y217) * input_stride + _gid_x217);
        int _gid_x218 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y218 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y218 >= input_height)
            _gid_y218 = input_height - 1;
        if (_gid_x218 < 0)
            _gid_x218 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y218) * input_stride + _gid_x218);
        int _gid_x219 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y219 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y219 >= input_height)
            _gid_y219 = input_height - 1;
        if (_gid_x219 < 0)
            _gid_x219 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y219) * input_stride + _gid_x219);
        int _gid_x220 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y220 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y220 >= input_height)
            _gid_y220 = input_height - 1;
        if (_gid_x220 < 0)
            _gid_x220 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y220) * input_stride + _gid_x220);
        int _gid_x221 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y221 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y221 >= input_height)
            _gid_y221 = input_height - 1;
        if (_gid_x221 < 0)
            _gid_x221 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y221) * input_stride + _gid_x221);
        int _gid_x222 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y222 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y222 >= input_height)
            _gid_y222 = input_height - 1;
        if (_gid_x222 < 0)
            _gid_x222 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y222) * input_stride + _gid_x222);
        int _gid_x223 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y223 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y223 >= input_height)
            _gid_y223 = input_height - 1;
        if (_gid_x223 < 0)
            _gid_x223 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y223) * input_stride + _gid_x223);
        int _gid_x224 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y224 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y224 >= input_height)
            _gid_y224 = input_height - 1;
        if (_gid_x224 < 0)
            _gid_x224 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y224) * input_stride + _gid_x224);
        int _gid_x225 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y225 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y225 >= input_height)
            _gid_y225 = input_height - 1;
        if (_gid_x225 < 0)
            _gid_x225 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y225) * input_stride + _gid_x225);
        int _gid_x226 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y226 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y226 >= input_height)
            _gid_y226 = input_height - 1;
        if (_gid_x226 < 0)
            _gid_x226 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y226) * input_stride + _gid_x226);
        int _gid_x227 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y227 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y227 >= input_height)
            _gid_y227 = input_height - 1;
        if (_gid_x227 < 0)
            _gid_x227 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y227) * input_stride + _gid_x227);
        int _gid_x228 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y228 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y228 >= input_height)
            _gid_y228 = input_height - 1;
        if (_gid_x228 < 0)
            _gid_x228 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y228) * input_stride + _gid_x228);
        int _gid_x229 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y229 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y229 >= input_height)
            _gid_y229 = input_height - 1;
        if (_gid_x229 < 0)
            _gid_x229 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y229) * input_stride + _gid_x229);
        int _gid_x230 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y230 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y230 >= input_height)
            _gid_y230 = input_height - 1;
        if (_gid_x230 < 0)
            _gid_x230 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y230) * input_stride + _gid_x230);
        int _gid_x231 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y231 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y231 >= input_height)
            _gid_y231 = input_height - 1;
        if (_gid_x231 < 0)
            _gid_x231 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y231) * input_stride + _gid_x231);
        int _gid_x232 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y232 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y232 >= input_height)
            _gid_y232 = input_height - 1;
        if (_gid_x232 < 0)
            _gid_x232 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y232) * input_stride + _gid_x232);
        int _gid_x233 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y233 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y233 >= input_height)
            _gid_y233 = input_height - 1;
        if (_gid_x233 < 0)
            _gid_x233 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y233) * input_stride + _gid_x233);
        int _gid_x234 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y234 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y234 >= input_height)
            _gid_y234 = input_height - 1;
        if (_gid_x234 < 0)
            _gid_x234 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y234) * input_stride + _gid_x234);
        int _gid_x235 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y235 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y235 >= input_height)
            _gid_y235 = input_height - 1;
        if (_gid_x235 < 0)
            _gid_x235 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y235) * input_stride + _gid_x235);
        int _gid_x236 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y236 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y236 >= input_height)
            _gid_y236 = input_height - 1;
        if (_gid_x236 < 0)
            _gid_x236 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y236) * input_stride + _gid_x236);
        int _gid_x237 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y237 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y237 >= input_height)
            _gid_y237 = input_height - 1;
        if (_gid_x237 < 0)
            _gid_x237 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y237) * input_stride + _gid_x237);
        int _gid_x238 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y238 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y238 >= input_height)
            _gid_y238 = input_height - 1;
        if (_gid_x238 < 0)
            _gid_x238 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y238) * input_stride + _gid_x238);
        int _gid_x239 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y239 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y239 >= input_height)
            _gid_y239 = input_height - 1;
        if (_gid_x239 < 0)
            _gid_x239 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y239) * input_stride + _gid_x239);
        int _gid_x240 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y240 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y240 >= input_height)
            _gid_y240 = input_height - 1;
        if (_gid_x240 < 0)
            _gid_x240 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y240) * input_stride + _gid_x240);
        int _gid_x241 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y241 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y241 >= input_height)
            _gid_y241 = input_height - 1;
        if (_gid_x241 < 0)
            _gid_x241 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y241) * input_stride + _gid_x241);
        __syncthreads();
        if (gid_y < iter_height) {
            float _tmp242 = 0.F;
            {
                _tmp242 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp242 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp242 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp242 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp242 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp242 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp242 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp242 + 0.5F);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp243 = 0.F;
            {
                _tmp243 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp243 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp243 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp243 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp243 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp243 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp243 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp243 + 0.5F);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp244 = 0.F;
            {
                _tmp244 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp244 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp244 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp244 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp244 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp244 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp244 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp244 + 0.5F);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp245 = 0.F;
            {
                _tmp245 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp245 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp245 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp245 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp245 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp245 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp245 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp245 + 0.5F);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp246 = 0.F;
            {
                _tmp246 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp246 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp246 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp246 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp246 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp246 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp246 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp246 + 0.5F);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp247 = 0.F;
            {
                _tmp247 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp247 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp247 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp247 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp247 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp247 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp247 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp247 + 0.5F);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp248 = 0.F;
            {
                _tmp248 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp248 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp248 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp248 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp248 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp248 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp248 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp248 + 0.5F);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp249 = 0.F;
            {
                _tmp249 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp249 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp249 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp249 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp249 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp249 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp249 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp249 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_BR:
    {
        int _gid_x250 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y250 = gid_y + (-3);
        if (_gid_x250 >= input_width)
            _gid_x250 = input_width - 1;
        if (_gid_y250 >= input_height)
            _gid_y250 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y250) * input_stride + _gid_x250);
        int _gid_x251 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y251 = gid_y + (-3);
        if (_gid_x251 >= input_width)
            _gid_x251 = input_width - 1;
        if (_gid_y251 >= input_height)
            _gid_y251 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y251) * input_stride + _gid_x251);
        int _gid_x252 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y252 = gid_y + (-3);
        if (_gid_x252 >= input_width)
            _gid_x252 = input_width - 1;
        if (_gid_y252 >= input_height)
            _gid_y252 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y252) * input_stride + _gid_x252);
        int _gid_x253 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y253 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x253 >= input_width)
            _gid_x253 = input_width - 1;
        if (_gid_y253 >= input_height)
            _gid_y253 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y253) * input_stride + _gid_x253);
        int _gid_x254 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y254 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x254 >= input_width)
            _gid_x254 = input_width - 1;
        if (_gid_y254 >= input_height)
            _gid_y254 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y254) * input_stride + _gid_x254);
        int _gid_x255 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y255 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x255 >= input_width)
            _gid_x255 = input_width - 1;
        if (_gid_y255 >= input_height)
            _gid_y255 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y255) * input_stride + _gid_x255);
        int _gid_x256 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y256 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x256 >= input_width)
            _gid_x256 = input_width - 1;
        if (_gid_y256 >= input_height)
            _gid_y256 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y256) * input_stride + _gid_x256);
        int _gid_x257 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y257 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x257 >= input_width)
            _gid_x257 = input_width - 1;
        if (_gid_y257 >= input_height)
            _gid_y257 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y257) * input_stride + _gid_x257);
        int _gid_x258 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y258 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x258 >= input_width)
            _gid_x258 = input_width - 1;
        if (_gid_y258 >= input_height)
            _gid_y258 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y258) * input_stride + _gid_x258);
        int _gid_x259 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y259 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x259 >= input_width)
            _gid_x259 = input_width - 1;
        if (_gid_y259 >= input_height)
            _gid_y259 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y259) * input_stride + _gid_x259);
        int _gid_x260 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y260 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x260 >= input_width)
            _gid_x260 = input_width - 1;
        if (_gid_y260 >= input_height)
            _gid_y260 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y260) * input_stride + _gid_x260);
        int _gid_x261 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y261 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x261 >= input_width)
            _gid_x261 = input_width - 1;
        if (_gid_y261 >= input_height)
            _gid_y261 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y261) * input_stride + _gid_x261);
        int _gid_x262 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y262 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x262 >= input_width)
            _gid_x262 = input_width - 1;
        if (_gid_y262 >= input_height)
            _gid_y262 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y262) * input_stride + _gid_x262);
        int _gid_x263 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y263 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x263 >= input_width)
            _gid_x263 = input_width - 1;
        if (_gid_y263 >= input_height)
            _gid_y263 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y263) * input_stride + _gid_x263);
        int _gid_x264 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y264 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x264 >= input_width)
            _gid_x264 = input_width - 1;
        if (_gid_y264 >= input_height)
            _gid_y264 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y264) * input_stride + _gid_x264);
        int _gid_x265 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y265 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x265 >= input_width)
            _gid_x265 = input_width - 1;
        if (_gid_y265 >= input_height)
            _gid_y265 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y265) * input_stride + _gid_x265);
        int _gid_x266 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y266 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x266 >= input_width)
            _gid_x266 = input_width - 1;
        if (_gid_y266 >= input_height)
            _gid_y266 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y266) * input_stride + _gid_x266);
        int _gid_x267 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y267 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x267 >= input_width)
            _gid_x267 = input_width - 1;
        if (_gid_y267 >= input_height)
            _gid_y267 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y267) * input_stride + _gid_x267);
        int _gid_x268 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y268 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x268 >= input_width)
            _gid_x268 = input_width - 1;
        if (_gid_y268 >= input_height)
            _gid_y268 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y268) * input_stride + _gid_x268);
        int _gid_x269 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y269 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x269 >= input_width)
            _gid_x269 = input_width - 1;
        if (_gid_y269 >= input_height)
            _gid_y269 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y269) * input_stride + _gid_x269);
        int _gid_x270 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y270 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x270 >= input_width)
            _gid_x270 = input_width - 1;
        if (_gid_y270 >= input_height)
            _gid_y270 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y270) * input_stride + _gid_x270);
        int _gid_x271 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y271 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x271 >= input_width)
            _gid_x271 = input_width - 1;
        if (_gid_y271 >= input_height)
            _gid_y271 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y271) * input_stride + _gid_x271);
        int _gid_x272 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y272 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x272 >= input_width)
            _gid_x272 = input_width - 1;
        if (_gid_y272 >= input_height)
            _gid_y272 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y272) * input_stride + _gid_x272);
        int _gid_x273 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y273 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x273 >= input_width)
            _gid_x273 = input_width - 1;
        if (_gid_y273 >= input_height)
            _gid_y273 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y273) * input_stride + _gid_x273);
        int _gid_x274 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y274 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x274 >= input_width)
            _gid_x274 = input_width - 1;
        if (_gid_y274 >= input_height)
            _gid_y274 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y274) * input_stride + _gid_x274);
        int _gid_x275 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y275 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x275 >= input_width)
            _gid_x275 = input_width - 1;
        if (_gid_y275 >= input_height)
            _gid_y275 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y275) * input_stride + _gid_x275);
        int _gid_x276 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y276 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x276 >= input_width)
            _gid_x276 = input_width - 1;
        if (_gid_y276 >= input_height)
            _gid_y276 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y276) * input_stride + _gid_x276);
        int _gid_x277 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y277 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x277 >= input_width)
            _gid_x277 = input_width - 1;
        if (_gid_y277 >= input_height)
            _gid_y277 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y277) * input_stride + _gid_x277);
        int _gid_x278 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y278 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x278 >= input_width)
            _gid_x278 = input_width - 1;
        if (_gid_y278 >= input_height)
            _gid_y278 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y278) * input_stride + _gid_x278);
        int _gid_x279 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y279 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x279 >= input_width)
            _gid_x279 = input_width - 1;
        if (_gid_y279 >= input_height)
            _gid_y279 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y279) * input_stride + _gid_x279);
        int _gid_x280 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y280 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x280 >= input_width)
            _gid_x280 = input_width - 1;
        if (_gid_y280 >= input_height)
            _gid_y280 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y280) * input_stride + _gid_x280);
        int _gid_x281 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y281 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x281 >= input_width)
            _gid_x281 = input_width - 1;
        if (_gid_y281 >= input_height)
            _gid_y281 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y281) * input_stride + _gid_x281);
        int _gid_x282 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y282 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x282 >= input_width)
            _gid_x282 = input_width - 1;
        if (_gid_y282 >= input_height)
            _gid_y282 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y282) * input_stride + _gid_x282);
        int _gid_x283 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y283 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x283 >= input_width)
            _gid_x283 = input_width - 1;
        if (_gid_y283 >= input_height)
            _gid_y283 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y283) * input_stride + _gid_x283);
        int _gid_x284 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y284 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x284 >= input_width)
            _gid_x284 = input_width - 1;
        if (_gid_y284 >= input_height)
            _gid_y284 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y284) * input_stride + _gid_x284);
        int _gid_x285 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y285 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x285 >= input_width)
            _gid_x285 = input_width - 1;
        if (_gid_y285 >= input_height)
            _gid_y285 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y285) * input_stride + _gid_x285);
        int _gid_x286 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y286 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x286 >= input_width)
            _gid_x286 = input_width - 1;
        if (_gid_y286 >= input_height)
            _gid_y286 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y286) * input_stride + _gid_x286);
        int _gid_x287 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y287 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x287 >= input_width)
            _gid_x287 = input_width - 1;
        if (_gid_y287 >= input_height)
            _gid_y287 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y287) * input_stride + _gid_x287);
        int _gid_x288 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y288 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x288 >= input_width)
            _gid_x288 = input_width - 1;
        if (_gid_y288 >= input_height)
            _gid_y288 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y288) * input_stride + _gid_x288);
        int _gid_x289 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y289 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x289 >= input_width)
            _gid_x289 = input_width - 1;
        if (_gid_y289 >= input_height)
            _gid_y289 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y289) * input_stride + _gid_x289);
        int _gid_x290 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y290 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x290 >= input_width)
            _gid_x290 = input_width - 1;
        if (_gid_y290 >= input_height)
            _gid_y290 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y290) * input_stride + _gid_x290);
        int _gid_x291 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y291 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x291 >= input_width)
            _gid_x291 = input_width - 1;
        if (_gid_y291 >= input_height)
            _gid_y291 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y291) * input_stride + _gid_x291);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp292 = 0.F;
                {
                    _tmp292 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp292 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp292 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp292 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp292 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp292 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp292 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp292 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp293 = 0.F;
                {
                    _tmp293 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp293 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp293 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp293 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp293 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp293 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp293 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp293 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp294 = 0.F;
                {
                    _tmp294 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp294 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp294 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp294 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp294 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp294 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp294 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp294 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp295 = 0.F;
                {
                    _tmp295 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp295 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp295 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp295 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp295 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp295 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp295 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp295 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp296 = 0.F;
                {
                    _tmp296 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp296 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp296 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp296 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp296 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp296 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp296 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp296 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp297 = 0.F;
                {
                    _tmp297 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp297 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp297 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp297 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp297 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp297 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp297 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp297 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp298 = 0.F;
                {
                    _tmp298 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp298 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp298 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp298 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp298 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp298 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp298 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp298 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp299 = 0.F;
                {
                    _tmp299 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp299 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp299 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp299 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp299 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp299 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp299 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp299 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        int _gid_x300 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y300 = gid_y + (-3);
        if (_gid_y300 >= input_height)
            _gid_y300 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y300) * input_stride + _gid_x300);
        int _gid_x301 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y301 = gid_y + (-3);
        if (_gid_y301 >= input_height)
            _gid_y301 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y301) * input_stride + _gid_x301);
        int _gid_x302 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y302 = gid_y + (-3);
        if (_gid_y302 >= input_height)
            _gid_y302 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y302) * input_stride + _gid_x302);
        int _gid_x303 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y303 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y303 >= input_height)
            _gid_y303 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y303) * input_stride + _gid_x303);
        int _gid_x304 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y304 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y304 >= input_height)
            _gid_y304 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y304) * input_stride + _gid_x304);
        int _gid_x305 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y305 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y305 >= input_height)
            _gid_y305 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y305) * input_stride + _gid_x305);
        int _gid_x306 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y306 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y306 >= input_height)
            _gid_y306 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y306) * input_stride + _gid_x306);
        int _gid_x307 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y307 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y307 >= input_height)
            _gid_y307 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y307) * input_stride + _gid_x307);
        int _gid_x308 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y308 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y308 >= input_height)
            _gid_y308 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y308) * input_stride + _gid_x308);
        int _gid_x309 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y309 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y309 >= input_height)
            _gid_y309 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y309) * input_stride + _gid_x309);
        int _gid_x310 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y310 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y310 >= input_height)
            _gid_y310 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y310) * input_stride + _gid_x310);
        int _gid_x311 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y311 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y311 >= input_height)
            _gid_y311 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y311) * input_stride + _gid_x311);
        int _gid_x312 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y312 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y312 >= input_height)
            _gid_y312 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y312) * input_stride + _gid_x312);
        int _gid_x313 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y313 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y313 >= input_height)
            _gid_y313 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y313) * input_stride + _gid_x313);
        int _gid_x314 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y314 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y314 >= input_height)
            _gid_y314 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y314) * input_stride + _gid_x314);
        int _gid_x315 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y315 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y315 >= input_height)
            _gid_y315 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y315) * input_stride + _gid_x315);
        int _gid_x316 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y316 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y316 >= input_height)
            _gid_y316 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y316) * input_stride + _gid_x316);
        int _gid_x317 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y317 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y317 >= input_height)
            _gid_y317 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y317) * input_stride + _gid_x317);
        int _gid_x318 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y318 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y318 >= input_height)
            _gid_y318 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y318) * input_stride + _gid_x318);
        int _gid_x319 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y319 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y319 >= input_height)
            _gid_y319 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y319) * input_stride + _gid_x319);
        int _gid_x320 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y320 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y320 >= input_height)
            _gid_y320 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y320) * input_stride + _gid_x320);
        int _gid_x321 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y321 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y321 >= input_height)
            _gid_y321 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y321) * input_stride + _gid_x321);
        int _gid_x322 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y322 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y322 >= input_height)
            _gid_y322 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y322) * input_stride + _gid_x322);
        int _gid_x323 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y323 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y323 >= input_height)
            _gid_y323 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y323) * input_stride + _gid_x323);
        int _gid_x324 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y324 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y324 >= input_height)
            _gid_y324 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y324) * input_stride + _gid_x324);
        int _gid_x325 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y325 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y325 >= input_height)
            _gid_y325 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y325) * input_stride + _gid_x325);
        int _gid_x326 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y326 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y326 >= input_height)
            _gid_y326 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y326) * input_stride + _gid_x326);
        int _gid_x327 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y327 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y327 >= input_height)
            _gid_y327 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y327) * input_stride + _gid_x327);
        int _gid_x328 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y328 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y328 >= input_height)
            _gid_y328 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y328) * input_stride + _gid_x328);
        int _gid_x329 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y329 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y329 >= input_height)
            _gid_y329 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y329) * input_stride + _gid_x329);
        int _gid_x330 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y330 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y330 >= input_height)
            _gid_y330 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y330) * input_stride + _gid_x330);
        int _gid_x331 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y331 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y331 >= input_height)
            _gid_y331 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y331) * input_stride + _gid_x331);
        int _gid_x332 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y332 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y332 >= input_height)
            _gid_y332 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y332) * input_stride + _gid_x332);
        int _gid_x333 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y333 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y333 >= input_height)
            _gid_y333 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y333) * input_stride + _gid_x333);
        int _gid_x334 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y334 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y334 >= input_height)
            _gid_y334 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y334) * input_stride + _gid_x334);
        int _gid_x335 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y335 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y335 >= input_height)
            _gid_y335 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y335) * input_stride + _gid_x335);
        int _gid_x336 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y336 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y336 >= input_height)
            _gid_y336 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y336) * input_stride + _gid_x336);
        int _gid_x337 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y337 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y337 >= input_height)
            _gid_y337 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y337) * input_stride + _gid_x337);
        int _gid_x338 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y338 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y338 >= input_height)
            _gid_y338 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y338) * input_stride + _gid_x338);
        int _gid_x339 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y339 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y339 >= input_height)
            _gid_y339 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y339) * input_stride + _gid_x339);
        int _gid_x340 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y340 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y340 >= input_height)
            _gid_y340 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y340) * input_stride + _gid_x340);
        int _gid_x341 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y341 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y341 >= input_height)
            _gid_y341 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y341) * input_stride + _gid_x341);
        __syncthreads();
        if (gid_y < iter_height) {
            float _tmp342 = 0.F;
            {
                _tmp342 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp342 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp342 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp342 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp342 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp342 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp342 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp342 + 0.5F);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp343 = 0.F;
            {
                _tmp343 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp343 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp343 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp343 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp343 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp343 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp343 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp343 + 0.5F);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp344 = 0.F;
            {
                _tmp344 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp344 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp344 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp344 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp344 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp344 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp344 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp344 + 0.5F);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp345 = 0.F;
            {
                _tmp345 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp345 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp345 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp345 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp345 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp345 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp345 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp345 + 0.5F);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp346 = 0.F;
            {
                _tmp346 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp346 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp346 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp346 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp346 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp346 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp346 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp346 + 0.5F);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp347 = 0.F;
            {
                _tmp347 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp347 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp347 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp347 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp347 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp347 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp347 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp347 + 0.5F);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp348 = 0.F;
            {
                _tmp348 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp348 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp348 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp348 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp348 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp348 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp348 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp348 + 0.5F);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp349 = 0.F;
            {
                _tmp349 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp349 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp349 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp349 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp349 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp349 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp349 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp349 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        int _gid_x350 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y350 = gid_y + (-3);
        if (_gid_x350 >= input_width)
            _gid_x350 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y350) * input_stride + _gid_x350);
        int _gid_x351 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y351 = gid_y + (-3);
        if (_gid_x351 >= input_width)
            _gid_x351 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y351) * input_stride + _gid_x351);
        int _gid_x352 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y352 = gid_y + (-3);
        if (_gid_x352 >= input_width)
            _gid_x352 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y352) * input_stride + _gid_x352);
        int _gid_x353 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y353 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x353 >= input_width)
            _gid_x353 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y353) * input_stride + _gid_x353);
        int _gid_x354 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y354 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x354 >= input_width)
            _gid_x354 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y354) * input_stride + _gid_x354);
        int _gid_x355 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y355 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x355 >= input_width)
            _gid_x355 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y355) * input_stride + _gid_x355);
        int _gid_x356 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y356 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x356 >= input_width)
            _gid_x356 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y356) * input_stride + _gid_x356);
        int _gid_x357 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y357 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x357 >= input_width)
            _gid_x357 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y357) * input_stride + _gid_x357);
        int _gid_x358 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y358 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x358 >= input_width)
            _gid_x358 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y358) * input_stride + _gid_x358);
        int _gid_x359 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y359 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x359 >= input_width)
            _gid_x359 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y359) * input_stride + _gid_x359);
        int _gid_x360 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y360 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x360 >= input_width)
            _gid_x360 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y360) * input_stride + _gid_x360);
        int _gid_x361 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y361 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x361 >= input_width)
            _gid_x361 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y361) * input_stride + _gid_x361);
        int _gid_x362 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y362 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x362 >= input_width)
            _gid_x362 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y362) * input_stride + _gid_x362);
        int _gid_x363 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y363 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x363 >= input_width)
            _gid_x363 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y363) * input_stride + _gid_x363);
        int _gid_x364 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y364 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x364 >= input_width)
            _gid_x364 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y364) * input_stride + _gid_x364);
        int _gid_x365 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y365 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x365 >= input_width)
            _gid_x365 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y365) * input_stride + _gid_x365);
        int _gid_x366 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y366 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x366 >= input_width)
            _gid_x366 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y366) * input_stride + _gid_x366);
        int _gid_x367 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y367 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x367 >= input_width)
            _gid_x367 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y367) * input_stride + _gid_x367);
        int _gid_x368 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y368 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x368 >= input_width)
            _gid_x368 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y368) * input_stride + _gid_x368);
        int _gid_x369 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y369 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x369 >= input_width)
            _gid_x369 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y369) * input_stride + _gid_x369);
        int _gid_x370 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y370 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x370 >= input_width)
            _gid_x370 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y370) * input_stride + _gid_x370);
        int _gid_x371 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y371 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x371 >= input_width)
            _gid_x371 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y371) * input_stride + _gid_x371);
        int _gid_x372 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y372 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x372 >= input_width)
            _gid_x372 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y372) * input_stride + _gid_x372);
        int _gid_x373 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y373 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x373 >= input_width)
            _gid_x373 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y373) * input_stride + _gid_x373);
        int _gid_x374 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y374 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x374 >= input_width)
            _gid_x374 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y374) * input_stride + _gid_x374);
        int _gid_x375 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y375 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x375 >= input_width)
            _gid_x375 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y375) * input_stride + _gid_x375);
        int _gid_x376 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y376 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x376 >= input_width)
            _gid_x376 = input_width - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y376) * input_stride + _gid_x376);
        int _gid_x377 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y377 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x377 >= input_width)
            _gid_x377 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y377) * input_stride + _gid_x377);
        int _gid_x378 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y378 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x378 >= input_width)
            _gid_x378 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y378) * input_stride + _gid_x378);
        int _gid_x379 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y379 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x379 >= input_width)
            _gid_x379 = input_width - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y379) * input_stride + _gid_x379);
        int _gid_x380 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y380 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x380 >= input_width)
            _gid_x380 = input_width - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y380) * input_stride + _gid_x380);
        int _gid_x381 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y381 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x381 >= input_width)
            _gid_x381 = input_width - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y381) * input_stride + _gid_x381);
        int _gid_x382 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y382 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x382 >= input_width)
            _gid_x382 = input_width - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y382) * input_stride + _gid_x382);
        int _gid_x383 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y383 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x383 >= input_width)
            _gid_x383 = input_width - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y383) * input_stride + _gid_x383);
        int _gid_x384 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y384 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x384 >= input_width)
            _gid_x384 = input_width - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y384) * input_stride + _gid_x384);
        int _gid_x385 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y385 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x385 >= input_width)
            _gid_x385 = input_width - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y385) * input_stride + _gid_x385);
        int _gid_x386 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y386 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x386 >= input_width)
            _gid_x386 = input_width - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y386) * input_stride + _gid_x386);
        int _gid_x387 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y387 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x387 >= input_width)
            _gid_x387 = input_width - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y387) * input_stride + _gid_x387);
        int _gid_x388 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y388 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x388 >= input_width)
            _gid_x388 = input_width - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y388) * input_stride + _gid_x388);
        int _gid_x389 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y389 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x389 >= input_width)
            _gid_x389 = input_width - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y389) * input_stride + _gid_x389);
        int _gid_x390 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y390 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x390 >= input_width)
            _gid_x390 = input_width - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y390) * input_stride + _gid_x390);
        int _gid_x391 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y391 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x391 >= input_width)
            _gid_x391 = input_width - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y391) * input_stride + _gid_x391);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp392 = 0.F;
                {
                    _tmp392 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp392 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp392 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp392 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp392 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp392 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp392 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp392 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp393 = 0.F;
                {
                    _tmp393 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp393 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp393 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp393 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp393 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp393 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp393 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp393 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp394 = 0.F;
                {
                    _tmp394 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp394 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp394 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp394 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp394 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp394 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp394 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp394 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp395 = 0.F;
                {
                    _tmp395 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp395 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp395 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp395 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp395 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp395 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp395 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp395 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp396 = 0.F;
                {
                    _tmp396 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp396 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp396 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp396 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp396 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp396 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp396 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp396 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp397 = 0.F;
                {
                    _tmp397 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp397 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp397 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp397 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp397 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp397 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp397 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp397 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp398 = 0.F;
                {
                    _tmp398 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp398 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp398 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp398 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp398 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp398 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp398 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp398 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp399 = 0.F;
                {
                    _tmp399 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp399 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp399 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp399 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp399 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp399 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp399 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp399 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_L:
    {
        int _gid_x400 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y400 = gid_y + (-3);
        if (_gid_x400 < 0)
            _gid_x400 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y400) * input_stride + _gid_x400);
        int _gid_x401 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y401 = gid_y + (-3);
        if (_gid_x401 < 0)
            _gid_x401 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y401) * input_stride + _gid_x401);
        int _gid_x402 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y402 = gid_y + (-3);
        if (_gid_x402 < 0)
            _gid_x402 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y402) * input_stride + _gid_x402);
        int _gid_x403 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y403 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x403 < 0)
            _gid_x403 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y403) * input_stride + _gid_x403);
        int _gid_x404 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y404 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x404 < 0)
            _gid_x404 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y404) * input_stride + _gid_x404);
        int _gid_x405 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y405 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_x405 < 0)
            _gid_x405 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y405) * input_stride + _gid_x405);
        int _gid_x406 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y406 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x406 < 0)
            _gid_x406 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y406) * input_stride + _gid_x406);
        int _gid_x407 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y407 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x407 < 0)
            _gid_x407 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y407) * input_stride + _gid_x407);
        int _gid_x408 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y408 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_x408 < 0)
            _gid_x408 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y408) * input_stride + _gid_x408);
        int _gid_x409 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y409 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x409 < 0)
            _gid_x409 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y409) * input_stride + _gid_x409);
        int _gid_x410 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y410 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x410 < 0)
            _gid_x410 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y410) * input_stride + _gid_x410);
        int _gid_x411 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y411 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_x411 < 0)
            _gid_x411 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y411) * input_stride + _gid_x411);
        int _gid_x412 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y412 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x412 < 0)
            _gid_x412 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y412) * input_stride + _gid_x412);
        int _gid_x413 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y413 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x413 < 0)
            _gid_x413 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y413) * input_stride + _gid_x413);
        int _gid_x414 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y414 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_x414 < 0)
            _gid_x414 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y414) * input_stride + _gid_x414);
        int _gid_x415 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y415 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x415 < 0)
            _gid_x415 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y415) * input_stride + _gid_x415);
        int _gid_x416 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y416 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x416 < 0)
            _gid_x416 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y416) * input_stride + _gid_x416);
        int _gid_x417 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y417 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_x417 < 0)
            _gid_x417 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y417) * input_stride + _gid_x417);
        int _gid_x418 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y418 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x418 < 0)
            _gid_x418 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y418) * input_stride + _gid_x418);
        int _gid_x419 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y419 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x419 < 0)
            _gid_x419 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y419) * input_stride + _gid_x419);
        int _gid_x420 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y420 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_x420 < 0)
            _gid_x420 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y420) * input_stride + _gid_x420);
        int _gid_x421 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y421 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x421 < 0)
            _gid_x421 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y421) * input_stride + _gid_x421);
        int _gid_x422 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y422 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x422 < 0)
            _gid_x422 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y422) * input_stride + _gid_x422);
        int _gid_x423 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y423 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_x423 < 0)
            _gid_x423 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y423) * input_stride + _gid_x423);
        int _gid_x424 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y424 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x424 < 0)
            _gid_x424 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y424) * input_stride + _gid_x424);
        int _gid_x425 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y425 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x425 < 0)
            _gid_x425 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y425) * input_stride + _gid_x425);
        int _gid_x426 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y426 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_x426 < 0)
            _gid_x426 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y426) * input_stride + _gid_x426);
        int _gid_x427 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y427 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x427 < 0)
            _gid_x427 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y427) * input_stride + _gid_x427);
        int _gid_x428 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y428 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x428 < 0)
            _gid_x428 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y428) * input_stride + _gid_x428);
        int _gid_x429 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y429 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_x429 < 0)
            _gid_x429 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y429) * input_stride + _gid_x429);
        int _gid_x430 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y430 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x430 < 0)
            _gid_x430 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y430) * input_stride + _gid_x430);
        int _gid_x431 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y431 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x431 < 0)
            _gid_x431 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y431) * input_stride + _gid_x431);
        int _gid_x432 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y432 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_x432 < 0)
            _gid_x432 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y432) * input_stride + _gid_x432);
        int _gid_x433 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y433 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x433 < 0)
            _gid_x433 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y433) * input_stride + _gid_x433);
        int _gid_x434 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y434 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x434 < 0)
            _gid_x434 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y434) * input_stride + _gid_x434);
        int _gid_x435 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y435 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_x435 < 0)
            _gid_x435 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y435) * input_stride + _gid_x435);
        int _gid_x436 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y436 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x436 < 0)
            _gid_x436 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y436) * input_stride + _gid_x436);
        int _gid_x437 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y437 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x437 < 0)
            _gid_x437 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y437) * input_stride + _gid_x437);
        int _gid_x438 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y438 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_x438 < 0)
            _gid_x438 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y438) * input_stride + _gid_x438);
        int _gid_x439 = gid_x + 0 * (int)blockDim.x - 32;
        int _gid_y439 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x439 < 0)
            _gid_x439 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y439) * input_stride + _gid_x439);
        int _gid_x440 = gid_x + 1 * (int)blockDim.x - 32;
        int _gid_y440 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x440 < 0)
            _gid_x440 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y440) * input_stride + _gid_x440);
        int _gid_x441 = gid_x + 2 * (int)blockDim.x - 32;
        int _gid_y441 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_x441 < 0)
            _gid_x441 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (_gid_y441) * input_stride + _gid_x441);
        __syncthreads();
        {
            float _tmp442 = 0.F;
            {
                _tmp442 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp442 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp442 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp442 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp442 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp442 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp442 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp442 + 0.5F);
        }
        {
            float _tmp443 = 0.F;
            {
                _tmp443 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp443 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp443 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp443 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp443 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp443 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp443 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp443 + 0.5F);
        }
        {
            float _tmp444 = 0.F;
            {
                _tmp444 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp444 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp444 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp444 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp444 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp444 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp444 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp444 + 0.5F);
        }
        {
            float _tmp445 = 0.F;
            {
                _tmp445 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp445 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp445 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp445 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp445 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp445 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp445 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp445 + 0.5F);
        }
        {
            float _tmp446 = 0.F;
            {
                _tmp446 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp446 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp446 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp446 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp446 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp446 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp446 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp446 + 0.5F);
        }
        {
            float _tmp447 = 0.F;
            {
                _tmp447 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp447 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp447 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp447 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp447 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp447 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp447 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp447 + 0.5F);
        }
        {
            float _tmp448 = 0.F;
            {
                _tmp448 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp448 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp448 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp448 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp448 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp448 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp448 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp448 + 0.5F);
        }
        {
            float _tmp449 = 0.F;
            {
                _tmp449 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp449 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp449 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp449 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp449 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp449 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp449 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp449 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 1 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 1 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 1 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 2 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 2 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 2 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 3 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 3 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 3 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 4 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 4 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 4 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 5 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 5 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 5 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 6 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 6 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 6 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 7 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 7 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 7 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 8 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 8 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 8 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 9 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 9 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 9 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 10 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 10 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 10 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 11 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 11 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 11 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 12 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 12 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 12 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 13 * (int)blockDim.y + (-3)) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 13 * (int)blockDim.y + (-3)) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputXY, (gid_y + 13 * (int)blockDim.y + (-3)) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        __syncthreads();
        {
            float _tmp450 = 0.F;
            {
                _tmp450 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp450 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp450 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp450 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp450 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp450 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp450 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp450 + 0.5F);
        }
        {
            float _tmp451 = 0.F;
            {
                _tmp451 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp451 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp451 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp451 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp451 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp451 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp451 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp451 + 0.5F);
        }
        {
            float _tmp452 = 0.F;
            {
                _tmp452 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp452 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp452 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp452 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp452 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp452 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp452 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp452 + 0.5F);
        }
        {
            float _tmp453 = 0.F;
            {
                _tmp453 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp453 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp453 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp453 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp453 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp453 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp453 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp453 + 0.5F);
        }
        {
            float _tmp454 = 0.F;
            {
                _tmp454 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp454 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp454 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp454 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp454 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp454 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp454 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp454 + 0.5F);
        }
        {
            float _tmp455 = 0.F;
            {
                _tmp455 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp455 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp455 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp455 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp455 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp455 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp455 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp455 + 0.5F);
        }
        {
            float _tmp456 = 0.F;
            {
                _tmp456 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp456 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp456 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp456 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp456 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp456 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp456 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp456 + 0.5F);
        }
        {
            float _tmp457 = 0.F;
            {
                _tmp457 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp457 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.082959000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.064280000000000004 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.049806000000000003 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.029902000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.023168999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.010777999999999999 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp457 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp457 += 0.0083510000000000008 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp457 += 0.0064710000000000002 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp457 += 0.0030100000000000001 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp457 += 8.4099999999999995E-4 * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 3 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp457 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERXY_CU_

