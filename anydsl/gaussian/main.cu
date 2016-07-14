extern "C" {
typedef struct array_1590 {
    float e[3];
} array_1590;
typedef struct array_1591 {
    array_1590 e[3];
} array_1591;

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
__global__ void lambda_crit_1951(int*, int, int, array_1591, int, int);
__device__ int acc_bidx_2355();
__device__ int acc_bdimx_2367();
__device__ int acc_tidx_2379();
__device__ int acc_bidy_2391();
__device__ int acc_bdimy_2403();
__device__ int acc_tidy_2415();

__global__ void lambda_crit_1951(int* _1954_2349, int _1955_2350, int _1956_2351, array_1591 _1957_2352, int _1958_2353, int _1959_2354) {
    int  acc_bidx_2366;
    int pacc_bidx_2366;
    int  acc_bdimx_2378;
    int pacc_bdimx_2378;
    int  acc_tidx_2390;
    int pacc_tidx_2390;
    int  acc_bidy_2402;
    int pacc_bidy_2402;
    int  acc_bdimy_2414;
    int pacc_bdimy_2414;
    int  acc_tidy_2426;
    int pacc_tidy_2426;
    int  min_2428;
    int pmin_2428;
    int*  data_2430;
    int* pdata_2430;
    float  sum_2431;
    float psum_2431;
    int  min_2435;
    int pmin_2435;
    float  sum_2437;
    float psum_2437;
    float  sum_2457;
    float psum_2457;
    acc_bidx_2366 = acc_bidx_2355();
    pacc_bidx_2366 = acc_bidx_2366;
    l2364: ;
        acc_bidx_2366 = pacc_bidx_2366;
        acc_bdimx_2378 = acc_bdimx_2367();
        pacc_bdimx_2378 = acc_bdimx_2378;
    l2376: ;
        acc_bdimx_2378 = pacc_bdimx_2378;
        acc_tidx_2390 = acc_tidx_2379();
        pacc_tidx_2390 = acc_tidx_2390;
    l2388: ;
        acc_tidx_2390 = pacc_tidx_2390;
        acc_bidy_2402 = acc_bidy_2391();
        pacc_bidy_2402 = acc_bidy_2402;
    l2400: ;
        acc_bidy_2402 = pacc_bidy_2402;
        acc_bdimy_2414 = acc_bdimy_2403();
        pacc_bdimy_2414 = acc_bdimy_2414;
    l2412: ;
        acc_bdimy_2414 = pacc_bdimy_2414;
        acc_tidy_2426 = acc_tidy_2415();
        pacc_tidy_2426 = acc_tidy_2426;
    l2424: ;
        acc_tidy_2426 = pacc_tidy_2426;
        int _2441;
        _2441 = acc_bidx_2366 * acc_bdimx_2378;
        int x_2442;
        x_2442 = _2441 + acc_tidx_2390;
        int _2448;
        _2448 = acc_bidy_2402 * acc_bdimy_2414;
        int y_2449;
        y_2449 = _2448 + acc_tidy_2426;
        pmin_2428 = _1959_2354;
        pdata_2430 = _1954_2349;
        psum_2431 = 0.000000e+00f;
        goto l2427;
    l2427: ;
        min_2428 = pmin_2428;
        data_2430 = pdata_2430;
        sum_2431 = psum_2431;
        bool _2432;
        _2432 = min_2428 < _1956_2351;
        if (_2432) goto l2433; else goto l2482;
    l2482: ;
        int _2483;
        _2483 = y_2449 * _1955_2350;
        int _2484;
        _2484 = _2483 + x_2442;
        int* _2485;
        _2485 = data_2430 + _2484;
        int _2486;
        _2486 = (int)sum_2431;
        *_2485 = _2486;
        return ;
    l2433: ;
        int _2443;
        _2443 = x_2442 + min_2428;
        bool _2444;
        _2444 = -1 < _2443;
        bool _2446;
        _2446 = _2443 < _1955_2350;
        int _2466;
        _2466 = min_2428 + _1956_2351;
        array_1590 _2467;
        _2467 = _1957_2352.e[_2466];
        pmin_2435 = _1959_2354;
        psum_2437 = sum_2431;
        goto l2434;
    l2434: ;
        min_2435 = pmin_2435;
        sum_2437 = psum_2437;
        bool _2438;
        _2438 = min_2435 < _1956_2351;
        if (_2438) goto l2439; else goto l2480;
    l2480: ;
        int _2481;
        _2481 = 1 + min_2428;
        pmin_2428 = _2481;
        pdata_2430 = data_2430;
        psum_2431 = sum_2437;
        goto l2427;
    l2439: ;
        if (_2444) goto l2445; else goto l2479;
    l2479: ;
        goto l2476;
    l2445: ;
        if (_2446) goto l2447; else goto l2478;
    l2478: ;
        goto l2476;
    l2447: ;
        int _2450;
        _2450 = y_2449 + min_2435;
        bool _2451;
        _2451 = -1 < _2450;
        if (_2451) goto l2452; else goto l2477;
    l2477: ;
        goto l2476;
    l2452: ;
        bool _2453;
        _2453 = _2450 < _1958_2353;
        if (_2453) goto l2454; else goto l2475;
    l2475: ;
        goto l2476;
    l2476: ;
        psum_2457 = sum_2437;
        goto l2455;
    l2454: ;
        int _2460;
        _2460 = _2450 * _1955_2350;
        int _2461;
        _2461 = _2460 + _2443;
        int* _2462;
        _2462 = data_2430 + _2461;
        int _2463;
        _2463 = *_2462;
        int _2468;
        _2468 = min_2435 + _1956_2351;
        float _2469;
        _2469 = _2467.e[_2468];
        int _2471;
        _2471 = _2463;
        float _2472;
        _2472 = (float)_2471;
        float _2473;
        _2473 = _2469 * _2472;
        float _2474;
        _2474 = sum_2437 + _2473;
        psum_2457 = _2474;
        goto l2455;
    l2455: ;
        sum_2457 = psum_2457;
        int _2459;
        _2459 = 1 + min_2435;
        pmin_2435 = _2459;
        psum_2437 = sum_2457;
        goto l2434;
}

__device__ int acc_bidx_2355() {
    int  blockIdx_x_2363;
    int pblockIdx_x_2363;
    blockIdx_x_2363 = blockIdx_x();
    pblockIdx_x_2363 = blockIdx_x_2363;
    l2361: ;
        blockIdx_x_2363 = pblockIdx_x_2363;
        return blockIdx_x_2363;
}

__device__ int acc_bdimx_2367() {
    int  blockDim_x_2375;
    int pblockDim_x_2375;
    blockDim_x_2375 = blockDim_x();
    pblockDim_x_2375 = blockDim_x_2375;
    l2373: ;
        blockDim_x_2375 = pblockDim_x_2375;
        return blockDim_x_2375;
}

__device__ int acc_tidx_2379() {
    int  threadIdx_x_2387;
    int pthreadIdx_x_2387;
    threadIdx_x_2387 = threadIdx_x();
    pthreadIdx_x_2387 = threadIdx_x_2387;
    l2385: ;
        threadIdx_x_2387 = pthreadIdx_x_2387;
        return threadIdx_x_2387;
}

__device__ int acc_bidy_2391() {
    int  blockIdx_y_2399;
    int pblockIdx_y_2399;
    blockIdx_y_2399 = blockIdx_y();
    pblockIdx_y_2399 = blockIdx_y_2399;
    l2397: ;
        blockIdx_y_2399 = pblockIdx_y_2399;
        return blockIdx_y_2399;
}

__device__ int acc_bdimy_2403() {
    int  blockDim_y_2411;
    int pblockDim_y_2411;
    blockDim_y_2411 = blockDim_y();
    pblockDim_y_2411 = blockDim_y_2411;
    l2409: ;
        blockDim_y_2411 = pblockDim_y_2411;
        return blockDim_y_2411;
}

__device__ int acc_tidy_2415() {
    int  threadIdx_y_2423;
    int pthreadIdx_y_2423;
    threadIdx_y_2423 = threadIdx_y();
    pthreadIdx_y_2423 = threadIdx_y_2423;
    l2421: ;
        threadIdx_y_2423 = pthreadIdx_y_2423;
        return threadIdx_y_2423;
}

}
