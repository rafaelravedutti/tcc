#ifndef _CUGAUSSIANFILTERROWX_CU_
#define _CUGAUSSIANFILTERROWX_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<uchar, cudaTextureType1D, cudaReadModeElementType> _texinputX;
const textureReference *_texinputXRef;
__device__ __constant__ float _constmask_xX[1][19];


extern "C" {
__global__ __launch_bounds__ (32*1) void cuGaussianFilterRowXKernel(float * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int bh_start_left, int bh_start_right, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
    uchar _smeminput[8][97] __attribute__((shared));
    if (bh_fall_back)
        goto BH_FB;
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
        if (_gid_x0 >= input_width)
            _gid_x0 = input_width - 1;
        if (_gid_x0 < 0)
            _gid_x0 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x0);
        int _gid_x1 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x1 >= input_width)
            _gid_x1 = input_width - 1;
        if (_gid_x1 < 0)
            _gid_x1 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x1);
        int _gid_x2 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x2 >= input_width)
            _gid_x2 = input_width - 1;
        if (_gid_x2 < 0)
            _gid_x2 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x2);
        int _gid_x3 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x3 >= input_width)
            _gid_x3 = input_width - 1;
        if (_gid_x3 < 0)
            _gid_x3 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x3);
        int _gid_x4 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x4 >= input_width)
            _gid_x4 = input_width - 1;
        if (_gid_x4 < 0)
            _gid_x4 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x4);
        int _gid_x5 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x5 >= input_width)
            _gid_x5 = input_width - 1;
        if (_gid_x5 < 0)
            _gid_x5 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x5);
        int _gid_x6 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x6 >= input_width)
            _gid_x6 = input_width - 1;
        if (_gid_x6 < 0)
            _gid_x6 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x6);
        int _gid_x7 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x7 >= input_width)
            _gid_x7 = input_width - 1;
        if (_gid_x7 < 0)
            _gid_x7 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x7);
        int _gid_x8 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x8 >= input_width)
            _gid_x8 = input_width - 1;
        if (_gid_x8 < 0)
            _gid_x8 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x8);
        int _gid_x9 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x9 >= input_width)
            _gid_x9 = input_width - 1;
        if (_gid_x9 < 0)
            _gid_x9 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x9);
        int _gid_x10 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x10 >= input_width)
            _gid_x10 = input_width - 1;
        if (_gid_x10 < 0)
            _gid_x10 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x10);
        int _gid_x11 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x11 >= input_width)
            _gid_x11 = input_width - 1;
        if (_gid_x11 < 0)
            _gid_x11 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x11);
        int _gid_x12 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x12 >= input_width)
            _gid_x12 = input_width - 1;
        if (_gid_x12 < 0)
            _gid_x12 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x12);
        int _gid_x13 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x13 >= input_width)
            _gid_x13 = input_width - 1;
        if (_gid_x13 < 0)
            _gid_x13 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x13);
        int _gid_x14 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x14 >= input_width)
            _gid_x14 = input_width - 1;
        if (_gid_x14 < 0)
            _gid_x14 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x14);
        int _gid_x15 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x15 >= input_width)
            _gid_x15 = input_width - 1;
        if (_gid_x15 < 0)
            _gid_x15 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x15);
        int _gid_x16 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x16 >= input_width)
            _gid_x16 = input_width - 1;
        if (_gid_x16 < 0)
            _gid_x16 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x16);
        int _gid_x17 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x17 >= input_width)
            _gid_x17 = input_width - 1;
        if (_gid_x17 < 0)
            _gid_x17 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x17);
        int _gid_x18 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x18 >= input_width)
            _gid_x18 = input_width - 1;
        if (_gid_x18 < 0)
            _gid_x18 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x18);
        int _gid_x19 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x19 >= input_width)
            _gid_x19 = input_width - 1;
        if (_gid_x19 < 0)
            _gid_x19 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x19);
        int _gid_x20 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x20 >= input_width)
            _gid_x20 = input_width - 1;
        if (_gid_x20 < 0)
            _gid_x20 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x20);
        int _gid_x21 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x21 >= input_width)
            _gid_x21 = input_width - 1;
        if (_gid_x21 < 0)
            _gid_x21 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x21);
        int _gid_x22 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x22 >= input_width)
            _gid_x22 = input_width - 1;
        if (_gid_x22 < 0)
            _gid_x22 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x22);
        int _gid_x23 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x23 >= input_width)
            _gid_x23 = input_width - 1;
        if (_gid_x23 < 0)
            _gid_x23 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x23);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp24 = 0.F;
                {
                    _tmp24 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp24 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp24);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp25 = 0.F;
                {
                    _tmp25 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp25 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp25);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp26 = 0.F;
                {
                    _tmp26 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp26 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp26);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp27 = 0.F;
                {
                    _tmp27 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp27 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp27);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp28 = 0.F;
                {
                    _tmp28 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp28 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp28);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp29 = 0.F;
                {
                    _tmp29 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp29 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp29);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp30 = 0.F;
                {
                    _tmp30 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp30 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp30);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp31 = 0.F;
                {
                    _tmp31 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp31 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp31);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        int _gid_x32 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x32);
        int _gid_x33 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x33);
        int _gid_x34 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x34);
        int _gid_x35 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x35);
        int _gid_x36 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x36);
        int _gid_x37 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x37);
        int _gid_x38 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x38);
        int _gid_x39 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x39);
        int _gid_x40 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x40);
        int _gid_x41 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x41);
        int _gid_x42 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x42);
        int _gid_x43 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x43);
        int _gid_x44 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x44);
        int _gid_x45 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x45);
        int _gid_x46 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x46);
        int _gid_x47 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x47);
        int _gid_x48 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x48);
        int _gid_x49 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x49);
        int _gid_x50 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x50);
        int _gid_x51 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x51);
        int _gid_x52 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x52);
        int _gid_x53 = gid_x + 0 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x53);
        int _gid_x54 = gid_x + 1 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x54);
        int _gid_x55 = gid_x + 2 * (int)blockDim.x - 32;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x55);
        __syncthreads();
        if (gid_y < iter_height) {
            float _tmp56 = 0.F;
            {
                _tmp56 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp56 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp56);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp57 = 0.F;
            {
                _tmp57 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp57 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp57);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp58 = 0.F;
            {
                _tmp58 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp58 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp58);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp59 = 0.F;
            {
                _tmp59 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp59 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp59);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp60 = 0.F;
            {
                _tmp60 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp60 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp60);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp61 = 0.F;
            {
                _tmp61 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp61 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp61);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp62 = 0.F;
            {
                _tmp62 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp62 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp62);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp63 = 0.F;
            {
                _tmp63 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp63 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp63);
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        int _gid_x64 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x64 >= input_width)
            _gid_x64 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x64);
        int _gid_x65 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x65 >= input_width)
            _gid_x65 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x65);
        int _gid_x66 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x66 >= input_width)
            _gid_x66 = input_width - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x66);
        int _gid_x67 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x67 >= input_width)
            _gid_x67 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x67);
        int _gid_x68 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x68 >= input_width)
            _gid_x68 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x68);
        int _gid_x69 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x69 >= input_width)
            _gid_x69 = input_width - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x69);
        int _gid_x70 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x70 >= input_width)
            _gid_x70 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x70);
        int _gid_x71 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x71 >= input_width)
            _gid_x71 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x71);
        int _gid_x72 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x72 >= input_width)
            _gid_x72 = input_width - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x72);
        int _gid_x73 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x73 >= input_width)
            _gid_x73 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x73);
        int _gid_x74 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x74 >= input_width)
            _gid_x74 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x74);
        int _gid_x75 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x75 >= input_width)
            _gid_x75 = input_width - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x75);
        int _gid_x76 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x76 >= input_width)
            _gid_x76 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x76);
        int _gid_x77 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x77 >= input_width)
            _gid_x77 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x77);
        int _gid_x78 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x78 >= input_width)
            _gid_x78 = input_width - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x78);
        int _gid_x79 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x79 >= input_width)
            _gid_x79 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x79);
        int _gid_x80 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x80 >= input_width)
            _gid_x80 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x80);
        int _gid_x81 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x81 >= input_width)
            _gid_x81 = input_width - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x81);
        int _gid_x82 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x82 >= input_width)
            _gid_x82 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x82);
        int _gid_x83 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x83 >= input_width)
            _gid_x83 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x83);
        int _gid_x84 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x84 >= input_width)
            _gid_x84 = input_width - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x84);
        int _gid_x85 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x85 >= input_width)
            _gid_x85 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x85);
        int _gid_x86 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x86 >= input_width)
            _gid_x86 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x86);
        int _gid_x87 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x87 >= input_width)
            _gid_x87 = input_width - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x87);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp88 = 0.F;
                {
                    _tmp88 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp88 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp88);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp89 = 0.F;
                {
                    _tmp89 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp89 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp89);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp90 = 0.F;
                {
                    _tmp90 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp90 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp90);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp91 = 0.F;
                {
                    _tmp91 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp91 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp91);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp92 = 0.F;
                {
                    _tmp92 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp92 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp92);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp93 = 0.F;
                {
                    _tmp93 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp93 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp93);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp94 = 0.F;
                {
                    _tmp94 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp94 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp94);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp95 = 0.F;
                {
                    _tmp95 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
                }
                {
                    _tmp95 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp95);
            }
        }
    }
    goto BH_EXIT;
  BH_L:
    {
        int _gid_x96 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x96 < 0)
            _gid_x96 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x96);
        int _gid_x97 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x97 < 0)
            _gid_x97 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x97);
        int _gid_x98 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x98 < 0)
            _gid_x98 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + _gid_x98);
        int _gid_x99 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x99 < 0)
            _gid_x99 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x99);
        int _gid_x100 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x100 < 0)
            _gid_x100 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x100);
        int _gid_x101 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x101 < 0)
            _gid_x101 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + _gid_x101);
        int _gid_x102 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x102 < 0)
            _gid_x102 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x102);
        int _gid_x103 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x103 < 0)
            _gid_x103 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x103);
        int _gid_x104 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x104 < 0)
            _gid_x104 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + _gid_x104);
        int _gid_x105 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x105 < 0)
            _gid_x105 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x105);
        int _gid_x106 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x106 < 0)
            _gid_x106 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x106);
        int _gid_x107 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x107 < 0)
            _gid_x107 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + _gid_x107);
        int _gid_x108 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x108 < 0)
            _gid_x108 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x108);
        int _gid_x109 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x109 < 0)
            _gid_x109 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x109);
        int _gid_x110 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x110 < 0)
            _gid_x110 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + _gid_x110);
        int _gid_x111 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x111 < 0)
            _gid_x111 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x111);
        int _gid_x112 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x112 < 0)
            _gid_x112 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x112);
        int _gid_x113 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x113 < 0)
            _gid_x113 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + _gid_x113);
        int _gid_x114 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x114 < 0)
            _gid_x114 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x114);
        int _gid_x115 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x115 < 0)
            _gid_x115 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x115);
        int _gid_x116 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x116 < 0)
            _gid_x116 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + _gid_x116);
        int _gid_x117 = gid_x + 0 * (int)blockDim.x - 32;
        if (_gid_x117 < 0)
            _gid_x117 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x117);
        int _gid_x118 = gid_x + 1 * (int)blockDim.x - 32;
        if (_gid_x118 < 0)
            _gid_x118 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x118);
        int _gid_x119 = gid_x + 2 * (int)blockDim.x - 32;
        if (_gid_x119 < 0)
            _gid_x119 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + _gid_x119);
        __syncthreads();
        if (gid_y < iter_height) {
            float _tmp120 = 0.F;
            {
                _tmp120 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp120 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp120);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp121 = 0.F;
            {
                _tmp121 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp121 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp121);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp122 = 0.F;
            {
                _tmp122 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp122 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp122);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp123 = 0.F;
            {
                _tmp123 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp123 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp123);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp124 = 0.F;
            {
                _tmp124 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp124 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp124);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp125 = 0.F;
            {
                _tmp125 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp125 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp125);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp126 = 0.F;
            {
                _tmp126 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp126 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp126);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp127 = 0.F;
            {
                _tmp127 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp127 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp127);
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 0 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + gid_x + 0 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 1 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + gid_x + 1 * (int)blockDim.x - 32);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x + 2 * (int)blockDim.x] = tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y) * input_stride + gid_x + 2 * (int)blockDim.x - 32);
        __syncthreads();
        {
            float _tmp128 = 0.F;
            {
                _tmp128 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp128 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp128);
        }
        {
            float _tmp129 = 0.F;
            {
                _tmp129 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp129 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp129);
        }
        {
            float _tmp130 = 0.F;
            {
                _tmp130 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp130 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp130);
        }
        {
            float _tmp131 = 0.F;
            {
                _tmp131 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp131 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp131);
        }
        {
            float _tmp132 = 0.F;
            {
                _tmp132 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp132 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp132);
        }
        {
            float _tmp133 = 0.F;
            {
                _tmp133 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp133 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp133);
        }
        {
            float _tmp134 = 0.F;
            {
                _tmp134 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp134 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp134);
        }
        {
            float _tmp135 = 0.F;
            {
                _tmp135 += _constmask_xX[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -9 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][1] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -8 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][2] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -7 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][3] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -6 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][4] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -5 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][5] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -4 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][6] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -3 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][7] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -2 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][8] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + -1 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][9] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 0 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][10] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 1 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][11] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 2 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][12] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 3 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][13] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 4 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][14] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 5 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][15] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 6 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][16] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 7 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][17] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 8 + 32];
            }
            {
                _tmp135 += _constmask_xX[0][18] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 0][(int)threadIdx.x + 9 + 32];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp135);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERROWX_CU_

