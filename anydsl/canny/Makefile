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

# OpenCV
OPENCV_LIBS=-lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_imgcodecs

# Clang++ options
CLANGPP_FLAGS=

# Device type (gpu or cpu)
PLATFORM_TYPE=cpu

# Target platform (may be cpu, cuda, opencl, spir, nvvm, ...)
TARGET_PLATFORM=opencl

# Platform compilation flags
PLATFORM_FLAGS=-lOpenCL

# Impala files to link
IMPALA_LINK_FILES=${ANYDSL_PATH}/runtime/src/runtime.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_thorin.impala ${ANYDSL_PATH}/runtime/platforms/intrinsics_cpu.impala

all: canny

main.ll: ${PLATFORM_TYPE}_device.impala dsl.impala main.impala
	impala -emit-llvm -O3 -Othorin ${IMPALA_LINK_FILES} $^

utils.ll: utils.c
	clang -S -emit-llvm $^

opencv_runtime.ll: opencv_runtime.cpp
	clang++ -S -emit-llvm $^

runtime.ll: ${ANYDSL_PATH}/runtime/src/runtime.cpp
	clang++ -std=c++11 -S -emit-llvm $^

canny: main.ll utils.ll opencv_runtime.ll runtime.ll
	clang++ -lm ${OPENCV_LIBS} -lpthread $^ -o $@

clean:
	rm -f main.bc main.cl main.cu main.ll utils.ll runtime.ll opencv_runtime.ll canny
