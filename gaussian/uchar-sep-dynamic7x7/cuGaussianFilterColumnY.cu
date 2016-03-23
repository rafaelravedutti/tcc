#ifndef _CUGAUSSIANFILTERCOLUMNY_CU_
#define _CUGAUSSIANFILTERCOLUMNY_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<float, cudaTextureType1D, cudaReadModeElementType> _texinputY;
const textureReference *_texinputYRef;
__device__ __constant__ float _constmask_yY[7][1];


extern "C" {
__global__ __launch_bounds__ (32*1) void cuGaussianFilterColumnYKernel(uchar * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
    float _smeminput[14][33] __attribute__((shared));
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
        int _gid_y0 = gid_y + (-3);
        if (_gid_y0 >= input_height)
            _gid_y0 = input_height - 1;
        if (_gid_y0 < 0)
            _gid_y0 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y0) * input_stride + gid_x);
        int _gid_y1 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y1 >= input_height)
            _gid_y1 = input_height - 1;
        if (_gid_y1 < 0)
            _gid_y1 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y1) * input_stride + gid_x);
        int _gid_y2 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y2 >= input_height)
            _gid_y2 = input_height - 1;
        if (_gid_y2 < 0)
            _gid_y2 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y2) * input_stride + gid_x);
        int _gid_y3 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y3 >= input_height)
            _gid_y3 = input_height - 1;
        if (_gid_y3 < 0)
            _gid_y3 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y3) * input_stride + gid_x);
        int _gid_y4 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y4 >= input_height)
            _gid_y4 = input_height - 1;
        if (_gid_y4 < 0)
            _gid_y4 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y4) * input_stride + gid_x);
        int _gid_y5 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y5 >= input_height)
            _gid_y5 = input_height - 1;
        if (_gid_y5 < 0)
            _gid_y5 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y5) * input_stride + gid_x);
        int _gid_y6 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y6 >= input_height)
            _gid_y6 = input_height - 1;
        if (_gid_y6 < 0)
            _gid_y6 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y6) * input_stride + gid_x);
        int _gid_y7 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y7 >= input_height)
            _gid_y7 = input_height - 1;
        if (_gid_y7 < 0)
            _gid_y7 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y7) * input_stride + gid_x);
        int _gid_y8 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y8 >= input_height)
            _gid_y8 = input_height - 1;
        if (_gid_y8 < 0)
            _gid_y8 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y8) * input_stride + gid_x);
        int _gid_y9 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y9 >= input_height)
            _gid_y9 = input_height - 1;
        if (_gid_y9 < 0)
            _gid_y9 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y9) * input_stride + gid_x);
        int _gid_y10 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y10 >= input_height)
            _gid_y10 = input_height - 1;
        if (_gid_y10 < 0)
            _gid_y10 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y10) * input_stride + gid_x);
        int _gid_y11 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y11 >= input_height)
            _gid_y11 = input_height - 1;
        if (_gid_y11 < 0)
            _gid_y11 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y11) * input_stride + gid_x);
        int _gid_y12 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y12 >= input_height)
            _gid_y12 = input_height - 1;
        if (_gid_y12 < 0)
            _gid_y12 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y12) * input_stride + gid_x);
        int _gid_y13 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y13 >= input_height)
            _gid_y13 = input_height - 1;
        if (_gid_y13 < 0)
            _gid_y13 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y13) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp14 = 0.F;
                {
                    _tmp14 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp14 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp14 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp14 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp14 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp14 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp14 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp14 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp15 = 0.F;
                {
                    _tmp15 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp15 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp15 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp15 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp15 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp15 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp15 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp15 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp16 = 0.F;
                {
                    _tmp16 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp16 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp16 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp16 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp16 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp16 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp16 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp16 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp17 = 0.F;
                {
                    _tmp17 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp17 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp17 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp18 = 0.F;
                {
                    _tmp18 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp18 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp18 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp19 = 0.F;
                {
                    _tmp19 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp19 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp19 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp20 = 0.F;
                {
                    _tmp20 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp20 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp20 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp21 = 0.F;
                {
                    _tmp21 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp21 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp21 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        int _gid_y22 = gid_y + (-3);
        if (_gid_y22 < 0)
            _gid_y22 = 0;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y22) * input_stride + gid_x);
        int _gid_y23 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y23 < 0)
            _gid_y23 = 0;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y23) * input_stride + gid_x);
        int _gid_y24 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y24 < 0)
            _gid_y24 = 0;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y24) * input_stride + gid_x);
        int _gid_y25 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y25 < 0)
            _gid_y25 = 0;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y25) * input_stride + gid_x);
        int _gid_y26 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y26 < 0)
            _gid_y26 = 0;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y26) * input_stride + gid_x);
        int _gid_y27 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y27 < 0)
            _gid_y27 = 0;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y27) * input_stride + gid_x);
        int _gid_y28 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y28 < 0)
            _gid_y28 = 0;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y28) * input_stride + gid_x);
        int _gid_y29 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y29 < 0)
            _gid_y29 = 0;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y29) * input_stride + gid_x);
        int _gid_y30 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y30 < 0)
            _gid_y30 = 0;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y30) * input_stride + gid_x);
        int _gid_y31 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y31 < 0)
            _gid_y31 = 0;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y31) * input_stride + gid_x);
        int _gid_y32 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y32 < 0)
            _gid_y32 = 0;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y32) * input_stride + gid_x);
        int _gid_y33 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y33 < 0)
            _gid_y33 = 0;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y33) * input_stride + gid_x);
        int _gid_y34 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y34 < 0)
            _gid_y34 = 0;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y34) * input_stride + gid_x);
        int _gid_y35 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y35 < 0)
            _gid_y35 = 0;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y35) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp36 = 0.F;
                {
                    _tmp36 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp36 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp36 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp36 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp36 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp36 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp36 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp36 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp37 = 0.F;
                {
                    _tmp37 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp37 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp37 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp37 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp37 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp37 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp37 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp37 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp38 = 0.F;
                {
                    _tmp38 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp38 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp38 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp38 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp38 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp38 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp38 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp38 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp39 = 0.F;
                {
                    _tmp39 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp39 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp39 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp39 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp39 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp39 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp39 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp39 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp40 = 0.F;
                {
                    _tmp40 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp40 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp40 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp40 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp40 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp40 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp40 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp40 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp41 = 0.F;
                {
                    _tmp41 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp41 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp41 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp41 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp41 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp41 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp41 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp41 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp42 = 0.F;
                {
                    _tmp42 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp42 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp42 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp43 = 0.F;
                {
                    _tmp43 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp43 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp43 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        int _gid_y44 = gid_y + (-3);
        if (_gid_y44 >= input_height)
            _gid_y44 = input_height - 1;
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y44) * input_stride + gid_x);
        int _gid_y45 = gid_y + 1 * (int)blockDim.y + (-3);
        if (_gid_y45 >= input_height)
            _gid_y45 = input_height - 1;
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y45) * input_stride + gid_x);
        int _gid_y46 = gid_y + 2 * (int)blockDim.y + (-3);
        if (_gid_y46 >= input_height)
            _gid_y46 = input_height - 1;
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y46) * input_stride + gid_x);
        int _gid_y47 = gid_y + 3 * (int)blockDim.y + (-3);
        if (_gid_y47 >= input_height)
            _gid_y47 = input_height - 1;
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y47) * input_stride + gid_x);
        int _gid_y48 = gid_y + 4 * (int)blockDim.y + (-3);
        if (_gid_y48 >= input_height)
            _gid_y48 = input_height - 1;
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y48) * input_stride + gid_x);
        int _gid_y49 = gid_y + 5 * (int)blockDim.y + (-3);
        if (_gid_y49 >= input_height)
            _gid_y49 = input_height - 1;
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y49) * input_stride + gid_x);
        int _gid_y50 = gid_y + 6 * (int)blockDim.y + (-3);
        if (_gid_y50 >= input_height)
            _gid_y50 = input_height - 1;
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y50) * input_stride + gid_x);
        int _gid_y51 = gid_y + 7 * (int)blockDim.y + (-3);
        if (_gid_y51 >= input_height)
            _gid_y51 = input_height - 1;
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y51) * input_stride + gid_x);
        int _gid_y52 = gid_y + 8 * (int)blockDim.y + (-3);
        if (_gid_y52 >= input_height)
            _gid_y52 = input_height - 1;
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y52) * input_stride + gid_x);
        int _gid_y53 = gid_y + 9 * (int)blockDim.y + (-3);
        if (_gid_y53 >= input_height)
            _gid_y53 = input_height - 1;
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y53) * input_stride + gid_x);
        int _gid_y54 = gid_y + 10 * (int)blockDim.y + (-3);
        if (_gid_y54 >= input_height)
            _gid_y54 = input_height - 1;
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y54) * input_stride + gid_x);
        int _gid_y55 = gid_y + 11 * (int)blockDim.y + (-3);
        if (_gid_y55 >= input_height)
            _gid_y55 = input_height - 1;
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y55) * input_stride + gid_x);
        int _gid_y56 = gid_y + 12 * (int)blockDim.y + (-3);
        if (_gid_y56 >= input_height)
            _gid_y56 = input_height - 1;
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y56) * input_stride + gid_x);
        int _gid_y57 = gid_y + 13 * (int)blockDim.y + (-3);
        if (_gid_y57 >= input_height)
            _gid_y57 = input_height - 1;
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y57) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp58 = 0.F;
                {
                    _tmp58 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp58 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp58 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp58 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp58 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp58 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp58 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp58 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp59 = 0.F;
                {
                    _tmp59 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp59 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp59 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp59 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp59 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp59 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp59 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp59 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp60 = 0.F;
                {
                    _tmp60 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp60 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp60 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp60 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp60 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp60 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp60 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp60 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp61 = 0.F;
                {
                    _tmp61 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp61 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp61 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp61 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp61 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp61 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp61 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp61 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp62 = 0.F;
                {
                    _tmp62 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp62 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp62 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp62 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp62 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp62 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp62 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp62 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp63 = 0.F;
                {
                    _tmp63 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp63 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp63 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp63 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp63 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp63 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp63 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp63 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp64 = 0.F;
                {
                    _tmp64 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp64 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp64 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp64 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp64 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp64 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp64 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp64 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp65 = 0.F;
                {
                    _tmp65 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp65 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp65 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp65 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp65 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp65 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp65 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp65 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        int _gid_y66 = gid_y + (-3);
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y66) * input_stride + gid_x);
        int _gid_y67 = gid_y + 1 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y67) * input_stride + gid_x);
        int _gid_y68 = gid_y + 2 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y68) * input_stride + gid_x);
        int _gid_y69 = gid_y + 3 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y69) * input_stride + gid_x);
        int _gid_y70 = gid_y + 4 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y70) * input_stride + gid_x);
        int _gid_y71 = gid_y + 5 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y71) * input_stride + gid_x);
        int _gid_y72 = gid_y + 6 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y72) * input_stride + gid_x);
        int _gid_y73 = gid_y + 7 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y73) * input_stride + gid_x);
        int _gid_y74 = gid_y + 8 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y74) * input_stride + gid_x);
        int _gid_y75 = gid_y + 9 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y75) * input_stride + gid_x);
        int _gid_y76 = gid_y + 10 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y76) * input_stride + gid_x);
        int _gid_y77 = gid_y + 11 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y77) * input_stride + gid_x);
        int _gid_y78 = gid_y + 12 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y78) * input_stride + gid_x);
        int _gid_y79 = gid_y + 13 * (int)blockDim.y + (-3);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (_gid_y79) * input_stride + gid_x);
        __syncthreads();
        if (gid_x < iter_width) {
            {
                float _tmp80 = 0.F;
                {
                    _tmp80 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp80 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp80 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp80 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp80 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp80 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp80 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp80 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp81 = 0.F;
                {
                    _tmp81 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp81 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp81 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp81 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp81 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp81 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp81 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp81 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp82 = 0.F;
                {
                    _tmp82 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp82 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp82 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp82 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp82 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp82 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp82 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp82 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp83 = 0.F;
                {
                    _tmp83 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp83 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp83 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp83 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp83 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp83 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp83 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp83 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp84 = 0.F;
                {
                    _tmp84 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp84 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp84 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp84 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp84 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp84 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp84 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp84 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp85 = 0.F;
                {
                    _tmp85 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp85 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp85 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp85 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp85 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp85 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp85 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp85 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp86 = 0.F;
                {
                    _tmp86 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp86 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp86 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp86 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp86 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp86 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp86 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp86 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp87 = 0.F;
                {
                    _tmp87 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp87 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp87 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp87 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp87 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp87 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
                }
                {
                    _tmp87 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp87 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        _smeminput[(int)threadIdx.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 8 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 8 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 9 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 9 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 10 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 10 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 11 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 11 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 12 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 12 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        _smeminput[(int)threadIdx.y + 13 * (int)blockDim.y][(int)threadIdx.x] = tex1Dfetch(_texinputY, (gid_y + 13 * (int)blockDim.y + (-3)) * input_stride + gid_x);
        __syncthreads();
        {
            float _tmp88 = 0.F;
            {
                _tmp88 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp88 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp88 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp88 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp88 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp88 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp88 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp88 + 0.5F);
        }
        {
            float _tmp89 = 0.F;
            {
                _tmp89 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp89 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp89 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp89 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp89 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp89 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp89 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 1 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp89 + 0.5F);
        }
        {
            float _tmp90 = 0.F;
            {
                _tmp90 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp90 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp90 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp90 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp90 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp90 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp90 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 2 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp90 + 0.5F);
        }
        {
            float _tmp91 = 0.F;
            {
                _tmp91 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp91 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp91 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp91 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp91 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp91 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp91 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 3 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp91 + 0.5F);
        }
        {
            float _tmp92 = 0.F;
            {
                _tmp92 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp92 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp92 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp92 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp92 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp92 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp92 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 4 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp92 + 0.5F);
        }
        {
            float _tmp93 = 0.F;
            {
                _tmp93 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp93 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp93 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp93 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp93 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp93 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp93 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 5 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp93 + 0.5F);
        }
        {
            float _tmp94 = 0.F;
            {
                _tmp94 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp94 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp94 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp94 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp94 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp94 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp94 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 6 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp94 + 0.5F);
        }
        {
            float _tmp95 = 0.F;
            {
                _tmp95 += _constmask_yY[0][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -3 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp95 += _constmask_yY[1][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp95 += _constmask_yY[2][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + -1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp95 += _constmask_yY[3][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 0 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp95 += _constmask_yY[4][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 1 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp95 += _constmask_yY[5][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 2 + 3][(int)threadIdx.x + 0 + 0];
            }
            {
                _tmp95 += _constmask_yY[6][0] * _smeminput[(int)threadIdx.y + 7 * (int)blockDim.y + 3 + 3][(int)threadIdx.x + 0 + 0];
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp95 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERCOLUMNY_CU_

