extern "C" {
typedef struct struct_14391 {
    int e0;
    char* e1;
} struct_14391;
typedef struct struct_14389 {
    float* e0;
    struct_14391 e1;
    struct_14391 e2;
    struct_14391 e3;
    struct_14391 e4;
    int e5;
    int e6;
} struct_14389;
typedef struct array_14454 {
    int e[2];
} array_14454;
typedef struct array_14455 {
    array_14454 e[7];
} array_14455;

__device__ inline int threadIdx_x() { return threadIdx.x; }
__device__ inline int threadIdx_y() { return threadIdx.y; }
__device__ inline int threadIdx_z() { return threadIdx.z; }
__device__ inline int blockIdx_x() { return blockIdx.x; }
__device__ inline int blockIdx_y() { return blockIdx.y; }
__device__ inline int blockIdx_z() { return blockIdx.z; }
__device__ inline int blockDim_x() { return blockDim.x; }
__device__ inline int blockDim_y() { return blockDim.y; }
__device__ inline int blockDim_z() { return blockDim.z; }
__device__ inline int gridDim_x() { return gridDim.x; }
__device__ inline int gridDim_y() { return gridDim.y; }
__device__ inline int gridDim_z() { return gridDim.z; }
__global__ void lambda_crit_37781(float, char*, char*, char*, float, struct_14389, char*);
__global__ void lambda_crit_37249(float*, float*, struct_14389, char*, float*);
__global__ void lambda_crit_37068(float*, float*, struct_14389, float*, char*);
__global__ void lambda_crit_37448(char*, char*, struct_14389, char*, char*);
__global__ void lambda_36802();
__device__ float read_39282(struct_14391, int);
__device__ int abs_39538(int);
__device__ void write_38998(struct_14391, int, float);

__global__ void lambda_crit_37781(float _37784_39481, char* _37785_39482, char* _37786_39483, char* _37787_39484, float _37788_39485, struct_14389 _37789_39486, char* _37790_39487) {
    int  _39490;
    int p_39490;
    int  _39493;
    int p_39493;
    int  _39496;
    int p_39496;
    int  _39499;
    int p_39499;
    int  _39502;
    int p_39502;
    int  _39505;
    int p_39505;
    float  read_39533;
    float pread_39533;
    float  read_39537;
    float pread_39537;
    int  mx_39553;
    int pmx_39553;
    int  abs_39557;
    int pabs_39557;
    float  read_39561;
    float pread_39561;
    float  read_39595;
    float pread_39595;
    float  read_39598;
    float pread_39598;
    float  read_39605;
    float pread_39605;
    float  read_39608;
    float pread_39608;
    float  read_39611;
    float pread_39611;
    #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _39490 = blockIdx_x();
    p_39490 = _39490;
    l39488: ;
        _39490 = p_39490;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39493 = blockDim_x();
        p_39493 = _39493;
    l39491: ;
        _39493 = p_39493;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39496 = threadIdx_x();
        p_39496 = _39496;
    l39494: ;
        _39496 = p_39496;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39499 = blockIdx_y();
        p_39499 = _39499;
    l39497: ;
        _39499 = p_39499;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39502 = blockDim_y();
        p_39502 = _39502;
    l39500: ;
        _39502 = p_39502;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39505 = threadIdx_y();
        p_39505 = _39505;
    l39503: ;
        _39505 = p_39505;
        #line 354 "dsl.impala"
        int _39506;
        _39506 = _37789_39486.e5;
        #line 135 "gpu_device.impala"
        int _39509;
        _39509 = _39490 * _39493;
        #line 116 "gpu_device.impala"
        int _39507;
        _39507 = 2 * _39506;
        #line 135 "gpu_device.impala"
        int _39510;
        _39510 = _39509 + _39496;
        #line 116 "gpu_device.impala"
        int offset_39508;
        offset_39508 = 5 + _39507;
        #line 135 "gpu_device.impala"
        int _39511;
        _39511 = _39510 + _39507;
        #line 135 "gpu_device.impala"
        int x_39512;
        x_39512 = 5 + _39511;
        #line 138 "gpu_device.impala"
        bool _39513;
        _39513 = offset_39508 < x_39512;
        #line 138 "gpu_device.impala"
        if (_39513) goto l39514; else goto l39636;
    l39636: ;
        #line 140 "gpu_device.impala"
        goto l39633;
    l39514: ;
        #line 138 "gpu_device.impala"
        int _39515;
        _39515 = _39506 + _39507;
        #line 138 "gpu_device.impala"
        int _39516;
        _39516 = 5 + _39515;
        #line 138 "gpu_device.impala"
        bool _39517;
        _39517 = x_39512 < _39516;
        #line 138 "gpu_device.impala"
        if (_39517) goto l39518; else goto l39635;
    l39635: ;
        #line 140 "gpu_device.impala"
        goto l39633;
    l39518: ;
        #line 136 "gpu_device.impala"
        int _39519;
        _39519 = _39499 * _39502;
        #line 136 "gpu_device.impala"
        int y_39520;
        y_39520 = _39519 + _39505;
        #line 138 "gpu_device.impala"
        bool _39521;
        _39521 = 1 < y_39520;
        #line 138 "gpu_device.impala"
        if (_39521) goto l39522; else goto l39634;
    l39634: ;
        #line 140 "gpu_device.impala"
        goto l39633;
    l39522: ;
        #line 115 "gpu_device.impala"
        int _39523;
        _39523 = _37789_39486.e6;
        #line 138 "gpu_device.impala"
        int _39524;
        _39524 = _39523 - 2;
        #line 138 "gpu_device.impala"
        bool _39525;
        _39525 = y_39520 < _39524;
        #line 138 "gpu_device.impala"
        if (_39525) goto l39526; else goto l39632;
    l39632: ;
        #line 140 "gpu_device.impala"
        goto l39633;
    l39633: ;
        #line 140 "gpu_device.impala"
        goto l39630;
    l39526: ;
        #line 354 "dsl.impala"
        int _39528;
        _39528 = y_39520 * _39506;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39527;
        _39527.e0 = 1;
        _39527.e1 = _37790_39487;
        #line 354 "dsl.impala"
        int _39529;
        _39529 = _39528 + _39511;
        #line 354 "dsl.impala"
        int _39530;
        _39530 = 5 + _39529;
        #line 9 "gpu_device.impala"
        read_39533 = read_39282(_39527, _39530);
        pread_39533 = read_39533;
    l39531: ;
        read_39533 = pread_39533;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39534;
        _39534.e0 = 1;
        _39534.e1 = _37785_39482;
        #line 9 "gpu_device.impala"
        read_39537 = read_39282(_39534, _39530);
        pread_39537 = read_39537;
    l39535: ;
        read_39537 = pread_39537;
        #line 354 "dsl.impala"
        int xs_39550;
        xs_39550 = (int)read_39533;
        #line 145 "dsl.impala"
        mx_39553 = abs_39538(xs_39550);
        pmx_39553 = mx_39553;
    l39551: ;
        mx_39553 = pmx_39553;
        #line 355 "dsl.impala"
        int ys_39554;
        ys_39554 = (int)read_39537;
        #line 145 "dsl.impala"
        abs_39557 = abs_39538(ys_39554);
        pabs_39557 = abs_39557;
    l39555: ;
        abs_39557 = pabs_39557;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39558;
        _39558.e0 = 1;
        _39558.e1 = _37787_39484;
        #line 9 "gpu_device.impala"
        read_39561 = read_39282(_39558, _39530);
        pread_39561 = read_39561;
    l39559: ;
        read_39561 = pread_39561;
        #line 357 "dsl.impala"
        int my_39568;
        my_39568 = abs_39557 << 15;
        #line 359 "dsl.impala"
        int tg22x_39570;
        tg22x_39570 = 13573 * mx_39553;
        #line 360 "dsl.impala"
        int _39575;
        _39575 = mx_39553 << 16;
        #line 364 "dsl.impala"
        int _39581;
        _39581 = xs_39550 ^ ys_39554;
        #line 360 "dsl.impala"
        int tg67x_39576;
        tg67x_39576 = tg22x_39570 + _39575;
        #line 362 "dsl.impala"
        bool _39571;
        _39571 = my_39568 < tg22x_39570;
        #line 362 "dsl.impala"
        int cond1_39572;
        cond1_39572 = (int)_39571;
        #line 363 "dsl.impala"
        bool _39577;
        _39577 = tg67x_39576 < my_39568;
        #line 364 "dsl.impala"
        bool _39582;
        _39582 = _39581 < 0;
        #line 366 "dsl.impala"
        int _39573;
        _39573 = cond1_39572 << 2;
        #line 363 "dsl.impala"
        int cond2_39578;
        cond2_39578 = (int)_39577;
        #line 364 "dsl.impala"
        int cond3_39583;
        cond3_39583 = (int)_39582;
        #line 366 "dsl.impala"
        int _39579;
        _39579 = cond2_39578 << 1;
        #line 366 "dsl.impala"
        int _39580;
        _39580 = _39573 + _39579;
        #line 366 "dsl.impala"
        int index_39584;
        index_39584 = _39580 + cond3_39583;
        #line 367 "dsl.impala"
        array_14454 _39562_24;
        _39562_24.e[0] = 1;
        _39562_24.e[1] = 1;
        array_14454 _39563_27;
        _39563_27.e[0] = -1;
        _39563_27.e[1] = 1;
        array_14454 _39564_30;
        _39564_30.e[0] = 0;
        _39564_30.e[1] = 1;
        array_14454 _39565_33;
        _39565_33.e[0] = 1;
        _39565_33.e[1] = 0;
        array_14455 offsets_39566_36;
        offsets_39566_36.e[0] = _39562_24;
        offsets_39566_36.e[1] = _39563_27;
        offsets_39566_36.e[2] = _39564_30;
        offsets_39566_36.e[3] = _39564_30;
        offsets_39566_36.e[4] = _39565_33;
        offsets_39566_36.e[5] = _39565_33;
        offsets_39566_36.e[6] = _39565_33;
        array_14454 _39585;
        _39585 = offsets_39566_36.e[index_39584];
        #line 367 "dsl.impala"
        int _39589;
        _39589 = _39585.e[0];
        #line 368 "dsl.impala"
        int _39586;
        _39586 = _39585.e[1];
        #line 367 "dsl.impala"
        int nb1_x_39590;
        nb1_x_39590 = _39511 + _39589;
        #line 368 "dsl.impala"
        int nb1_y_39587;
        nb1_y_39587 = y_39520 + _39586;
        #line 373 "dsl.impala"
        int _39588;
        _39588 = nb1_y_39587 * _39506;
        #line 373 "dsl.impala"
        int _39591;
        _39591 = _39588 + nb1_x_39590;
        #line 373 "dsl.impala"
        int _39592;
        _39592 = 5 + _39591;
        #line 9 "gpu_device.impala"
        read_39595 = read_39282(_39558, _39592);
        pread_39595 = read_39595;
    l39593: ;
        read_39595 = pread_39595;
        #line 9 "gpu_device.impala"
        read_39598 = read_39282(_39558, _39530);
        pread_39598 = read_39598;
    l39596: ;
        read_39598 = pread_39598;
        #line 369 "dsl.impala"
        int nb2_x_39601;
        nb2_x_39601 = x_39512 - _39589;
        #line 370 "dsl.impala"
        int nb2_y_39599;
        nb2_y_39599 = y_39520 - _39586;
        #line 377 "dsl.impala"
        int _39600;
        _39600 = nb2_y_39599 * _39506;
        #line 377 "dsl.impala"
        int _39602;
        _39602 = _39600 + nb2_x_39601;
        #line 9 "gpu_device.impala"
        read_39605 = read_39282(_39558, _39602);
        pread_39605 = read_39605;
    l39603: ;
        read_39605 = pread_39605;
        #line 9 "gpu_device.impala"
        read_39608 = read_39282(_39558, _39530);
        pread_39608 = read_39608;
    l39606: ;
        read_39608 = pread_39608;
        #line 9 "gpu_device.impala"
        read_39611 = read_39282(_39558, _39530);
        pread_39611 = read_39611;
    l39609: ;
        read_39611 = pread_39611;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39612;
        _39612.e0 = 1;
        _39612.e1 = _37786_39483;
        #line 377 "dsl.impala"
        bool _39625;
        _39625 = read_39605 < read_39598;
        #line 373 "dsl.impala"
        bool _39622;
        _39622 = read_39595 < read_39561;
        #line 376 "dsl.impala"
        float nb2_cond_39626;
        nb2_cond_39626 = (float)_39625;
        #line 398 "dsl.impala"
        bool _39618;
        _39618 = _37788_39485 < read_39611;
        #line 397 "dsl.impala"
        bool _39614;
        _39614 = _37784_39481 < read_39608;
        #line 372 "dsl.impala"
        float nb1_cond_39623;
        nb1_cond_39623 = (float)_39622;
        #line 398 "dsl.impala"
        float _39619;
        _39619 = (float)_39618;
        #line 397 "dsl.impala"
        float _39615;
        _39615 = (float)_39614;
        #line 398 "dsl.impala"
        float _39620;
        _39620 = 1.400000e+01f * _39619;
        #line 397 "dsl.impala"
        float _39616;
        _39616 = 1.000000e+00f * _39615;
        #line 397 "dsl.impala"
        float _39621;
        _39621 = _39616 + _39620;
        #line 396 "dsl.impala"
        float _39624;
        _39624 = _39621 * nb1_cond_39623;
        #line 396 "dsl.impala"
        float _39627;
        _39627 = _39624 * nb2_cond_39626;
        #line 13 "gpu_device.impala"
        write_38998(_39612, _39530, _39627);
    l39628: ;
        #line 140 "gpu_device.impala"
        goto l39630;
    l39630: ;
        return ;
}

__global__ void lambda_crit_37249(float* _37252_39095, float* _37253_39096, struct_14389 _37254_39097, char* _37255_39098, float* _37256_39099) {
    int  _39102;
    int p_39102;
    int  _39105;
    int p_39105;
    int  _39108;
    int p_39108;
    int  _39111;
    int p_39111;
    int  _39114;
    int p_39114;
    int  _39117;
    int p_39117;
    #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _39102 = blockIdx_x();
    p_39102 = _39102;
    l39100: ;
        _39102 = p_39102;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39105 = blockDim_x();
        p_39105 = _39105;
    l39103: ;
        _39105 = p_39105;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39108 = threadIdx_x();
        p_39108 = _39108;
    l39106: ;
        _39108 = p_39108;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39111 = blockIdx_y();
        p_39111 = _39111;
    l39109: ;
        _39111 = p_39111;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39114 = blockDim_y();
        p_39114 = _39114;
    l39112: ;
        _39114 = p_39114;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39117 = threadIdx_y();
        p_39117 = _39117;
    l39115: ;
        _39117 = p_39117;
        #line 88 "gpu_device.impala"
        int _39121;
        _39121 = _39102 * _39105;
        #line 88 "gpu_device.impala"
        int _39122;
        _39122 = _39121 + _39108;
        #line 185 "dsl.impala"
        int _39118;
        _39118 = _37254_39097.e5;
        #line 73 "gpu_device.impala"
        int _39119;
        _39119 = 2 * _39118;
        #line 73 "gpu_device.impala"
        int offset_39120;
        offset_39120 = 5 + _39119;
        #line 88 "gpu_device.impala"
        int _39123;
        _39123 = _39122 + _39119;
        #line 88 "gpu_device.impala"
        int x_39124;
        x_39124 = 5 + _39123;
        #line 91 "gpu_device.impala"
        bool _39125;
        _39125 = offset_39120 < x_39124;
        #line 91 "gpu_device.impala"
        if (_39125) goto l39126; else goto l39228;
    l39228: ;
        #line 93 "gpu_device.impala"
        goto l39225;
    l39126: ;
        #line 91 "gpu_device.impala"
        int _39127;
        _39127 = _39118 + _39119;
        #line 91 "gpu_device.impala"
        int _39128;
        _39128 = 5 + _39127;
        #line 91 "gpu_device.impala"
        bool _39129;
        _39129 = x_39124 < _39128;
        #line 91 "gpu_device.impala"
        if (_39129) goto l39130; else goto l39227;
    l39227: ;
        #line 93 "gpu_device.impala"
        goto l39225;
    l39130: ;
        #line 89 "gpu_device.impala"
        int _39131;
        _39131 = _39111 * _39114;
        #line 89 "gpu_device.impala"
        int y_39132;
        y_39132 = _39131 + _39117;
        #line 91 "gpu_device.impala"
        bool _39133;
        _39133 = 1 < y_39132;
        #line 91 "gpu_device.impala"
        if (_39133) goto l39134; else goto l39226;
    l39226: ;
        #line 93 "gpu_device.impala"
        goto l39225;
    l39134: ;
        #line 72 "gpu_device.impala"
        int _39135;
        _39135 = _37254_39097.e6;
        #line 91 "gpu_device.impala"
        int _39136;
        _39136 = _39135 - 2;
        #line 91 "gpu_device.impala"
        bool _39137;
        _39137 = y_39132 < _39136;
        #line 91 "gpu_device.impala"
        if (_39137) goto l39138; else goto l39224;
    l39224: ;
        #line 93 "gpu_device.impala"
        goto l39225;
    l39225: ;
        #line 93 "gpu_device.impala"
        goto l39145;
    l39138: ;
        #line 185 "dsl.impala"
        int _39140;
        _39140 = y_39132 * _39118;
        #line 185 "dsl.impala"
        int _39141;
        _39141 = _39140 + _39123;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39139;
        _39139.e0 = 1;
        _39139.e1 = _37255_39098;
        #line 185 "dsl.impala"
        int _39142;
        _39142 = 5 + _39141;
        #line 13 "gpu_device.impala"
        write_38998(_39139, _39142, 0.000000e+00f);
    l39143: ;
        #line 190 "dsl.impala"
        int _39171;
        _39171 = -1 + y_39132;
        #line 9 "gpu_device.impala"
        float* i_39183;
        i_39183 = _37252_39095 + 2;
        #line 9 "gpu_device.impala"
        float* i_39186;
        i_39186 = _37253_39096 + _39142;
        #line 9 "gpu_device.impala"
        float* i_39150;
        i_39150 = _37252_39095 + 0;
        #line 190 "dsl.impala"
        int _39172;
        _39172 = _39171 * _39118;
        #line 9 "gpu_device.impala"
        float* i_39147;
        i_39147 = _37256_39099 + _39142;
        #line 9 "gpu_device.impala"
        float* i_39209;
        i_39209 = _37252_39095 + 4;
        #line 190 "dsl.impala"
        int _39212;
        _39212 = 2 + y_39132;
        #line 9 "gpu_device.impala"
        float* i_39194;
        i_39194 = _37252_39095 + 3;
        #line 10 "gpu_device.impala"
        float _39148;
        _39148 = *i_39147;
        #line 9 "gpu_device.impala"
        float* i_39167;
        i_39167 = _37252_39095 + 1;
        #line 10 "gpu_device.impala"
        float _39161;
        _39161 = _39148;
        #line 190 "dsl.impala"
        int _39197;
        _39197 = 1 + y_39132;
        #line 190 "dsl.impala"
        int _39173;
        _39173 = _39172 + _39123;
        #line 190 "dsl.impala"
        int _39154;
        _39154 = -2 + y_39132;
        #line 10 "gpu_device.impala"
        float _39151;
        _39151 = *i_39150;
        #line 190 "dsl.impala"
        int _39213;
        _39213 = _39212 * _39118;
        #line 190 "dsl.impala"
        int _39198;
        _39198 = _39197 * _39118;
        #line 190 "dsl.impala"
        int _39174;
        _39174 = 5 + _39173;
        #line 190 "dsl.impala"
        int _39155;
        _39155 = _39154 * _39118;
        #line 10 "gpu_device.impala"
        float _39162;
        _39162 = _39151;
        #line 190 "dsl.impala"
        int _39214;
        _39214 = _39213 + _39123;
        #line 190 "dsl.impala"
        int _39199;
        _39199 = _39198 + _39123;
        #line 9 "gpu_device.impala"
        float* i_39175;
        i_39175 = _37253_39096 + _39174;
        #line 190 "dsl.impala"
        int _39156;
        _39156 = _39155 + _39123;
        #line 190 "dsl.impala"
        int _39215;
        _39215 = 5 + _39214;
        #line 190 "dsl.impala"
        int _39200;
        _39200 = 5 + _39199;
        #line 190 "dsl.impala"
        int _39157;
        _39157 = 5 + _39156;
        #line 9 "gpu_device.impala"
        float* i_39216;
        i_39216 = _37253_39096 + _39215;
        #line 9 "gpu_device.impala"
        float* i_39201;
        i_39201 = _37253_39096 + _39200;
        #line 9 "gpu_device.impala"
        float* i_39158;
        i_39158 = _37253_39096 + _39157;
        #line 10 "gpu_device.impala"
        float _39159;
        _39159 = *i_39158;
        #line 10 "gpu_device.impala"
        float _39163;
        _39163 = _39159;
        #line 190 "dsl.impala"
        float _39164;
        _39164 = _39162 * _39163;
        #line 189 "dsl.impala"
        float _39165;
        _39165 = _39161 + _39164;
        #line 14 "gpu_device.impala"
        *i_39147 = _39165;
        #line 10 "gpu_device.impala"
        float _39168;
        _39168 = *i_39167;
        #line 10 "gpu_device.impala"
        float _39178;
        _39178 = _39168;
        #line 10 "gpu_device.impala"
        float _39176;
        _39176 = *i_39175;
        #line 10 "gpu_device.impala"
        float _39179;
        _39179 = _39176;
        #line 190 "dsl.impala"
        float _39180;
        _39180 = _39178 * _39179;
        #line 189 "dsl.impala"
        float _39181;
        _39181 = _39165 + _39180;
        #line 14 "gpu_device.impala"
        *i_39147 = _39181;
        #line 10 "gpu_device.impala"
        float _39184;
        _39184 = *i_39183;
        #line 10 "gpu_device.impala"
        float _39189;
        _39189 = _39184;
        #line 10 "gpu_device.impala"
        float _39187;
        _39187 = *i_39186;
        #line 10 "gpu_device.impala"
        float _39190;
        _39190 = _39187;
        #line 190 "dsl.impala"
        float _39191;
        _39191 = _39189 * _39190;
        #line 189 "dsl.impala"
        float _39192;
        _39192 = _39181 + _39191;
        #line 14 "gpu_device.impala"
        *i_39147 = _39192;
        #line 10 "gpu_device.impala"
        float _39195;
        _39195 = *i_39194;
        #line 10 "gpu_device.impala"
        float _39204;
        _39204 = _39195;
        #line 10 "gpu_device.impala"
        float _39202;
        _39202 = *i_39201;
        #line 10 "gpu_device.impala"
        float _39205;
        _39205 = _39202;
        #line 190 "dsl.impala"
        float _39206;
        _39206 = _39204 * _39205;
        #line 189 "dsl.impala"
        float _39207;
        _39207 = _39192 + _39206;
        #line 14 "gpu_device.impala"
        *i_39147 = _39207;
        #line 10 "gpu_device.impala"
        float _39210;
        _39210 = *i_39209;
        #line 10 "gpu_device.impala"
        float _39219;
        _39219 = _39210;
        #line 10 "gpu_device.impala"
        float _39217;
        _39217 = *i_39216;
        #line 10 "gpu_device.impala"
        float _39220;
        _39220 = _39217;
        #line 190 "dsl.impala"
        float _39221;
        _39221 = _39219 * _39220;
        #line 189 "dsl.impala"
        float _39222;
        _39222 = _39207 + _39221;
        #line 14 "gpu_device.impala"
        *i_39147 = _39222;
        #line 93 "gpu_device.impala"
        goto l39145;
    l39145: ;
        return ;
}

__global__ void lambda_crit_37068(float* _37071_38949, float* _37072_38950, struct_14389 _37073_38951, float* _37074_38952, char* _37075_38953) {
    int  _38956;
    int p_38956;
    int  _38959;
    int p_38959;
    int  _38962;
    int p_38962;
    int  _38965;
    int p_38965;
    int  _38968;
    int p_38968;
    int  _38971;
    int p_38971;
    #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _38956 = blockIdx_x();
    p_38956 = _38956;
    l38954: ;
        _38956 = p_38956;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38959 = blockDim_x();
        p_38959 = _38959;
    l38957: ;
        _38959 = p_38959;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38962 = threadIdx_x();
        p_38962 = _38962;
    l38960: ;
        _38962 = p_38962;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38965 = blockIdx_y();
        p_38965 = _38965;
    l38963: ;
        _38965 = p_38965;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38968 = blockDim_y();
        p_38968 = _38968;
    l38966: ;
        _38968 = p_38968;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38971 = threadIdx_y();
        p_38971 = _38971;
    l38969: ;
        _38971 = p_38971;
        #line 170 "dsl.impala"
        int _38975;
        _38975 = _37073_38951.e5;
        #line 88 "gpu_device.impala"
        int _38978;
        _38978 = _38956 * _38959;
        #line 88 "gpu_device.impala"
        int _38979;
        _38979 = _38978 + _38962;
        #line 73 "gpu_device.impala"
        int _38976;
        _38976 = 2 * _38975;
        #line 88 "gpu_device.impala"
        int _38980;
        _38980 = _38979 + _38976;
        #line 73 "gpu_device.impala"
        int offset_38977;
        offset_38977 = 5 + _38976;
        #line 88 "gpu_device.impala"
        int x_38981;
        x_38981 = 5 + _38980;
        #line 91 "gpu_device.impala"
        bool _38982;
        _38982 = offset_38977 < x_38981;
        #line 91 "gpu_device.impala"
        if (_38982) goto l38983; else goto l39091;
    l39091: ;
        #line 93 "gpu_device.impala"
        goto l39088;
    l38983: ;
        #line 91 "gpu_device.impala"
        int _38984;
        _38984 = _38975 + _38976;
        #line 91 "gpu_device.impala"
        int _38985;
        _38985 = 5 + _38984;
        #line 91 "gpu_device.impala"
        bool _38986;
        _38986 = x_38981 < _38985;
        #line 91 "gpu_device.impala"
        if (_38986) goto l38987; else goto l39090;
    l39090: ;
        #line 93 "gpu_device.impala"
        goto l39088;
    l38987: ;
        #line 89 "gpu_device.impala"
        int _38989;
        _38989 = _38965 * _38968;
        #line 89 "gpu_device.impala"
        int y_38990;
        y_38990 = _38989 + _38971;
        #line 91 "gpu_device.impala"
        bool _38991;
        _38991 = 1 < y_38990;
        #line 91 "gpu_device.impala"
        if (_38991) goto l38992; else goto l39089;
    l39089: ;
        #line 93 "gpu_device.impala"
        goto l39088;
    l38992: ;
        #line 72 "gpu_device.impala"
        int _38994;
        _38994 = _37073_38951.e6;
        #line 91 "gpu_device.impala"
        int _38995;
        _38995 = _38994 - 2;
        #line 91 "gpu_device.impala"
        bool _38996;
        _38996 = y_38990 < _38995;
        #line 91 "gpu_device.impala"
        if (_38996) goto l38997; else goto l39087;
    l39087: ;
        #line 93 "gpu_device.impala"
        goto l39088;
    l39088: ;
        #line 93 "gpu_device.impala"
        goto l39016;
    l38997: ;
        #line 170 "dsl.impala"
        int _39010;
        _39010 = y_38990 * _38975;
        #line 170 "dsl.impala"
        int _39011;
        _39011 = _39010 + _38980;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39009;
        _39009.e0 = 1;
        _39009.e1 = _37075_38953;
        #line 170 "dsl.impala"
        int _39012;
        _39012 = 5 + _39011;
        #line 13 "gpu_device.impala"
        write_38998(_39009, _39012, 0.000000e+00f);
    l39014: ;
        #line 175 "dsl.impala"
        int _39041;
        _39041 = 4 + _39011;
        #line 9 "gpu_device.impala"
        float* i_39061;
        i_39061 = _37071_38949 + 3;
        #line 9 "gpu_device.impala"
        float* i_39053;
        i_39053 = _37072_38950 + _39012;
        #line 175 "dsl.impala"
        int _39065;
        _39065 = 6 + _39011;
        #line 9 "gpu_device.impala"
        float* i_39050;
        i_39050 = _37071_38949 + 2;
        #line 9 "gpu_device.impala"
        float* i_39037;
        i_39037 = _37071_38949 + 1;
        #line 175 "dsl.impala"
        int _39027;
        _39027 = 3 + _39011;
        #line 9 "gpu_device.impala"
        float* i_39018;
        i_39018 = _37074_38952 + _39012;
        #line 9 "gpu_device.impala"
        float* i_39074;
        i_39074 = _37071_38949 + 4;
        #line 9 "gpu_device.impala"
        float* i_39023;
        i_39023 = _37071_38949 + 0;
        #line 175 "dsl.impala"
        int _39078;
        _39078 = 7 + _39011;
        #line 9 "gpu_device.impala"
        float* i_39066;
        i_39066 = _37072_38950 + _39065;
        #line 9 "gpu_device.impala"
        float* i_39042;
        i_39042 = _37072_38950 + _39041;
        #line 9 "gpu_device.impala"
        float* i_39028;
        i_39028 = _37072_38950 + _39027;
        #line 10 "gpu_device.impala"
        float _39019;
        _39019 = *i_39018;
        #line 9 "gpu_device.impala"
        float* i_39079;
        i_39079 = _37072_38950 + _39078;
        #line 10 "gpu_device.impala"
        float _39031;
        _39031 = _39019;
        #line 10 "gpu_device.impala"
        float _39024;
        _39024 = *i_39023;
        #line 10 "gpu_device.impala"
        float _39032;
        _39032 = _39024;
        #line 10 "gpu_device.impala"
        float _39029;
        _39029 = *i_39028;
        #line 10 "gpu_device.impala"
        float _39033;
        _39033 = _39029;
        #line 175 "dsl.impala"
        float _39034;
        _39034 = _39032 * _39033;
        #line 174 "dsl.impala"
        float _39035;
        _39035 = _39031 + _39034;
        #line 14 "gpu_device.impala"
        *i_39018 = _39035;
        #line 10 "gpu_device.impala"
        float _39038;
        _39038 = *i_39037;
        #line 10 "gpu_device.impala"
        float _39045;
        _39045 = _39038;
        #line 10 "gpu_device.impala"
        float _39043;
        _39043 = *i_39042;
        #line 10 "gpu_device.impala"
        float _39046;
        _39046 = _39043;
        #line 175 "dsl.impala"
        float _39047;
        _39047 = _39045 * _39046;
        #line 174 "dsl.impala"
        float _39048;
        _39048 = _39035 + _39047;
        #line 14 "gpu_device.impala"
        *i_39018 = _39048;
        #line 10 "gpu_device.impala"
        float _39051;
        _39051 = *i_39050;
        #line 10 "gpu_device.impala"
        float _39056;
        _39056 = _39051;
        #line 10 "gpu_device.impala"
        float _39054;
        _39054 = *i_39053;
        #line 10 "gpu_device.impala"
        float _39057;
        _39057 = _39054;
        #line 175 "dsl.impala"
        float _39058;
        _39058 = _39056 * _39057;
        #line 174 "dsl.impala"
        float _39059;
        _39059 = _39048 + _39058;
        #line 14 "gpu_device.impala"
        *i_39018 = _39059;
        #line 10 "gpu_device.impala"
        float _39062;
        _39062 = *i_39061;
        #line 10 "gpu_device.impala"
        float _39069;
        _39069 = _39062;
        #line 10 "gpu_device.impala"
        float _39067;
        _39067 = *i_39066;
        #line 10 "gpu_device.impala"
        float _39070;
        _39070 = _39067;
        #line 175 "dsl.impala"
        float _39071;
        _39071 = _39069 * _39070;
        #line 174 "dsl.impala"
        float _39072;
        _39072 = _39059 + _39071;
        #line 14 "gpu_device.impala"
        *i_39018 = _39072;
        #line 10 "gpu_device.impala"
        float _39075;
        _39075 = *i_39074;
        #line 10 "gpu_device.impala"
        float _39082;
        _39082 = _39075;
        #line 10 "gpu_device.impala"
        float _39080;
        _39080 = *i_39079;
        #line 10 "gpu_device.impala"
        float _39083;
        _39083 = _39080;
        #line 175 "dsl.impala"
        float _39084;
        _39084 = _39082 * _39083;
        #line 174 "dsl.impala"
        float _39085;
        _39085 = _39072 + _39084;
        #line 14 "gpu_device.impala"
        *i_39018 = _39085;
        #line 93 "gpu_device.impala"
        goto l39016;
    l39016: ;
        return ;
}

__global__ void lambda_crit_37448(char* _37451_39232, char* _37452_39233, struct_14389 _37453_39234, char* _37454_39235, char* _37455_39236) {
    int  _39239;
    int p_39239;
    int  _39242;
    int p_39242;
    int  _39245;
    int p_39245;
    int  _39248;
    int p_39248;
    int  _39251;
    int p_39251;
    int  _39254;
    int p_39254;
    float  read_39295;
    float pread_39295;
    float  read_39303;
    float pread_39303;
    float  read_39309;
    float pread_39309;
    float  read_39313;
    float pread_39313;
    float  read_39321;
    float pread_39321;
    float  read_39327;
    float pread_39327;
    float  read_39333;
    float pread_39333;
    float  read_39338;
    float pread_39338;
    float  read_39344;
    float pread_39344;
    float  read_39348;
    float pread_39348;
    float  read_39355;
    float pread_39355;
    float  read_39360;
    float pread_39360;
    float  read_39369;
    float pread_39369;
    float  read_39372;
    float pread_39372;
    float  read_39378;
    float pread_39378;
    float  read_39382;
    float pread_39382;
    float  read_39389;
    float pread_39389;
    float  read_39392;
    float pread_39392;
    float  read_39398;
    float pread_39398;
    float  read_39401;
    float pread_39401;
    float  read_39407;
    float pread_39407;
    float  read_39411;
    float pread_39411;
    float  read_39418;
    float pread_39418;
    float  read_39421;
    float pread_39421;
    bool  _39432;
    bool p_39432;
    bool  _39434;
    bool p_39434;
    float  read_39437;
    float pread_39437;
    float  read_39444;
    float pread_39444;
    float  read_39450;
    float pread_39450;
    float  read_39453;
    float pread_39453;
    float  read_39456;
    float pread_39456;
    float  read_39459;
    float pread_39459;
    #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _39239 = blockIdx_x();
    p_39239 = _39239;
    l39237: ;
        _39239 = p_39239;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39242 = blockDim_x();
        p_39242 = _39242;
    l39240: ;
        _39242 = p_39242;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39245 = threadIdx_x();
        p_39245 = _39245;
    l39243: ;
        _39245 = p_39245;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39248 = blockIdx_y();
        p_39248 = _39248;
    l39246: ;
        _39248 = p_39248;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39251 = blockDim_y();
        p_39251 = _39251;
    l39249: ;
        _39251 = p_39251;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _39254 = threadIdx_y();
        p_39254 = _39254;
    l39252: ;
        _39254 = p_39254;
        #line 135 "gpu_device.impala"
        int _39258;
        _39258 = _39239 * _39242;
        #line 242 "dsl.impala"
        int _39255;
        _39255 = _37453_39234.e5;
        #line 321 "dsl.impala"
        int _39256;
        _39256 = 2 * _39255;
        #line 321 "dsl.impala"
        int _39257;
        _39257 = 5 + _39256;
        #line 135 "gpu_device.impala"
        int _39259;
        _39259 = _39258 + _39245;
        #line 135 "gpu_device.impala"
        int _39260;
        _39260 = _39259 + _39256;
        #line 135 "gpu_device.impala"
        int x_39261;
        x_39261 = 5 + _39260;
        #line 138 "gpu_device.impala"
        bool _39262;
        _39262 = _39257 < x_39261;
        #line 138 "gpu_device.impala"
        if (_39262) goto l39263; else goto l39477;
    l39477: ;
        #line 140 "gpu_device.impala"
        goto l39474;
    l39263: ;
        #line 138 "gpu_device.impala"
        int _39264;
        _39264 = _39255 + _39256;
        #line 138 "gpu_device.impala"
        int _39265;
        _39265 = 5 + _39264;
        #line 138 "gpu_device.impala"
        bool _39266;
        _39266 = x_39261 < _39265;
        #line 138 "gpu_device.impala"
        if (_39266) goto l39267; else goto l39476;
    l39476: ;
        #line 140 "gpu_device.impala"
        goto l39474;
    l39267: ;
        #line 136 "gpu_device.impala"
        int _39268;
        _39268 = _39248 * _39251;
        #line 136 "gpu_device.impala"
        int y_39269;
        y_39269 = _39268 + _39254;
        #line 138 "gpu_device.impala"
        bool _39270;
        _39270 = 1 < y_39269;
        #line 138 "gpu_device.impala"
        if (_39270) goto l39271; else goto l39475;
    l39475: ;
        #line 140 "gpu_device.impala"
        goto l39474;
    l39271: ;
        #line 322 "dsl.impala"
        int _39272;
        _39272 = _37453_39234.e6;
        #line 322 "dsl.impala"
        int _39273;
        _39273 = _39272 - 2;
        #line 138 "gpu_device.impala"
        bool _39274;
        _39274 = y_39269 < _39273;
        #line 138 "gpu_device.impala"
        if (_39274) goto l39275; else goto l39473;
    l39473: ;
        #line 140 "gpu_device.impala"
        goto l39474;
    l39474: ;
        #line 140 "gpu_device.impala"
        goto l39466;
    l39275: ;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39276;
        _39276.e0 = 1;
        _39276.e1 = _37454_39235;
        #line 242 "dsl.impala"
        int _39277;
        _39277 = y_39269 * _39255;
        #line 242 "dsl.impala"
        int _39278;
        _39278 = _39277 + _39260;
        #line 242 "dsl.impala"
        int _39279;
        _39279 = 5 + _39278;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, 0.000000e+00f);
    l39280: ;
        #line 9 "gpu_device.impala"
        read_39295 = read_39282(_39276, _39279);
        pread_39295 = read_39295;
    l39293: ;
        read_39295 = pread_39295;
        #line 247 "dsl.impala"
        int _39299;
        _39299 = x_39261 - 1;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39296;
        _39296.e0 = 1;
        _39296.e1 = _37455_39236;
        #line 247 "dsl.impala"
        int _39297;
        _39297 = y_39269 - 1;
        #line 247 "dsl.impala"
        int _39298;
        _39298 = _39297 * _39255;
        #line 247 "dsl.impala"
        int _39300;
        _39300 = _39298 + _39299;
        #line 9 "gpu_device.impala"
        read_39303 = read_39282(_39296, _39300);
        pread_39303 = read_39303;
    l39301: ;
        read_39303 = pread_39303;
        #line 246 "dsl.impala"
        float _39304;
        _39304 = read_39295 - read_39303;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39304);
    l39305: ;
        #line 9 "gpu_device.impala"
        read_39309 = read_39282(_39276, _39279);
        pread_39309 = read_39309;
    l39307: ;
        read_39309 = pread_39309;
        #line 253 "dsl.impala"
        int _39310;
        _39310 = _39277 + _39299;
        #line 9 "gpu_device.impala"
        read_39313 = read_39282(_39296, _39310);
        pread_39313 = read_39313;
    l39311: ;
        read_39313 = pread_39313;
        #line 253 "dsl.impala"
        float _39315;
        _39315 = 2.000000e+00f * read_39313;
        #line 252 "dsl.impala"
        float _39316;
        _39316 = read_39309 - _39315;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39316);
    l39317: ;
        #line 9 "gpu_device.impala"
        read_39321 = read_39282(_39276, _39279);
        pread_39321 = read_39321;
    l39319: ;
        read_39321 = pread_39321;
        #line 259 "dsl.impala"
        int _39322;
        _39322 = 1 + y_39269;
        #line 259 "dsl.impala"
        int _39323;
        _39323 = _39322 * _39255;
        #line 259 "dsl.impala"
        int _39324;
        _39324 = _39323 + _39299;
        #line 9 "gpu_device.impala"
        read_39327 = read_39282(_39296, _39324);
        pread_39327 = read_39327;
    l39325: ;
        read_39327 = pread_39327;
        #line 258 "dsl.impala"
        float _39328;
        _39328 = read_39321 - read_39327;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39328);
    l39329: ;
        #line 9 "gpu_device.impala"
        read_39333 = read_39282(_39276, _39279);
        pread_39333 = read_39333;
    l39331: ;
        read_39333 = pread_39333;
        #line 265 "dsl.impala"
        int _39334;
        _39334 = _39298 + _39260;
        #line 265 "dsl.impala"
        int _39335;
        _39335 = 6 + _39334;
        #line 9 "gpu_device.impala"
        read_39338 = read_39282(_39296, _39335);
        pread_39338 = read_39338;
    l39336: ;
        read_39338 = pread_39338;
        #line 264 "dsl.impala"
        float _39339;
        _39339 = read_39333 + read_39338;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39339);
    l39340: ;
        #line 9 "gpu_device.impala"
        read_39344 = read_39282(_39276, _39279);
        pread_39344 = read_39344;
    l39342: ;
        read_39344 = pread_39344;
        #line 271 "dsl.impala"
        int _39345;
        _39345 = 6 + _39278;
        #line 9 "gpu_device.impala"
        read_39348 = read_39282(_39296, _39345);
        pread_39348 = read_39348;
    l39346: ;
        read_39348 = pread_39348;
        #line 271 "dsl.impala"
        float _39349;
        _39349 = 2.000000e+00f * read_39348;
        #line 270 "dsl.impala"
        float _39350;
        _39350 = read_39344 + _39349;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39350);
    l39351: ;
        #line 9 "gpu_device.impala"
        read_39355 = read_39282(_39276, _39279);
        pread_39355 = read_39355;
    l39353: ;
        read_39355 = pread_39355;
        #line 277 "dsl.impala"
        int _39356;
        _39356 = _39323 + _39260;
        #line 277 "dsl.impala"
        int _39357;
        _39357 = 6 + _39356;
        #line 9 "gpu_device.impala"
        read_39360 = read_39282(_39296, _39357);
        pread_39360 = read_39360;
    l39358: ;
        read_39360 = pread_39360;
        #line 276 "dsl.impala"
        float _39361;
        _39361 = read_39355 + read_39360;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39361);
    l39362: ;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39364;
        _39364.e0 = 1;
        _39364.e1 = _37452_39233;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, 0.000000e+00f);
    l39365: ;
        #line 9 "gpu_device.impala"
        read_39369 = read_39282(_39364, _39279);
        pread_39369 = read_39369;
    l39367: ;
        read_39369 = pread_39369;
        #line 9 "gpu_device.impala"
        read_39372 = read_39282(_39296, _39300);
        pread_39372 = read_39372;
    l39370: ;
        read_39372 = pread_39372;
        #line 285 "dsl.impala"
        float _39373;
        _39373 = read_39369 - read_39372;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39373);
    l39374: ;
        #line 9 "gpu_device.impala"
        read_39378 = read_39282(_39364, _39279);
        pread_39378 = read_39378;
    l39376: ;
        read_39378 = pread_39378;
        #line 265 "dsl.impala"
        int _39379;
        _39379 = 5 + _39334;
        #line 9 "gpu_device.impala"
        read_39382 = read_39282(_39296, _39379);
        pread_39382 = read_39382;
    l39380: ;
        read_39382 = pread_39382;
        #line 292 "dsl.impala"
        float _39383;
        _39383 = 2.000000e+00f * read_39382;
        #line 291 "dsl.impala"
        float _39384;
        _39384 = read_39378 - _39383;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39384);
    l39385: ;
        #line 9 "gpu_device.impala"
        read_39389 = read_39282(_39364, _39279);
        pread_39389 = read_39389;
    l39387: ;
        read_39389 = pread_39389;
        #line 9 "gpu_device.impala"
        read_39392 = read_39282(_39296, _39335);
        pread_39392 = read_39392;
    l39390: ;
        read_39392 = pread_39392;
        #line 297 "dsl.impala"
        float _39393;
        _39393 = read_39389 - read_39392;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39393);
    l39394: ;
        #line 9 "gpu_device.impala"
        read_39398 = read_39282(_39364, _39279);
        pread_39398 = read_39398;
    l39396: ;
        read_39398 = pread_39398;
        #line 9 "gpu_device.impala"
        read_39401 = read_39282(_39296, _39324);
        pread_39401 = read_39401;
    l39399: ;
        read_39401 = pread_39401;
        #line 303 "dsl.impala"
        float _39402;
        _39402 = read_39398 + read_39401;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39402);
    l39403: ;
        #line 9 "gpu_device.impala"
        read_39407 = read_39282(_39364, _39279);
        pread_39407 = read_39407;
    l39405: ;
        read_39407 = pread_39407;
        #line 277 "dsl.impala"
        int _39408;
        _39408 = 5 + _39356;
        #line 9 "gpu_device.impala"
        read_39411 = read_39282(_39296, _39408);
        pread_39411 = read_39411;
    l39409: ;
        read_39411 = pread_39411;
        #line 310 "dsl.impala"
        float _39412;
        _39412 = 2.000000e+00f * read_39411;
        #line 309 "dsl.impala"
        float _39413;
        _39413 = read_39407 + _39412;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39413);
    l39414: ;
        #line 9 "gpu_device.impala"
        read_39418 = read_39282(_39364, _39279);
        pread_39418 = read_39418;
    l39416: ;
        read_39418 = pread_39418;
        #line 9 "gpu_device.impala"
        read_39421 = read_39282(_39296, _39357);
        pread_39421 = read_39421;
    l39419: ;
        read_39421 = pread_39421;
        #line 315 "dsl.impala"
        float _39422;
        _39422 = read_39418 + read_39421;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39422);
    l39423: ;
        #line 138 "gpu_device.impala"
        if (_39262) goto l39425; else goto l39472;
    l39472: ;
        #line 322 "dsl.impala"
        goto l39471;
    l39425: ;
        #line 321 "dsl.impala"
        int _39426;
        _39426 = 3 * _39255;
        #line 321 "dsl.impala"
        int _39427;
        _39427 = 4 + _39426;
        #line 321 "dsl.impala"
        bool _39428;
        _39428 = x_39261 < _39427;
        #line 321 "dsl.impala"
        if (_39428) goto l39429; else goto l39470;
    l39470: ;
        #line 322 "dsl.impala"
        goto l39471;
    l39471: ;
        #line 322 "dsl.impala"
        p_39434 = false;
        goto l39433;
    l39429: ;
        #line 138 "gpu_device.impala"
        if (_39270) goto l39430; else goto l39468;
    l39468: ;
        #line 322 "dsl.impala"
        p_39432 = false;
        goto l39431;
    l39430: ;
        #line 322 "dsl.impala"
        p_39432 = _39274;
        goto l39431;
    l39431: ;
        _39432 = p_39432;
        #line 322 "dsl.impala"
        p_39434 = _39432;
        goto l39433;
    l39433: ;
        _39434 = p_39434;
        #line 9 "gpu_device.impala"
        read_39437 = read_39282(_39276, _39279);
        pread_39437 = read_39437;
    l39435: ;
        read_39437 = pread_39437;
        #line 320 "dsl.impala"
        float condition_39438;
        condition_39438 = (float)_39434;
        #line 327 "dsl.impala"
        float _39439;
        _39439 = read_39437 * condition_39438;
        #line 13 "gpu_device.impala"
        write_38998(_39276, _39279, _39439);
    l39440: ;
        #line 9 "gpu_device.impala"
        read_39444 = read_39282(_39364, _39279);
        pread_39444 = read_39444;
    l39442: ;
        read_39444 = pread_39444;
        #line 332 "dsl.impala"
        float _39445;
        _39445 = read_39444 * condition_39438;
        #line 13 "gpu_device.impala"
        write_38998(_39364, _39279, _39445);
    l39446: ;
        #line 9 "gpu_device.impala"
        read_39450 = read_39282(_39276, _39279);
        pread_39450 = read_39450;
    l39448: ;
        read_39450 = pread_39450;
        #line 9 "gpu_device.impala"
        read_39453 = read_39282(_39276, _39279);
        pread_39453 = read_39453;
    l39451: ;
        read_39453 = pread_39453;
        #line 9 "gpu_device.impala"
        read_39456 = read_39282(_39364, _39279);
        pread_39456 = read_39456;
    l39454: ;
        read_39456 = pread_39456;
        #line 9 "gpu_device.impala"
        read_39459 = read_39282(_39364, _39279);
        pread_39459 = read_39459;
    l39457: ;
        read_39459 = pread_39459;
        #line 337 "dsl.impala"
        float _39461;
        _39461 = read_39450 * read_39453;
        #line 338 "dsl.impala"
        float _39462;
        _39462 = read_39456 * read_39459;
        #line 36 "/home/rafael/Utilities/anydsl/runtime/src/runtime.impala"
        struct_14391 _39460;
        _39460.e0 = 1;
        _39460.e1 = _37451_39232;
        #line 337 "dsl.impala"
        float _39463;
        _39463 = _39461 + _39462;
        #line 13 "gpu_device.impala"
        write_38998(_39460, _39279, _39463);
    l39464: ;
        #line 140 "gpu_device.impala"
        goto l39466;
    l39466: ;
        return ;
}

