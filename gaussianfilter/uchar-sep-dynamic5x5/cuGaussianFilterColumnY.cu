#ifndef _CUGAUSSIANFILTERCOLUMNY_CU_
#define _CUGAUSSIANFILTERCOLUMNY_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<float, cudaTextureType1D, cudaReadModeElementType> _texinputY;
const textureReference *_texinputYRef;
__device__ __constant__ float _constmask_yY[5][1];


extern "C" {
__global__ __launch_bounds__ (32*2) void cuGaussianFilterColumnYKernel(uchar * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
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
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp0 = 0.F;
                {
                    int _gid_x1 = gid_x + 0;
                    int _gid_y1 = gid_y + -2;
                    if (_gid_y1 >= input_height)
                        _gid_y1 = input_height - 1;
                    if (_gid_y1 < 0)
                        _gid_y1 = 0;
                    _tmp0 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y1) * input_stride + _gid_x1);
                }
                {
                    int _gid_x2 = gid_x + 0;
                    int _gid_y2 = gid_y + -1;
                    if (_gid_y2 >= input_height)
                        _gid_y2 = input_height - 1;
                    if (_gid_y2 < 0)
                        _gid_y2 = 0;
                    _tmp0 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y2) * input_stride + _gid_x2);
                }
                {
                    int _gid_x3 = gid_x + 0;
                    int _gid_y3 = gid_y + 0;
                    if (_gid_y3 >= input_height)
                        _gid_y3 = input_height - 1;
                    if (_gid_y3 < 0)
                        _gid_y3 = 0;
                    _tmp0 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y3) * input_stride + _gid_x3);
                }
                {
                    int _gid_x4 = gid_x + 0;
                    int _gid_y4 = gid_y + 1;
                    if (_gid_y4 >= input_height)
                        _gid_y4 = input_height - 1;
                    if (_gid_y4 < 0)
                        _gid_y4 = 0;
                    _tmp0 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y4) * input_stride + _gid_x4);
                }
                {
                    int _gid_x5 = gid_x + 0;
                    int _gid_y5 = gid_y + 2;
                    if (_gid_y5 >= input_height)
                        _gid_y5 = input_height - 1;
                    if (_gid_y5 < 0)
                        _gid_y5 = 0;
                    _tmp0 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y5) * input_stride + _gid_x5);
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp0 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp6 = 0.F;
                {
                    int _gid_x7 = gid_x + 0;
                    int _gid_y7 = gid_y + 1 * (int)blockDim.y + -2;
                    if (_gid_y7 >= input_height)
                        _gid_y7 = input_height - 1;
                    if (_gid_y7 < 0)
                        _gid_y7 = 0;
                    _tmp6 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y7) * input_stride + _gid_x7);
                }
                {
                    int _gid_x8 = gid_x + 0;
                    int _gid_y8 = gid_y + 1 * (int)blockDim.y + -1;
                    if (_gid_y8 >= input_height)
                        _gid_y8 = input_height - 1;
                    if (_gid_y8 < 0)
                        _gid_y8 = 0;
                    _tmp6 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y8) * input_stride + _gid_x8);
                }
                {
                    int _gid_x9 = gid_x + 0;
                    int _gid_y9 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_y9 >= input_height)
                        _gid_y9 = input_height - 1;
                    if (_gid_y9 < 0)
                        _gid_y9 = 0;
                    _tmp6 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y9) * input_stride + _gid_x9);
                }
                {
                    int _gid_x10 = gid_x + 0;
                    int _gid_y10 = gid_y + 1 * (int)blockDim.y + 1;
                    if (_gid_y10 >= input_height)
                        _gid_y10 = input_height - 1;
                    if (_gid_y10 < 0)
                        _gid_y10 = 0;
                    _tmp6 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y10) * input_stride + _gid_x10);
                }
                {
                    int _gid_x11 = gid_x + 0;
                    int _gid_y11 = gid_y + 1 * (int)blockDim.y + 2;
                    if (_gid_y11 >= input_height)
                        _gid_y11 = input_height - 1;
                    if (_gid_y11 < 0)
                        _gid_y11 = 0;
                    _tmp6 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y11) * input_stride + _gid_x11);
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp6 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp12 = 0.F;
                {
                    int _gid_x13 = gid_x + 0;
                    int _gid_y13 = gid_y + 2 * (int)blockDim.y + -2;
                    if (_gid_y13 >= input_height)
                        _gid_y13 = input_height - 1;
                    if (_gid_y13 < 0)
                        _gid_y13 = 0;
                    _tmp12 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y13) * input_stride + _gid_x13);
                }
                {
                    int _gid_x14 = gid_x + 0;
                    int _gid_y14 = gid_y + 2 * (int)blockDim.y + -1;
                    if (_gid_y14 >= input_height)
                        _gid_y14 = input_height - 1;
                    if (_gid_y14 < 0)
                        _gid_y14 = 0;
                    _tmp12 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y14) * input_stride + _gid_x14);
                }
                {
                    int _gid_x15 = gid_x + 0;
                    int _gid_y15 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_y15 >= input_height)
                        _gid_y15 = input_height - 1;
                    if (_gid_y15 < 0)
                        _gid_y15 = 0;
                    _tmp12 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y15) * input_stride + _gid_x15);
                }
                {
                    int _gid_x16 = gid_x + 0;
                    int _gid_y16 = gid_y + 2 * (int)blockDim.y + 1;
                    if (_gid_y16 >= input_height)
                        _gid_y16 = input_height - 1;
                    if (_gid_y16 < 0)
                        _gid_y16 = 0;
                    _tmp12 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y16) * input_stride + _gid_x16);
                }
                {
                    int _gid_x17 = gid_x + 0;
                    int _gid_y17 = gid_y + 2 * (int)blockDim.y + 2;
                    if (_gid_y17 >= input_height)
                        _gid_y17 = input_height - 1;
                    if (_gid_y17 < 0)
                        _gid_y17 = 0;
                    _tmp12 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y17) * input_stride + _gid_x17);
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp12 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp18 = 0.F;
                {
                    int _gid_x19 = gid_x + 0;
                    int _gid_y19 = gid_y + 3 * (int)blockDim.y + -2;
                    if (_gid_y19 >= input_height)
                        _gid_y19 = input_height - 1;
                    if (_gid_y19 < 0)
                        _gid_y19 = 0;
                    _tmp18 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y19) * input_stride + _gid_x19);
                }
                {
                    int _gid_x20 = gid_x + 0;
                    int _gid_y20 = gid_y + 3 * (int)blockDim.y + -1;
                    if (_gid_y20 >= input_height)
                        _gid_y20 = input_height - 1;
                    if (_gid_y20 < 0)
                        _gid_y20 = 0;
                    _tmp18 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y20) * input_stride + _gid_x20);
                }
                {
                    int _gid_x21 = gid_x + 0;
                    int _gid_y21 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_y21 >= input_height)
                        _gid_y21 = input_height - 1;
                    if (_gid_y21 < 0)
                        _gid_y21 = 0;
                    _tmp18 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y21) * input_stride + _gid_x21);
                }
                {
                    int _gid_x22 = gid_x + 0;
                    int _gid_y22 = gid_y + 3 * (int)blockDim.y + 1;
                    if (_gid_y22 >= input_height)
                        _gid_y22 = input_height - 1;
                    if (_gid_y22 < 0)
                        _gid_y22 = 0;
                    _tmp18 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y22) * input_stride + _gid_x22);
                }
                {
                    int _gid_x23 = gid_x + 0;
                    int _gid_y23 = gid_y + 3 * (int)blockDim.y + 2;
                    if (_gid_y23 >= input_height)
                        _gid_y23 = input_height - 1;
                    if (_gid_y23 < 0)
                        _gid_y23 = 0;
                    _tmp18 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y23) * input_stride + _gid_x23);
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp18 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp24 = 0.F;
                {
                    int _gid_x25 = gid_x + 0;
                    int _gid_y25 = gid_y + 4 * (int)blockDim.y + -2;
                    if (_gid_y25 >= input_height)
                        _gid_y25 = input_height - 1;
                    if (_gid_y25 < 0)
                        _gid_y25 = 0;
                    _tmp24 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y25) * input_stride + _gid_x25);
                }
                {
                    int _gid_x26 = gid_x + 0;
                    int _gid_y26 = gid_y + 4 * (int)blockDim.y + -1;
                    if (_gid_y26 >= input_height)
                        _gid_y26 = input_height - 1;
                    if (_gid_y26 < 0)
                        _gid_y26 = 0;
                    _tmp24 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y26) * input_stride + _gid_x26);
                }
                {
                    int _gid_x27 = gid_x + 0;
                    int _gid_y27 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_y27 >= input_height)
                        _gid_y27 = input_height - 1;
                    if (_gid_y27 < 0)
                        _gid_y27 = 0;
                    _tmp24 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y27) * input_stride + _gid_x27);
                }
                {
                    int _gid_x28 = gid_x + 0;
                    int _gid_y28 = gid_y + 4 * (int)blockDim.y + 1;
                    if (_gid_y28 >= input_height)
                        _gid_y28 = input_height - 1;
                    if (_gid_y28 < 0)
                        _gid_y28 = 0;
                    _tmp24 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y28) * input_stride + _gid_x28);
                }
                {
                    int _gid_x29 = gid_x + 0;
                    int _gid_y29 = gid_y + 4 * (int)blockDim.y + 2;
                    if (_gid_y29 >= input_height)
                        _gid_y29 = input_height - 1;
                    if (_gid_y29 < 0)
                        _gid_y29 = 0;
                    _tmp24 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y29) * input_stride + _gid_x29);
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp24 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp30 = 0.F;
                {
                    int _gid_x31 = gid_x + 0;
                    int _gid_y31 = gid_y + 5 * (int)blockDim.y + -2;
                    if (_gid_y31 >= input_height)
                        _gid_y31 = input_height - 1;
                    if (_gid_y31 < 0)
                        _gid_y31 = 0;
                    _tmp30 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y31) * input_stride + _gid_x31);
                }
                {
                    int _gid_x32 = gid_x + 0;
                    int _gid_y32 = gid_y + 5 * (int)blockDim.y + -1;
                    if (_gid_y32 >= input_height)
                        _gid_y32 = input_height - 1;
                    if (_gid_y32 < 0)
                        _gid_y32 = 0;
                    _tmp30 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y32) * input_stride + _gid_x32);
                }
                {
                    int _gid_x33 = gid_x + 0;
                    int _gid_y33 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_y33 >= input_height)
                        _gid_y33 = input_height - 1;
                    if (_gid_y33 < 0)
                        _gid_y33 = 0;
                    _tmp30 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y33) * input_stride + _gid_x33);
                }
                {
                    int _gid_x34 = gid_x + 0;
                    int _gid_y34 = gid_y + 5 * (int)blockDim.y + 1;
                    if (_gid_y34 >= input_height)
                        _gid_y34 = input_height - 1;
                    if (_gid_y34 < 0)
                        _gid_y34 = 0;
                    _tmp30 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y34) * input_stride + _gid_x34);
                }
                {
                    int _gid_x35 = gid_x + 0;
                    int _gid_y35 = gid_y + 5 * (int)blockDim.y + 2;
                    if (_gid_y35 >= input_height)
                        _gid_y35 = input_height - 1;
                    if (_gid_y35 < 0)
                        _gid_y35 = 0;
                    _tmp30 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y35) * input_stride + _gid_x35);
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp30 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp36 = 0.F;
                {
                    int _gid_x37 = gid_x + 0;
                    int _gid_y37 = gid_y + 6 * (int)blockDim.y + -2;
                    if (_gid_y37 >= input_height)
                        _gid_y37 = input_height - 1;
                    if (_gid_y37 < 0)
                        _gid_y37 = 0;
                    _tmp36 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y37) * input_stride + _gid_x37);
                }
                {
                    int _gid_x38 = gid_x + 0;
                    int _gid_y38 = gid_y + 6 * (int)blockDim.y + -1;
                    if (_gid_y38 >= input_height)
                        _gid_y38 = input_height - 1;
                    if (_gid_y38 < 0)
                        _gid_y38 = 0;
                    _tmp36 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y38) * input_stride + _gid_x38);
                }
                {
                    int _gid_x39 = gid_x + 0;
                    int _gid_y39 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_y39 >= input_height)
                        _gid_y39 = input_height - 1;
                    if (_gid_y39 < 0)
                        _gid_y39 = 0;
                    _tmp36 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y39) * input_stride + _gid_x39);
                }
                {
                    int _gid_x40 = gid_x + 0;
                    int _gid_y40 = gid_y + 6 * (int)blockDim.y + 1;
                    if (_gid_y40 >= input_height)
                        _gid_y40 = input_height - 1;
                    if (_gid_y40 < 0)
                        _gid_y40 = 0;
                    _tmp36 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y40) * input_stride + _gid_x40);
                }
                {
                    int _gid_x41 = gid_x + 0;
                    int _gid_y41 = gid_y + 6 * (int)blockDim.y + 2;
                    if (_gid_y41 >= input_height)
                        _gid_y41 = input_height - 1;
                    if (_gid_y41 < 0)
                        _gid_y41 = 0;
                    _tmp36 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y41) * input_stride + _gid_x41);
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp36 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp42 = 0.F;
                {
                    int _gid_x43 = gid_x + 0;
                    int _gid_y43 = gid_y + 7 * (int)blockDim.y + -2;
                    if (_gid_y43 >= input_height)
                        _gid_y43 = input_height - 1;
                    if (_gid_y43 < 0)
                        _gid_y43 = 0;
                    _tmp42 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y43) * input_stride + _gid_x43);
                }
                {
                    int _gid_x44 = gid_x + 0;
                    int _gid_y44 = gid_y + 7 * (int)blockDim.y + -1;
                    if (_gid_y44 >= input_height)
                        _gid_y44 = input_height - 1;
                    if (_gid_y44 < 0)
                        _gid_y44 = 0;
                    _tmp42 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y44) * input_stride + _gid_x44);
                }
                {
                    int _gid_x45 = gid_x + 0;
                    int _gid_y45 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_y45 >= input_height)
                        _gid_y45 = input_height - 1;
                    if (_gid_y45 < 0)
                        _gid_y45 = 0;
                    _tmp42 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y45) * input_stride + _gid_x45);
                }
                {
                    int _gid_x46 = gid_x + 0;
                    int _gid_y46 = gid_y + 7 * (int)blockDim.y + 1;
                    if (_gid_y46 >= input_height)
                        _gid_y46 = input_height - 1;
                    if (_gid_y46 < 0)
                        _gid_y46 = 0;
                    _tmp42 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y46) * input_stride + _gid_x46);
                }
                {
                    int _gid_x47 = gid_x + 0;
                    int _gid_y47 = gid_y + 7 * (int)blockDim.y + 2;
                    if (_gid_y47 >= input_height)
                        _gid_y47 = input_height - 1;
                    if (_gid_y47 < 0)
                        _gid_y47 = 0;
                    _tmp42 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y47) * input_stride + _gid_x47);
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp42 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        if (gid_x < iter_width) {
            {
                float _tmp48 = 0.F;
                {
                    int _gid_x49 = gid_x + 0;
                    int _gid_y49 = gid_y + -2;
                    if (_gid_y49 < 0)
                        _gid_y49 = 0;
                    _tmp48 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y49) * input_stride + _gid_x49);
                }
                {
                    int _gid_x50 = gid_x + 0;
                    int _gid_y50 = gid_y + -1;
                    if (_gid_y50 < 0)
                        _gid_y50 = 0;
                    _tmp48 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y50) * input_stride + _gid_x50);
                }
                {
                    int _gid_x51 = gid_x + 0;
                    int _gid_y51 = gid_y + 0;
                    if (_gid_y51 < 0)
                        _gid_y51 = 0;
                    _tmp48 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y51) * input_stride + _gid_x51);
                }
                {
                    int _gid_x52 = gid_x + 0;
                    int _gid_y52 = gid_y + 1;
                    if (_gid_y52 < 0)
                        _gid_y52 = 0;
                    _tmp48 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y52) * input_stride + _gid_x52);
                }
                {
                    int _gid_x53 = gid_x + 0;
                    int _gid_y53 = gid_y + 2;
                    if (_gid_y53 < 0)
                        _gid_y53 = 0;
                    _tmp48 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y53) * input_stride + _gid_x53);
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp48 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp54 = 0.F;
                {
                    int _gid_x55 = gid_x + 0;
                    int _gid_y55 = gid_y + 1 * (int)blockDim.y + -2;
                    if (_gid_y55 < 0)
                        _gid_y55 = 0;
                    _tmp54 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y55) * input_stride + _gid_x55);
                }
                {
                    int _gid_x56 = gid_x + 0;
                    int _gid_y56 = gid_y + 1 * (int)blockDim.y + -1;
                    if (_gid_y56 < 0)
                        _gid_y56 = 0;
                    _tmp54 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y56) * input_stride + _gid_x56);
                }
                {
                    int _gid_x57 = gid_x + 0;
                    int _gid_y57 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_y57 < 0)
                        _gid_y57 = 0;
                    _tmp54 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y57) * input_stride + _gid_x57);
                }
                {
                    int _gid_x58 = gid_x + 0;
                    int _gid_y58 = gid_y + 1 * (int)blockDim.y + 1;
                    if (_gid_y58 < 0)
                        _gid_y58 = 0;
                    _tmp54 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y58) * input_stride + _gid_x58);
                }
                {
                    int _gid_x59 = gid_x + 0;
                    int _gid_y59 = gid_y + 1 * (int)blockDim.y + 2;
                    if (_gid_y59 < 0)
                        _gid_y59 = 0;
                    _tmp54 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y59) * input_stride + _gid_x59);
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp54 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp60 = 0.F;
                {
                    int _gid_x61 = gid_x + 0;
                    int _gid_y61 = gid_y + 2 * (int)blockDim.y + -2;
                    if (_gid_y61 < 0)
                        _gid_y61 = 0;
                    _tmp60 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y61) * input_stride + _gid_x61);
                }
                {
                    int _gid_x62 = gid_x + 0;
                    int _gid_y62 = gid_y + 2 * (int)blockDim.y + -1;
                    if (_gid_y62 < 0)
                        _gid_y62 = 0;
                    _tmp60 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y62) * input_stride + _gid_x62);
                }
                {
                    int _gid_x63 = gid_x + 0;
                    int _gid_y63 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_y63 < 0)
                        _gid_y63 = 0;
                    _tmp60 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y63) * input_stride + _gid_x63);
                }
                {
                    int _gid_x64 = gid_x + 0;
                    int _gid_y64 = gid_y + 2 * (int)blockDim.y + 1;
                    if (_gid_y64 < 0)
                        _gid_y64 = 0;
                    _tmp60 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y64) * input_stride + _gid_x64);
                }
                {
                    int _gid_x65 = gid_x + 0;
                    int _gid_y65 = gid_y + 2 * (int)blockDim.y + 2;
                    if (_gid_y65 < 0)
                        _gid_y65 = 0;
                    _tmp60 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y65) * input_stride + _gid_x65);
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp60 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp66 = 0.F;
                {
                    int _gid_x67 = gid_x + 0;
                    int _gid_y67 = gid_y + 3 * (int)blockDim.y + -2;
                    if (_gid_y67 < 0)
                        _gid_y67 = 0;
                    _tmp66 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y67) * input_stride + _gid_x67);
                }
                {
                    int _gid_x68 = gid_x + 0;
                    int _gid_y68 = gid_y + 3 * (int)blockDim.y + -1;
                    if (_gid_y68 < 0)
                        _gid_y68 = 0;
                    _tmp66 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y68) * input_stride + _gid_x68);
                }
                {
                    int _gid_x69 = gid_x + 0;
                    int _gid_y69 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_y69 < 0)
                        _gid_y69 = 0;
                    _tmp66 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y69) * input_stride + _gid_x69);
                }
                {
                    int _gid_x70 = gid_x + 0;
                    int _gid_y70 = gid_y + 3 * (int)blockDim.y + 1;
                    if (_gid_y70 < 0)
                        _gid_y70 = 0;
                    _tmp66 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y70) * input_stride + _gid_x70);
                }
                {
                    int _gid_x71 = gid_x + 0;
                    int _gid_y71 = gid_y + 3 * (int)blockDim.y + 2;
                    if (_gid_y71 < 0)
                        _gid_y71 = 0;
                    _tmp66 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y71) * input_stride + _gid_x71);
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp66 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp72 = 0.F;
                {
                    int _gid_x73 = gid_x + 0;
                    int _gid_y73 = gid_y + 4 * (int)blockDim.y + -2;
                    if (_gid_y73 < 0)
                        _gid_y73 = 0;
                    _tmp72 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y73) * input_stride + _gid_x73);
                }
                {
                    int _gid_x74 = gid_x + 0;
                    int _gid_y74 = gid_y + 4 * (int)blockDim.y + -1;
                    if (_gid_y74 < 0)
                        _gid_y74 = 0;
                    _tmp72 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y74) * input_stride + _gid_x74);
                }
                {
                    int _gid_x75 = gid_x + 0;
                    int _gid_y75 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_y75 < 0)
                        _gid_y75 = 0;
                    _tmp72 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y75) * input_stride + _gid_x75);
                }
                {
                    int _gid_x76 = gid_x + 0;
                    int _gid_y76 = gid_y + 4 * (int)blockDim.y + 1;
                    if (_gid_y76 < 0)
                        _gid_y76 = 0;
                    _tmp72 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y76) * input_stride + _gid_x76);
                }
                {
                    int _gid_x77 = gid_x + 0;
                    int _gid_y77 = gid_y + 4 * (int)blockDim.y + 2;
                    if (_gid_y77 < 0)
                        _gid_y77 = 0;
                    _tmp72 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y77) * input_stride + _gid_x77);
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp72 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp78 = 0.F;
                {
                    int _gid_x79 = gid_x + 0;
                    int _gid_y79 = gid_y + 5 * (int)blockDim.y + -2;
                    if (_gid_y79 < 0)
                        _gid_y79 = 0;
                    _tmp78 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y79) * input_stride + _gid_x79);
                }
                {
                    int _gid_x80 = gid_x + 0;
                    int _gid_y80 = gid_y + 5 * (int)blockDim.y + -1;
                    if (_gid_y80 < 0)
                        _gid_y80 = 0;
                    _tmp78 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y80) * input_stride + _gid_x80);
                }
                {
                    int _gid_x81 = gid_x + 0;
                    int _gid_y81 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_y81 < 0)
                        _gid_y81 = 0;
                    _tmp78 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y81) * input_stride + _gid_x81);
                }
                {
                    int _gid_x82 = gid_x + 0;
                    int _gid_y82 = gid_y + 5 * (int)blockDim.y + 1;
                    if (_gid_y82 < 0)
                        _gid_y82 = 0;
                    _tmp78 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y82) * input_stride + _gid_x82);
                }
                {
                    int _gid_x83 = gid_x + 0;
                    int _gid_y83 = gid_y + 5 * (int)blockDim.y + 2;
                    if (_gid_y83 < 0)
                        _gid_y83 = 0;
                    _tmp78 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y83) * input_stride + _gid_x83);
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp78 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp84 = 0.F;
                {
                    int _gid_x85 = gid_x + 0;
                    int _gid_y85 = gid_y + 6 * (int)blockDim.y + -2;
                    if (_gid_y85 < 0)
                        _gid_y85 = 0;
                    _tmp84 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y85) * input_stride + _gid_x85);
                }
                {
                    int _gid_x86 = gid_x + 0;
                    int _gid_y86 = gid_y + 6 * (int)blockDim.y + -1;
                    if (_gid_y86 < 0)
                        _gid_y86 = 0;
                    _tmp84 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y86) * input_stride + _gid_x86);
                }
                {
                    int _gid_x87 = gid_x + 0;
                    int _gid_y87 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_y87 < 0)
                        _gid_y87 = 0;
                    _tmp84 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y87) * input_stride + _gid_x87);
                }
                {
                    int _gid_x88 = gid_x + 0;
                    int _gid_y88 = gid_y + 6 * (int)blockDim.y + 1;
                    if (_gid_y88 < 0)
                        _gid_y88 = 0;
                    _tmp84 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y88) * input_stride + _gid_x88);
                }
                {
                    int _gid_x89 = gid_x + 0;
                    int _gid_y89 = gid_y + 6 * (int)blockDim.y + 2;
                    if (_gid_y89 < 0)
                        _gid_y89 = 0;
                    _tmp84 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y89) * input_stride + _gid_x89);
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp84 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp90 = 0.F;
                {
                    int _gid_x91 = gid_x + 0;
                    int _gid_y91 = gid_y + 7 * (int)blockDim.y + -2;
                    if (_gid_y91 < 0)
                        _gid_y91 = 0;
                    _tmp90 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y91) * input_stride + _gid_x91);
                }
                {
                    int _gid_x92 = gid_x + 0;
                    int _gid_y92 = gid_y + 7 * (int)blockDim.y + -1;
                    if (_gid_y92 < 0)
                        _gid_y92 = 0;
                    _tmp90 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y92) * input_stride + _gid_x92);
                }
                {
                    int _gid_x93 = gid_x + 0;
                    int _gid_y93 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_y93 < 0)
                        _gid_y93 = 0;
                    _tmp90 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y93) * input_stride + _gid_x93);
                }
                {
                    int _gid_x94 = gid_x + 0;
                    int _gid_y94 = gid_y + 7 * (int)blockDim.y + 1;
                    if (_gid_y94 < 0)
                        _gid_y94 = 0;
                    _tmp90 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y94) * input_stride + _gid_x94);
                }
                {
                    int _gid_x95 = gid_x + 0;
                    int _gid_y95 = gid_y + 7 * (int)blockDim.y + 2;
                    if (_gid_y95 < 0)
                        _gid_y95 = 0;
                    _tmp90 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y95) * input_stride + _gid_x95);
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp90 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp96 = 0.F;
                {
                    int _gid_x97 = gid_x + 0;
                    int _gid_y97 = gid_y + -2;
                    if (_gid_y97 >= input_height)
                        _gid_y97 = input_height - 1;
                    _tmp96 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y97) * input_stride + _gid_x97);
                }
                {
                    int _gid_x98 = gid_x + 0;
                    int _gid_y98 = gid_y + -1;
                    if (_gid_y98 >= input_height)
                        _gid_y98 = input_height - 1;
                    _tmp96 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y98) * input_stride + _gid_x98);
                }
                {
                    int _gid_x99 = gid_x + 0;
                    int _gid_y99 = gid_y + 0;
                    if (_gid_y99 >= input_height)
                        _gid_y99 = input_height - 1;
                    _tmp96 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y99) * input_stride + _gid_x99);
                }
                {
                    int _gid_x100 = gid_x + 0;
                    int _gid_y100 = gid_y + 1;
                    if (_gid_y100 >= input_height)
                        _gid_y100 = input_height - 1;
                    _tmp96 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y100) * input_stride + _gid_x100);
                }
                {
                    int _gid_x101 = gid_x + 0;
                    int _gid_y101 = gid_y + 2;
                    if (_gid_y101 >= input_height)
                        _gid_y101 = input_height - 1;
                    _tmp96 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y101) * input_stride + _gid_x101);
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp96 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp102 = 0.F;
                {
                    int _gid_x103 = gid_x + 0;
                    int _gid_y103 = gid_y + 1 * (int)blockDim.y + -2;
                    if (_gid_y103 >= input_height)
                        _gid_y103 = input_height - 1;
                    _tmp102 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y103) * input_stride + _gid_x103);
                }
                {
                    int _gid_x104 = gid_x + 0;
                    int _gid_y104 = gid_y + 1 * (int)blockDim.y + -1;
                    if (_gid_y104 >= input_height)
                        _gid_y104 = input_height - 1;
                    _tmp102 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y104) * input_stride + _gid_x104);
                }
                {
                    int _gid_x105 = gid_x + 0;
                    int _gid_y105 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_y105 >= input_height)
                        _gid_y105 = input_height - 1;
                    _tmp102 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y105) * input_stride + _gid_x105);
                }
                {
                    int _gid_x106 = gid_x + 0;
                    int _gid_y106 = gid_y + 1 * (int)blockDim.y + 1;
                    if (_gid_y106 >= input_height)
                        _gid_y106 = input_height - 1;
                    _tmp102 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y106) * input_stride + _gid_x106);
                }
                {
                    int _gid_x107 = gid_x + 0;
                    int _gid_y107 = gid_y + 1 * (int)blockDim.y + 2;
                    if (_gid_y107 >= input_height)
                        _gid_y107 = input_height - 1;
                    _tmp102 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y107) * input_stride + _gid_x107);
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp102 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp108 = 0.F;
                {
                    int _gid_x109 = gid_x + 0;
                    int _gid_y109 = gid_y + 2 * (int)blockDim.y + -2;
                    if (_gid_y109 >= input_height)
                        _gid_y109 = input_height - 1;
                    _tmp108 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y109) * input_stride + _gid_x109);
                }
                {
                    int _gid_x110 = gid_x + 0;
                    int _gid_y110 = gid_y + 2 * (int)blockDim.y + -1;
                    if (_gid_y110 >= input_height)
                        _gid_y110 = input_height - 1;
                    _tmp108 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y110) * input_stride + _gid_x110);
                }
                {
                    int _gid_x111 = gid_x + 0;
                    int _gid_y111 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_y111 >= input_height)
                        _gid_y111 = input_height - 1;
                    _tmp108 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y111) * input_stride + _gid_x111);
                }
                {
                    int _gid_x112 = gid_x + 0;
                    int _gid_y112 = gid_y + 2 * (int)blockDim.y + 1;
                    if (_gid_y112 >= input_height)
                        _gid_y112 = input_height - 1;
                    _tmp108 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y112) * input_stride + _gid_x112);
                }
                {
                    int _gid_x113 = gid_x + 0;
                    int _gid_y113 = gid_y + 2 * (int)blockDim.y + 2;
                    if (_gid_y113 >= input_height)
                        _gid_y113 = input_height - 1;
                    _tmp108 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y113) * input_stride + _gid_x113);
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp108 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp114 = 0.F;
                {
                    int _gid_x115 = gid_x + 0;
                    int _gid_y115 = gid_y + 3 * (int)blockDim.y + -2;
                    if (_gid_y115 >= input_height)
                        _gid_y115 = input_height - 1;
                    _tmp114 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y115) * input_stride + _gid_x115);
                }
                {
                    int _gid_x116 = gid_x + 0;
                    int _gid_y116 = gid_y + 3 * (int)blockDim.y + -1;
                    if (_gid_y116 >= input_height)
                        _gid_y116 = input_height - 1;
                    _tmp114 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y116) * input_stride + _gid_x116);
                }
                {
                    int _gid_x117 = gid_x + 0;
                    int _gid_y117 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_y117 >= input_height)
                        _gid_y117 = input_height - 1;
                    _tmp114 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y117) * input_stride + _gid_x117);
                }
                {
                    int _gid_x118 = gid_x + 0;
                    int _gid_y118 = gid_y + 3 * (int)blockDim.y + 1;
                    if (_gid_y118 >= input_height)
                        _gid_y118 = input_height - 1;
                    _tmp114 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y118) * input_stride + _gid_x118);
                }
                {
                    int _gid_x119 = gid_x + 0;
                    int _gid_y119 = gid_y + 3 * (int)blockDim.y + 2;
                    if (_gid_y119 >= input_height)
                        _gid_y119 = input_height - 1;
                    _tmp114 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y119) * input_stride + _gid_x119);
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp114 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp120 = 0.F;
                {
                    int _gid_x121 = gid_x + 0;
                    int _gid_y121 = gid_y + 4 * (int)blockDim.y + -2;
                    if (_gid_y121 >= input_height)
                        _gid_y121 = input_height - 1;
                    _tmp120 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y121) * input_stride + _gid_x121);
                }
                {
                    int _gid_x122 = gid_x + 0;
                    int _gid_y122 = gid_y + 4 * (int)blockDim.y + -1;
                    if (_gid_y122 >= input_height)
                        _gid_y122 = input_height - 1;
                    _tmp120 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y122) * input_stride + _gid_x122);
                }
                {
                    int _gid_x123 = gid_x + 0;
                    int _gid_y123 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_y123 >= input_height)
                        _gid_y123 = input_height - 1;
                    _tmp120 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y123) * input_stride + _gid_x123);
                }
                {
                    int _gid_x124 = gid_x + 0;
                    int _gid_y124 = gid_y + 4 * (int)blockDim.y + 1;
                    if (_gid_y124 >= input_height)
                        _gid_y124 = input_height - 1;
                    _tmp120 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y124) * input_stride + _gid_x124);
                }
                {
                    int _gid_x125 = gid_x + 0;
                    int _gid_y125 = gid_y + 4 * (int)blockDim.y + 2;
                    if (_gid_y125 >= input_height)
                        _gid_y125 = input_height - 1;
                    _tmp120 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y125) * input_stride + _gid_x125);
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp120 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp126 = 0.F;
                {
                    int _gid_x127 = gid_x + 0;
                    int _gid_y127 = gid_y + 5 * (int)blockDim.y + -2;
                    if (_gid_y127 >= input_height)
                        _gid_y127 = input_height - 1;
                    _tmp126 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y127) * input_stride + _gid_x127);
                }
                {
                    int _gid_x128 = gid_x + 0;
                    int _gid_y128 = gid_y + 5 * (int)blockDim.y + -1;
                    if (_gid_y128 >= input_height)
                        _gid_y128 = input_height - 1;
                    _tmp126 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y128) * input_stride + _gid_x128);
                }
                {
                    int _gid_x129 = gid_x + 0;
                    int _gid_y129 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_y129 >= input_height)
                        _gid_y129 = input_height - 1;
                    _tmp126 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y129) * input_stride + _gid_x129);
                }
                {
                    int _gid_x130 = gid_x + 0;
                    int _gid_y130 = gid_y + 5 * (int)blockDim.y + 1;
                    if (_gid_y130 >= input_height)
                        _gid_y130 = input_height - 1;
                    _tmp126 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y130) * input_stride + _gid_x130);
                }
                {
                    int _gid_x131 = gid_x + 0;
                    int _gid_y131 = gid_y + 5 * (int)blockDim.y + 2;
                    if (_gid_y131 >= input_height)
                        _gid_y131 = input_height - 1;
                    _tmp126 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y131) * input_stride + _gid_x131);
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp126 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp132 = 0.F;
                {
                    int _gid_x133 = gid_x + 0;
                    int _gid_y133 = gid_y + 6 * (int)blockDim.y + -2;
                    if (_gid_y133 >= input_height)
                        _gid_y133 = input_height - 1;
                    _tmp132 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y133) * input_stride + _gid_x133);
                }
                {
                    int _gid_x134 = gid_x + 0;
                    int _gid_y134 = gid_y + 6 * (int)blockDim.y + -1;
                    if (_gid_y134 >= input_height)
                        _gid_y134 = input_height - 1;
                    _tmp132 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y134) * input_stride + _gid_x134);
                }
                {
                    int _gid_x135 = gid_x + 0;
                    int _gid_y135 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_y135 >= input_height)
                        _gid_y135 = input_height - 1;
                    _tmp132 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y135) * input_stride + _gid_x135);
                }
                {
                    int _gid_x136 = gid_x + 0;
                    int _gid_y136 = gid_y + 6 * (int)blockDim.y + 1;
                    if (_gid_y136 >= input_height)
                        _gid_y136 = input_height - 1;
                    _tmp132 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y136) * input_stride + _gid_x136);
                }
                {
                    int _gid_x137 = gid_x + 0;
                    int _gid_y137 = gid_y + 6 * (int)blockDim.y + 2;
                    if (_gid_y137 >= input_height)
                        _gid_y137 = input_height - 1;
                    _tmp132 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y137) * input_stride + _gid_x137);
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp132 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp138 = 0.F;
                {
                    int _gid_x139 = gid_x + 0;
                    int _gid_y139 = gid_y + 7 * (int)blockDim.y + -2;
                    if (_gid_y139 >= input_height)
                        _gid_y139 = input_height - 1;
                    _tmp138 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y139) * input_stride + _gid_x139);
                }
                {
                    int _gid_x140 = gid_x + 0;
                    int _gid_y140 = gid_y + 7 * (int)blockDim.y + -1;
                    if (_gid_y140 >= input_height)
                        _gid_y140 = input_height - 1;
                    _tmp138 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y140) * input_stride + _gid_x140);
                }
                {
                    int _gid_x141 = gid_x + 0;
                    int _gid_y141 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_y141 >= input_height)
                        _gid_y141 = input_height - 1;
                    _tmp138 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y141) * input_stride + _gid_x141);
                }
                {
                    int _gid_x142 = gid_x + 0;
                    int _gid_y142 = gid_y + 7 * (int)blockDim.y + 1;
                    if (_gid_y142 >= input_height)
                        _gid_y142 = input_height - 1;
                    _tmp138 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y142) * input_stride + _gid_x142);
                }
                {
                    int _gid_x143 = gid_x + 0;
                    int _gid_y143 = gid_y + 7 * (int)blockDim.y + 2;
                    if (_gid_y143 >= input_height)
                        _gid_y143 = input_height - 1;
                    _tmp138 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y143) * input_stride + _gid_x143);
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp138 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        if (gid_x < iter_width) {
            {
                float _tmp144 = 0.F;
                {
                    int _gid_x145 = gid_x + 0;
                    int _gid_y145 = gid_y + -2;
                    if (_gid_x145 >= input_width)
                        _gid_x145 = input_width - 1;
                    _tmp144 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y145) * input_stride + _gid_x145);
                }
                {
                    int _gid_x146 = gid_x + 0;
                    int _gid_y146 = gid_y + -1;
                    if (_gid_x146 >= input_width)
                        _gid_x146 = input_width - 1;
                    _tmp144 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y146) * input_stride + _gid_x146);
                }
                {
                    int _gid_x147 = gid_x + 0;
                    int _gid_y147 = gid_y + 0;
                    if (_gid_x147 >= input_width)
                        _gid_x147 = input_width - 1;
                    _tmp144 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y147) * input_stride + _gid_x147);
                }
                {
                    int _gid_x148 = gid_x + 0;
                    int _gid_y148 = gid_y + 1;
                    if (_gid_x148 >= input_width)
                        _gid_x148 = input_width - 1;
                    _tmp144 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y148) * input_stride + _gid_x148);
                }
                {
                    int _gid_x149 = gid_x + 0;
                    int _gid_y149 = gid_y + 2;
                    if (_gid_x149 >= input_width)
                        _gid_x149 = input_width - 1;
                    _tmp144 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y149) * input_stride + _gid_x149);
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp144 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp150 = 0.F;
                {
                    int _gid_x151 = gid_x + 0;
                    int _gid_y151 = gid_y + 1 * (int)blockDim.y + -2;
                    if (_gid_x151 >= input_width)
                        _gid_x151 = input_width - 1;
                    _tmp150 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y151) * input_stride + _gid_x151);
                }
                {
                    int _gid_x152 = gid_x + 0;
                    int _gid_y152 = gid_y + 1 * (int)blockDim.y + -1;
                    if (_gid_x152 >= input_width)
                        _gid_x152 = input_width - 1;
                    _tmp150 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y152) * input_stride + _gid_x152);
                }
                {
                    int _gid_x153 = gid_x + 0;
                    int _gid_y153 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x153 >= input_width)
                        _gid_x153 = input_width - 1;
                    _tmp150 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y153) * input_stride + _gid_x153);
                }
                {
                    int _gid_x154 = gid_x + 0;
                    int _gid_y154 = gid_y + 1 * (int)blockDim.y + 1;
                    if (_gid_x154 >= input_width)
                        _gid_x154 = input_width - 1;
                    _tmp150 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y154) * input_stride + _gid_x154);
                }
                {
                    int _gid_x155 = gid_x + 0;
                    int _gid_y155 = gid_y + 1 * (int)blockDim.y + 2;
                    if (_gid_x155 >= input_width)
                        _gid_x155 = input_width - 1;
                    _tmp150 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y155) * input_stride + _gid_x155);
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp150 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp156 = 0.F;
                {
                    int _gid_x157 = gid_x + 0;
                    int _gid_y157 = gid_y + 2 * (int)blockDim.y + -2;
                    if (_gid_x157 >= input_width)
                        _gid_x157 = input_width - 1;
                    _tmp156 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y157) * input_stride + _gid_x157);
                }
                {
                    int _gid_x158 = gid_x + 0;
                    int _gid_y158 = gid_y + 2 * (int)blockDim.y + -1;
                    if (_gid_x158 >= input_width)
                        _gid_x158 = input_width - 1;
                    _tmp156 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y158) * input_stride + _gid_x158);
                }
                {
                    int _gid_x159 = gid_x + 0;
                    int _gid_y159 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x159 >= input_width)
                        _gid_x159 = input_width - 1;
                    _tmp156 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y159) * input_stride + _gid_x159);
                }
                {
                    int _gid_x160 = gid_x + 0;
                    int _gid_y160 = gid_y + 2 * (int)blockDim.y + 1;
                    if (_gid_x160 >= input_width)
                        _gid_x160 = input_width - 1;
                    _tmp156 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y160) * input_stride + _gid_x160);
                }
                {
                    int _gid_x161 = gid_x + 0;
                    int _gid_y161 = gid_y + 2 * (int)blockDim.y + 2;
                    if (_gid_x161 >= input_width)
                        _gid_x161 = input_width - 1;
                    _tmp156 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y161) * input_stride + _gid_x161);
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp156 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp162 = 0.F;
                {
                    int _gid_x163 = gid_x + 0;
                    int _gid_y163 = gid_y + 3 * (int)blockDim.y + -2;
                    if (_gid_x163 >= input_width)
                        _gid_x163 = input_width - 1;
                    _tmp162 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y163) * input_stride + _gid_x163);
                }
                {
                    int _gid_x164 = gid_x + 0;
                    int _gid_y164 = gid_y + 3 * (int)blockDim.y + -1;
                    if (_gid_x164 >= input_width)
                        _gid_x164 = input_width - 1;
                    _tmp162 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y164) * input_stride + _gid_x164);
                }
                {
                    int _gid_x165 = gid_x + 0;
                    int _gid_y165 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x165 >= input_width)
                        _gid_x165 = input_width - 1;
                    _tmp162 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y165) * input_stride + _gid_x165);
                }
                {
                    int _gid_x166 = gid_x + 0;
                    int _gid_y166 = gid_y + 3 * (int)blockDim.y + 1;
                    if (_gid_x166 >= input_width)
                        _gid_x166 = input_width - 1;
                    _tmp162 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y166) * input_stride + _gid_x166);
                }
                {
                    int _gid_x167 = gid_x + 0;
                    int _gid_y167 = gid_y + 3 * (int)blockDim.y + 2;
                    if (_gid_x167 >= input_width)
                        _gid_x167 = input_width - 1;
                    _tmp162 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y167) * input_stride + _gid_x167);
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp162 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp168 = 0.F;
                {
                    int _gid_x169 = gid_x + 0;
                    int _gid_y169 = gid_y + 4 * (int)blockDim.y + -2;
                    if (_gid_x169 >= input_width)
                        _gid_x169 = input_width - 1;
                    _tmp168 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y169) * input_stride + _gid_x169);
                }
                {
                    int _gid_x170 = gid_x + 0;
                    int _gid_y170 = gid_y + 4 * (int)blockDim.y + -1;
                    if (_gid_x170 >= input_width)
                        _gid_x170 = input_width - 1;
                    _tmp168 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y170) * input_stride + _gid_x170);
                }
                {
                    int _gid_x171 = gid_x + 0;
                    int _gid_y171 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x171 >= input_width)
                        _gid_x171 = input_width - 1;
                    _tmp168 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y171) * input_stride + _gid_x171);
                }
                {
                    int _gid_x172 = gid_x + 0;
                    int _gid_y172 = gid_y + 4 * (int)blockDim.y + 1;
                    if (_gid_x172 >= input_width)
                        _gid_x172 = input_width - 1;
                    _tmp168 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y172) * input_stride + _gid_x172);
                }
                {
                    int _gid_x173 = gid_x + 0;
                    int _gid_y173 = gid_y + 4 * (int)blockDim.y + 2;
                    if (_gid_x173 >= input_width)
                        _gid_x173 = input_width - 1;
                    _tmp168 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y173) * input_stride + _gid_x173);
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp168 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp174 = 0.F;
                {
                    int _gid_x175 = gid_x + 0;
                    int _gid_y175 = gid_y + 5 * (int)blockDim.y + -2;
                    if (_gid_x175 >= input_width)
                        _gid_x175 = input_width - 1;
                    _tmp174 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y175) * input_stride + _gid_x175);
                }
                {
                    int _gid_x176 = gid_x + 0;
                    int _gid_y176 = gid_y + 5 * (int)blockDim.y + -1;
                    if (_gid_x176 >= input_width)
                        _gid_x176 = input_width - 1;
                    _tmp174 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y176) * input_stride + _gid_x176);
                }
                {
                    int _gid_x177 = gid_x + 0;
                    int _gid_y177 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x177 >= input_width)
                        _gid_x177 = input_width - 1;
                    _tmp174 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y177) * input_stride + _gid_x177);
                }
                {
                    int _gid_x178 = gid_x + 0;
                    int _gid_y178 = gid_y + 5 * (int)blockDim.y + 1;
                    if (_gid_x178 >= input_width)
                        _gid_x178 = input_width - 1;
                    _tmp174 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y178) * input_stride + _gid_x178);
                }
                {
                    int _gid_x179 = gid_x + 0;
                    int _gid_y179 = gid_y + 5 * (int)blockDim.y + 2;
                    if (_gid_x179 >= input_width)
                        _gid_x179 = input_width - 1;
                    _tmp174 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y179) * input_stride + _gid_x179);
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp174 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp180 = 0.F;
                {
                    int _gid_x181 = gid_x + 0;
                    int _gid_y181 = gid_y + 6 * (int)blockDim.y + -2;
                    if (_gid_x181 >= input_width)
                        _gid_x181 = input_width - 1;
                    _tmp180 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y181) * input_stride + _gid_x181);
                }
                {
                    int _gid_x182 = gid_x + 0;
                    int _gid_y182 = gid_y + 6 * (int)blockDim.y + -1;
                    if (_gid_x182 >= input_width)
                        _gid_x182 = input_width - 1;
                    _tmp180 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y182) * input_stride + _gid_x182);
                }
                {
                    int _gid_x183 = gid_x + 0;
                    int _gid_y183 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x183 >= input_width)
                        _gid_x183 = input_width - 1;
                    _tmp180 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y183) * input_stride + _gid_x183);
                }
                {
                    int _gid_x184 = gid_x + 0;
                    int _gid_y184 = gid_y + 6 * (int)blockDim.y + 1;
                    if (_gid_x184 >= input_width)
                        _gid_x184 = input_width - 1;
                    _tmp180 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y184) * input_stride + _gid_x184);
                }
                {
                    int _gid_x185 = gid_x + 0;
                    int _gid_y185 = gid_y + 6 * (int)blockDim.y + 2;
                    if (_gid_x185 >= input_width)
                        _gid_x185 = input_width - 1;
                    _tmp180 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y185) * input_stride + _gid_x185);
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp180 + 0.5F);
            }
        }
        if (gid_x < iter_width) {
            {
                float _tmp186 = 0.F;
                {
                    int _gid_x187 = gid_x + 0;
                    int _gid_y187 = gid_y + 7 * (int)blockDim.y + -2;
                    if (_gid_x187 >= input_width)
                        _gid_x187 = input_width - 1;
                    _tmp186 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (_gid_y187) * input_stride + _gid_x187);
                }
                {
                    int _gid_x188 = gid_x + 0;
                    int _gid_y188 = gid_y + 7 * (int)blockDim.y + -1;
                    if (_gid_x188 >= input_width)
                        _gid_x188 = input_width - 1;
                    _tmp186 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (_gid_y188) * input_stride + _gid_x188);
                }
                {
                    int _gid_x189 = gid_x + 0;
                    int _gid_y189 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x189 >= input_width)
                        _gid_x189 = input_width - 1;
                    _tmp186 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (_gid_y189) * input_stride + _gid_x189);
                }
                {
                    int _gid_x190 = gid_x + 0;
                    int _gid_y190 = gid_y + 7 * (int)blockDim.y + 1;
                    if (_gid_x190 >= input_width)
                        _gid_x190 = input_width - 1;
                    _tmp186 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (_gid_y190) * input_stride + _gid_x190);
                }
                {
                    int _gid_x191 = gid_x + 0;
                    int _gid_y191 = gid_y + 7 * (int)blockDim.y + 2;
                    if (_gid_x191 >= input_width)
                        _gid_x191 = input_width - 1;
                    _tmp186 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (_gid_y191) * input_stride + _gid_x191);
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp186 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        {
            float _tmp192 = 0.F;
            {
                _tmp192 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp192 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp192 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp192 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp192 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp192 + 0.5F);
        }
        {
            float _tmp193 = 0.F;
            {
                _tmp193 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp193 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp193 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp193 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp193 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 1 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp193 + 0.5F);
        }
        {
            float _tmp194 = 0.F;
            {
                _tmp194 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp194 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp194 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp194 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp194 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 2 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp194 + 0.5F);
        }
        {
            float _tmp195 = 0.F;
            {
                _tmp195 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp195 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp195 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp195 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp195 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 3 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp195 + 0.5F);
        }
        {
            float _tmp196 = 0.F;
            {
                _tmp196 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp196 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp196 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp196 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp196 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 4 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp196 + 0.5F);
        }
        {
            float _tmp197 = 0.F;
            {
                _tmp197 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp197 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp197 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp197 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp197 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 5 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp197 + 0.5F);
        }
        {
            float _tmp198 = 0.F;
            {
                _tmp198 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp198 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp198 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp198 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp198 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 6 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp198 + 0.5F);
        }
        {
            float _tmp199 = 0.F;
            {
                _tmp199 += _constmask_yY[0][0] * tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + -2) * input_stride + gid_x + 0);
            }
            {
                _tmp199 += _constmask_yY[1][0] * tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + -1) * input_stride + gid_x + 0);
            }
            {
                _tmp199 += _constmask_yY[2][0] * tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp199 += _constmask_yY[3][0] * tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + 1) * input_stride + gid_x + 0);
            }
            {
                _tmp199 += _constmask_yY[4][0] * tex1Dfetch(_texinputY, (gid_y + 7 * (int)blockDim.y + 2) * input_stride + gid_x + 0);
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (uchar)(_tmp199 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERCOLUMNY_CU_

