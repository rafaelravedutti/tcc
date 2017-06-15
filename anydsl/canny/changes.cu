__device__ int abs_39677(int a) {
  return a * (a >= 0) - a * (a < 0);
}

__device__ void write_39137(struct_14422 buf_39876, int i_39877, float v_39878) {
    #line 14 "gpu_device.impala"
    char* _39881;
    _39881 = buf_39876.e1;
    *((float *) _39881 + i_39877) = v_39878;
}

__device__ float read_39421(struct_14422 buf_39423, int i_39424) {
    #line 10 "gpu_device.impala"
    char* _39426;
    _39426 = buf_39423.e1;
    return *((float *) _39426 + i_39424);
}

}
