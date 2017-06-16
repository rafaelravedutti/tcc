extern "C" {
typedef struct struct_12604 {
    int e0;
    char* e1;
} struct_12604;
typedef struct struct_12602 {
    float* e0;
    struct_12604 e1;
    struct_12604 e2;
    struct_12604 e3;
    struct_12604 e4;
    int e5;
    int e6;
} struct_12602;
typedef struct array_12689 {
    int e[2];
} array_12689;
typedef struct array_12690 {
    array_12689 e[7];
} array_12690;

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
__global__ void lambda_58814(float*, float*, float*, struct_12602);
__global__ void lambda_58390();
__global__ void lambda_58645(float*, float*, float*, struct_12602);
__global__ void lambda_58978(float*, float*, float*, float*, struct_12602);
__global__ void lambda_59217(float*, float*, float*, float*, struct_12602);

__global__ void lambda_58814(float* _58817_60498, float* _58818_60499, float* _58819_60500, struct_12602 _58820_60501) {
    int  _60504;
    int p_60504;
    int  _60507;
    int p_60507;
    int  _60510;
    int p_60510;
    int  _60513;
    int p_60513;
    int  _60516;
    int p_60516;
    int  _60519;
    int p_60519;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _60504 = blockIdx_x();
    p_60504 = _60504;
    l60502: ;
        _60504 = p_60504;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60507 = blockDim_x();
        p_60507 = _60507;
    l60505: ;
        _60507 = p_60507;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60510 = threadIdx_x();
        p_60510 = _60510;
    l60508: ;
        _60510 = p_60510;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60513 = blockIdx_y();
        p_60513 = _60513;
    l60511: ;
        _60513 = p_60513;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60516 = blockDim_y();
        p_60516 = _60516;
    l60514: ;
        _60516 = p_60516;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60519 = threadIdx_y();
        p_60519 = _60519;
    l60517: ;
        _60519 = p_60519;
        #line 88 "gpu_device.impala"
        int _60520;
        _60520 = _60504 * _60507;
        #line 88 "gpu_device.impala"
        int x_60521;
        x_60521 = _60520 + _60510;
        #line 91 "gpu_device.impala"
        bool _60522;
        _60522 = 1 < x_60521;
        #line 91 "gpu_device.impala"
        if (_60522) goto l60523; else goto l60620;
    l60620: ;
        #line 93 "gpu_device.impala"
        goto l60617;
    l60523: ;
        #line 410 "dsl.impala"
        int _60524;
        _60524 = _58820_60501.e5;
        #line 91 "gpu_device.impala"
        int _60525;
        _60525 = _60524 - 2;
        #line 91 "gpu_device.impala"
        bool _60526;
        _60526 = x_60521 < _60525;
        #line 91 "gpu_device.impala"
        if (_60526) goto l60527; else goto l60619;
    l60619: ;
        #line 93 "gpu_device.impala"
        goto l60617;
    l60527: ;
        #line 89 "gpu_device.impala"
        int _60528;
        _60528 = _60513 * _60516;
        #line 89 "gpu_device.impala"
        int y_60529;
        y_60529 = _60528 + _60519;
        #line 91 "gpu_device.impala"
        bool _60530;
        _60530 = 1 < y_60529;
        #line 91 "gpu_device.impala"
        if (_60530) goto l60531; else goto l60618;
    l60618: ;
        #line 93 "gpu_device.impala"
        goto l60617;
    l60531: ;
        #line 495 "dsl.impala"
        int _60532;
        _60532 = _58820_60501.e6;
        #line 322 "dsl.impala"
        int _60533;
        _60533 = _60532 - 2;
        #line 91 "gpu_device.impala"
        bool _60534;
        _60534 = y_60529 < _60533;
        #line 91 "gpu_device.impala"
        if (_60534) goto l60535; else goto l60616;
    l60616: ;
        #line 93 "gpu_device.impala"
        goto l60617;
    l60617: ;
        return ;
    l60535: ;
        #line 190 "dsl.impala"
        int _60563;
        _60563 = -1 + y_60529;
        #line 9 "gpu_device.impala"
        float* i_60575;
        i_60575 = _58817_60498 + 2;
        #line 185 "dsl.impala"
        int _60536;
        _60536 = y_60529 * _60524;
        #line 9 "gpu_device.impala"
        float* i_60559;
        i_60559 = _58817_60498 + 1;
        #line 190 "dsl.impala"
        int _60589;
        _60589 = 1 + y_60529;
        #line 9 "gpu_device.impala"
        float* i_60586;
        i_60586 = _58817_60498 + 3;
        #line 9 "gpu_device.impala"
        float* i_60601;
        i_60601 = _58817_60498 + 4;
        #line 492 "dsl.impala"
        int _60537;
        _60537 = 2 * _60524;
        #line 9 "gpu_device.impala"
        float* i_60543;
        i_60543 = _58817_60498 + 0;
        #line 190 "dsl.impala"
        int _60604;
        _60604 = 2 + y_60529;
        #line 190 "dsl.impala"
        int _60564;
        _60564 = _60563 * _60524;
        #line 92 "gpu_device.impala"
        int _60538;
        _60538 = x_60521 + _60537;
        #line 190 "dsl.impala"
        int _60547;
        _60547 = -2 + y_60529;
        #line 190 "dsl.impala"
        int _60548;
        _60548 = _60547 * _60524;
        #line 185 "dsl.impala"
        int _60539;
        _60539 = _60536 + _60538;
        #line 190 "dsl.impala"
        int _60590;
        _60590 = _60589 * _60524;
        #line 190 "dsl.impala"
        int _60605;
        _60605 = _60604 * _60524;
        #line 190 "dsl.impala"
        int _60565;
        _60565 = _60564 + _60538;
        #line 190 "dsl.impala"
        int _60549;
        _60549 = _60548 + _60538;
        #line 190 "dsl.impala"
        int _60606;
        _60606 = _60605 + _60538;
        #line 190 "dsl.impala"
        int _60591;
        _60591 = _60590 + _60538;
        #line 185 "dsl.impala"
        int _60540;
        _60540 = 5 + _60539;
        #line 190 "dsl.impala"
        int _60566;
        _60566 = 5 + _60565;
        #line 190 "dsl.impala"
        int _60550;
        _60550 = 5 + _60549;
        #line 190 "dsl.impala"
        int _60607;
        _60607 = 5 + _60606;
        #line 190 "dsl.impala"
        int _60592;
        _60592 = 5 + _60591;
        #line 13 "gpu_device.impala"
        float* i_60541;
        i_60541 = _58818_60499 + _60540;
        #line 9 "gpu_device.impala"
        float* i_60578;
        i_60578 = _58819_60500 + _60540;
        #line 9 "gpu_device.impala"
        float* i_60567;
        i_60567 = _58819_60500 + _60566;
        #line 9 "gpu_device.impala"
        float* i_60551;
        i_60551 = _58819_60500 + _60550;
        #line 9 "gpu_device.impala"
        float* i_60608;
        i_60608 = _58819_60500 + _60607;
        #line 9 "gpu_device.impala"
        float* i_60593;
        i_60593 = _58819_60500 + _60592;
        #line 14 "gpu_device.impala"
        *i_60541 = 0.000000e+00f;
        #line 10 "gpu_device.impala"
        float _60544;
        _60544 = *i_60543;
        #line 10 "gpu_device.impala"
        float _60554;
        _60554 = _60544;
        #line 10 "gpu_device.impala"
        float _60552;
        _60552 = *i_60551;
        #line 10 "gpu_device.impala"
        float _60555;
        _60555 = _60552;
        #line 190 "dsl.impala"
        float _60556;
        _60556 = _60554 * _60555;
        #line 189 "dsl.impala"
        float _60557;
        _60557 = 0.000000e+00f + _60556;
        #line 14 "gpu_device.impala"
        *i_60541 = _60557;
        #line 10 "gpu_device.impala"
        float _60560;
        _60560 = *i_60559;
        #line 10 "gpu_device.impala"
        float _60570;
        _60570 = _60560;
        #line 10 "gpu_device.impala"
        float _60568;
        _60568 = *i_60567;
        #line 10 "gpu_device.impala"
        float _60571;
        _60571 = _60568;
        #line 190 "dsl.impala"
        float _60572;
        _60572 = _60570 * _60571;
        #line 189 "dsl.impala"
        float _60573;
        _60573 = _60557 + _60572;
        #line 14 "gpu_device.impala"
        *i_60541 = _60573;
        #line 10 "gpu_device.impala"
        float _60576;
        _60576 = *i_60575;
        #line 10 "gpu_device.impala"
        float _60581;
        _60581 = _60576;
        #line 10 "gpu_device.impala"
        float _60579;
        _60579 = *i_60578;
        #line 10 "gpu_device.impala"
        float _60582;
        _60582 = _60579;
        #line 190 "dsl.impala"
        float _60583;
        _60583 = _60581 * _60582;
        #line 189 "dsl.impala"
        float _60584;
        _60584 = _60573 + _60583;
        #line 14 "gpu_device.impala"
        *i_60541 = _60584;
        #line 10 "gpu_device.impala"
        float _60587;
        _60587 = *i_60586;
        #line 10 "gpu_device.impala"
        float _60596;
        _60596 = _60587;
        #line 10 "gpu_device.impala"
        float _60594;
        _60594 = *i_60593;
        #line 10 "gpu_device.impala"
        float _60597;
        _60597 = _60594;
        #line 190 "dsl.impala"
        float _60598;
        _60598 = _60596 * _60597;
        #line 189 "dsl.impala"
        float _60599;
        _60599 = _60584 + _60598;
        #line 14 "gpu_device.impala"
        *i_60541 = _60599;
        #line 10 "gpu_device.impala"
        float _60602;
        _60602 = *i_60601;
        #line 10 "gpu_device.impala"
        float _60611;
        _60611 = _60602;
        #line 10 "gpu_device.impala"
        float _60609;
        _60609 = *i_60608;
        #line 10 "gpu_device.impala"
        float _60612;
        _60612 = _60609;
        #line 190 "dsl.impala"
        float _60613;
        _60613 = _60611 * _60612;
        #line 189 "dsl.impala"
        float _60614;
        _60614 = _60599 + _60613;
        #line 14 "gpu_device.impala"
        *i_60541 = _60614;
        return ;
}

__global__ void lambda_58390() {
    int  _60339;
    int p_60339;
    int  _60345;
    int p_60345;
    int  _60351;
    int p_60351;
    int  _60357;
    int p_60357;
    int  _60363;
    int p_60363;
    int  _60369;
    int p_60369;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _60339 = blockIdx_x();
    p_60339 = _60339;
    l60337: ;
        _60339 = p_60339;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60345 = blockDim_x();
        p_60345 = _60345;
    l60343: ;
        _60345 = p_60345;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60351 = threadIdx_x();
        p_60351 = _60351;
    l60349: ;
        _60351 = p_60351;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60357 = blockIdx_y();
        p_60357 = _60357;
    l60355: ;
        _60357 = p_60357;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60363 = blockDim_y();
        p_60363 = _60363;
    l60361: ;
        _60363 = p_60363;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60369 = threadIdx_y();
        p_60369 = _60369;
    l60367: ;
        _60369 = p_60369;
        return ;
}

__global__ void lambda_58645(float* _58648_60373, float* _58649_60374, float* _58650_60375, struct_12602 _58651_60376) {
    int  _60379;
    int p_60379;
    int  _60382;
    int p_60382;
    int  _60385;
    int p_60385;
    int  _60388;
    int p_60388;
    int  _60391;
    int p_60391;
    int  _60394;
    int p_60394;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _60379 = blockIdx_x();
    p_60379 = _60379;
    l60377: ;
        _60379 = p_60379;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60382 = blockDim_x();
        p_60382 = _60382;
    l60380: ;
        _60382 = p_60382;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60385 = threadIdx_x();
        p_60385 = _60385;
    l60383: ;
        _60385 = p_60385;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60388 = blockIdx_y();
        p_60388 = _60388;
    l60386: ;
        _60388 = p_60388;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60391 = blockDim_y();
        p_60391 = _60391;
    l60389: ;
        _60391 = p_60391;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60394 = threadIdx_y();
        p_60394 = _60394;
    l60392: ;
        _60394 = p_60394;
        #line 88 "gpu_device.impala"
        int _60396;
        _60396 = _60379 * _60382;
        #line 88 "gpu_device.impala"
        int x_60397;
        x_60397 = _60396 + _60385;
        #line 91 "gpu_device.impala"
        bool _60398;
        _60398 = 1 < x_60397;
        #line 91 "gpu_device.impala"
        if (_60398) goto l60399; else goto l60494;
    l60494: ;
        #line 93 "gpu_device.impala"
        goto l60491;
    l60399: ;
        #line 410 "dsl.impala"
        int _60401;
        _60401 = _58651_60376.e5;
        #line 91 "gpu_device.impala"
        int _60403;
        _60403 = _60401 - 2;
        #line 91 "gpu_device.impala"
        bool _60404;
        _60404 = x_60397 < _60403;
        #line 91 "gpu_device.impala"
        if (_60404) goto l60405; else goto l60493;
    l60493: ;
        #line 93 "gpu_device.impala"
        goto l60491;
    l60405: ;
        #line 89 "gpu_device.impala"
        int _60406;
        _60406 = _60388 * _60391;
        #line 89 "gpu_device.impala"
        int y_60407;
        y_60407 = _60406 + _60394;
        #line 91 "gpu_device.impala"
        bool _60408;
        _60408 = 1 < y_60407;
        #line 91 "gpu_device.impala"
        if (_60408) goto l60409; else goto l60492;
    l60492: ;
        #line 93 "gpu_device.impala"
        goto l60491;
    l60409: ;
        #line 495 "dsl.impala"
        int _60411;
        _60411 = _58651_60376.e6;
        #line 322 "dsl.impala"
        int _60412;
        _60412 = _60411 - 2;
        #line 91 "gpu_device.impala"
        bool _60413;
        _60413 = y_60407 < _60412;
        #line 91 "gpu_device.impala"
        if (_60413) goto l60414; else goto l60490;
    l60490: ;
        #line 93 "gpu_device.impala"
        goto l60491;
    l60491: ;
        return ;
    l60414: ;
        #line 170 "dsl.impala"
        int _60416;
        _60416 = y_60407 * _60401;
        #line 9 "gpu_device.impala"
        float* i_60425;
        i_60425 = _58650_60375 + 0;
        #line 9 "gpu_device.impala"
        float* i_60440;
        i_60440 = _58650_60375 + 1;
        #line 9 "gpu_device.impala"
        float* i_60453;
        i_60453 = _58650_60375 + 2;
        #line 9 "gpu_device.impala"
        float* i_60477;
        i_60477 = _58650_60375 + 4;
        #line 9 "gpu_device.impala"
        float* i_60464;
        i_60464 = _58650_60375 + 3;
        #line 492 "dsl.impala"
        int _60417;
        _60417 = 2 * _60401;
        #line 92 "gpu_device.impala"
        int _60418;
        _60418 = x_60397 + _60417;
        #line 170 "dsl.impala"
        int _60419;
        _60419 = _60416 + _60418;
        #line 175 "dsl.impala"
        int _60468;
        _60468 = 6 + _60419;
        #line 170 "dsl.impala"
        int _60420;
        _60420 = 5 + _60419;
        #line 175 "dsl.impala"
        int _60481;
        _60481 = 7 + _60419;
        #line 175 "dsl.impala"
        int _60444;
        _60444 = 4 + _60419;
        #line 175 "dsl.impala"
        int _60430;
        _60430 = 3 + _60419;
        #line 9 "gpu_device.impala"
        float* i_60469;
        i_60469 = _58648_60373 + _60468;
        #line 13 "gpu_device.impala"
        float* i_60421;
        i_60421 = _58649_60374 + _60420;
        #line 9 "gpu_device.impala"
        float* i_60456;
        i_60456 = _58648_60373 + _60420;
        #line 9 "gpu_device.impala"
        float* i_60482;
        i_60482 = _58648_60373 + _60481;
        #line 9 "gpu_device.impala"
        float* i_60445;
        i_60445 = _58648_60373 + _60444;
        #line 9 "gpu_device.impala"
        float* i_60431;
        i_60431 = _58648_60373 + _60430;
        #line 14 "gpu_device.impala"
        *i_60421 = 0.000000e+00f;
        #line 10 "gpu_device.impala"
        float _60426;
        _60426 = *i_60425;
        #line 10 "gpu_device.impala"
        float _60435;
        _60435 = _60426;
        #line 10 "gpu_device.impala"
        float _60432;
        _60432 = *i_60431;
        #line 10 "gpu_device.impala"
        float _60436;
        _60436 = _60432;
        #line 175 "dsl.impala"
        float _60437;
        _60437 = _60435 * _60436;
        #line 174 "dsl.impala"
        float _60438;
        _60438 = 0.000000e+00f + _60437;
        #line 14 "gpu_device.impala"
        *i_60421 = _60438;
        #line 10 "gpu_device.impala"
        float _60441;
        _60441 = *i_60440;
        #line 10 "gpu_device.impala"
        float _60448;
        _60448 = _60441;
        #line 10 "gpu_device.impala"
        float _60446;
        _60446 = *i_60445;
        #line 10 "gpu_device.impala"
        float _60449;
        _60449 = _60446;
        #line 175 "dsl.impala"
        float _60450;
        _60450 = _60448 * _60449;
        #line 174 "dsl.impala"
        float _60451;
        _60451 = _60438 + _60450;
        #line 14 "gpu_device.impala"
        *i_60421 = _60451;
        #line 10 "gpu_device.impala"
        float _60454;
        _60454 = *i_60453;
        #line 10 "gpu_device.impala"
        float _60459;
        _60459 = _60454;
        #line 10 "gpu_device.impala"
        float _60457;
        _60457 = *i_60456;
        #line 10 "gpu_device.impala"
        float _60460;
        _60460 = _60457;
        #line 175 "dsl.impala"
        float _60461;
        _60461 = _60459 * _60460;
        #line 174 "dsl.impala"
        float _60462;
        _60462 = _60451 + _60461;
        #line 14 "gpu_device.impala"
        *i_60421 = _60462;
        #line 10 "gpu_device.impala"
        float _60465;
        _60465 = *i_60464;
        #line 10 "gpu_device.impala"
        float _60472;
        _60472 = _60465;
        #line 10 "gpu_device.impala"
        float _60470;
        _60470 = *i_60469;
        #line 10 "gpu_device.impala"
        float _60473;
        _60473 = _60470;
        #line 175 "dsl.impala"
        float _60474;
        _60474 = _60472 * _60473;
        #line 174 "dsl.impala"
        float _60475;
        _60475 = _60462 + _60474;
        #line 14 "gpu_device.impala"
        *i_60421 = _60475;
        #line 10 "gpu_device.impala"
        float _60478;
        _60478 = *i_60477;
        #line 10 "gpu_device.impala"
        float _60485;
        _60485 = _60478;
        #line 10 "gpu_device.impala"
        float _60483;
        _60483 = *i_60482;
        #line 10 "gpu_device.impala"
        float _60486;
        _60486 = _60483;
        #line 175 "dsl.impala"
        float _60487;
        _60487 = _60485 * _60486;
        #line 174 "dsl.impala"
        float _60488;
        _60488 = _60475 + _60487;
        #line 14 "gpu_device.impala"
        *i_60421 = _60488;
        return ;
}

__global__ void lambda_58978(float* _58981_60624, float* _58982_60625, float* _58983_60626, float* _58984_60627, struct_12602 _58985_60628) {
    int  _60631;
    int p_60631;
    int  _60634;
    int p_60634;
    int  _60637;
    int p_60637;
    int  _60640;
    int p_60640;
    int  _60643;
    int p_60643;
    int  _60646;
    int p_60646;
    bool  converge_60675;
    bool pconverge_60675;
    bool  converge_60677;
    bool pconverge_60677;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _60631 = blockIdx_x();
    p_60631 = _60631;
    l60629: ;
        _60631 = p_60631;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60634 = blockDim_x();
        p_60634 = _60634;
    l60632: ;
        _60634 = p_60634;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60637 = threadIdx_x();
        p_60637 = _60637;
    l60635: ;
        _60637 = p_60637;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60640 = blockIdx_y();
        p_60640 = _60640;
    l60638: ;
        _60640 = p_60640;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60643 = blockDim_y();
        p_60643 = _60643;
    l60641: ;
        _60643 = p_60643;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60646 = threadIdx_y();
        p_60646 = _60646;
    l60644: ;
        _60646 = p_60646;
        #line 135 "gpu_device.impala"
        int _60647;
        _60647 = _60631 * _60634;
        #line 135 "gpu_device.impala"
        int x_60648;
        x_60648 = _60647 + _60637;
        #line 138 "gpu_device.impala"
        bool _60649;
        _60649 = 1 < x_60648;
        #line 138 "gpu_device.impala"
        if (_60649) goto l60650; else goto l60804;
    l60804: ;
        #line 140 "gpu_device.impala"
        goto l60801;
    l60650: ;
        #line 410 "dsl.impala"
        int _60651;
        _60651 = _58985_60628.e5;
        #line 91 "gpu_device.impala"
        int _60652;
        _60652 = _60651 - 2;
        #line 138 "gpu_device.impala"
        bool _60653;
        _60653 = x_60648 < _60652;
        #line 138 "gpu_device.impala"
        if (_60653) goto l60654; else goto l60803;
    l60803: ;
        #line 140 "gpu_device.impala"
        goto l60801;
    l60654: ;
        #line 136 "gpu_device.impala"
        int _60655;
        _60655 = _60640 * _60643;
        #line 136 "gpu_device.impala"
        int y_60656;
        y_60656 = _60655 + _60646;
        #line 138 "gpu_device.impala"
        bool _60657;
        _60657 = 1 < y_60656;
        #line 138 "gpu_device.impala"
        if (_60657) goto l60658; else goto l60802;
    l60802: ;
        #line 140 "gpu_device.impala"
        goto l60801;
    l60658: ;
        #line 495 "dsl.impala"
        int _60659;
        _60659 = _58985_60628.e6;
        #line 322 "dsl.impala"
        int _60660;
        _60660 = _60659 - 2;
        #line 138 "gpu_device.impala"
        bool _60661;
        _60661 = y_60656 < _60660;
        #line 138 "gpu_device.impala"
        if (_60661) goto l60662; else goto l60800;
    l60800: ;
        #line 140 "gpu_device.impala"
        goto l60801;
    l60801: ;
        return ;
    l60662: ;
        #line 492 "dsl.impala"
        int _60663;
        _60663 = 2 * _60651;
        #line 321 "dsl.impala"
        int _60664;
        _60664 = 5 + _60663;
        #line 139 "gpu_device.impala"
        int _60665;
        _60665 = x_60648 + _60663;
        #line 139 "gpu_device.impala"
        int _60666;
        _60666 = 5 + _60665;
        #line 321 "dsl.impala"
        bool _60667;
        _60667 = _60664 < _60666;
        #line 321 "dsl.impala"
        if (_60667) goto l60668; else goto l60799;
    l60799: ;
        #line 322 "dsl.impala"
        goto l60798;
    l60668: ;
        #line 321 "dsl.impala"
        int _60669;
        _60669 = 3 * _60651;
        #line 321 "dsl.impala"
        int _60670;
        _60670 = 4 + _60669;
        #line 321 "dsl.impala"
        bool _60671;
        _60671 = _60666 < _60670;
        #line 321 "dsl.impala"
        if (_60671) goto l60672; else goto l60797;
    l60797: ;
        #line 322 "dsl.impala"
        goto l60798;
    l60798: ;
        #line 322 "dsl.impala"
        pconverge_60677 = false;
        goto l60676;
    l60672: ;
        #line 138 "gpu_device.impala"
        if (_60657) goto l60673; else goto l60795;
    l60795: ;
        #line 322 "dsl.impala"
        pconverge_60675 = false;
        goto l60674;
    l60673: ;
        #line 322 "dsl.impala"
        pconverge_60675 = _60661;
        goto l60674;
    l60674: ;
        converge_60675 = pconverge_60675;
        #line 322 "dsl.impala"
        pconverge_60677 = converge_60675;
        goto l60676;
    l60676: ;
        converge_60677 = pconverge_60677;
        #line 247 "dsl.impala"
        int _60683;
        _60683 = y_60656 - 1;
        #line 242 "dsl.impala"
        int _60678;
        _60678 = y_60656 * _60651;
        #line 247 "dsl.impala"
        int _60685;
        _60685 = _60666 - 1;
        #line 242 "dsl.impala"
        int _60679;
        _60679 = _60678 + _60665;
        #line 271 "dsl.impala"
        int _60719;
        _60719 = 6 + _60679;
        #line 253 "dsl.impala"
        int _60693;
        _60693 = _60678 + _60685;
        #line 320 "dsl.impala"
        float condition_60776;
        condition_60776 = (float)converge_60677;
        #line 259 "dsl.impala"
        int _60702;
        _60702 = 1 + y_60656;
        #line 247 "dsl.impala"
        int _60684;
        _60684 = _60683 * _60651;
        #line 259 "dsl.impala"
        int _60703;
        _60703 = _60702 * _60651;
        #line 259 "dsl.impala"
        int _60704;
        _60704 = _60703 + _60685;
        #line 247 "dsl.impala"
        int _60686;
        _60686 = _60684 + _60685;
        #line 242 "dsl.impala"
        int _60680;
        _60680 = 5 + _60679;
        #line 9 "gpu_device.impala"
        float* i_60720;
        i_60720 = _58984_60627 + _60719;
        #line 9 "gpu_device.impala"
        float* i_60694;
        i_60694 = _58984_60627 + _60693;
        #line 265 "dsl.impala"
        int _60711;
        _60711 = _60684 + _60665;
        #line 277 "dsl.impala"
        int _60727;
        _60727 = _60703 + _60665;
        #line 9 "gpu_device.impala"
        float* i_60705;
        i_60705 = _58984_60627 + _60704;
        #line 9 "gpu_device.impala"
        float* i_60687;
        i_60687 = _58984_60627 + _60686;
        #line 13 "gpu_device.impala"
        float* i_60788;
        i_60788 = _58981_60624 + _60680;
        #line 13 "gpu_device.impala"
        float* i_60735;
        i_60735 = _58983_60626 + _60680;
        #line 13 "gpu_device.impala"
        float* i_60681;
        i_60681 = _58982_60625 + _60680;
        #line 265 "dsl.impala"
        int _60712;
        _60712 = 6 + _60711;
        #line 265 "dsl.impala"
        int _60742;
        _60742 = 5 + _60711;
        #line 277 "dsl.impala"
        int _60728;
        _60728 = 6 + _60727;
        #line 277 "dsl.impala"
        int _60760;
        _60760 = 5 + _60727;
        #line 14 "gpu_device.impala"
        *i_60681 = 0.000000e+00f;
        #line 9 "gpu_device.impala"
        float* i_60713;
        i_60713 = _58984_60627 + _60712;
        #line 9 "gpu_device.impala"
        float* i_60743;
        i_60743 = _58984_60627 + _60742;
        #line 9 "gpu_device.impala"
        float* i_60729;
        i_60729 = _58984_60627 + _60728;
        #line 9 "gpu_device.impala"
        float* i_60761;
        i_60761 = _58984_60627 + _60760;
        #line 10 "gpu_device.impala"
        float _60688;
        _60688 = *i_60687;
        #line 10 "gpu_device.impala"
        float _60690;
        _60690 = _60688;
        #line 246 "dsl.impala"
        float _60691;
        _60691 = 0.000000e+00f - _60690;
        #line 14 "gpu_device.impala"
        *i_60681 = _60691;
        #line 10 "gpu_device.impala"
        float _60695;
        _60695 = *i_60694;
        #line 10 "gpu_device.impala"
        float _60698;
        _60698 = _60695;
        #line 253 "dsl.impala"
        float _60699;
        _60699 = 2.000000e+00f * _60698;
        #line 252 "dsl.impala"
        float _60700;
        _60700 = _60691 - _60699;
        #line 14 "gpu_device.impala"
        *i_60681 = _60700;
        #line 10 "gpu_device.impala"
        float _60706;
        _60706 = *i_60705;
        #line 10 "gpu_device.impala"
        float _60708;
        _60708 = _60706;
        #line 258 "dsl.impala"
        float _60709;
        _60709 = _60700 - _60708;
        #line 14 "gpu_device.impala"
        *i_60681 = _60709;
        #line 10 "gpu_device.impala"
        float _60714;
        _60714 = *i_60713;
        #line 10 "gpu_device.impala"
        float _60716;
        _60716 = _60714;
        #line 264 "dsl.impala"
        float _60717;
        _60717 = _60709 + _60716;
        #line 14 "gpu_device.impala"
        *i_60681 = _60717;
        #line 10 "gpu_device.impala"
        float _60721;
        _60721 = *i_60720;
        #line 10 "gpu_device.impala"
        float _60723;
        _60723 = _60721;
        #line 271 "dsl.impala"
        float _60724;
        _60724 = 2.000000e+00f * _60723;
        #line 270 "dsl.impala"
        float _60725;
        _60725 = _60717 + _60724;
        #line 14 "gpu_device.impala"
        *i_60681 = _60725;
        #line 10 "gpu_device.impala"
        float _60730;
        _60730 = *i_60729;
        #line 10 "gpu_device.impala"
        float _60732;
        _60732 = _60730;
        #line 276 "dsl.impala"
        float _60733;
        _60733 = _60725 + _60732;
        #line 14 "gpu_device.impala"
        *i_60681 = _60733;
        #line 14 "gpu_device.impala"
        *i_60735 = 0.000000e+00f;
        #line 10 "gpu_device.impala"
        float _60737;
        _60737 = *i_60687;
        #line 10 "gpu_device.impala"
        float _60739;
        _60739 = _60737;
        #line 285 "dsl.impala"
        float _60740;
        _60740 = 0.000000e+00f - _60739;
        #line 14 "gpu_device.impala"
        *i_60735 = _60740;
        #line 10 "gpu_device.impala"
        float _60744;
        _60744 = *i_60743;
        #line 10 "gpu_device.impala"
        float _60746;
        _60746 = _60744;
        #line 292 "dsl.impala"
        float _60747;
        _60747 = 2.000000e+00f * _60746;
        #line 291 "dsl.impala"
        float _60748;
        _60748 = _60740 - _60747;
        #line 14 "gpu_device.impala"
        *i_60735 = _60748;
        #line 10 "gpu_device.impala"
        float _60750;
        _60750 = *i_60713;
        #line 10 "gpu_device.impala"
        float _60752;
        _60752 = _60750;
        #line 297 "dsl.impala"
        float _60753;
        _60753 = _60748 - _60752;
        #line 14 "gpu_device.impala"
        *i_60735 = _60753;
        #line 10 "gpu_device.impala"
        float _60755;
        _60755 = *i_60705;
        #line 10 "gpu_device.impala"
        float _60757;
        _60757 = _60755;
        #line 303 "dsl.impala"
        float _60758;
        _60758 = _60753 + _60757;
        #line 14 "gpu_device.impala"
        *i_60735 = _60758;
        #line 10 "gpu_device.impala"
        float _60762;
        _60762 = *i_60761;
        #line 10 "gpu_device.impala"
        float _60764;
        _60764 = _60762;
        #line 310 "dsl.impala"
        float _60765;
        _60765 = 2.000000e+00f * _60764;
        #line 309 "dsl.impala"
        float _60766;
        _60766 = _60758 + _60765;
        #line 14 "gpu_device.impala"
        *i_60735 = _60766;
        #line 10 "gpu_device.impala"
        float _60768;
        _60768 = *i_60729;
        #line 10 "gpu_device.impala"
        float _60770;
        _60770 = _60768;
        #line 315 "dsl.impala"
        float _60771;
        _60771 = _60766 + _60770;
        #line 14 "gpu_device.impala"
        *i_60735 = _60771;
        #line 10 "gpu_device.impala"
        float _60773;
        _60773 = *i_60681;
        #line 10 "gpu_device.impala"
        float _60775;
        _60775 = _60773;
        #line 327 "dsl.impala"
        float _60777;
        _60777 = _60775 * condition_60776;
        #line 14 "gpu_device.impala"
        *i_60681 = _60777;
        #line 10 "gpu_device.impala"
        float _60779;
        _60779 = *i_60735;
        #line 10 "gpu_device.impala"
        float _60781;
        _60781 = _60779;
        #line 332 "dsl.impala"
        float _60782;
        _60782 = _60781 * condition_60776;
        #line 14 "gpu_device.impala"
        *i_60735 = _60782;
        #line 10 "gpu_device.impala"
        float _60784;
        _60784 = *i_60681;
        #line 10 "gpu_device.impala"
        float _60789;
        _60789 = _60784;
        #line 10 "gpu_device.impala"
        float _60786;
        _60786 = *i_60735;
        #line 337 "dsl.impala"
        float _60790;
        _60790 = _60789 * _60789;
        #line 10 "gpu_device.impala"
        float _60791;
        _60791 = _60786;
        #line 338 "dsl.impala"
        float _60792;
        _60792 = _60791 * _60791;
        #line 337 "dsl.impala"
        float _60793;
        _60793 = _60790 + _60792;
        #line 14 "gpu_device.impala"
        *i_60788 = _60793;
        return ;
}

__global__ void lambda_59217(float* _59220_60808, float* _59221_60809, float* _59222_60810, float* _59223_60811, struct_12602 _59224_60812) {
    int  _60815;
    int p_60815;
    int  _60818;
    int p_60818;
    int  _60821;
    int p_60821;
    int  _60824;
    int p_60824;
    int  _60827;
    int p_60827;
    int  _60830;
    int p_60830;
    #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
    _60815 = blockIdx_x();
    p_60815 = _60815;
    l60813: ;
        _60815 = p_60815;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60818 = blockDim_x();
        p_60818 = _60818;
    l60816: ;
        _60818 = p_60818;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60821 = threadIdx_x();
        p_60821 = _60821;
    l60819: ;
        _60821 = p_60821;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60824 = blockIdx_y();
        p_60824 = _60824;
    l60822: ;
        _60824 = p_60824;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60827 = blockDim_y();
        p_60827 = _60827;
    l60825: ;
        _60827 = p_60827;
        #line 1 "/home/rafael/Utilities/new_anydsl/anydsl/runtime/platforms/intrinsics_cuda.impala"
        _60830 = threadIdx_y();
        p_60830 = _60830;
    l60828: ;
        _60830 = p_60830;
        #line 135 "gpu_device.impala"
        int _60831;
        _60831 = _60815 * _60818;
        #line 135 "gpu_device.impala"
        int x_60832;
        x_60832 = _60831 + _60821;
        #line 138 "gpu_device.impala"
        bool _60833;
        _60833 = 1 < x_60832;
        #line 138 "gpu_device.impala"
        if (_60833) goto l60834; else goto l60955;
    l60955: ;
        #line 140 "gpu_device.impala"
        goto l60952;
    l60834: ;
        #line 410 "dsl.impala"
        int _60835;
        _60835 = _59224_60812.e5;
        #line 91 "gpu_device.impala"
        int _60836;
        _60836 = _60835 - 2;
        #line 138 "gpu_device.impala"
        bool _60837;
        _60837 = x_60832 < _60836;
        #line 138 "gpu_device.impala"
        if (_60837) goto l60838; else goto l60954;
    l60954: ;
        #line 140 "gpu_device.impala"
        goto l60952;
    l60838: ;
        #line 136 "gpu_device.impala"
        int _60839;
        _60839 = _60824 * _60827;
        #line 136 "gpu_device.impala"
        int y_60840;
        y_60840 = _60839 + _60830;
        #line 138 "gpu_device.impala"
        bool _60841;
        _60841 = 1 < y_60840;
        #line 138 "gpu_device.impala"
        if (_60841) goto l60842; else goto l60953;
    l60953: ;
        #line 140 "gpu_device.impala"
        goto l60952;
    l60842: ;
        #line 495 "dsl.impala"
        int _60843;
        _60843 = _59224_60812.e6;
        #line 322 "dsl.impala"
        int _60844;
        _60844 = _60843 - 2;
        #line 138 "gpu_device.impala"
        bool _60845;
        _60845 = y_60840 < _60844;
        #line 138 "gpu_device.impala"
        if (_60845) goto l60846; else goto l60951;
    l60951: ;
        #line 140 "gpu_device.impala"
        goto l60952;
    l60952: ;
        return ;
    l60846: ;
        #line 492 "dsl.impala"
        int _60848;
        _60848 = 2 * _60835;
        #line 354 "dsl.impala"
        int _60847;
        _60847 = y_60840 * _60835;
        #line 139 "gpu_device.impala"
        int _60849;
        _60849 = x_60832 + _60848;
        #line 139 "gpu_device.impala"
        int _60919;
        _60919 = 5 + _60849;
        #line 354 "dsl.impala"
        int _60850;
        _60850 = _60847 + _60849;
        #line 354 "dsl.impala"
        int _60851;
        _60851 = 5 + _60850;
        #line 13 "gpu_device.impala"
        float* i_60927;
        i_60927 = _59220_60808 + _60851;
        #line 9 "gpu_device.impala"
        float* i_60858;
        i_60858 = _59223_60811 + _60851;
        #line 9 "gpu_device.impala"
        float* i_60855;
        i_60855 = _59222_60810 + _60851;
        #line 9 "gpu_device.impala"
        float* i_60852;
        i_60852 = _59221_60809 + _60851;
        #line 10 "gpu_device.impala"
        float _60853;
        _60853 = *i_60852;
        #line 10 "gpu_device.impala"
        float _60879;
        _60879 = _60853;
        #line 10 "gpu_device.impala"
        float _60856;
        _60856 = *i_60855;
        #line 354 "dsl.impala"
        int xs_60880;
        xs_60880 = (int)_60879;
        #line 10 "gpu_device.impala"
        float _60866;
        _60866 = _60856;
        #line 146 "dsl.impala"
        bool _60881;
        _60881 = 0 <= xs_60880;
        #line 147 "dsl.impala"
        int _60884;
        _60884 = 0 - xs_60880;
        #line 147 "dsl.impala"
        bool _60885;
        _60885 = xs_60880 < 0;
        #line 10 "gpu_device.impala"
        float _60859;
        _60859 = *i_60858;
        #line 355 "dsl.impala"
        int ys_60867;
        ys_60867 = (int)_60866;
        #line 146 "dsl.impala"
        int _60882;
        _60882 = (int)_60881;
        #line 147 "dsl.impala"
        int _60886;
        _60886 = (int)_60885;
        #line 10 "gpu_device.impala"
        float _60941;
        _60941 = _60859;
        #line 147 "dsl.impala"
        bool _60872;
        _60872 = ys_60867 < 0;
        #line 364 "dsl.impala"
        int _60900;
        _60900 = xs_60880 ^ ys_60867;
        #line 146 "dsl.impala"
        bool _60868;
        _60868 = 0 <= ys_60867;
        #line 147 "dsl.impala"
        int _60871;
        _60871 = 0 - ys_60867;
        #line 146 "dsl.impala"
        int _60883;
        _60883 = xs_60880 * _60882;
        #line 147 "dsl.impala"
        int _60887;
        _60887 = _60884 * _60886;
        #line 147 "dsl.impala"
        int _60873;
        _60873 = (int)_60872;
        #line 364 "dsl.impala"
        bool _60901;
        _60901 = _60900 < 0;
        #line 146 "dsl.impala"
        int _60869;
        _60869 = (int)_60868;
        #line 147 "dsl.impala"
        int _60874;
        _60874 = _60871 * _60873;
        #line 146 "dsl.impala"
        int _60888;
        _60888 = _60883 + _60887;
        #line 364 "dsl.impala"
        int cond3_60902;
        cond3_60902 = (int)_60901;
        #line 146 "dsl.impala"
        int _60870;
        _60870 = ys_60867 * _60869;
        #line 146 "dsl.impala"
        int _60875;
        _60875 = _60870 + _60874;
        #line 359 "dsl.impala"
        int tg22x_60889;
        tg22x_60889 = 13573 * _60888;
        #line 360 "dsl.impala"
        int _60894;
        _60894 = _60888 << 16;
        #line 357 "dsl.impala"
        int my_60877;
        my_60877 = _60875 << 15;
        #line 362 "dsl.impala"
        bool _60890;
        _60890 = my_60877 < tg22x_60889;
        #line 360 "dsl.impala"
        int tg67x_60895;
        tg67x_60895 = tg22x_60889 + _60894;
        #line 363 "dsl.impala"
        bool _60896;
        _60896 = tg67x_60895 < my_60877;
        #line 362 "dsl.impala"
        int cond1_60891;
        cond1_60891 = (int)_60890;
        #line 363 "dsl.impala"
        int cond2_60897;
        cond2_60897 = (int)_60896;
        #line 366 "dsl.impala"
        int _60892;
        _60892 = cond1_60891 << 2;
        #line 366 "dsl.impala"
        int _60898;
        _60898 = cond2_60897 << 1;
        #line 366 "dsl.impala"
        int _60899;
        _60899 = _60892 + _60898;
        #line 366 "dsl.impala"
        int index_60903;
        index_60903 = _60899 + cond3_60902;
        #line 367 "dsl.impala"
        array_12689 _60861_93;
        _60861_93.e[0] = 1;
        _60861_93.e[1] = 1;
        array_12689 _60862_96;
        _60862_96.e[0] = -1;
        _60862_96.e[1] = 1;
        array_12689 _60863_99;
        _60863_99.e[0] = 0;
        _60863_99.e[1] = 1;
        array_12689 _60864_102;
        _60864_102.e[0] = 1;
        _60864_102.e[1] = 0;
        array_12690 offsets_60865_105;
        offsets_60865_105.e[0] = _60861_93;
        offsets_60865_105.e[1] = _60862_96;
        offsets_60865_105.e[2] = _60863_99;
        offsets_60865_105.e[3] = _60863_99;
        offsets_60865_105.e[4] = _60864_102;
        offsets_60865_105.e[5] = _60864_102;
        offsets_60865_105.e[6] = _60864_102;
        array_12689 _60904;
        _60904 = offsets_60865_105.e[index_60903];
        #line 367 "dsl.impala"
        int _60908;
        _60908 = _60904.e[0];
        #line 368 "dsl.impala"
        int _60905;
        _60905 = _60904.e[1];
        #line 369 "dsl.impala"
        int nb2_x_60920;
        nb2_x_60920 = _60919 - _60908;
        #line 367 "dsl.impala"
        int nb1_x_60909;
        nb1_x_60909 = _60849 + _60908;
        #line 370 "dsl.impala"
        int nb2_y_60917;
        nb2_y_60917 = y_60840 - _60905;
        #line 368 "dsl.impala"
        int nb1_y_60906;
        nb1_y_60906 = y_60840 + _60905;
        #line 377 "dsl.impala"
        int _60918;
        _60918 = nb2_y_60917 * _60835;
        #line 373 "dsl.impala"
        int _60907;
        _60907 = nb1_y_60906 * _60835;
        #line 377 "dsl.impala"
        int _60921;
        _60921 = _60918 + nb2_x_60920;
        #line 373 "dsl.impala"
        int _60910;
        _60910 = _60907 + nb1_x_60909;
        #line 9 "gpu_device.impala"
        float* i_60922;
        i_60922 = _59223_60811 + _60921;
        #line 373 "dsl.impala"
        int _60911;
        _60911 = 5 + _60910;
        #line 9 "gpu_device.impala"
        float* i_60912;
        i_60912 = _59223_60811 + _60911;
        #line 10 "gpu_device.impala"
        float _60913;
        _60913 = *i_60912;
        #line 10 "gpu_device.impala"
        float _60940;
        _60940 = _60913;
        #line 373 "dsl.impala"
        bool _60942;
        _60942 = _60940 < _60941;
        #line 10 "gpu_device.impala"
        float _60915;
        _60915 = *i_60858;
        #line 372 "dsl.impala"
        float nb1_cond_60943;
        nb1_cond_60943 = (float)_60942;
        #line 10 "gpu_device.impala"
        float _60946;
        _60946 = _60915;
        #line 10 "gpu_device.impala"
        float _60923;
        _60923 = *i_60922;
        #line 10 "gpu_device.impala"
        float _60945;
        _60945 = _60923;
        #line 10 "gpu_device.impala"
        float _60925;
        _60925 = *i_60858;
        #line 377 "dsl.impala"
        bool _60947;
        _60947 = _60945 < _60946;
        #line 10 "gpu_device.impala"
        float _60930;
        _60930 = _60925;
        #line 376 "dsl.impala"
        float nb2_cond_60948;
        nb2_cond_60948 = (float)_60947;
        #line 397 "dsl.impala"
        bool _60931;
        _60931 = 1.600000e+03f < _60930;
        #line 398 "dsl.impala"
        bool _60936;
        _60936 = 1.440000e+04f < _60930;
        #line 397 "dsl.impala"
        float _60932;
        _60932 = (float)_60931;
        #line 398 "dsl.impala"
        float _60937;
        _60937 = (float)_60936;
        #line 397 "dsl.impala"
        float _60933;
        _60933 = 1.000000e+00f * _60932;
        #line 398 "dsl.impala"
        float _60938;
        _60938 = 1.400000e+01f * _60937;
        #line 397 "dsl.impala"
        float _60939;
        _60939 = _60933 + _60938;
        #line 396 "dsl.impala"
        float _60944;
        _60944 = _60939 * nb1_cond_60943;
        #line 396 "dsl.impala"
        float _60949;
        _60949 = _60944 * nb2_cond_60948;
        #line 14 "gpu_device.impala"
        *i_60927 = _60949;
        return ;
}

}