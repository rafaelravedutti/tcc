#ifndef _CUGAUSSIANBLURFILTERMASKROWGFRCONST_CU_
#define _CUGAUSSIANBLURFILTERMASKROWGFRCONST_CU_

#include "hipacc_types.hpp"
#include "hipacc_math_functions.hpp"


extern "C" {
__global__ __launch_bounds__ (128*1) void cuGaussianBlurFilterMaskRowGFRConstKernel(float * __restrict__ iter, int iter_width, int iter_stride, const uchar * __restrict__ input, int input_width, int input_height, int input_stride, int bh_start_left, int bh_start_right, int bh_fall_back) {
    const int gid_x = blockDim.x * blockIdx.x + threadIdx.x;
    const int gid_y = blockDim.y * blockIdx.y + threadIdx.y;
    if (bh_fall_back)
        goto BH_FB;
    if (blockIdx.x >= bh_start_right)
        goto BH_R;
    if (blockIdx.x < bh_start_left)
        goto BH_L;
    goto BH_NO;
  BH_FB:
    {
        if (gid_x < iter_width) {
            {
                float _tmp0 = 0.F;
                {
                    int _gid_x1 = gid_x + -2;
                    int _gid_y1 = gid_y + 0;
                    uchar _tmp1 = '1';
                    if (_gid_x1 >= 0 && _gid_x1 < input_width)
                        _tmp1 = input[(_gid_y1) * input_stride + _gid_x1];
                    _tmp0 += 0.0707660019F * _tmp1;
                }
                {
                    int _gid_x2 = gid_x + -1;
                    int _gid_y2 = gid_y + 0;
                    uchar _tmp2 = '1';
                    if (_gid_x2 >= 0 && _gid_x2 < input_width)
                        _tmp2 = input[(_gid_y2) * input_stride + _gid_x2];
                    _tmp0 += 0.244460002F * _tmp2;
                }
                {
                    int _gid_x3 = gid_x + 0;
                    int _gid_y3 = gid_y + 0;
                    uchar _tmp3 = '1';
                    if (_gid_x3 >= 0 && _gid_x3 < input_width)
                        _tmp3 = input[(_gid_y3) * input_stride + _gid_x3];
                    _tmp0 += 0.369545996F * _tmp3;
                }
                {
                    int _gid_x4 = gid_x + 1;
                    int _gid_y4 = gid_y + 0;
                    uchar _tmp4 = '1';
                    if (_gid_x4 >= 0 && _gid_x4 < input_width)
                        _tmp4 = input[(_gid_y4) * input_stride + _gid_x4];
                    _tmp0 += 0.244460002F * _tmp4;
                }
                {
                    int _gid_x5 = gid_x + 2;
                    int _gid_y5 = gid_y + 0;
                    uchar _tmp5 = '1';
                    if (_gid_x5 >= 0 && _gid_x5 < input_width)
                        _tmp5 = input[(_gid_y5) * input_stride + _gid_x5];
                    _tmp0 += 0.0707660019F * _tmp5;
                }
                iter[(gid_y) * iter_stride + gid_x] = _tmp0;
            }
        }
    }
    goto BH_EXIT;
  BH_R:
    {
        if (gid_x < iter_width) {
            {
                float _tmp6 = 0.F;
                {
                    int _gid_x7 = gid_x + -2;
                    int _gid_y7 = gid_y + 0;
                    uchar _tmp7 = '1';
                    if (_gid_x7 < input_width)
                        _tmp7 = input[(_gid_y7) * input_stride + _gid_x7];
                    _tmp6 += 0.0707660019F * _tmp7;
                }
                {
                    int _gid_x8 = gid_x + -1;
                    int _gid_y8 = gid_y + 0;
                    uchar _tmp8 = '1';
                    if (_gid_x8 < input_width)
                        _tmp8 = input[(_gid_y8) * input_stride + _gid_x8];
                    _tmp6 += 0.244460002F * _tmp8;
                }
                {
                    int _gid_x9 = gid_x + 0;
                    int _gid_y9 = gid_y + 0;
                    uchar _tmp9 = '1';
                    if (_gid_x9 < input_width)
                        _tmp9 = input[(_gid_y9) * input_stride + _gid_x9];
                    _tmp6 += 0.369545996F * _tmp9;
                }
                {
                    int _gid_x10 = gid_x + 1;
                    int _gid_y10 = gid_y + 0;
                    uchar _tmp10 = '1';
                    if (_gid_x10 < input_width)
                        _tmp10 = input[(_gid_y10) * input_stride + _gid_x10];
                    _tmp6 += 0.244460002F * _tmp10;
                }
                {
                    int _gid_x11 = gid_x + 2;
                    int _gid_y11 = gid_y + 0;
                    uchar _tmp11 = '1';
                    if (_gid_x11 < input_width)
                        _tmp11 = input[(_gid_y11) * input_stride + _gid_x11];
                    _tmp6 += 0.0707660019F * _tmp11;
                }
                iter[(gid_y) * iter_stride + gid_x] = _tmp6;
            }
        }
    }
    goto BH_EXIT;
  BH_L:
    {
        {
            float _tmp12 = 0.F;
            {
                int _gid_x13 = gid_x + -2;
                int _gid_y13 = gid_y + 0;
                uchar _tmp13 = '1';
                if (_gid_x13 >= 0)
                    _tmp13 = input[(_gid_y13) * input_stride + _gid_x13];
                _tmp12 += 0.0707660019F * _tmp13;
            }
            {
                int _gid_x14 = gid_x + -1;
                int _gid_y14 = gid_y + 0;
                uchar _tmp14 = '1';
                if (_gid_x14 >= 0)
                    _tmp14 = input[(_gid_y14) * input_stride + _gid_x14];
                _tmp12 += 0.244460002F * _tmp14;
            }
            {
                int _gid_x15 = gid_x + 0;
                int _gid_y15 = gid_y + 0;
                uchar _tmp15 = '1';
                if (_gid_x15 >= 0)
                    _tmp15 = input[(_gid_y15) * input_stride + _gid_x15];
                _tmp12 += 0.369545996F * _tmp15;
            }
            {
                int _gid_x16 = gid_x + 1;
                int _gid_y16 = gid_y + 0;
                uchar _tmp16 = '1';
                if (_gid_x16 >= 0)
                    _tmp16 = input[(_gid_y16) * input_stride + _gid_x16];
                _tmp12 += 0.244460002F * _tmp16;
            }
            {
                int _gid_x17 = gid_x + 2;
                int _gid_y17 = gid_y + 0;
                uchar _tmp17 = '1';
                if (_gid_x17 >= 0)
                    _tmp17 = input[(_gid_y17) * input_stride + _gid_x17];
                _tmp12 += 0.0707660019F * _tmp17;
            }
            iter[(gid_y) * iter_stride + gid_x] = _tmp12;
        }
    }
    goto BH_EXIT;
  BH_NO:
    {
        {
            float _tmp18 = 0.F;
            {
                _tmp18 += 0.0707660019F * input[(gid_y + 0) * input_stride + gid_x + -2];
            }
            {
                _tmp18 += 0.244460002F * input[(gid_y + 0) * input_stride + gid_x + -1];
            }
            {
                _tmp18 += 0.369545996F * input[(gid_y + 0) * input_stride + gid_x + 0];
            }
            {
                _tmp18 += 0.244460002F * input[(gid_y + 0) * input_stride + gid_x + 1];
            }
            {
                _tmp18 += 0.0707660019F * input[(gid_y + 0) * input_stride + gid_x + 2];
            }
            iter[(gid_y) * iter_stride + gid_x] = _tmp18;
        }
    }
    goto BH_EXIT;
  BH_EXIT:
    ;
}
}

#endif //_CUGAUSSIANBLURFILTERMASKROWGFRCONST_CU_

