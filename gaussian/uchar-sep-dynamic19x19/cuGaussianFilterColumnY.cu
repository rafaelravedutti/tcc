#ifndef _CUGAUSSIANFILTERCOLUMNY_CU_
#define _CUGAUSSIANFILTERCOLUMNY_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<float, cudaTextureType1D, cudaReadModeElementType> _texinputY;
const textureReference *_texinputYRef;
__device__ __constant__ float _constmask_yY[19][1];


extern "C" {
__global__ __launch_bounds__ (32*2) void cuGaussianFilterColumnYKernel(uchar * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
    float _smeminput[34][33] __attribute__((shared));
    if (bh_fall_back)
        goto BH_FB;
    if (blockIdx.y < bh_start_top)
        goto BH_T;
    if (blockIdx.y >= bh_start_bottom)
        goto BH_B;
    if (blockIdx.x >= bh_start_right)
        goto BH_R;
    goto BH_NO;
  BH_FB:
    {
        int _gid_y0 = gid_y + (-9);
        if (_gid_y0 >= input_height)
            _gid_y0 = input_height - 1;
        if (_gid_y0 < 0)
            _gid_y0 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y0) * input_stride + gid_x);
        int _gid_y1 = gid_y + 1 * (int)blockDim.y + (-9);
        if (_gid_y1 >= input_height)
            _gid_y1 = input_height - 1;
        if (_gid_y1 < 0)
            _gid_y1 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y1) * input_stride + gid_x);
        int _gid_y2 = gid_y + 2 * (int)blockDim.y + (-9);
        if (_gid_y2 >= input_height)
            _gid_y2 = input_height - 1;
        if (_gid_y2 < 0)
            _gid_y2 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y2) * input_stride + gid_x);
        int _gid_y3 = gid_y + 3 * (int)blockDim.y + (-9);
        if (_gid_y3 >= input_height)
            _gid_y3 = input_height - 1;
        if (_gid_y3 < 0)
            _gid_y3 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y3) * input_stride + gid_x);
        int _gid_y4 = gid_y + 4 * (int)blockDim.y + (-9);
        if (_gid_y4 >= input_height)
            _gid_y4 = input_height - 1;
        if (_gid_y4 < 0)
            _gid_y4 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y4) * input_stride + gid_x);
        int _gid_y5 = gid_y + 5 * (int)blockDim.y + (-9);
        if (_gid_y5 >= input_height)
            _gid_y5 = input_height - 1;
        if (_gid_y5 < 0)
            _gid_y5 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y5) * input_stride + gid_x);
        int _gid_y6 = gid_y + 6 * (int)blockDim.y + (-9);
        if (_gid_y6 >= input_height)
            _gid_y6 = input_height - 1;
        if (_gid_y6 < 0)
            _gid_y6 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y6) * input_stride + gid_x);
        int _gid_y7 = gid_y + 7 * (int)blockDim.y + (-9);
        if (_gid_y7 >= input_height)
            _gid_y7 = input_height - 1;
        if (_gid_y7 < 0)
            _gid_y7 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y7) * input_stride + gid_x);
        int _gid_y8 = gid_y + 8 * (int)blockDim.y + (-9);
        if (_gid_y8 >= input_height)
            _gid_y8 = input_height - 1;
        if (_gid_y8 < 0)
            _gid_y8 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y8) * input_stride + gid_x);
        int _gid_y9 = gid_y + 9 * (int)blockDim.y + (-9);
        if (_gid_y9 >= input_height)
            _gid_y9 = input_height - 1;
        if (_gid_y9 < 0)
            _gid_y9 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y9) * input_stride + gid_x);
        int _gid_y10 = gid_y + 10 * (int)blockDim.y + (-9);
        if (_gid_y10 >= input_height)
            _gid_y10 = input_height - 1;
        if (_gid_y10 < 0)
            _gid_y10 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y10) * input_stride + gid_x);
        int _gid_y11 = gid_y + 11 * (int)blockDim.y + (-9);
        if (_gid_y11 >= input_height)
            _gid_y11 = input_height - 1;
        if (_gid_y11 < 0)
            _gid_y11 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y11) * input_stride + gid_x);
        int _gid_y12 = gid_y + 12 * (int)blockDim.y + (-9);
        if (_gid_y12 >= input_height)
            _gid_y12 = input_height - 1;
        if (_gid_y12 < 0)
            _gid_y12 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y12) * input_stride + gid_x);
        int _gid_y13 = gid_y + 13 * (int)blockDim.y + (-9);
        if (_gid_y13 >= input_height)
            _gid_y13 = input_height - 1;
        if (_gid_y13 < 0)
            _gid_y13 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y13) * input_stride + gid_x);
        int _gid_y14 = gid_y + 14 * (int)blockDim.y + (-9);
        if (_gid_y14 >= input_height)
            _gid_y14 = input_height - 1;
        if (_gid_y14 < 0)
            _gid_y14 = 0;
        _smeminput[(int)threadIdx.y + 14 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y14) * input_stride + gid_x);
        int _gid_y15 = gid_y + 15 * (int)blockDim.y + (-9);
        if (_gid_y15 >= input_height)
            _gid_y15 = input_height - 1;
        if (_gid_y15 < 0)
            _gid_y15 = 0;
        _smeminput[(int)threadIdx.y + 15 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y15) * input_stride + gid_x);
        int _gid_y16 = gid_y + 16 * (int)blockDim.y + (-9);
        if (_gid_y16 >= input_height)
            _gid_y16 = input_height - 1;
        if (_gid_y16 < 0)
            _gid_y16 = 0;
        _smeminput[(int)threadIdx.y + 16 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y16) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp17 = 0.F;
                {
                    _tmp17 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp17 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp18 = 0.F;
                {
                    _tmp18 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp18 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp19 = 0.F;
                {
                    _tmp19 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp19 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp20 = 0.F;
                {
                    _tmp20 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp20 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp21 = 0.F;
                {
                    _tmp21 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp21 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp22 = 0.F;
                {
                    _tmp22 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp22 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp22 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp23 = 0.F;
                {
                    _tmp23 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp23 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp23 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp24 = 0.F;
                {
                    _tmp24 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp24 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp24 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        int _gid_y25 = gid_y + (-9);
        if (_gid_y25 < 0)
            _gid_y25 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y25) * input_stride + gid_x);
        int _gid_y26 = gid_y + 1 * (int)blockDim.y + (-9);
        if (_gid_y26 < 0)
            _gid_y26 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y26) * input_stride + gid_x);
        int _gid_y27 = gid_y + 2 * (int)blockDim.y + (-9);
        if (_gid_y27 < 0)
            _gid_y27 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y27) * input_stride + gid_x);
        int _gid_y28 = gid_y + 3 * (int)blockDim.y + (-9);
        if (_gid_y28 < 0)
            _gid_y28 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y28) * input_stride + gid_x);
        int _gid_y29 = gid_y + 4 * (int)blockDim.y + (-9);
        if (_gid_y29 < 0)
            _gid_y29 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y29) * input_stride + gid_x);
        int _gid_y30 = gid_y + 5 * (int)blockDim.y + (-9);
        if (_gid_y30 < 0)
            _gid_y30 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y30) * input_stride + gid_x);
        int _gid_y31 = gid_y + 6 * (int)blockDim.y + (-9);
        if (_gid_y31 < 0)
            _gid_y31 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y31) * input_stride + gid_x);
        int _gid_y32 = gid_y + 7 * (int)blockDim.y + (-9);
        if (_gid_y32 < 0)
            _gid_y32 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y32) * input_stride + gid_x);
        int _gid_y33 = gid_y + 8 * (int)blockDim.y + (-9);
        if (_gid_y33 < 0)
            _gid_y33 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y33) * input_stride + gid_x);
        int _gid_y34 = gid_y + 9 * (int)blockDim.y + (-9);
        if (_gid_y34 < 0)
            _gid_y34 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y34) * input_stride + gid_x);
        int _gid_y35 = gid_y + 10 * (int)blockDim.y + (-9);
        if (_gid_y35 < 0)
            _gid_y35 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y35) * input_stride + gid_x);
        int _gid_y36 = gid_y + 11 * (int)blockDim.y + (-9);
        if (_gid_y36 < 0)
            _gid_y36 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y36) * input_stride + gid_x);
        int _gid_y37 = gid_y + 12 * (int)blockDim.y + (-9);
        if (_gid_y37 < 0)
            _gid_y37 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y37) * input_stride + gid_x);
        int _gid_y38 = gid_y + 13 * (int)blockDim.y + (-9);
        if (_gid_y38 < 0)
            _gid_y38 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y38) * input_stride + gid_x);
        int _gid_y39 = gid_y + 14 * (int)blockDim.y + (-9);
        if (_gid_y39 < 0)
            _gid_y39 = 0;
        _smeminput[(int)threadIdx.y + 14 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y39) * input_stride + gid_x);
        int _gid_y40 = gid_y + 15 * (int)blockDim.y + (-9);
        if (_gid_y40 < 0)
            _gid_y40 = 0;
        _smeminput[(int)threadIdx.y + 15 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y40) * input_stride + gid_x);
        int _gid_y41 = gid_y + 16 * (int)blockDim.y + (-9);
        if (_gid_y41 < 0)
            _gid_y41 = 0;
        _smeminput[(int)threadIdx.y + 16 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y41) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp42 = 0.F;
                {
                    _tmp42 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp42 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp43 = 0.F;
                {
                    _tmp43 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp43 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp44 = 0.F;
                {
                    _tmp44 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp44 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp44 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp45 = 0.F;
                {
                    _tmp45 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp45 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp45 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp46 = 0.F;
                {
                    _tmp46 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp46 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp46 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp47 = 0.F;
                {
                    _tmp47 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp47 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp47 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp48 = 0.F;
                {
                    _tmp48 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp48 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp48 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp49 = 0.F;
                {
                    _tmp49 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp49 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp49 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        int _gid_y50 = gid_y + (-9);
        if (_gid_y50 >= input_height)
            _gid_y50 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y50) * input_stride + gid_x);
        int _gid_y51 = gid_y + 1 * (int)blockDim.y + (-9);
        if (_gid_y51 >= input_height)
            _gid_y51 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y51) * input_stride + gid_x);
        int _gid_y52 = gid_y + 2 * (int)blockDim.y + (-9);
        if (_gid_y52 >= input_height)
            _gid_y52 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y52) * input_stride + gid_x);
        int _gid_y53 = gid_y + 3 * (int)blockDim.y + (-9);
        if (_gid_y53 >= input_height)
            _gid_y53 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y53) * input_stride + gid_x);
        int _gid_y54 = gid_y + 4 * (int)blockDim.y + (-9);
        if (_gid_y54 >= input_height)
            _gid_y54 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y54) * input_stride + gid_x);
        int _gid_y55 = gid_y + 5 * (int)blockDim.y + (-9);
        if (_gid_y55 >= input_height)
            _gid_y55 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y55) * input_stride + gid_x);
        int _gid_y56 = gid_y + 6 * (int)blockDim.y + (-9);
        if (_gid_y56 >= input_height)
            _gid_y56 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y56) * input_stride + gid_x);
        int _gid_y57 = gid_y + 7 * (int)blockDim.y + (-9);
        if (_gid_y57 >= input_height)
            _gid_y57 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y57) * input_stride + gid_x);
        int _gid_y58 = gid_y + 8 * (int)blockDim.y + (-9);
        if (_gid_y58 >= input_height)
            _gid_y58 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y58) * input_stride + gid_x);
        int _gid_y59 = gid_y + 9 * (int)blockDim.y + (-9);
        if (_gid_y59 >= input_height)
            _gid_y59 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y59) * input_stride + gid_x);
        int _gid_y60 = gid_y + 10 * (int)blockDim.y + (-9);
        if (_gid_y60 >= input_height)
            _gid_y60 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y60) * input_stride + gid_x);
        int _gid_y61 = gid_y + 11 * (int)blockDim.y + (-9);
        if (_gid_y61 >= input_height)
            _gid_y61 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y61) * input_stride + gid_x);
        int _gid_y62 = gid_y + 12 * (int)blockDim.y + (-9);
        if (_gid_y62 >= input_height)
            _gid_y62 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y62) * input_stride + gid_x);
        int _gid_y63 = gid_y + 13 * (int)blockDim.y + (-9);
        if (_gid_y63 >= input_height)
            _gid_y63 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y63) * input_stride + gid_x);
        int _gid_y64 = gid_y + 14 * (int)blockDim.y + (-9);
        if (_gid_y64 >= input_height)
            _gid_y64 = input_height - 1;
        _smeminput[(int)threadIdx.y + 14 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y64) * input_stride + gid_x);
        int _gid_y65 = gid_y + 15 * (int)blockDim.y + (-9);
        if (_gid_y65 >= input_height)
            _gid_y65 = input_height - 1;
        _smeminput[(int)threadIdx.y + 15 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y65) * input_stride + gid_x);
        int _gid_y66 = gid_y + 16 * (int)blockDim.y + (-9);
        if (_gid_y66 >= input_height)
            _gid_y66 = input_height - 1;
        _smeminput[(int)threadIdx.y + 16 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y66) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp67 = 0.F;
                {
                    _tmp67 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp67 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp67 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp68 = 0.F;
                {
                    _tmp68 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp68 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp68 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp69 = 0.F;
                {
                    _tmp69 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp69 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp69 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp70 = 0.F;
                {
                    _tmp70 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp70 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp70 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp71 = 0.F;
                {
                    _tmp71 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp71 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp71 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp72 = 0.F;
                {
                    _tmp72 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp72 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp72 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp73 = 0.F;
                {
                    _tmp73 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp73 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp73 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp74 = 0.F;
                {
                    _tmp74 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp74 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp74 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        int _gid_y75 = gid_y + (-9);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y75) * input_stride + gid_x);
        int _gid_y76 = gid_y + 1 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y76) * input_stride + gid_x);
        int _gid_y77 = gid_y + 2 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y77) * input_stride + gid_x);
        int _gid_y78 = gid_y + 3 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y78) * input_stride + gid_x);
        int _gid_y79 = gid_y + 4 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y79) * input_stride + gid_x);
        int _gid_y80 = gid_y + 5 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y80) * input_stride + gid_x);
        int _gid_y81 = gid_y + 6 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y81) * input_stride + gid_x);
        int _gid_y82 = gid_y + 7 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y82) * input_stride + gid_x);
        int _gid_y83 = gid_y + 8 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y83) * input_stride + gid_x);
        int _gid_y84 = gid_y + 9 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y84) * input_stride + gid_x);
        int _gid_y85 = gid_y + 10 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y85) * input_stride + gid_x);
        int _gid_y86 = gid_y + 11 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y86) * input_stride + gid_x);
        int _gid_y87 = gid_y + 12 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y87) * input_stride + gid_x);
        int _gid_y88 = gid_y + 13 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y88) * input_stride + gid_x);
        int _gid_y89 = gid_y + 14 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 14 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y89) * input_stride + gid_x);
        int _gid_y90 = gid_y + 15 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 15 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y90) * input_stride + gid_x);
        int _gid_y91 = gid_y + 16 * (int)blockDim.y + (-9);
        _smeminput[(int)threadIdx.y + 16 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y91) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp92 = 0.F;
                {
                    _tmp92 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp92 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp92 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp93 = 0.F;
                {
                    _tmp93 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp93 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp93 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp94 = 0.F;
                {
                    _tmp94 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp94 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp94 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp95 = 0.F;
                {
                    _tmp95 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp95 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp95 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp96 = 0.F;
                {
                    _tmp96 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp96 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp96 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp97 = 0.F;
                {
                    _tmp97 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp97 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp97 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp98 = 0.F;
                {
                    _tmp98 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp98 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp98 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp99 = 0.F;
                {
                    _tmp99 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp99 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp99 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 8 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 9 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 10 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 11 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 12 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 13 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 14 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 14 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 15 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 15 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 16 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 16 * (int)blockDim.y + (-9)) * input_stride + gid_x);
        __syncthreads();
        {
            float _tmp100 = 0.F;
            {
                _tmp100 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp100 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp100 + 0.5F);
        }
        {
            float _tmp101 = 0.F;
            {
                _tmp101 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp101 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp101 + 0.5F);
        }
        {
            float _tmp102 = 0.F;
            {
                _tmp102 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp102 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp102 + 0.5F);
        }
        {
            float _tmp103 = 0.F;
            {
                _tmp103 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp103 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp103 + 0.5F);
        }
        {
            float _tmp104 = 0.F;
            {
                _tmp104 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp104 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp104 + 0.5F);
        }
        {
            float _tmp105 = 0.F;
            {
                _tmp105 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp105 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp105 + 0.5F);
        }
        {
            float _tmp106 = 0.F;
            {
                _tmp106 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp106 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp106 + 0.5F);
        }
        {
            float _tmp107 = 0.F;
            {
                _tmp107 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -9 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[7][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[8][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[9][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[10][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[11][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[12][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[13][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 4 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[14][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 5 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[15][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 6 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[16][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 7 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[17][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 8 + 9][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp107 += _constmask_yY[18][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 9 + 9][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp107 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERCOLUMNY_CU_

