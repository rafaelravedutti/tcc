# Impala
IMPALA_PATH=/home/rafael/Utilities/anydsl/impala
IMPALA_BIN=${IMPALA_PATH}/build/bin

# Thorin
THORIN_PATH=/home/rafael/Utilities/anydsl/thorin
THORIN_RUNTIME=${THORIN_PATH}/runtime
THORIN_SRC=${THORIN_PATH}/src
THORIN_COMMON=${THORIN_RUNTIME}/runtime.cpp
THORIN_LIB=${THORIN_PATH}/build/lib
THORIN_FLAGS=-L${THORIN_LIB} -lthorin -lthorin_runtime -lpthread

# Clang++ options
CLANGPP_FLAGS=

# Target platform (may be cpu, cuda, opencl, spir, nvvm, ...)
TARGET_PLATFORM=opencl

# Platform compilation flags
PLATFORM_FLAGS=-lOpenCL

# Impala files to link
IMPALA_LINK_FILES=${THORIN_RUNTIME}/runtime.impala ${THORIN_RUNTIME}/platforms/intrinsics_thorin.impala ${THORIN_RUNTIME}/platforms/intrinsics_${TARGET_PLATFORM}.impala

all: final

main.bc: filters.impala image.impala test_device.impala main.impala
	# clang++ -S -emit-llvm utils.cpp
	clang -S -emit-llvm utils.c
	${IMPALA_BIN}/impala -emit-llvm ${IMPALA_LINK_FILES} $^

final: main.bc utils.ll
	clang++ ${THORIN_FLAGS} ${PLATFORM_FLAGS} $^ -o $@

clean:
	rm -f main.bc main.cl main.cu main.ll utils.ll
