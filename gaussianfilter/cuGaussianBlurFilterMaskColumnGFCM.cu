#ifndef _CUGAUSSIANBLURFILTERMASKCOLUMNGFCM_CU_
#define _CUGAUSSIANBLURFILTERMASKCOLUMNGFCM_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"


extern "C" {
__global__ __launch_bounds__ (128*1) void cuGaussianBlurFilterMaskColumnGFCMKernel(uchar * __restrict__ iter, int iter_width, int iter_stride, const float * __restrict__ input, int input_width, int input_height, int input_stride, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y + threadIdx.y;
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
            {
                float _tmp0 = 0.F;
                {
                    int _gid_x1 = gid_x + 0;
                    int _gid_y1 = gid_y + -2;
                    if (_gid_y1 >= input_height)
                        _gid_y1 = input_height - (_gid_y1 + 1 - (input_height));
                    if (_gid_y1 < 0)
                        _gid_y1 = 0 + (0 - _gid_y1 - 1);
                    _tmp0 += 0.0707660019F * input[(_gid_y1) * input_stride + _gid_x1];
                }
                {
                    int _gid_x2 = gid_x + 0;
                    int _gid_y2 = gid_y + -1;
                    if (_gid_y2 >= input_height)
                        _gid_y2 = input_height - (_gid_y2 + 1 - (input_height));
                    if (_gid_y2 < 0)
                        _gid_y2 = 0 + (0 - _gid_y2 - 1);
                    _tmp0 += 0.244460002F * input[(_gid_y2) * input_stride + _gid_x2];
                }
                {
                    int _gid_x3 = gid_x + 0;
                    int _gid_y3 = gid_y + 0;
                    if (_gid_y3 >= input_height)
                        _gid_y3 = input_height - (_gid_y3 + 1 - (input_height));
                    if (_gid_y3 < 0)
                        _gid_y3 = 0 + (0 - _gid_y3 - 1);
                    _tmp0 += 0.369545996F * input[(_gid_y3) * input_stride + _gid_x3];
                }
                {
                    int _gid_x4 = gid_x + 0;
                    int _gid_y4 = gid_y + 1;
                    if (_gid_y4 >= input_height)
                        _gid_y4 = input_height - (_gid_y4 + 1 - (input_height));
                    if (_gid_y4 < 0)
                        _gid_y4 = 0 + (0 - _gid_y4 - 1);
                    _tmp0 += 0.244460002F * input[(_gid_y4) * input_stride + _gid_x4];
                }
                {
                    int _gid_x5 = gid_x + 0;
                    int _gid_y5 = gid_y + 2;
                    if (_gid_y5 >= input_height)
                        _gid_y5 = input_height - (_gid_y5 + 1 - (input_height));
                    if (_gid_y5 < 0)
                        _gid_y5 = 0 + (0 - _gid_y5 - 1);
                    _tmp0 += 0.0707660019F * input[(_gid_y5) * input_stride + _gid_x5];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp0 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_T:
    {
        if (gid_x < iter_width) {
            {
                float _tmp6 = 0.F;
                {
                    int _gid_x7 = gid_x + 0;
                    int _gid_y7 = gid_y + -2;
                    if (_gid_y7 < 0)
                        _gid_y7 = 0 + (0 - _gid_y7 - 1);
                    _tmp6 += 0.0707660019F * input[(_gid_y7) * input_stride + _gid_x7];
                }
                {
                    int _gid_x8 = gid_x + 0;
                    int _gid_y8 = gid_y + -1;
                    if (_gid_y8 < 0)
                        _gid_y8 = 0 + (0 - _gid_y8 - 1);
                    _tmp6 += 0.244460002F * input[(_gid_y8) * input_stride + _gid_x8];
                }
                {
                    int _gid_x9 = gid_x + 0;
                    int _gid_y9 = gid_y + 0;
                    if (_gid_y9 < 0)
                        _gid_y9 = 0 + (0 - _gid_y9 - 1);
                    _tmp6 += 0.369545996F * input[(_gid_y9) * input_stride + _gid_x9];
                }
                {
                    int _gid_x10 = gid_x + 0;
                    int _gid_y10 = gid_y + 1;
                    if (_gid_y10 < 0)
                        _gid_y10 = 0 + (0 - _gid_y10 - 1);
                    _tmp6 += 0.244460002F * input[(_gid_y10) * input_stride + _gid_x10];
                }
                {
                    int _gid_x11 = gid_x + 0;
                    int _gid_y11 = gid_y + 2;
                    if (_gid_y11 < 0)
                        _gid_y11 = 0 + (0 - _gid_y11 - 1);
                    _tmp6 += 0.0707660019F * input[(_gid_y11) * input_stride + _gid_x11];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp6 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_B:
    {
        if (gid_x < iter_width) {
            {
                float _tmp12 = 0.F;
                {
                    int _gid_x13 = gid_x + 0;
                    int _gid_y13 = gid_y + -2;
                    if (_gid_y13 >= input_height)
                        _gid_y13 = input_height - (_gid_y13 + 1 - (input_height));
                    _tmp12 += 0.0707660019F * input[(_gid_y13) * input_stride + _gid_x13];
                }
                {
                    int _gid_x14 = gid_x + 0;
                    int _gid_y14 = gid_y + -1;
                    if (_gid_y14 >= input_height)
                        _gid_y14 = input_height - (_gid_y14 + 1 - (input_height));
                    _tmp12 += 0.244460002F * input[(_gid_y14) * input_stride + _gid_x14];
                }
                {
                    int _gid_x15 = gid_x + 0;
                    int _gid_y15 = gid_y + 0;
                    if (_gid_y15 >= input_height)
                        _gid_y15 = input_height - (_gid_y15 + 1 - (input_height));
                    _tmp12 += 0.369545996F * input[(_gid_y15) * input_stride + _gid_x15];
                }
                {
                    int _gid_x16 = gid_x + 0;
                    int _gid_y16 = gid_y + 1;
                    if (_gid_y16 >= input_height)
                        _gid_y16 = input_height - (_gid_y16 + 1 - (input_height));
                    _tmp12 += 0.244460002F * input[(_gid_y16) * input_stride + _gid_x16];
                }
                {
                    int _gid_x17 = gid_x + 0;
                    int _gid_y17 = gid_y + 2;
                    if (_gid_y17 >= input_height)
                        _gid_y17 = input_height - (_gid_y17 + 1 - (input_height));
                    _tmp12 += 0.0707660019F * input[(_gid_y17) * input_stride + _gid_x17];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp12 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        if (gid_x < iter_width) {
            {
                float _tmp18 = 0.F;
                {
                    int _gid_x19 = gid_x + 0;
                    int _gid_y19 = gid_y + -2;
                    if (_gid_x19 >= input_width)
                        _gid_x19 = input_width - (_gid_x19 + 1 - (input_width));
                    _tmp18 += 0.0707660019F * input[(_gid_y19) * input_stride + _gid_x19];
                }
                {
                    int _gid_x20 = gid_x + 0;
                    int _gid_y20 = gid_y + -1;
                    if (_gid_x20 >= input_width)
                        _gid_x20 = input_width - (_gid_x20 + 1 - (input_width));
                    _tmp18 += 0.244460002F * input[(_gid_y20) * input_stride + _gid_x20];
                }
                {
                    int _gid_x21 = gid_x + 0;
                    int _gid_y21 = gid_y + 0;
                    if (_gid_x21 >= input_width)
                        _gid_x21 = input_width - (_gid_x21 + 1 - (input_width));
                    _tmp18 += 0.369545996F * input[(_gid_y21) * input_stride + _gid_x21];
                }
                {
                    int _gid_x22 = gid_x + 0;
                    int _gid_y22 = gid_y + 1;
                    if (_gid_x22 >= input_width)
                        _gid_x22 = input_width - (_gid_x22 + 1 - (input_width));
                    _tmp18 += 0.244460002F * input[(_gid_y22) * input_stride + _gid_x22];
                }
                {
                    int _gid_x23 = gid_x + 0;
                    int _gid_y23 = gid_y + 2;
                    if (_gid_x23 >= input_width)
                        _gid_x23 = input_width - (_gid_x23 + 1 - (input_width));
                    _tmp18 += 0.0707660019F * input[(_gid_y23) * input_stride + _gid_x23];
                }
                iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp18 + 0.5F);
            }
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        {
            float _tmp24 = 0.F;
            {
                _tmp24 += 0.0707660019F * input[(gid_y + -2) * input_stride + gid_x + 0];
            }
            {
                _tmp24 += 0.244460002F * input[(gid_y + -1) * input_stride + gid_x + 0];
            }
            {
                _tmp24 += 0.369545996F * input[(gid_y + 0) * input_stride + gid_x + 0];
            }
            {
                _tmp24 += 0.244460002F * input[(gid_y + 1) * input_stride + gid_x + 0];
            }
            {
                _tmp24 += 0.0707660019F * input[(gid_y + 2) * input_stride + gid_x + 0];
            }
            iter[(gid_y) * iter_stride + gid_x] = (uchar)(_tmp24 + 0.5F);
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANBLURFILTERMASKCOLUMNGFCM_CU_

