# Impala
IMPALA_PATH=/home/rafael/Utilities/anydsl/impala
IMPALA_BIN=${IMPALA_PATH}/build/bin

# Thorin
THORIN_PATH=/home/rafael/Utilities/anydsl/thorin
THORIN_RUNTIME=${THORIN_PATH}/runtime

# Impala files to link
IMPALA_LINK_FILES=${THORIN_RUNTIME}/runtime.impala ${THORIN_RUNTIME}/platforms/intrinsics_thorin.impala ${THORIN_RUNTIME}/platforms/intrinsics_opencl.impala

all: main.ll

main.ll: filters.impala image.impala test_device.impala main.impala
	${IMPALA_BIN}/impala -emit-llvm ${IMPALA_LINK_FILES} $^
