#ifndef _CUGAUSSIANBLURFILTERMASKCOLUMNGFCCONST_CU_
#define _CUGAUSSIANBLURFILTERMASKCOLUMNGFCCONST_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"


extern "C" {
__global__ __launch_bounds__ (128*1) void cuGaussianBlurFilterMaskColumnGFCConstKernel(uchar * __restrict__ iter, int iter_width, int iter_stride, const float * __restrict__ input, int input_width, int input_height, int input_stride, int bh_start_right, int bh_start_top, int bh_start_bottom, int bh_fall_back) {
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
                    float _tmp1 = 1.F;
                    if (_gid_y1 >= 0 && _gid_y1 < input_height)
                        _tmp1 = input[(_gid_y1) * input_stride + _gid_x1];
                    _tmp0 += 0.0707660019F * _tmp1;
                }
                {
                    int _gid_x2 = gid_x + 0;
                    int _gid_y2 = gid_y + -1;
                    float _tmp2 = 1.F;
                    if (_gid_y2 >= 0 && _gid_y2 < input_height)
                        _tmp2 = input[(_gid_y2) * input_stride + _gid_x2];
                    _tmp0 += 0.244460002F * _tmp2;
                }
                {
                    int _gid_x3 = gid_x + 0;
                    int _gid_y3 = gid_y + 0;
                    float _tmp3 = 1.F;
                    if (_gid_y3 >= 0 && _gid_y3 < input_height)
                        _tmp3 = input[(_gid_y3) * input_stride + _gid_x3];
                    _tmp0 += 0.369545996F * _tmp3;
                }
                {
                    int _gid_x4 = gid_x + 0;
                    int _gid_y4 = gid_y + 1;
                    float _tmp4 = 1.F;
                    if (_gid_y4 >= 0 && _gid_y4 < input_height)
                        _tmp4 = input[(_gid_y4) * input_stride + _gid_x4];
                    _tmp0 += 0.244460002F * _tmp4;
                }
                {
                    int _gid_x5 = gid_x + 0;
                    int _gid_y5 = gid_y + 2;
                    float _tmp5 = 1.F;
                    if (_gid_y5 >= 0 && _gid_y5 < input_height)
                        _tmp5 = input[(_gid_y5) * input_stride + _gid_x5];
                    _tmp0 += 0.0707660019F * _tmp5;
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
                    float _tmp7 = 1.F;
                    if (_gid_y7 >= 0)
                        _tmp7 = input[(_gid_y7) * input_stride + _gid_x7];
                    _tmp6 += 0.0707660019F * _tmp7;
                }
                {
                    int _gid_x8 = gid_x + 0;
                    int _gid_y8 = gid_y + -1;
                    float _tmp8 = 1.F;
                    if (_gid_y8 >= 0)
                        _tmp8 = input[(_gid_y8) * input_stride + _gid_x8];
                    _tmp6 += 0.244460002F * _tmp8;
                }
                {
                    int _gid_x9 = gid_x + 0;
                    int _gid_y9 = gid_y + 0;
                    float _tmp9 = 1.F;
                    if (_gid_y9 >= 0)
                        _tmp9 = input[(_gid_y9) * input_stride + _gid_x9];
                    _tmp6 += 0.369545996F * _tmp9;
                }
                {
                    int _gid_x10 = gid_x + 0;
                    int _gid_y10 = gid_y + 1;
                    float _tmp10 = 1.F;
                    if (_gid_y10 >= 0)
                        _tmp10 = input[(_gid_y10) * input_stride + _gid_x10];
                    _tmp6 += 0.244460002F * _tmp10;
                }
                {
                    int _gid_x11 = gid_x + 0;
                    int _gid_y11 = gid_y + 2;
                    float _tmp11 = 1.F;
                    if (_gid_y11 >= 0)
                        _tmp11 = input[(_gid_y11) * input_stride + _gid_x11];
                    _tmp6 += 0.0707660019F * _tmp11;
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
                    float _tmp13 = 1.F;
                    if (_gid_y13 < input_height)
                        _tmp13 = input[(_gid_y13) * input_stride + _gid_x13];
                    _tmp12 += 0.0707660019F * _tmp13;
                }
                {
                    int _gid_x14 = gid_x + 0;
                    int _gid_y14 = gid_y + -1;
                    float _tmp14 = 1.F;
                    if (_gid_y14 < input_height)
                        _tmp14 = input[(_gid_y14) * input_stride + _gid_x14];
                    _tmp12 += 0.244460002F * _tmp14;
                }
                {
                    int _gid_x15 = gid_x + 0;
                    int _gid_y15 = gid_y + 0;
                    float _tmp15 = 1.F;
                    if (_gid_y15 < input_height)
                        _tmp15 = input[(_gid_y15) * input_stride + _gid_x15];
                    _tmp12 += 0.369545996F * _tmp15;
                }
                {
                    int _gid_x16 = gid_x + 0;
                    int _gid_y16 = gid_y + 1;
                    float _tmp16 = 1.F;
                    if (_gid_y16 < input_height)
                        _tmp16 = input[(_gid_y16) * input_stride + _gid_x16];
                    _tmp12 += 0.244460002F * _tmp16;
                }
                {
                    int _gid_x17 = gid_x + 0;
                    int _gid_y17 = gid_y + 2;
                    float _tmp17 = 1.F;
                    if (_gid_y17 < input_height)
                        _tmp17 = input[(_gid_y17) * input_stride + _gid_x17];
                    _tmp12 += 0.0707660019F * _tmp17;
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
                    float _tmp19 = 1.F;
                    if (_gid_x19 < input_width)
                        _tmp19 = input[(_gid_y19) * input_stride + _gid_x19];
                    _tmp18 += 0.0707660019F * _tmp19;
                }
                {
                    int _gid_x20 = gid_x + 0;
                    int _gid_y20 = gid_y + -1;
                    float _tmp20 = 1.F;
                    if (_gid_x20 < input_width)
                        _tmp20 = input[(_gid_y20) * input_stride + _gid_x20];
                    _tmp18 += 0.244460002F * _tmp20;
                }
                {
                    int _gid_x21 = gid_x + 0;
                    int _gid_y21 = gid_y + 0;
                    float _tmp21 = 1.F;
                    if (_gid_x21 < input_width)
                        _tmp21 = input[(_gid_y21) * input_stride + _gid_x21];
                    _tmp18 += 0.369545996F * _tmp21;
                }
                {
                    int _gid_x22 = gid_x + 0;
                    int _gid_y22 = gid_y + 1;
                    float _tmp22 = 1.F;
                    if (_gid_x22 < input_width)
                        _tmp22 = input[(_gid_y22) * input_stride + _gid_x22];
                    _tmp18 += 0.244460002F * _tmp22;
                }
                {
                    int _gid_x23 = gid_x + 0;
                    int _gid_y23 = gid_y + 2;
                    float _tmp23 = 1.F;
                    if (_gid_x23 < input_width)
                        _tmp23 = input[(_gid_y23) * input_stride + _gid_x23];
                    _tmp18 += 0.0707660019F * _tmp23;
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

#endif //_CUGAUSSIANBLURFILTERMASKCOLUMNGFCCONST_CU_

