# AnyDSL
ANYDSL_PATH=/home/rafael/Utilities/anydsl

# Impala
IMPALA_PATH=${ANYDSL_PATH}/impala
IMPALA_BIN=${IMPALA_PATH}/build/bin

# Thorin
THORIN_PATH=${ANYDSL_PATH}/thorin
THORIN_RUNTIME=${THORIN_PATH}/runtime
THORIN_SRC=${THORIN_PATH}/src
THORIN_COMMON=${THORIN_RUNTIME}/runtime.cpp
THORIN_LIB=${THORIN_PATH}/build/lib
THORIN_FLAGS=-L${THORIN_LIB} -lthorin -lthorin_runtime -lpthread

# Runtime
RUNTIME_LIB=${ANYDSL_PATH}/runtime/build/lib/libruntime.so

# OpenCV
OPENCV_LIBS=-lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_imgcodecs

# Device type (gpu or cpu)
PLATFORM_TYPE=gpu

# Compilation flags
ifeq ($(PLATFORM_TYPE), cpu)
	CLANG_FLAGS=-Ofast -msse2
else
	CLANG_FLAGS=
endif

# Impala files to link
IMPALA_LINK_FILES=${ANYDSL_PATH}/runtime/src/runtime.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_thorin.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_cpu.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_nvvm.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_opencl.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_cuda.impala

all: canny

main.ll: ${PLATFORM_TYPE}_device.impala dsl.impala main.impala
	impala -emit-llvm -g -Othorin -O3 ${IMPALA_LINK_FILES} $^

utils.ll: utils.c
	clang -S -emit-llvm $^

opencv_runtime.ll: opencv_runtime.cpp
	clang++ -S -emit-llvm $^

runtime.ll: ${ANYDSL_PATH}/runtime/src/runtime.cpp
	clang++ -std=c++11 -S -emit-llvm $^

canny: main.ll utils.ll opencv_runtime.ll ${RUNTIME_LIB}
	clang++ ${CLANG_FLAGS} -lm -lOpenCL ${OPENCV_LIBS} -lpthread $^ -o $@

clean:
	rm -f main.bc main.cl main.cu main.ll utils.ll runtime.ll opencv_runtime.ll canny
