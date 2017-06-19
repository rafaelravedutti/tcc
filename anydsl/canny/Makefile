# AnyDSL
ANYDSL_PATH=/home/rafael/Utilities/new_anydsl/anydsl

# Impala
IMPALA_PATH=${ANYDSL_PATH}/impala
IMPALA_BIN=${IMPALA_PATH}/build/bin

# OpenCV
OPENCV_LIBS=-lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_imgcodecs -lopencv_cudaimgproc -lopencv_cudafilters

# Device type (gpu or cpu)
PLATFORM_TYPE=cpu

# Compilation flags
ifeq ($(PLATFORM_TYPE), cpu)
	CLANG_FLAGS=-O3
  OPENCV_RUNTIME_FLAGS=
else
	CLANG_FLAGS=
  OPENCV_RUNTIME_FLAGS=-DDEVICE_TYPE_GPU
endif

# Impala files to link
IMPALA_LINK_FILES=${ANYDSL_PATH}/runtime/src/runtime.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_thorin.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_cpu.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_nvvm.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_opencl.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_cuda.impala

all: canny

main.ll: ${PLATFORM_TYPE}_device.impala dsl.impala main.impala
	impala -emit-llvm -g -Othorin -O3 ${IMPALA_LINK_FILES} $^

utils.ll: utils.c
	clang -S -emit-llvm $^

opencv_runtime.ll: opencv_runtime.cpp
	clang++ -S -emit-llvm ${OPENCV_RUNTIME_FLAGS} $^

canny: main.ll utils.ll opencv_runtime.ll ${ANYDSL_PATH}/runtime/build/lib/libruntime.so
	clang++ ${CLANG_FLAGS} -lm -lOpenCL ${OPENCV_LIBS} -lpthread $^ -o $@

clean:
	rm -f main.bc main.cl main.cu main.ll utils.ll runtime.ll opencv_runtime.ll canny
