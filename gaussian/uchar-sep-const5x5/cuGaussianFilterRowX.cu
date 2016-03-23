#ifndef _CUGAUSSIANFILTERROWX_CU_
#define _CUGAUSSIANFILTERROWX_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"

texture<uchar, cudaTextureType1D, cudaReadModeElementType> _texinputX;
const textureReference *_texinputXRef;

extern "C" {
__global__ __launch_bounds__ (64*1) void cuGaussianFilterRowXKernel(float * __restrict__ iter, int iter_width, int iter_height, int iter_stride, int input_width, int input_height, int input_stride, int bh_start_left, int bh_start_right, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y * 8 + threadIdx.y;
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
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp0 = 0.F;
                {
                    int _gid_x1 = gid_x + -2;
                    int _gid_y1 = gid_y + 0;
                    if (_gid_x1 >= input_width)
                        _gid_x1 = input_width - 1;
                    if (_gid_x1 < 0)
                        _gid_x1 = 0;
                    _tmp0 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y1) * input_stride + _gid_x1);
                }
                {
                    int _gid_x2 = gid_x + -1;
                    int _gid_y2 = gid_y + 0;
                    if (_gid_x2 >= input_width)
                        _gid_x2 = input_width - 1;
                    if (_gid_x2 < 0)
                        _gid_x2 = 0;
                    _tmp0 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y2) * input_stride + _gid_x2);
                }
                {
                    int _gid_x3 = gid_x + 0;
                    int _gid_y3 = gid_y + 0;
                    if (_gid_x3 >= input_width)
                        _gid_x3 = input_width - 1;
                    if (_gid_x3 < 0)
                        _gid_x3 = 0;
                    _tmp0 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y3) * input_stride + _gid_x3);
                }
                {
                    int _gid_x4 = gid_x + 1;
                    int _gid_y4 = gid_y + 0;
                    if (_gid_x4 >= input_width)
                        _gid_x4 = input_width - 1;
                    if (_gid_x4 < 0)
                        _gid_x4 = 0;
                    _tmp0 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y4) * input_stride + _gid_x4);
                }
                {
                    int _gid_x5 = gid_x + 2;
                    int _gid_y5 = gid_y + 0;
                    if (_gid_x5 >= input_width)
                        _gid_x5 = input_width - 1;
                    if (_gid_x5 < 0)
                        _gid_x5 = 0;
                    _tmp0 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y5) * input_stride + _gid_x5);
                }
                iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp0);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp6 = 0.F;
                {
                    int _gid_x7 = gid_x + -2;
                    int _gid_y7 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x7 >= input_width)
                        _gid_x7 = input_width - 1;
                    if (_gid_x7 < 0)
                        _gid_x7 = 0;
                    _tmp6 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y7) * input_stride + _gid_x7);
                }
                {
                    int _gid_x8 = gid_x + -1;
                    int _gid_y8 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x8 >= input_width)
                        _gid_x8 = input_width - 1;
                    if (_gid_x8 < 0)
                        _gid_x8 = 0;
                    _tmp6 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y8) * input_stride + _gid_x8);
                }
                {
                    int _gid_x9 = gid_x + 0;
                    int _gid_y9 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x9 >= input_width)
                        _gid_x9 = input_width - 1;
                    if (_gid_x9 < 0)
                        _gid_x9 = 0;
                    _tmp6 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y9) * input_stride + _gid_x9);
                }
                {
                    int _gid_x10 = gid_x + 1;
                    int _gid_y10 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x10 >= input_width)
                        _gid_x10 = input_width - 1;
                    if (_gid_x10 < 0)
                        _gid_x10 = 0;
                    _tmp6 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y10) * input_stride + _gid_x10);
                }
                {
                    int _gid_x11 = gid_x + 2;
                    int _gid_y11 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x11 >= input_width)
                        _gid_x11 = input_width - 1;
                    if (_gid_x11 < 0)
                        _gid_x11 = 0;
                    _tmp6 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y11) * input_stride + _gid_x11);
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp6);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp12 = 0.F;
                {
                    int _gid_x13 = gid_x + -2;
                    int _gid_y13 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x13 >= input_width)
                        _gid_x13 = input_width - 1;
                    if (_gid_x13 < 0)
                        _gid_x13 = 0;
                    _tmp12 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y13) * input_stride + _gid_x13);
                }
                {
                    int _gid_x14 = gid_x + -1;
                    int _gid_y14 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x14 >= input_width)
                        _gid_x14 = input_width - 1;
                    if (_gid_x14 < 0)
                        _gid_x14 = 0;
                    _tmp12 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y14) * input_stride + _gid_x14);
                }
                {
                    int _gid_x15 = gid_x + 0;
                    int _gid_y15 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x15 >= input_width)
                        _gid_x15 = input_width - 1;
                    if (_gid_x15 < 0)
                        _gid_x15 = 0;
                    _tmp12 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y15) * input_stride + _gid_x15);
                }
                {
                    int _gid_x16 = gid_x + 1;
                    int _gid_y16 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x16 >= input_width)
                        _gid_x16 = input_width - 1;
                    if (_gid_x16 < 0)
                        _gid_x16 = 0;
                    _tmp12 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y16) * input_stride + _gid_x16);
                }
                {
                    int _gid_x17 = gid_x + 2;
                    int _gid_y17 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x17 >= input_width)
                        _gid_x17 = input_width - 1;
                    if (_gid_x17 < 0)
                        _gid_x17 = 0;
                    _tmp12 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y17) * input_stride + _gid_x17);
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp12);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp18 = 0.F;
                {
                    int _gid_x19 = gid_x + -2;
                    int _gid_y19 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x19 >= input_width)
                        _gid_x19 = input_width - 1;
                    if (_gid_x19 < 0)
                        _gid_x19 = 0;
                    _tmp18 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y19) * input_stride + _gid_x19);
                }
                {
                    int _gid_x20 = gid_x + -1;
                    int _gid_y20 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x20 >= input_width)
                        _gid_x20 = input_width - 1;
                    if (_gid_x20 < 0)
                        _gid_x20 = 0;
                    _tmp18 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y20) * input_stride + _gid_x20);
                }
                {
                    int _gid_x21 = gid_x + 0;
                    int _gid_y21 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x21 >= input_width)
                        _gid_x21 = input_width - 1;
                    if (_gid_x21 < 0)
                        _gid_x21 = 0;
                    _tmp18 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y21) * input_stride + _gid_x21);
                }
                {
                    int _gid_x22 = gid_x + 1;
                    int _gid_y22 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x22 >= input_width)
                        _gid_x22 = input_width - 1;
                    if (_gid_x22 < 0)
                        _gid_x22 = 0;
                    _tmp18 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y22) * input_stride + _gid_x22);
                }
                {
                    int _gid_x23 = gid_x + 2;
                    int _gid_y23 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x23 >= input_width)
                        _gid_x23 = input_width - 1;
                    if (_gid_x23 < 0)
                        _gid_x23 = 0;
                    _tmp18 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y23) * input_stride + _gid_x23);
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp18);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp24 = 0.F;
                {
                    int _gid_x25 = gid_x + -2;
                    int _gid_y25 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x25 >= input_width)
                        _gid_x25 = input_width - 1;
                    if (_gid_x25 < 0)
                        _gid_x25 = 0;
                    _tmp24 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y25) * input_stride + _gid_x25);
                }
                {
                    int _gid_x26 = gid_x + -1;
                    int _gid_y26 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x26 >= input_width)
                        _gid_x26 = input_width - 1;
                    if (_gid_x26 < 0)
                        _gid_x26 = 0;
                    _tmp24 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y26) * input_stride + _gid_x26);
                }
                {
                    int _gid_x27 = gid_x + 0;
                    int _gid_y27 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x27 >= input_width)
                        _gid_x27 = input_width - 1;
                    if (_gid_x27 < 0)
                        _gid_x27 = 0;
                    _tmp24 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y27) * input_stride + _gid_x27);
                }
                {
                    int _gid_x28 = gid_x + 1;
                    int _gid_y28 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x28 >= input_width)
                        _gid_x28 = input_width - 1;
                    if (_gid_x28 < 0)
                        _gid_x28 = 0;
                    _tmp24 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y28) * input_stride + _gid_x28);
                }
                {
                    int _gid_x29 = gid_x + 2;
                    int _gid_y29 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x29 >= input_width)
                        _gid_x29 = input_width - 1;
                    if (_gid_x29 < 0)
                        _gid_x29 = 0;
                    _tmp24 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y29) * input_stride + _gid_x29);
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp24);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp30 = 0.F;
                {
                    int _gid_x31 = gid_x + -2;
                    int _gid_y31 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x31 >= input_width)
                        _gid_x31 = input_width - 1;
                    if (_gid_x31 < 0)
                        _gid_x31 = 0;
                    _tmp30 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y31) * input_stride + _gid_x31);
                }
                {
                    int _gid_x32 = gid_x + -1;
                    int _gid_y32 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x32 >= input_width)
                        _gid_x32 = input_width - 1;
                    if (_gid_x32 < 0)
                        _gid_x32 = 0;
                    _tmp30 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y32) * input_stride + _gid_x32);
                }
                {
                    int _gid_x33 = gid_x + 0;
                    int _gid_y33 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x33 >= input_width)
                        _gid_x33 = input_width - 1;
                    if (_gid_x33 < 0)
                        _gid_x33 = 0;
                    _tmp30 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y33) * input_stride + _gid_x33);
                }
                {
                    int _gid_x34 = gid_x + 1;
                    int _gid_y34 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x34 >= input_width)
                        _gid_x34 = input_width - 1;
                    if (_gid_x34 < 0)
                        _gid_x34 = 0;
                    _tmp30 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y34) * input_stride + _gid_x34);
                }
                {
                    int _gid_x35 = gid_x + 2;
                    int _gid_y35 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x35 >= input_width)
                        _gid_x35 = input_width - 1;
                    if (_gid_x35 < 0)
                        _gid_x35 = 0;
                    _tmp30 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y35) * input_stride + _gid_x35);
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp30);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp36 = 0.F;
                {
                    int _gid_x37 = gid_x + -2;
                    int _gid_y37 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x37 >= input_width)
                        _gid_x37 = input_width - 1;
                    if (_gid_x37 < 0)
                        _gid_x37 = 0;
                    _tmp36 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y37) * input_stride + _gid_x37);
                }
                {
                    int _gid_x38 = gid_x + -1;
                    int _gid_y38 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x38 >= input_width)
                        _gid_x38 = input_width - 1;
                    if (_gid_x38 < 0)
                        _gid_x38 = 0;
                    _tmp36 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y38) * input_stride + _gid_x38);
                }
                {
                    int _gid_x39 = gid_x + 0;
                    int _gid_y39 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x39 >= input_width)
                        _gid_x39 = input_width - 1;
                    if (_gid_x39 < 0)
                        _gid_x39 = 0;
                    _tmp36 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y39) * input_stride + _gid_x39);
                }
                {
                    int _gid_x40 = gid_x + 1;
                    int _gid_y40 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x40 >= input_width)
                        _gid_x40 = input_width - 1;
                    if (_gid_x40 < 0)
                        _gid_x40 = 0;
                    _tmp36 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y40) * input_stride + _gid_x40);
                }
                {
                    int _gid_x41 = gid_x + 2;
                    int _gid_y41 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x41 >= input_width)
                        _gid_x41 = input_width - 1;
                    if (_gid_x41 < 0)
                        _gid_x41 = 0;
                    _tmp36 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y41) * input_stride + _gid_x41);
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp36);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp42 = 0.F;
                {
                    int _gid_x43 = gid_x + -2;
                    int _gid_y43 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x43 >= input_width)
                        _gid_x43 = input_width - 1;
                    if (_gid_x43 < 0)
                        _gid_x43 = 0;
                    _tmp42 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y43) * input_stride + _gid_x43);
                }
                {
                    int _gid_x44 = gid_x + -1;
                    int _gid_y44 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x44 >= input_width)
                        _gid_x44 = input_width - 1;
                    if (_gid_x44 < 0)
                        _gid_x44 = 0;
                    _tmp42 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y44) * input_stride + _gid_x44);
                }
                {
                    int _gid_x45 = gid_x + 0;
                    int _gid_y45 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x45 >= input_width)
                        _gid_x45 = input_width - 1;
                    if (_gid_x45 < 0)
                        _gid_x45 = 0;
                    _tmp42 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y45) * input_stride + _gid_x45);
                }
                {
                    int _gid_x46 = gid_x + 1;
                    int _gid_y46 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x46 >= input_width)
                        _gid_x46 = input_width - 1;
                    if (_gid_x46 < 0)
                        _gid_x46 = 0;
                    _tmp42 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y46) * input_stride + _gid_x46);
                }
                {
                    int _gid_x47 = gid_x + 2;
                    int _gid_y47 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x47 >= input_width)
                        _gid_x47 = input_width - 1;
                    if (_gid_x47 < 0)
                        _gid_x47 = 0;
                    _tmp42 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y47) * input_stride + _gid_x47);
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp42);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        if (gid_y < iter_height) {
            float _tmp48 = 0.F;
            {
                int _gid_x49 = gid_x + -2;
                int _gid_y49 = gid_y + 0;
                if (_gid_y49 >= input_height)
                    _gid_y49 = input_height - 1;
                _tmp48 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y49) * input_stride + _gid_x49);
            }
            {
                int _gid_x50 = gid_x + -1;
                int _gid_y50 = gid_y + 0;
                if (_gid_y50 >= input_height)
                    _gid_y50 = input_height - 1;
                _tmp48 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y50) * input_stride + _gid_x50);
            }
            {
                int _gid_x51 = gid_x + 0;
                int _gid_y51 = gid_y + 0;
                if (_gid_y51 >= input_height)
                    _gid_y51 = input_height - 1;
                _tmp48 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y51) * input_stride + _gid_x51);
            }
            {
                int _gid_x52 = gid_x + 1;
                int _gid_y52 = gid_y + 0;
                if (_gid_y52 >= input_height)
                    _gid_y52 = input_height - 1;
                _tmp48 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y52) * input_stride + _gid_x52);
            }
            {
                int _gid_x53 = gid_x + 2;
                int _gid_y53 = gid_y + 0;
                if (_gid_y53 >= input_height)
                    _gid_y53 = input_height - 1;
                _tmp48 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y53) * input_stride + _gid_x53);
            }
            iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp48);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp54 = 0.F;
            {
                int _gid_x55 = gid_x + -2;
                int _gid_y55 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_y55 >= input_height)
                    _gid_y55 = input_height - 1;
                _tmp54 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y55) * input_stride + _gid_x55);
            }
            {
                int _gid_x56 = gid_x + -1;
                int _gid_y56 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_y56 >= input_height)
                    _gid_y56 = input_height - 1;
                _tmp54 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y56) * input_stride + _gid_x56);
            }
            {
                int _gid_x57 = gid_x + 0;
                int _gid_y57 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_y57 >= input_height)
                    _gid_y57 = input_height - 1;
                _tmp54 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y57) * input_stride + _gid_x57);
            }
            {
                int _gid_x58 = gid_x + 1;
                int _gid_y58 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_y58 >= input_height)
                    _gid_y58 = input_height - 1;
                _tmp54 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y58) * input_stride + _gid_x58);
            }
            {
                int _gid_x59 = gid_x + 2;
                int _gid_y59 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_y59 >= input_height)
                    _gid_y59 = input_height - 1;
                _tmp54 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y59) * input_stride + _gid_x59);
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp54);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp60 = 0.F;
            {
                int _gid_x61 = gid_x + -2;
                int _gid_y61 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_y61 >= input_height)
                    _gid_y61 = input_height - 1;
                _tmp60 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y61) * input_stride + _gid_x61);
            }
            {
                int _gid_x62 = gid_x + -1;
                int _gid_y62 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_y62 >= input_height)
                    _gid_y62 = input_height - 1;
                _tmp60 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y62) * input_stride + _gid_x62);
            }
            {
                int _gid_x63 = gid_x + 0;
                int _gid_y63 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_y63 >= input_height)
                    _gid_y63 = input_height - 1;
                _tmp60 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y63) * input_stride + _gid_x63);
            }
            {
                int _gid_x64 = gid_x + 1;
                int _gid_y64 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_y64 >= input_height)
                    _gid_y64 = input_height - 1;
                _tmp60 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y64) * input_stride + _gid_x64);
            }
            {
                int _gid_x65 = gid_x + 2;
                int _gid_y65 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_y65 >= input_height)
                    _gid_y65 = input_height - 1;
                _tmp60 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y65) * input_stride + _gid_x65);
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp60);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp66 = 0.F;
            {
                int _gid_x67 = gid_x + -2;
                int _gid_y67 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_y67 >= input_height)
                    _gid_y67 = input_height - 1;
                _tmp66 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y67) * input_stride + _gid_x67);
            }
            {
                int _gid_x68 = gid_x + -1;
                int _gid_y68 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_y68 >= input_height)
                    _gid_y68 = input_height - 1;
                _tmp66 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y68) * input_stride + _gid_x68);
            }
            {
                int _gid_x69 = gid_x + 0;
                int _gid_y69 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_y69 >= input_height)
                    _gid_y69 = input_height - 1;
                _tmp66 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y69) * input_stride + _gid_x69);
            }
            {
                int _gid_x70 = gid_x + 1;
                int _gid_y70 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_y70 >= input_height)
                    _gid_y70 = input_height - 1;
                _tmp66 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y70) * input_stride + _gid_x70);
            }
            {
                int _gid_x71 = gid_x + 2;
                int _gid_y71 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_y71 >= input_height)
                    _gid_y71 = input_height - 1;
                _tmp66 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y71) * input_stride + _gid_x71);
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp66);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp72 = 0.F;
            {
                int _gid_x73 = gid_x + -2;
                int _gid_y73 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_y73 >= input_height)
                    _gid_y73 = input_height - 1;
                _tmp72 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y73) * input_stride + _gid_x73);
            }
            {
                int _gid_x74 = gid_x + -1;
                int _gid_y74 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_y74 >= input_height)
                    _gid_y74 = input_height - 1;
                _tmp72 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y74) * input_stride + _gid_x74);
            }
            {
                int _gid_x75 = gid_x + 0;
                int _gid_y75 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_y75 >= input_height)
                    _gid_y75 = input_height - 1;
                _tmp72 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y75) * input_stride + _gid_x75);
            }
            {
                int _gid_x76 = gid_x + 1;
                int _gid_y76 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_y76 >= input_height)
                    _gid_y76 = input_height - 1;
                _tmp72 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y76) * input_stride + _gid_x76);
            }
            {
                int _gid_x77 = gid_x + 2;
                int _gid_y77 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_y77 >= input_height)
                    _gid_y77 = input_height - 1;
                _tmp72 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y77) * input_stride + _gid_x77);
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp72);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp78 = 0.F;
            {
                int _gid_x79 = gid_x + -2;
                int _gid_y79 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_y79 >= input_height)
                    _gid_y79 = input_height - 1;
                _tmp78 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y79) * input_stride + _gid_x79);
            }
            {
                int _gid_x80 = gid_x + -1;
                int _gid_y80 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_y80 >= input_height)
                    _gid_y80 = input_height - 1;
                _tmp78 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y80) * input_stride + _gid_x80);
            }
            {
                int _gid_x81 = gid_x + 0;
                int _gid_y81 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_y81 >= input_height)
                    _gid_y81 = input_height - 1;
                _tmp78 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y81) * input_stride + _gid_x81);
            }
            {
                int _gid_x82 = gid_x + 1;
                int _gid_y82 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_y82 >= input_height)
                    _gid_y82 = input_height - 1;
                _tmp78 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y82) * input_stride + _gid_x82);
            }
            {
                int _gid_x83 = gid_x + 2;
                int _gid_y83 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_y83 >= input_height)
                    _gid_y83 = input_height - 1;
                _tmp78 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y83) * input_stride + _gid_x83);
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp78);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp84 = 0.F;
            {
                int _gid_x85 = gid_x + -2;
                int _gid_y85 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_y85 >= input_height)
                    _gid_y85 = input_height - 1;
                _tmp84 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y85) * input_stride + _gid_x85);
            }
            {
                int _gid_x86 = gid_x + -1;
                int _gid_y86 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_y86 >= input_height)
                    _gid_y86 = input_height - 1;
                _tmp84 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y86) * input_stride + _gid_x86);
            }
            {
                int _gid_x87 = gid_x + 0;
                int _gid_y87 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_y87 >= input_height)
                    _gid_y87 = input_height - 1;
                _tmp84 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y87) * input_stride + _gid_x87);
            }
            {
                int _gid_x88 = gid_x + 1;
                int _gid_y88 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_y88 >= input_height)
                    _gid_y88 = input_height - 1;
                _tmp84 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y88) * input_stride + _gid_x88);
            }
            {
                int _gid_x89 = gid_x + 2;
                int _gid_y89 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_y89 >= input_height)
                    _gid_y89 = input_height - 1;
                _tmp84 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y89) * input_stride + _gid_x89);
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp84);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp90 = 0.F;
            {
                int _gid_x91 = gid_x + -2;
                int _gid_y91 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_y91 >= input_height)
                    _gid_y91 = input_height - 1;
                _tmp90 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y91) * input_stride + _gid_x91);
            }
            {
                int _gid_x92 = gid_x + -1;
                int _gid_y92 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_y92 >= input_height)
                    _gid_y92 = input_height - 1;
                _tmp90 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y92) * input_stride + _gid_x92);
            }
            {
                int _gid_x93 = gid_x + 0;
                int _gid_y93 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_y93 >= input_height)
                    _gid_y93 = input_height - 1;
                _tmp90 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y93) * input_stride + _gid_x93);
            }
            {
                int _gid_x94 = gid_x + 1;
                int _gid_y94 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_y94 >= input_height)
                    _gid_y94 = input_height - 1;
                _tmp90 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y94) * input_stride + _gid_x94);
            }
            {
                int _gid_x95 = gid_x + 2;
                int _gid_y95 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_y95 >= input_height)
                    _gid_y95 = input_height - 1;
                _tmp90 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y95) * input_stride + _gid_x95);
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp90);
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        if (gid_x < iter_width) {
            if (gid_y < iter_height) {
                float _tmp96 = 0.F;
                {
                    int _gid_x97 = gid_x + -2;
                    int _gid_y97 = gid_y + 0;
                    if (_gid_x97 >= input_width)
                        _gid_x97 = input_width - 1;
                    _tmp96 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y97) * input_stride + _gid_x97);
                }
                {
                    int _gid_x98 = gid_x + -1;
                    int _gid_y98 = gid_y + 0;
                    if (_gid_x98 >= input_width)
                        _gid_x98 = input_width - 1;
                    _tmp96 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y98) * input_stride + _gid_x98);
                }
                {
                    int _gid_x99 = gid_x + 0;
                    int _gid_y99 = gid_y + 0;
                    if (_gid_x99 >= input_width)
                        _gid_x99 = input_width - 1;
                    _tmp96 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y99) * input_stride + _gid_x99);
                }
                {
                    int _gid_x100 = gid_x + 1;
                    int _gid_y100 = gid_y + 0;
                    if (_gid_x100 >= input_width)
                        _gid_x100 = input_width - 1;
                    _tmp96 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y100) * input_stride + _gid_x100);
                }
                {
                    int _gid_x101 = gid_x + 2;
                    int _gid_y101 = gid_y + 0;
                    if (_gid_x101 >= input_width)
                        _gid_x101 = input_width - 1;
                    _tmp96 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y101) * input_stride + _gid_x101);
                }
                iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp96);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 1 * (int)blockDim.y < iter_height) {
                float _tmp102 = 0.F;
                {
                    int _gid_x103 = gid_x + -2;
                    int _gid_y103 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x103 >= input_width)
                        _gid_x103 = input_width - 1;
                    _tmp102 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y103) * input_stride + _gid_x103);
                }
                {
                    int _gid_x104 = gid_x + -1;
                    int _gid_y104 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x104 >= input_width)
                        _gid_x104 = input_width - 1;
                    _tmp102 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y104) * input_stride + _gid_x104);
                }
                {
                    int _gid_x105 = gid_x + 0;
                    int _gid_y105 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x105 >= input_width)
                        _gid_x105 = input_width - 1;
                    _tmp102 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y105) * input_stride + _gid_x105);
                }
                {
                    int _gid_x106 = gid_x + 1;
                    int _gid_y106 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x106 >= input_width)
                        _gid_x106 = input_width - 1;
                    _tmp102 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y106) * input_stride + _gid_x106);
                }
                {
                    int _gid_x107 = gid_x + 2;
                    int _gid_y107 = gid_y + 1 * (int)blockDim.y + 0;
                    if (_gid_x107 >= input_width)
                        _gid_x107 = input_width - 1;
                    _tmp102 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y107) * input_stride + _gid_x107);
                }
                iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp102);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 2 * (int)blockDim.y < iter_height) {
                float _tmp108 = 0.F;
                {
                    int _gid_x109 = gid_x + -2;
                    int _gid_y109 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x109 >= input_width)
                        _gid_x109 = input_width - 1;
                    _tmp108 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y109) * input_stride + _gid_x109);
                }
                {
                    int _gid_x110 = gid_x + -1;
                    int _gid_y110 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x110 >= input_width)
                        _gid_x110 = input_width - 1;
                    _tmp108 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y110) * input_stride + _gid_x110);
                }
                {
                    int _gid_x111 = gid_x + 0;
                    int _gid_y111 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x111 >= input_width)
                        _gid_x111 = input_width - 1;
                    _tmp108 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y111) * input_stride + _gid_x111);
                }
                {
                    int _gid_x112 = gid_x + 1;
                    int _gid_y112 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x112 >= input_width)
                        _gid_x112 = input_width - 1;
                    _tmp108 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y112) * input_stride + _gid_x112);
                }
                {
                    int _gid_x113 = gid_x + 2;
                    int _gid_y113 = gid_y + 2 * (int)blockDim.y + 0;
                    if (_gid_x113 >= input_width)
                        _gid_x113 = input_width - 1;
                    _tmp108 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y113) * input_stride + _gid_x113);
                }
                iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp108);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 3 * (int)blockDim.y < iter_height) {
                float _tmp114 = 0.F;
                {
                    int _gid_x115 = gid_x + -2;
                    int _gid_y115 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x115 >= input_width)
                        _gid_x115 = input_width - 1;
                    _tmp114 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y115) * input_stride + _gid_x115);
                }
                {
                    int _gid_x116 = gid_x + -1;
                    int _gid_y116 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x116 >= input_width)
                        _gid_x116 = input_width - 1;
                    _tmp114 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y116) * input_stride + _gid_x116);
                }
                {
                    int _gid_x117 = gid_x + 0;
                    int _gid_y117 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x117 >= input_width)
                        _gid_x117 = input_width - 1;
                    _tmp114 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y117) * input_stride + _gid_x117);
                }
                {
                    int _gid_x118 = gid_x + 1;
                    int _gid_y118 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x118 >= input_width)
                        _gid_x118 = input_width - 1;
                    _tmp114 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y118) * input_stride + _gid_x118);
                }
                {
                    int _gid_x119 = gid_x + 2;
                    int _gid_y119 = gid_y + 3 * (int)blockDim.y + 0;
                    if (_gid_x119 >= input_width)
                        _gid_x119 = input_width - 1;
                    _tmp114 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y119) * input_stride + _gid_x119);
                }
                iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp114);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 4 * (int)blockDim.y < iter_height) {
                float _tmp120 = 0.F;
                {
                    int _gid_x121 = gid_x + -2;
                    int _gid_y121 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x121 >= input_width)
                        _gid_x121 = input_width - 1;
                    _tmp120 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y121) * input_stride + _gid_x121);
                }
                {
                    int _gid_x122 = gid_x + -1;
                    int _gid_y122 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x122 >= input_width)
                        _gid_x122 = input_width - 1;
                    _tmp120 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y122) * input_stride + _gid_x122);
                }
                {
                    int _gid_x123 = gid_x + 0;
                    int _gid_y123 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x123 >= input_width)
                        _gid_x123 = input_width - 1;
                    _tmp120 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y123) * input_stride + _gid_x123);
                }
                {
                    int _gid_x124 = gid_x + 1;
                    int _gid_y124 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x124 >= input_width)
                        _gid_x124 = input_width - 1;
                    _tmp120 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y124) * input_stride + _gid_x124);
                }
                {
                    int _gid_x125 = gid_x + 2;
                    int _gid_y125 = gid_y + 4 * (int)blockDim.y + 0;
                    if (_gid_x125 >= input_width)
                        _gid_x125 = input_width - 1;
                    _tmp120 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y125) * input_stride + _gid_x125);
                }
                iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp120);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 5 * (int)blockDim.y < iter_height) {
                float _tmp126 = 0.F;
                {
                    int _gid_x127 = gid_x + -2;
                    int _gid_y127 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x127 >= input_width)
                        _gid_x127 = input_width - 1;
                    _tmp126 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y127) * input_stride + _gid_x127);
                }
                {
                    int _gid_x128 = gid_x + -1;
                    int _gid_y128 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x128 >= input_width)
                        _gid_x128 = input_width - 1;
                    _tmp126 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y128) * input_stride + _gid_x128);
                }
                {
                    int _gid_x129 = gid_x + 0;
                    int _gid_y129 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x129 >= input_width)
                        _gid_x129 = input_width - 1;
                    _tmp126 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y129) * input_stride + _gid_x129);
                }
                {
                    int _gid_x130 = gid_x + 1;
                    int _gid_y130 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x130 >= input_width)
                        _gid_x130 = input_width - 1;
                    _tmp126 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y130) * input_stride + _gid_x130);
                }
                {
                    int _gid_x131 = gid_x + 2;
                    int _gid_y131 = gid_y + 5 * (int)blockDim.y + 0;
                    if (_gid_x131 >= input_width)
                        _gid_x131 = input_width - 1;
                    _tmp126 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y131) * input_stride + _gid_x131);
                }
                iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp126);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 6 * (int)blockDim.y < iter_height) {
                float _tmp132 = 0.F;
                {
                    int _gid_x133 = gid_x + -2;
                    int _gid_y133 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x133 >= input_width)
                        _gid_x133 = input_width - 1;
                    _tmp132 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y133) * input_stride + _gid_x133);
                }
                {
                    int _gid_x134 = gid_x + -1;
                    int _gid_y134 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x134 >= input_width)
                        _gid_x134 = input_width - 1;
                    _tmp132 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y134) * input_stride + _gid_x134);
                }
                {
                    int _gid_x135 = gid_x + 0;
                    int _gid_y135 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x135 >= input_width)
                        _gid_x135 = input_width - 1;
                    _tmp132 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y135) * input_stride + _gid_x135);
                }
                {
                    int _gid_x136 = gid_x + 1;
                    int _gid_y136 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x136 >= input_width)
                        _gid_x136 = input_width - 1;
                    _tmp132 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y136) * input_stride + _gid_x136);
                }
                {
                    int _gid_x137 = gid_x + 2;
                    int _gid_y137 = gid_y + 6 * (int)blockDim.y + 0;
                    if (_gid_x137 >= input_width)
                        _gid_x137 = input_width - 1;
                    _tmp132 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y137) * input_stride + _gid_x137);
                }
                iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp132);
            }
        }
        if (gid_x < iter_width) {
            if (gid_y + 7 * (int)blockDim.y < iter_height) {
                float _tmp138 = 0.F;
                {
                    int _gid_x139 = gid_x + -2;
                    int _gid_y139 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x139 >= input_width)
                        _gid_x139 = input_width - 1;
                    _tmp138 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y139) * input_stride + _gid_x139);
                }
                {
                    int _gid_x140 = gid_x + -1;
                    int _gid_y140 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x140 >= input_width)
                        _gid_x140 = input_width - 1;
                    _tmp138 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y140) * input_stride + _gid_x140);
                }
                {
                    int _gid_x141 = gid_x + 0;
                    int _gid_y141 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x141 >= input_width)
                        _gid_x141 = input_width - 1;
                    _tmp138 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y141) * input_stride + _gid_x141);
                }
                {
                    int _gid_x142 = gid_x + 1;
                    int _gid_y142 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x142 >= input_width)
                        _gid_x142 = input_width - 1;
                    _tmp138 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y142) * input_stride + _gid_x142);
                }
                {
                    int _gid_x143 = gid_x + 2;
                    int _gid_y143 = gid_y + 7 * (int)blockDim.y + 0;
                    if (_gid_x143 >= input_width)
                        _gid_x143 = input_width - 1;
                    _tmp138 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y143) * input_stride + _gid_x143);
                }
                iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp138);
            }
        }
    }
    goto BH_EXIT;
  BH_L:
    {
        if (gid_y < iter_height) {
            float _tmp144 = 0.F;
            {
                int _gid_x145 = gid_x + -2;
                int _gid_y145 = gid_y + 0;
                if (_gid_x145 < 0)
                    _gid_x145 = 0;
                _tmp144 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y145) * input_stride + _gid_x145);
            }
            {
                int _gid_x146 = gid_x + -1;
                int _gid_y146 = gid_y + 0;
                if (_gid_x146 < 0)
                    _gid_x146 = 0;
                _tmp144 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y146) * input_stride + _gid_x146);
            }
            {
                int _gid_x147 = gid_x + 0;
                int _gid_y147 = gid_y + 0;
                if (_gid_x147 < 0)
                    _gid_x147 = 0;
                _tmp144 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y147) * input_stride + _gid_x147);
            }
            {
                int _gid_x148 = gid_x + 1;
                int _gid_y148 = gid_y + 0;
                if (_gid_x148 < 0)
                    _gid_x148 = 0;
                _tmp144 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y148) * input_stride + _gid_x148);
            }
            {
                int _gid_x149 = gid_x + 2;
                int _gid_y149 = gid_y + 0;
                if (_gid_x149 < 0)
                    _gid_x149 = 0;
                _tmp144 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y149) * input_stride + _gid_x149);
            }
            iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp144);
        }
        if (gid_y + 1 * (int)blockDim.y < iter_height) {
            float _tmp150 = 0.F;
            {
                int _gid_x151 = gid_x + -2;
                int _gid_y151 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_x151 < 0)
                    _gid_x151 = 0;
                _tmp150 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y151) * input_stride + _gid_x151);
            }
            {
                int _gid_x152 = gid_x + -1;
                int _gid_y152 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_x152 < 0)
                    _gid_x152 = 0;
                _tmp150 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y152) * input_stride + _gid_x152);
            }
            {
                int _gid_x153 = gid_x + 0;
                int _gid_y153 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_x153 < 0)
                    _gid_x153 = 0;
                _tmp150 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y153) * input_stride + _gid_x153);
            }
            {
                int _gid_x154 = gid_x + 1;
                int _gid_y154 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_x154 < 0)
                    _gid_x154 = 0;
                _tmp150 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y154) * input_stride + _gid_x154);
            }
            {
                int _gid_x155 = gid_x + 2;
                int _gid_y155 = gid_y + 1 * (int)blockDim.y + 0;
                if (_gid_x155 < 0)
                    _gid_x155 = 0;
                _tmp150 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y155) * input_stride + _gid_x155);
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp150);
        }
        if (gid_y + 2 * (int)blockDim.y < iter_height) {
            float _tmp156 = 0.F;
            {
                int _gid_x157 = gid_x + -2;
                int _gid_y157 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_x157 < 0)
                    _gid_x157 = 0;
                _tmp156 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y157) * input_stride + _gid_x157);
            }
            {
                int _gid_x158 = gid_x + -1;
                int _gid_y158 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_x158 < 0)
                    _gid_x158 = 0;
                _tmp156 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y158) * input_stride + _gid_x158);
            }
            {
                int _gid_x159 = gid_x + 0;
                int _gid_y159 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_x159 < 0)
                    _gid_x159 = 0;
                _tmp156 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y159) * input_stride + _gid_x159);
            }
            {
                int _gid_x160 = gid_x + 1;
                int _gid_y160 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_x160 < 0)
                    _gid_x160 = 0;
                _tmp156 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y160) * input_stride + _gid_x160);
            }
            {
                int _gid_x161 = gid_x + 2;
                int _gid_y161 = gid_y + 2 * (int)blockDim.y + 0;
                if (_gid_x161 < 0)
                    _gid_x161 = 0;
                _tmp156 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y161) * input_stride + _gid_x161);
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp156);
        }
        if (gid_y + 3 * (int)blockDim.y < iter_height) {
            float _tmp162 = 0.F;
            {
                int _gid_x163 = gid_x + -2;
                int _gid_y163 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_x163 < 0)
                    _gid_x163 = 0;
                _tmp162 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y163) * input_stride + _gid_x163);
            }
            {
                int _gid_x164 = gid_x + -1;
                int _gid_y164 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_x164 < 0)
                    _gid_x164 = 0;
                _tmp162 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y164) * input_stride + _gid_x164);
            }
            {
                int _gid_x165 = gid_x + 0;
                int _gid_y165 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_x165 < 0)
                    _gid_x165 = 0;
                _tmp162 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y165) * input_stride + _gid_x165);
            }
            {
                int _gid_x166 = gid_x + 1;
                int _gid_y166 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_x166 < 0)
                    _gid_x166 = 0;
                _tmp162 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y166) * input_stride + _gid_x166);
            }
            {
                int _gid_x167 = gid_x + 2;
                int _gid_y167 = gid_y + 3 * (int)blockDim.y + 0;
                if (_gid_x167 < 0)
                    _gid_x167 = 0;
                _tmp162 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y167) * input_stride + _gid_x167);
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp162);
        }
        if (gid_y + 4 * (int)blockDim.y < iter_height) {
            float _tmp168 = 0.F;
            {
                int _gid_x169 = gid_x + -2;
                int _gid_y169 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_x169 < 0)
                    _gid_x169 = 0;
                _tmp168 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y169) * input_stride + _gid_x169);
            }
            {
                int _gid_x170 = gid_x + -1;
                int _gid_y170 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_x170 < 0)
                    _gid_x170 = 0;
                _tmp168 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y170) * input_stride + _gid_x170);
            }
            {
                int _gid_x171 = gid_x + 0;
                int _gid_y171 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_x171 < 0)
                    _gid_x171 = 0;
                _tmp168 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y171) * input_stride + _gid_x171);
            }
            {
                int _gid_x172 = gid_x + 1;
                int _gid_y172 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_x172 < 0)
                    _gid_x172 = 0;
                _tmp168 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y172) * input_stride + _gid_x172);
            }
            {
                int _gid_x173 = gid_x + 2;
                int _gid_y173 = gid_y + 4 * (int)blockDim.y + 0;
                if (_gid_x173 < 0)
                    _gid_x173 = 0;
                _tmp168 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y173) * input_stride + _gid_x173);
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp168);
        }
        if (gid_y + 5 * (int)blockDim.y < iter_height) {
            float _tmp174 = 0.F;
            {
                int _gid_x175 = gid_x + -2;
                int _gid_y175 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_x175 < 0)
                    _gid_x175 = 0;
                _tmp174 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y175) * input_stride + _gid_x175);
            }
            {
                int _gid_x176 = gid_x + -1;
                int _gid_y176 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_x176 < 0)
                    _gid_x176 = 0;
                _tmp174 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y176) * input_stride + _gid_x176);
            }
            {
                int _gid_x177 = gid_x + 0;
                int _gid_y177 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_x177 < 0)
                    _gid_x177 = 0;
                _tmp174 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y177) * input_stride + _gid_x177);
            }
            {
                int _gid_x178 = gid_x + 1;
                int _gid_y178 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_x178 < 0)
                    _gid_x178 = 0;
                _tmp174 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y178) * input_stride + _gid_x178);
            }
            {
                int _gid_x179 = gid_x + 2;
                int _gid_y179 = gid_y + 5 * (int)blockDim.y + 0;
                if (_gid_x179 < 0)
                    _gid_x179 = 0;
                _tmp174 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y179) * input_stride + _gid_x179);
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp174);
        }
        if (gid_y + 6 * (int)blockDim.y < iter_height) {
            float _tmp180 = 0.F;
            {
                int _gid_x181 = gid_x + -2;
                int _gid_y181 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_x181 < 0)
                    _gid_x181 = 0;
                _tmp180 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y181) * input_stride + _gid_x181);
            }
            {
                int _gid_x182 = gid_x + -1;
                int _gid_y182 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_x182 < 0)
                    _gid_x182 = 0;
                _tmp180 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y182) * input_stride + _gid_x182);
            }
            {
                int _gid_x183 = gid_x + 0;
                int _gid_y183 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_x183 < 0)
                    _gid_x183 = 0;
                _tmp180 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y183) * input_stride + _gid_x183);
            }
            {
                int _gid_x184 = gid_x + 1;
                int _gid_y184 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_x184 < 0)
                    _gid_x184 = 0;
                _tmp180 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y184) * input_stride + _gid_x184);
            }
            {
                int _gid_x185 = gid_x + 2;
                int _gid_y185 = gid_y + 6 * (int)blockDim.y + 0;
                if (_gid_x185 < 0)
                    _gid_x185 = 0;
                _tmp180 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y185) * input_stride + _gid_x185);
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp180);
        }
        if (gid_y + 7 * (int)blockDim.y < iter_height) {
            float _tmp186 = 0.F;
            {
                int _gid_x187 = gid_x + -2;
                int _gid_y187 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_x187 < 0)
                    _gid_x187 = 0;
                _tmp186 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y187) * input_stride + _gid_x187);
            }
            {
                int _gid_x188 = gid_x + -1;
                int _gid_y188 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_x188 < 0)
                    _gid_x188 = 0;
                _tmp186 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y188) * input_stride + _gid_x188);
            }
            {
                int _gid_x189 = gid_x + 0;
                int _gid_y189 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_x189 < 0)
                    _gid_x189 = 0;
                _tmp186 += 0.369545996F * tex1Dfetch(_texinputX, (_gid_y189) * input_stride + _gid_x189);
            }
            {
                int _gid_x190 = gid_x + 1;
                int _gid_y190 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_x190 < 0)
                    _gid_x190 = 0;
                _tmp186 += 0.244460002F * tex1Dfetch(_texinputX, (_gid_y190) * input_stride + _gid_x190);
            }
            {
                int _gid_x191 = gid_x + 2;
                int _gid_y191 = gid_y + 7 * (int)blockDim.y + 0;
                if (_gid_x191 < 0)
                    _gid_x191 = 0;
                _tmp186 += 0.0707660019F * tex1Dfetch(_texinputX, (_gid_y191) * input_stride + _gid_x191);
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp186);
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        {
            float _tmp192 = 0.F;
            {
                _tmp192 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp192 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp192 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp192 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp192 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y) * iter_stride + gid_x] = (float)(_tmp192);
        }
        {
            float _tmp193 = 0.F;
            {
                _tmp193 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp193 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp193 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp193 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp193 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 1 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 1 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp193);
        }
        {
            float _tmp194 = 0.F;
            {
                _tmp194 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp194 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp194 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp194 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp194 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 2 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 2 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp194);
        }
        {
            float _tmp195 = 0.F;
            {
                _tmp195 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp195 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp195 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp195 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp195 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 3 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 3 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp195);
        }
        {
            float _tmp196 = 0.F;
            {
                _tmp196 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp196 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp196 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp196 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp196 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 4 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 4 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp196);
        }
        {
            float _tmp197 = 0.F;
            {
                _tmp197 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp197 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp197 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp197 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp197 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 5 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 5 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp197);
        }
        {
            float _tmp198 = 0.F;
            {
                _tmp198 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp198 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp198 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp198 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp198 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 6 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 6 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp198);
        }
        {
            float _tmp199 = 0.F;
            {
                _tmp199 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y + 0) * input_stride + gid_x + -2);
            }
            {
                _tmp199 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y + 0) * input_stride + gid_x + -1);
            }
            {
                _tmp199 += 0.369545996F * tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y + 0) * input_stride + gid_x + 0);
            }
            {
                _tmp199 += 0.244460002F * tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y + 0) * input_stride + gid_x + 1);
            }
            {
                _tmp199 += 0.0707660019F * tex1Dfetch(_texinputX, (gid_y + 7 * (int)blockDim.y + 0) * input_stride + gid_x + 2);
            }
            iter[(gid_y + 7 * (int)blockDim.y) * iter_stride + gid_x] = (float)(_tmp199);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANFILTERROWX_CU_

