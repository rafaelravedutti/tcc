# Impala
IMPALA_PATH=/home/rafael/Utilities/anydsl/impala
IMPALA_BIN=${IMPALA_PATH}/build/bin

# Thorin
THORIN_PATH=/home/rafael/Utilities/anydsl/thorin
THORIN_RUNTIME=${THORIN_PATH}/runtime
THORIN_SRC=${THORIN_PATH}/src

# Target platform (may be cpu, cuda, opencl, spir, nvvm, ...)
TARGET_PLATFORM=opencl

# Impala files to link
IMPALA_LINK_FILES=${THORIN_RUNTIME}/runtime.impala ${THORIN_RUNTIME}/platforms/intrinsics_thorin.impala ${THORIN_RUNTIME}/platforms/intrinsics_${TARGET_PLATFORM}.impala

all: main.ll

main.ll: filters.impala image.impala test_device.impala main.impala
	${IMPALA_BIN}/impala -emit-llvm ${IMPALA_LINK_FILES} $^
	clang -S -emit-llvm utils.c

final: main.ll utils.ll
	clang -std=c++11 utils.ll main.ll ${THORIN_RUNTIME}/runtime.cpp -I ${THORIN_SRC} -o $@

clean:
	rm -f main.bc main.cl main.cu main.ll utils.ll