__global__ void lambda_36802() {
    int  _38915;
    int p_38915;
    int  _38921;
    int p_38921;
    int  _38927;
    int p_38927;
    int  _38933;
    int p_38933;
    int  _38939;
    int p_38939;
    int  _38945;
    int p_38945;
    #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _38915 = blockIdx_x();
    p_38915 = _38915;
    l38913: ;
        _38915 = p_38915;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38921 = blockDim_x();
        p_38921 = _38921;
    l38919: ;
        _38921 = p_38921;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38927 = threadIdx_x();
        p_38927 = _38927;
    l38925: ;
        _38927 = p_38927;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38933 = blockIdx_y();
        p_38933 = _38933;
    l38931: ;
        _38933 = p_38933;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38939 = blockDim_y();
        p_38939 = _38939;
    l38937: ;
        _38939 = p_38939;
        #line 1 "/home/rafael/Utilities/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _38945 = threadIdx_y();
        p_38945 = _38945;
    l38943: ;
        _38945 = p_38945;
        return ;
}

__device__ int abs_39538(int a) {
  return a * (a >= 0) - a * (a < 0);
}

__device__ void write_38998(struct_14391, int, float);
__device__ void write_38998(struct_14391 buf_39876, int i_39877, float v_39878) {
    #line 14 "gpu_device.impala"
    char* _39881;
    _39881 = buf_39876.e1;
    *((float *) _39881 + i_39877) = v_39878;
}

__device__ float read_39282(struct_14391 buf_39423, int i_39424) {
    #line 10 "gpu_device.impala"
    char* _39426;
    _39426 = buf_39423.e1;
    return *((float *) _39426 + i_39424);
}

}
