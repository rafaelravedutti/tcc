extern "C" {
typedef struct struct_10057 {
    int e0;
    char* e1;
} struct_10057;
typedef struct struct_10055 {
    float* e0;
    int e1;
    int e2;
    struct_10057 e3;
    struct_10057 e4;
    struct_10057 e5;
    struct_10057 e6;
    struct_10057 e7;
    struct_10057 e8;
    struct_10057 e9;
    struct_10057 e10;
    struct_10057 e11;
} struct_10055;

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
__global__ void lambda_49095(float*, float*, struct_10055, float*);
__global__ void lambda_49587(float*, float*, struct_10055, float*, float*, float*);
__global__ void lambda_49385(float*, float*, struct_10055, float*, float*);
__global__ void lambda_48861();
__global__ void lambda_49241(float*, float*, struct_10055, float*);

__global__ void lambda_49095(float* _49098_50457, float* _49099_50458, struct_10055 _49100_50459, float* _49101_50460) {
    int  _50463;
    int p_50463;
    int  _50466;
    int p_50466;
    int  _50469;
    int p_50469;
    int  _50472;
    int p_50472;
    int  _50475;
    int p_50475;
    int  _50478;
    int p_50478;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _50463 = blockIdx_x();
    p_50463 = _50463;
    l50461: ;
        _50463 = p_50463;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50466 = blockDim_x();
        p_50466 = _50466;
    l50464: ;
        _50466 = p_50466;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50469 = threadIdx_x();
        p_50469 = _50469;
    l50467: ;
        _50469 = p_50469;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50472 = blockIdx_y();
        p_50472 = _50472;
    l50470: ;
        _50472 = p_50472;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50475 = blockDim_y();
        p_50475 = _50475;
    l50473: ;
        _50475 = p_50475;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50478 = threadIdx_y();
        p_50478 = _50478;
    l50476: ;
        _50478 = p_50478;
        #line 120 "gpu_device.impala"
        int _50480;
        _50480 = _50463 * _50466;
        #line 120 "gpu_device.impala"
        int x_50481;
        x_50481 = _50480 + _50469;
        #line 123 "gpu_device.impala"
        bool _50482;
        _50482 = 1 < x_50481;
        #line 123 "gpu_device.impala"
        if (_50482) goto l50483; else goto l50577;
    l50577: ;
        #line 125 "gpu_device.impala"
        goto l50574;
    l50483: ;
        #line 427 "dsl.impala"
        int _50485;
        _50485 = _49100_50459.e1;
        #line 123 "gpu_device.impala"
        int _50487;
        _50487 = _50485 - 2;
        #line 123 "gpu_device.impala"
        bool _50488;
        _50488 = x_50481 < _50487;
        #line 123 "gpu_device.impala"
        if (_50488) goto l50489; else goto l50576;
    l50576: ;
        #line 125 "gpu_device.impala"
        goto l50574;
    l50489: ;
        #line 121 "gpu_device.impala"
        int _50490;
        _50490 = _50472 * _50475;
        #line 121 "gpu_device.impala"
        int y_50491;
        y_50491 = _50490 + _50478;
        #line 123 "gpu_device.impala"
        bool _50492;
        _50492 = 1 < y_50491;
        #line 123 "gpu_device.impala"
        if (_50492) goto l50493; else goto l50575;
    l50575: ;
        #line 125 "gpu_device.impala"
        goto l50574;
    l50493: ;
        #line 511 "dsl.impala"
        int _50495;
        _50495 = _49100_50459.e2;
        #line 341 "dsl.impala"
        int _50496;
        _50496 = _50495 - 2;
        #line 123 "gpu_device.impala"
        bool _50497;
        _50497 = y_50491 < _50496;
        #line 123 "gpu_device.impala"
        if (_50497) goto l50498; else goto l50573;
    l50573: ;
        #line 125 "gpu_device.impala"
        goto l50574;
    l50574: ;
        return ;
    l50498: ;
        #line 11 "gpu_device.impala"
        float* i_50547;
        i_50547 = _49099_50458 + 3;
        #line 11 "gpu_device.impala"
        float* i_50560;
        i_50560 = _49099_50458 + 4;
        #line 189 "dsl.impala"
        int _50500;
        _50500 = y_50491 * _50485;
        #line 11 "gpu_device.impala"
        float* i_50536;
        i_50536 = _49099_50458 + 2;
        #line 11 "gpu_device.impala"
        float* i_50523;
        i_50523 = _49099_50458 + 1;
        #line 508 "dsl.impala"
        int _50501;
        _50501 = 2 * _50485;
        #line 11 "gpu_device.impala"
        float* i_50509;
        i_50509 = _49099_50458 + 0;
        #line 124 "gpu_device.impala"
        int _50502;
        _50502 = x_50481 + _50501;
        #line 189 "dsl.impala"
        int _50503;
        _50503 = _50500 + _50502;
        #line 194 "dsl.impala"
        int _50551;
        _50551 = 6 + _50503;
        #line 194 "dsl.impala"
        int _50514;
        _50514 = 3 + _50503;
        #line 194 "dsl.impala"
        int _50564;
        _50564 = 7 + _50503;
        #line 194 "dsl.impala"
        int _50527;
        _50527 = 4 + _50503;
        #line 189 "dsl.impala"
        int _50504;
        _50504 = 5 + _50503;
        #line 11 "gpu_device.impala"
        float* i_50552;
        i_50552 = _49098_50457 + _50551;
        #line 11 "gpu_device.impala"
        float* i_50515;
        i_50515 = _49098_50457 + _50514;
        #line 11 "gpu_device.impala"
        float* i_50565;
        i_50565 = _49098_50457 + _50564;
        #line 11 "gpu_device.impala"
        float* i_50528;
        i_50528 = _49098_50457 + _50527;
        #line 15 "gpu_device.impala"
        float* i_50505;
        i_50505 = _49101_50460 + _50504;
        #line 11 "gpu_device.impala"
        float* i_50539;
        i_50539 = _49098_50457 + _50504;
        #line 16 "gpu_device.impala"
        *i_50505 = 0.000000e+00f;
        #line 12 "gpu_device.impala"
        float _50510;
        _50510 = *i_50509;
        #line 12 "gpu_device.impala"
        float _50518;
        _50518 = _50510;
        #line 12 "gpu_device.impala"
        float _50516;
        _50516 = *i_50515;
        #line 12 "gpu_device.impala"
        float _50519;
        _50519 = _50516;
        #line 194 "dsl.impala"
        float _50520;
        _50520 = _50518 * _50519;
        #line 193 "dsl.impala"
        float _50521;
        _50521 = 0.000000e+00f + _50520;
        #line 16 "gpu_device.impala"
        *i_50505 = _50521;
        #line 12 "gpu_device.impala"
        float _50524;
        _50524 = *i_50523;
        #line 12 "gpu_device.impala"
        float _50531;
        _50531 = _50524;
        #line 12 "gpu_device.impala"
        float _50529;
        _50529 = *i_50528;
        #line 12 "gpu_device.impala"
        float _50532;
        _50532 = _50529;
        #line 194 "dsl.impala"
        float _50533;
        _50533 = _50531 * _50532;
        #line 193 "dsl.impala"
        float _50534;
        _50534 = _50521 + _50533;
        #line 16 "gpu_device.impala"
        *i_50505 = _50534;
        #line 12 "gpu_device.impala"
        float _50537;
        _50537 = *i_50536;
        #line 12 "gpu_device.impala"
        float _50542;
        _50542 = _50537;
        #line 12 "gpu_device.impala"
        float _50540;
        _50540 = *i_50539;
        #line 12 "gpu_device.impala"
        float _50543;
        _50543 = _50540;
        #line 194 "dsl.impala"
        float _50544;
        _50544 = _50542 * _50543;
        #line 193 "dsl.impala"
        float _50545;
        _50545 = _50534 + _50544;
        #line 16 "gpu_device.impala"
        *i_50505 = _50545;
        #line 12 "gpu_device.impala"
        float _50548;
        _50548 = *i_50547;
        #line 12 "gpu_device.impala"
        float _50555;
        _50555 = _50548;
        #line 12 "gpu_device.impala"
        float _50553;
        _50553 = *i_50552;
        #line 12 "gpu_device.impala"
        float _50556;
        _50556 = _50553;
        #line 194 "dsl.impala"
        float _50557;
        _50557 = _50555 * _50556;
        #line 193 "dsl.impala"
        float _50558;
        _50558 = _50545 + _50557;
        #line 16 "gpu_device.impala"
        *i_50505 = _50558;
        #line 12 "gpu_device.impala"
        float _50561;
        _50561 = *i_50560;
        #line 12 "gpu_device.impala"
        float _50568;
        _50568 = _50561;
        #line 12 "gpu_device.impala"
        float _50566;
        _50566 = *i_50565;
        #line 12 "gpu_device.impala"
        float _50569;
        _50569 = _50566;
        #line 194 "dsl.impala"
        float _50570;
        _50570 = _50568 * _50569;
        #line 193 "dsl.impala"
        float _50571;
        _50571 = _50558 + _50570;
        #line 16 "gpu_device.impala"
        *i_50505 = _50571;
        return ;
}

__global__ void lambda_49587(float* _49590_50891, float* _49591_50892, struct_10055 _49592_50893, float* _49593_50894, float* _49594_50895, float* _49595_50896) {
    int  _50899;
    int p_50899;
    int  _50902;
    int p_50902;
    int  _50905;
    int p_50905;
    int  _50908;
    int p_50908;
    int  _50911;
    int p_50911;
    int  _50914;
    int p_50914;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _50899 = blockIdx_x();
    p_50899 = _50899;
    l50897: ;
        _50899 = p_50899;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50902 = blockDim_x();
        p_50902 = _50902;
    l50900: ;
        _50902 = p_50902;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50905 = threadIdx_x();
        p_50905 = _50905;
    l50903: ;
        _50905 = p_50905;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50908 = blockIdx_y();
        p_50908 = _50908;
    l50906: ;
        _50908 = p_50908;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50911 = blockDim_y();
        p_50911 = _50911;
    l50909: ;
        _50911 = p_50911;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50914 = threadIdx_y();
        p_50914 = _50914;
    l50912: ;
        _50914 = p_50914;
        #line 153 "gpu_device.impala"
        int _50915;
        _50915 = _50899 * _50902;
        #line 153 "gpu_device.impala"
        int x_50916;
        x_50916 = _50915 + _50905;
        #line 156 "gpu_device.impala"
        bool _50917;
        _50917 = 1 < x_50916;
        #line 156 "gpu_device.impala"
        if (_50917) goto l50918; else goto l51051;
    l51051: ;
        #line 158 "gpu_device.impala"
        goto l51048;
    l50918: ;
        #line 427 "dsl.impala"
        int _50919;
        _50919 = _49592_50893.e1;
        #line 123 "gpu_device.impala"
        int _50920;
        _50920 = _50919 - 2;
        #line 156 "gpu_device.impala"
        bool _50921;
        _50921 = x_50916 < _50920;
        #line 156 "gpu_device.impala"
        if (_50921) goto l50922; else goto l51050;
    l51050: ;
        #line 158 "gpu_device.impala"
        goto l51048;
    l50922: ;
        #line 154 "gpu_device.impala"
        int _50923;
        _50923 = _50908 * _50911;
        #line 154 "gpu_device.impala"
        int y_50924;
        y_50924 = _50923 + _50914;
        #line 156 "gpu_device.impala"
        bool _50925;
        _50925 = 1 < y_50924;
        #line 156 "gpu_device.impala"
        if (_50925) goto l50926; else goto l51049;
    l51049: ;
        #line 158 "gpu_device.impala"
        goto l51048;
    l50926: ;
        #line 511 "dsl.impala"
        int _50927;
        _50927 = _49592_50893.e2;
        #line 341 "dsl.impala"
        int _50928;
        _50928 = _50927 - 2;
        #line 156 "gpu_device.impala"
        bool _50929;
        _50929 = y_50924 < _50928;
        #line 156 "gpu_device.impala"
        if (_50929) goto l50930; else goto l51047;
    l51047: ;
        #line 158 "gpu_device.impala"
        goto l51048;
    l51048: ;
        return ;
    l50930: ;
        #line 508 "dsl.impala"
        int _50932;
        _50932 = 2 * _50919;
        #line 370 "dsl.impala"
        int _50931;
        _50931 = y_50924 * _50919;
        #line 157 "gpu_device.impala"
        int _50933;
        _50933 = x_50916 + _50932;
        #line 370 "dsl.impala"
        int pos_50934;
        pos_50934 = _50931 + _50933;
        #line 157 "gpu_device.impala"
        int _51013;
        _51013 = 5 + _50933;
        #line 370 "dsl.impala"
        int pos_50935;
        pos_50935 = 5 + pos_50934;
        #line 15 "gpu_device.impala"
        float* i_51023;
        i_51023 = _49594_50895 + pos_50935;
        #line 11 "gpu_device.impala"
        float* i_50992;
        i_50992 = _49590_50891 + pos_50935;
        #line 11 "gpu_device.impala"
        float* i_50939;
        i_50939 = _49593_50894 + pos_50935;
        #line 11 "gpu_device.impala"
        float* i_50936;
        i_50936 = _49595_50896 + pos_50935;
        #line 12 "gpu_device.impala"
        float _50937;
        _50937 = *i_50936;
        #line 12 "gpu_device.impala"
        float _50955;
        _50955 = _50937;
        #line 12 "gpu_device.impala"
        float _50940;
        _50940 = *i_50939;
        #line 371 "dsl.impala"
        int xs_50956;
        xs_50956 = (int)_50955;
        #line 12 "gpu_device.impala"
        float _50942;
        _50942 = _50940;
        #line 166 "dsl.impala"
        bool _50961;
        _50961 = xs_50956 < 0;
        #line 165 "dsl.impala"
        bool _50957;
        _50957 = 0 <= xs_50956;
        #line 166 "dsl.impala"
        int _50960;
        _50960 = 0 - xs_50956;
        #line 372 "dsl.impala"
        int ys_50943;
        ys_50943 = (int)_50942;
        #line 166 "dsl.impala"
        int _50962;
        _50962 = (int)_50961;
        #line 165 "dsl.impala"
        int _50958;
        _50958 = (int)_50957;
        #line 166 "dsl.impala"
        int _50963;
        _50963 = _50960 * _50962;
        #line 166 "dsl.impala"
        bool _50948;
        _50948 = ys_50943 < 0;
        #line 166 "dsl.impala"
        int _50947;
        _50947 = 0 - ys_50943;
        #line 381 "dsl.impala"
        int _50976;
        _50976 = xs_50956 ^ ys_50943;
        #line 165 "dsl.impala"
        bool _50944;
        _50944 = 0 <= ys_50943;
        #line 165 "dsl.impala"
        int _50959;
        _50959 = xs_50956 * _50958;
        #line 165 "dsl.impala"
        int _50964;
        _50964 = _50959 + _50963;
        #line 166 "dsl.impala"
        int _50949;
        _50949 = (int)_50948;
        #line 166 "dsl.impala"
        int _50950;
        _50950 = _50947 * _50949;
        #line 381 "dsl.impala"
        bool _50977;
        _50977 = _50976 < 0;
        #line 165 "dsl.impala"
        int _50945;
        _50945 = (int)_50944;
        #line 376 "dsl.impala"
        int tg22x_50965;
        tg22x_50965 = 13573 * _50964;
        #line 377 "dsl.impala"
        int _50970;
        _50970 = _50964 << 16;
        #line 381 "dsl.impala"
        int cond3_50978;
        cond3_50978 = (int)_50977;
        #line 165 "dsl.impala"
        int _50946;
        _50946 = ys_50943 * _50945;
        #line 377 "dsl.impala"
        int tg67x_50971;
        tg67x_50971 = tg22x_50965 + _50970;
        #line 165 "dsl.impala"
        int _50951;
        _50951 = _50946 + _50950;
        #line 374 "dsl.impala"
        int my_50953;
        my_50953 = _50951 << 15;
        #line 379 "dsl.impala"
        bool _50966;
        _50966 = my_50953 < tg22x_50965;
        #line 380 "dsl.impala"
        bool _50972;
        _50972 = tg67x_50971 < my_50953;
        #line 379 "dsl.impala"
        int cond1_50967;
        cond1_50967 = (int)_50966;
        #line 380 "dsl.impala"
        int cond2_50973;
        cond2_50973 = (int)_50972;
        #line 383 "dsl.impala"
        int _50968;
        _50968 = cond1_50967 << 2;
        #line 383 "dsl.impala"
        int _50974;
        _50974 = cond2_50973 << 1;
        #line 383 "dsl.impala"
        int _50975;
        _50975 = _50968 + _50974;
        #line 383 "dsl.impala"
        int index_50979;
        index_50979 = _50975 + cond3_50978;
        #line 384 "dsl.impala"
        int _50980;
        _50980 = 2 * index_50979;
        #line 385 "dsl.impala"
        int _50984;
        _50984 = 1 + _50980;
        #line 11 "gpu_device.impala"
        float* i_50981;
        i_50981 = _49591_50892 + _50980;
        #line 11 "gpu_device.impala"
        float* i_50985;
        i_50985 = _49591_50892 + _50984;
        #line 12 "gpu_device.impala"
        float _50982;
        _50982 = *i_50981;
        #line 12 "gpu_device.impala"
        float _50999;
        _50999 = _50982;
        #line 384 "dsl.impala"
        int _51000;
        _51000 = (int)_50999;
        #line 12 "gpu_device.impala"
        float _50986;
        _50986 = *i_50985;
        #line 384 "dsl.impala"
        int nb1_x_51001;
        nb1_x_51001 = _50933 + _51000;
        #line 12 "gpu_device.impala"
        float _50995;
        _50995 = _50986;
        #line 12 "gpu_device.impala"
        float _50988;
        _50988 = *i_50981;
        #line 385 "dsl.impala"
        int _50996;
        _50996 = (int)_50995;
        #line 12 "gpu_device.impala"
        float _51014;
        _51014 = _50988;
        #line 385 "dsl.impala"
        int nb1_y_50997;
        nb1_y_50997 = y_50924 + _50996;
        #line 386 "dsl.impala"
        int _51015;
        _51015 = (int)_51014;
        #line 12 "gpu_device.impala"
        float _50990;
        _50990 = *i_50985;
        #line 390 "dsl.impala"
        int _50998;
        _50998 = nb1_y_50997 * _50919;
        #line 386 "dsl.impala"
        int nb2_x_51016;
        nb2_x_51016 = _51013 - _51015;
        #line 12 "gpu_device.impala"
        float _51009;
        _51009 = _50990;
        #line 390 "dsl.impala"
        int _51002;
        _51002 = _50998 + nb1_x_51001;
        #line 12 "gpu_device.impala"
        float _50993;
        _50993 = *i_50992;
        #line 387 "dsl.impala"
        int _51010;
        _51010 = (int)_51009;
        #line 390 "dsl.impala"
        int _51003;
        _51003 = 5 + _51002;
        #line 12 "gpu_device.impala"
        float _51037;
        _51037 = _50993;
        #line 387 "dsl.impala"
        int nb2_y_51011;
        nb2_y_51011 = y_50924 - _51010;
        #line 11 "gpu_device.impala"
        float* i_51004;
        i_51004 = _49590_50891 + _51003;
        #line 12 "gpu_device.impala"
        float _51005;
        _51005 = *i_51004;
        #line 394 "dsl.impala"
        int _51012;
        _51012 = nb2_y_51011 * _50919;
        #line 12 "gpu_device.impala"
        float _51036;
        _51036 = _51005;
        #line 394 "dsl.impala"
        int _51017;
        _51017 = _51012 + nb2_x_51016;
        #line 390 "dsl.impala"
        bool _51038;
        _51038 = _51036 < _51037;
        #line 12 "gpu_device.impala"
        float _51007;
        _51007 = *i_50992;
        #line 11 "gpu_device.impala"
        float* i_51018;
        i_51018 = _49590_50891 + _51017;
        #line 389 "dsl.impala"
        float nb1_cond_51039;
        nb1_cond_51039 = (float)_51038;
        #line 12 "gpu_device.impala"
        float _51042;
        _51042 = _51007;
        #line 12 "gpu_device.impala"
        float _51019;
        _51019 = *i_51018;
        #line 12 "gpu_device.impala"
        float _51041;
        _51041 = _51019;
        #line 12 "gpu_device.impala"
        float _51021;
        _51021 = *i_50992;
        #line 394 "dsl.impala"
        bool _51043;
        _51043 = _51041 < _51042;
        #line 12 "gpu_device.impala"
        float _51026;
        _51026 = _51021;
        #line 393 "dsl.impala"
        float nb2_cond_51044;
        nb2_cond_51044 = (float)_51043;
        #line 414 "dsl.impala"
        bool _51027;
        _51027 = 1.600000e+03f < _51026;
        #line 415 "dsl.impala"
        bool _51032;
        _51032 = 1.440000e+04f < _51026;
        #line 414 "dsl.impala"
        float _51028;
        _51028 = (float)_51027;
        #line 415 "dsl.impala"
        float _51033;
        _51033 = (float)_51032;
        #line 414 "dsl.impala"
        float _51029;
        _51029 = 1.000000e+00f * _51028;
        #line 415 "dsl.impala"
        float _51034;
        _51034 = 1.400000e+01f * _51033;
        #line 414 "dsl.impala"
        float _51035;
        _51035 = _51029 + _51034;
        #line 413 "dsl.impala"
        float _51040;
        _51040 = _51035 * nb1_cond_51039;
        #line 413 "dsl.impala"
        float _51045;
        _51045 = _51040 * nb2_cond_51044;
        #line 16 "gpu_device.impala"
        *i_51023 = _51045;
        return ;
}

__global__ void lambda_49385(float* _49388_50707, float* _49389_50708, struct_10055 _49390_50709, float* _49391_50710, float* _49392_50711) {
    int  _50714;
    int p_50714;
    int  _50717;
    int p_50717;
    int  _50720;
    int p_50720;
    int  _50723;
    int p_50723;
    int  _50726;
    int p_50726;
    int  _50729;
    int p_50729;
    bool  converge_50758;
    bool pconverge_50758;
    bool  converge_50760;
    bool pconverge_50760;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _50714 = blockIdx_x();
    p_50714 = _50714;
    l50712: ;
        _50714 = p_50714;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50717 = blockDim_x();
        p_50717 = _50717;
    l50715: ;
        _50717 = p_50717;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50720 = threadIdx_x();
        p_50720 = _50720;
    l50718: ;
        _50720 = p_50720;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50723 = blockIdx_y();
        p_50723 = _50723;
    l50721: ;
        _50723 = p_50723;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50726 = blockDim_y();
        p_50726 = _50726;
    l50724: ;
        _50726 = p_50726;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50729 = threadIdx_y();
        p_50729 = _50729;
    l50727: ;
        _50729 = p_50729;
        #line 153 "gpu_device.impala"
        int _50730;
        _50730 = _50714 * _50717;
        #line 153 "gpu_device.impala"
        int x_50731;
        x_50731 = _50730 + _50720;
        #line 156 "gpu_device.impala"
        bool _50732;
        _50732 = 1 < x_50731;
        #line 156 "gpu_device.impala"
        if (_50732) goto l50733; else goto l50887;
    l50887: ;
        #line 158 "gpu_device.impala"
        goto l50884;
    l50733: ;
        #line 427 "dsl.impala"
        int _50734;
        _50734 = _49390_50709.e1;
        #line 123 "gpu_device.impala"
        int _50735;
        _50735 = _50734 - 2;
        #line 156 "gpu_device.impala"
        bool _50736;
        _50736 = x_50731 < _50735;
        #line 156 "gpu_device.impala"
        if (_50736) goto l50737; else goto l50886;
    l50886: ;
        #line 158 "gpu_device.impala"
        goto l50884;
    l50737: ;
        #line 154 "gpu_device.impala"
        int _50738;
        _50738 = _50723 * _50726;
        #line 154 "gpu_device.impala"
        int y_50739;
        y_50739 = _50738 + _50729;
        #line 156 "gpu_device.impala"
        bool _50740;
        _50740 = 1 < y_50739;
        #line 156 "gpu_device.impala"
        if (_50740) goto l50741; else goto l50885;
    l50885: ;
        #line 158 "gpu_device.impala"
        goto l50884;
    l50741: ;
        #line 511 "dsl.impala"
        int _50742;
        _50742 = _49390_50709.e2;
        #line 341 "dsl.impala"
        int _50743;
        _50743 = _50742 - 2;
        #line 156 "gpu_device.impala"
        bool _50744;
        _50744 = y_50739 < _50743;
        #line 156 "gpu_device.impala"
        if (_50744) goto l50745; else goto l50883;
    l50883: ;
        #line 158 "gpu_device.impala"
        goto l50884;
    l50884: ;
        return ;
    l50745: ;
        #line 508 "dsl.impala"
        int _50746;
        _50746 = 2 * _50734;
        #line 340 "dsl.impala"
        int _50747;
        _50747 = 5 + _50746;
        #line 157 "gpu_device.impala"
        int _50748;
        _50748 = x_50731 + _50746;
        #line 157 "gpu_device.impala"
        int _50749;
        _50749 = 5 + _50748;
        #line 340 "dsl.impala"
        bool _50750;
        _50750 = _50747 < _50749;
        #line 340 "dsl.impala"
        if (_50750) goto l50751; else goto l50882;
    l50882: ;
        #line 341 "dsl.impala"
        goto l50881;
    l50751: ;
        #line 340 "dsl.impala"
        int _50752;
        _50752 = 3 * _50734;
        #line 340 "dsl.impala"
        int _50753;
        _50753 = 4 + _50752;
        #line 340 "dsl.impala"
        bool _50754;
        _50754 = _50749 < _50753;
        #line 340 "dsl.impala"
        if (_50754) goto l50755; else goto l50880;
    l50880: ;
        #line 341 "dsl.impala"
        goto l50881;
    l50881: ;
        #line 341 "dsl.impala"
        pconverge_50760 = false;
        goto l50759;
    l50755: ;
        #line 156 "gpu_device.impala"
        if (_50740) goto l50756; else goto l50878;
    l50878: ;
        #line 341 "dsl.impala"
        pconverge_50758 = false;
        goto l50757;
    l50756: ;
        #line 341 "dsl.impala"
        pconverge_50758 = _50744;
        goto l50757;
    l50757: ;
        converge_50758 = pconverge_50758;
        #line 341 "dsl.impala"
        pconverge_50760 = converge_50758;
        goto l50759;
    l50759: ;
        converge_50760 = pconverge_50760;
        #line 266 "dsl.impala"
        int _50766;
        _50766 = y_50739 - 1;
        #line 278 "dsl.impala"
        int _50785;
        _50785 = 1 + y_50739;
        #line 339 "dsl.impala"
        float condition_50859;
        condition_50859 = (float)converge_50760;
        #line 266 "dsl.impala"
        int _50768;
        _50768 = _50749 - 1;
        #line 261 "dsl.impala"
        int _50761;
        _50761 = y_50739 * _50734;
        #line 272 "dsl.impala"
        int _50776;
        _50776 = _50761 + _50768;
        #line 278 "dsl.impala"
        int _50786;
        _50786 = _50785 * _50734;
        #line 261 "dsl.impala"
        int _50762;
        _50762 = _50761 + _50748;
        #line 296 "dsl.impala"
        int _50810;
        _50810 = _50786 + _50748;
        #line 266 "dsl.impala"
        int _50767;
        _50767 = _50766 * _50734;
        #line 11 "gpu_device.impala"
        float* i_50777;
        i_50777 = _49389_50708 + _50776;
        #line 278 "dsl.impala"
        int _50787;
        _50787 = _50786 + _50768;
        #line 266 "dsl.impala"
        int _50769;
        _50769 = _50767 + _50768;
        #line 261 "dsl.impala"
        int _50763;
        _50763 = 5 + _50762;
        #line 290 "dsl.impala"
        int _50802;
        _50802 = 6 + _50762;
        #line 296 "dsl.impala"
        int _50811;
        _50811 = 6 + _50810;
        #line 296 "dsl.impala"
        int _50843;
        _50843 = 5 + _50810;
        #line 284 "dsl.impala"
        int _50794;
        _50794 = _50767 + _50748;
        #line 11 "gpu_device.impala"
        float* i_50788;
        i_50788 = _49389_50708 + _50787;
        #line 11 "gpu_device.impala"
        float* i_50770;
        i_50770 = _49389_50708 + _50769;
        #line 15 "gpu_device.impala"
        float* i_50871;
        i_50871 = _49392_50711 + _50763;
        #line 15 "gpu_device.impala"
        float* i_50818;
        i_50818 = _49388_50707 + _50763;
        #line 15 "gpu_device.impala"
        float* i_50764;
        i_50764 = _49391_50710 + _50763;
        #line 11 "gpu_device.impala"
        float* i_50803;
        i_50803 = _49389_50708 + _50802;
        #line 11 "gpu_device.impala"
        float* i_50812;
        i_50812 = _49389_50708 + _50811;
        #line 11 "gpu_device.impala"
        float* i_50844;
        i_50844 = _49389_50708 + _50843;
        #line 284 "dsl.impala"
        int _50795;
        _50795 = 6 + _50794;
        #line 284 "dsl.impala"
        int _50825;
        _50825 = 5 + _50794;
        #line 16 "gpu_device.impala"
        *i_50764 = 0.000000e+00f;
        #line 11 "gpu_device.impala"
        float* i_50796;
        i_50796 = _49389_50708 + _50795;
        #line 11 "gpu_device.impala"
        float* i_50826;
        i_50826 = _49389_50708 + _50825;
        #line 12 "gpu_device.impala"
        float _50771;
        _50771 = *i_50770;
        #line 12 "gpu_device.impala"
        float _50773;
        _50773 = _50771;
        #line 265 "dsl.impala"
        float _50774;
        _50774 = 0.000000e+00f - _50773;
        #line 16 "gpu_device.impala"
        *i_50764 = _50774;
        #line 12 "gpu_device.impala"
        float _50778;
        _50778 = *i_50777;
        #line 12 "gpu_device.impala"
        float _50781;
        _50781 = _50778;
        #line 272 "dsl.impala"
        float _50782;
        _50782 = 2.000000e+00f * _50781;
        #line 271 "dsl.impala"
        float _50783;
        _50783 = _50774 - _50782;
        #line 16 "gpu_device.impala"
        *i_50764 = _50783;
        #line 12 "gpu_device.impala"
        float _50789;
        _50789 = *i_50788;
        #line 12 "gpu_device.impala"
        float _50791;
        _50791 = _50789;
        #line 277 "dsl.impala"
        float _50792;
        _50792 = _50783 - _50791;
        #line 16 "gpu_device.impala"
        *i_50764 = _50792;
        #line 12 "gpu_device.impala"
        float _50797;
        _50797 = *i_50796;
        #line 12 "gpu_device.impala"
        float _50799;
        _50799 = _50797;
        #line 283 "dsl.impala"
        float _50800;
        _50800 = _50792 + _50799;
        #line 16 "gpu_device.impala"
        *i_50764 = _50800;
        #line 12 "gpu_device.impala"
        float _50804;
        _50804 = *i_50803;
        #line 12 "gpu_device.impala"
        float _50806;
        _50806 = _50804;
        #line 290 "dsl.impala"
        float _50807;
        _50807 = 2.000000e+00f * _50806;
        #line 289 "dsl.impala"
        float _50808;
        _50808 = _50800 + _50807;
        #line 16 "gpu_device.impala"
        *i_50764 = _50808;
        #line 12 "gpu_device.impala"
        float _50813;
        _50813 = *i_50812;
        #line 12 "gpu_device.impala"
        float _50815;
        _50815 = _50813;
        #line 295 "dsl.impala"
        float _50816;
        _50816 = _50808 + _50815;
        #line 16 "gpu_device.impala"
        *i_50764 = _50816;
        #line 16 "gpu_device.impala"
        *i_50818 = 0.000000e+00f;
        #line 12 "gpu_device.impala"
        float _50820;
        _50820 = *i_50770;
        #line 12 "gpu_device.impala"
        float _50822;
        _50822 = _50820;
        #line 304 "dsl.impala"
        float _50823;
        _50823 = 0.000000e+00f - _50822;
        #line 16 "gpu_device.impala"
        *i_50818 = _50823;
        #line 12 "gpu_device.impala"
        float _50827;
        _50827 = *i_50826;
        #line 12 "gpu_device.impala"
        float _50829;
        _50829 = _50827;
        #line 311 "dsl.impala"
        float _50830;
        _50830 = 2.000000e+00f * _50829;
        #line 310 "dsl.impala"
        float _50831;
        _50831 = _50823 - _50830;
        #line 16 "gpu_device.impala"
        *i_50818 = _50831;
        #line 12 "gpu_device.impala"
        float _50833;
        _50833 = *i_50796;
        #line 12 "gpu_device.impala"
        float _50835;
        _50835 = _50833;
        #line 316 "dsl.impala"
        float _50836;
        _50836 = _50831 - _50835;
        #line 16 "gpu_device.impala"
        *i_50818 = _50836;
        #line 12 "gpu_device.impala"
        float _50838;
        _50838 = *i_50788;
        #line 12 "gpu_device.impala"
        float _50840;
        _50840 = _50838;
        #line 322 "dsl.impala"
        float _50841;
        _50841 = _50836 + _50840;
        #line 16 "gpu_device.impala"
        *i_50818 = _50841;
        #line 12 "gpu_device.impala"
        float _50845;
        _50845 = *i_50844;
        #line 12 "gpu_device.impala"
        float _50847;
        _50847 = _50845;
        #line 329 "dsl.impala"
        float _50848;
        _50848 = 2.000000e+00f * _50847;
        #line 328 "dsl.impala"
        float _50849;
        _50849 = _50841 + _50848;
        #line 16 "gpu_device.impala"
        *i_50818 = _50849;
        #line 12 "gpu_device.impala"
        float _50851;
        _50851 = *i_50812;
        #line 12 "gpu_device.impala"
        float _50853;
        _50853 = _50851;
        #line 334 "dsl.impala"
        float _50854;
        _50854 = _50849 + _50853;
        #line 16 "gpu_device.impala"
        *i_50818 = _50854;
        #line 12 "gpu_device.impala"
        float _50856;
        _50856 = *i_50764;
        #line 12 "gpu_device.impala"
        float _50858;
        _50858 = _50856;
        #line 346 "dsl.impala"
        float _50860;
        _50860 = _50858 * condition_50859;
        #line 16 "gpu_device.impala"
        *i_50764 = _50860;
        #line 12 "gpu_device.impala"
        float _50862;
        _50862 = *i_50818;
        #line 12 "gpu_device.impala"
        float _50864;
        _50864 = _50862;
        #line 351 "dsl.impala"
        float _50865;
        _50865 = _50864 * condition_50859;
        #line 16 "gpu_device.impala"
        *i_50818 = _50865;
        #line 12 "gpu_device.impala"
        float _50867;
        _50867 = *i_50764;
        #line 12 "gpu_device.impala"
        float _50872;
        _50872 = _50867;
        #line 12 "gpu_device.impala"
        float _50869;
        _50869 = *i_50818;
        #line 356 "dsl.impala"
        float _50873;
        _50873 = _50872 * _50872;
        #line 12 "gpu_device.impala"
        float _50874;
        _50874 = _50869;
        #line 357 "dsl.impala"
        float _50875;
        _50875 = _50874 * _50874;
        #line 356 "dsl.impala"
        float _50876;
        _50876 = _50873 + _50875;
        #line 16 "gpu_device.impala"
        *i_50871 = _50876;
        return ;
}

__global__ void lambda_48861() {
    int  _50423;
    int p_50423;
    int  _50429;
    int p_50429;
    int  _50435;
    int p_50435;
    int  _50441;
    int p_50441;
    int  _50447;
    int p_50447;
    int  _50453;
    int p_50453;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _50423 = blockIdx_x();
    p_50423 = _50423;
    l50421: ;
        _50423 = p_50423;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50429 = blockDim_x();
        p_50429 = _50429;
    l50427: ;
        _50429 = p_50429;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50435 = threadIdx_x();
        p_50435 = _50435;
    l50433: ;
        _50435 = p_50435;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50441 = blockIdx_y();
        p_50441 = _50441;
    l50439: ;
        _50441 = p_50441;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50447 = blockDim_y();
        p_50447 = _50447;
    l50445: ;
        _50447 = p_50447;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50453 = threadIdx_y();
        p_50453 = _50453;
    l50451: ;
        _50453 = p_50453;
        return ;
}

__global__ void lambda_49241(float* _49244_50581, float* _49245_50582, struct_10055 _49246_50583, float* _49247_50584) {
    int  _50587;
    int p_50587;
    int  _50590;
    int p_50590;
    int  _50593;
    int p_50593;
    int  _50596;
    int p_50596;
    int  _50599;
    int p_50599;
    int  _50602;
    int p_50602;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _50587 = blockIdx_x();
    p_50587 = _50587;
    l50585: ;
        _50587 = p_50587;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50590 = blockDim_x();
        p_50590 = _50590;
    l50588: ;
        _50590 = p_50590;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50593 = threadIdx_x();
        p_50593 = _50593;
    l50591: ;
        _50593 = p_50593;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50596 = blockIdx_y();
        p_50596 = _50596;
    l50594: ;
        _50596 = p_50596;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50599 = blockDim_y();
        p_50599 = _50599;
    l50597: ;
        _50599 = p_50599;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _50602 = threadIdx_y();
        p_50602 = _50602;
    l50600: ;
        _50602 = p_50602;
        #line 120 "gpu_device.impala"
        int _50603;
        _50603 = _50587 * _50590;
        #line 120 "gpu_device.impala"
        int x_50604;
        x_50604 = _50603 + _50593;
        #line 123 "gpu_device.impala"
        bool _50605;
        _50605 = 1 < x_50604;
        #line 123 "gpu_device.impala"
        if (_50605) goto l50606; else goto l50703;
    l50703: ;
        #line 125 "gpu_device.impala"
        goto l50700;
    l50606: ;
        #line 427 "dsl.impala"
        int _50607;
        _50607 = _49246_50583.e1;
        #line 123 "gpu_device.impala"
        int _50608;
        _50608 = _50607 - 2;
        #line 123 "gpu_device.impala"
        bool _50609;
        _50609 = x_50604 < _50608;
        #line 123 "gpu_device.impala"
        if (_50609) goto l50610; else goto l50702;
    l50702: ;
        #line 125 "gpu_device.impala"
        goto l50700;
    l50610: ;
        #line 121 "gpu_device.impala"
        int _50611;
        _50611 = _50596 * _50599;
        #line 121 "gpu_device.impala"
        int y_50612;
        y_50612 = _50611 + _50602;
        #line 123 "gpu_device.impala"
        bool _50613;
        _50613 = 1 < y_50612;
        #line 123 "gpu_device.impala"
        if (_50613) goto l50614; else goto l50701;
    l50701: ;
        #line 125 "gpu_device.impala"
        goto l50700;
    l50614: ;
        #line 511 "dsl.impala"
        int _50615;
        _50615 = _49246_50583.e2;
        #line 341 "dsl.impala"
        int _50616;
        _50616 = _50615 - 2;
        #line 123 "gpu_device.impala"
        bool _50617;
        _50617 = y_50612 < _50616;
        #line 123 "gpu_device.impala"
        if (_50617) goto l50618; else goto l50699;
    l50699: ;
        #line 125 "gpu_device.impala"
        goto l50700;
    l50700: ;
        return ;
    l50618: ;
        #line 209 "dsl.impala"
        int _50687;
        _50687 = 2 + y_50612;
        #line 209 "dsl.impala"
        int _50646;
        _50646 = -1 + y_50612;
        #line 209 "dsl.impala"
        int _50672;
        _50672 = 1 + y_50612;
        #line 11 "gpu_device.impala"
        float* i_50626;
        i_50626 = _49244_50581 + 0;
        #line 11 "gpu_device.impala"
        float* i_50684;
        i_50684 = _49244_50581 + 4;
        #line 209 "dsl.impala"
        int _50688;
        _50688 = _50687 * _50607;
        #line 11 "gpu_device.impala"
        float* i_50669;
        i_50669 = _49244_50581 + 3;
        #line 508 "dsl.impala"
        int _50620;
        _50620 = 2 * _50607;
        #line 209 "dsl.impala"
        int _50630;
        _50630 = -2 + y_50612;
        #line 11 "gpu_device.impala"
        float* i_50642;
        i_50642 = _49244_50581 + 1;
        #line 11 "gpu_device.impala"
        float* i_50658;
        i_50658 = _49244_50581 + 2;
        #line 204 "dsl.impala"
        int _50619;
        _50619 = y_50612 * _50607;
        #line 209 "dsl.impala"
        int _50647;
        _50647 = _50646 * _50607;
        #line 209 "dsl.impala"
        int _50673;
        _50673 = _50672 * _50607;
        #line 209 "dsl.impala"
        int _50631;
        _50631 = _50630 * _50607;
        #line 124 "gpu_device.impala"
        int _50621;
        _50621 = x_50604 + _50620;
        #line 204 "dsl.impala"
        int _50622;
        _50622 = _50619 + _50621;
        #line 209 "dsl.impala"
        int _50648;
        _50648 = _50647 + _50621;
        #line 209 "dsl.impala"
        int _50674;
        _50674 = _50673 + _50621;
        #line 209 "dsl.impala"
        int _50632;
        _50632 = _50631 + _50621;
        #line 209 "dsl.impala"
        int _50689;
        _50689 = _50688 + _50621;
        #line 204 "dsl.impala"
        int _50623;
        _50623 = 5 + _50622;
        #line 209 "dsl.impala"
        int _50649;
        _50649 = 5 + _50648;
        #line 209 "dsl.impala"
        int _50675;
        _50675 = 5 + _50674;
        #line 209 "dsl.impala"
        int _50633;
        _50633 = 5 + _50632;
        #line 209 "dsl.impala"
        int _50690;
        _50690 = 5 + _50689;
        #line 15 "gpu_device.impala"
        float* i_50624;
        i_50624 = _49245_50582 + _50623;
        #line 11 "gpu_device.impala"
        float* i_50661;
        i_50661 = _49247_50584 + _50623;
        #line 11 "gpu_device.impala"
        float* i_50650;
        i_50650 = _49247_50584 + _50649;
        #line 11 "gpu_device.impala"
        float* i_50676;
        i_50676 = _49247_50584 + _50675;
        #line 11 "gpu_device.impala"
        float* i_50634;
        i_50634 = _49247_50584 + _50633;
        #line 11 "gpu_device.impala"
        float* i_50691;
        i_50691 = _49247_50584 + _50690;
        #line 16 "gpu_device.impala"
        *i_50624 = 0.000000e+00f;
        #line 12 "gpu_device.impala"
        float _50627;
        _50627 = *i_50626;
        #line 12 "gpu_device.impala"
        float _50637;
        _50637 = _50627;
        #line 12 "gpu_device.impala"
        float _50635;
        _50635 = *i_50634;
        #line 12 "gpu_device.impala"
        float _50638;
        _50638 = _50635;
        #line 209 "dsl.impala"
        float _50639;
        _50639 = _50637 * _50638;
        #line 208 "dsl.impala"
        float _50640;
        _50640 = 0.000000e+00f + _50639;
        #line 16 "gpu_device.impala"
        *i_50624 = _50640;
        #line 12 "gpu_device.impala"
        float _50643;
        _50643 = *i_50642;
        #line 12 "gpu_device.impala"
        float _50653;
        _50653 = _50643;
        #line 12 "gpu_device.impala"
        float _50651;
        _50651 = *i_50650;
        #line 12 "gpu_device.impala"
        float _50654;
        _50654 = _50651;
        #line 209 "dsl.impala"
        float _50655;
        _50655 = _50653 * _50654;
        #line 208 "dsl.impala"
        float _50656;
        _50656 = _50640 + _50655;
        #line 16 "gpu_device.impala"
        *i_50624 = _50656;
        #line 12 "gpu_device.impala"
        float _50659;
        _50659 = *i_50658;
        #line 12 "gpu_device.impala"
        float _50664;
        _50664 = _50659;
        #line 12 "gpu_device.impala"
        float _50662;
        _50662 = *i_50661;
        #line 12 "gpu_device.impala"
        float _50665;
        _50665 = _50662;
        #line 209 "dsl.impala"
        float _50666;
        _50666 = _50664 * _50665;
        #line 208 "dsl.impala"
        float _50667;
        _50667 = _50656 + _50666;
        #line 16 "gpu_device.impala"
        *i_50624 = _50667;
        #line 12 "gpu_device.impala"
        float _50670;
        _50670 = *i_50669;
        #line 12 "gpu_device.impala"
        float _50679;
        _50679 = _50670;
        #line 12 "gpu_device.impala"
        float _50677;
        _50677 = *i_50676;
        #line 12 "gpu_device.impala"
        float _50680;
        _50680 = _50677;
        #line 209 "dsl.impala"
        float _50681;
        _50681 = _50679 * _50680;
        #line 208 "dsl.impala"
        float _50682;
        _50682 = _50667 + _50681;
        #line 16 "gpu_device.impala"
        *i_50624 = _50682;
        #line 12 "gpu_device.impala"
        float _50685;
        _50685 = *i_50684;
        #line 12 "gpu_device.impala"
        float _50694;
        _50694 = _50685;
        #line 12 "gpu_device.impala"
        float _50692;
        _50692 = *i_50691;
        #line 12 "gpu_device.impala"
        float _50695;
        _50695 = _50692;
        #line 209 "dsl.impala"
        float _50696;
        _50696 = _50694 * _50695;
        #line 208 "dsl.impala"
        float _50697;
        _50697 = _50682 + _50696;
        #line 16 "gpu_device.impala"
        *i_50624 = _50697;
        return ;
}

}