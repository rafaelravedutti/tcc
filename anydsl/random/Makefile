# Impala
IMPALA_PATH=/home/rafael/Utilities/anydsl/impala
IMPALA_BIN=${IMPALA_PATH}/build/bin

# Thorin
THORIN_PATH=/home/rafael/Utilities/anydsl/thorin
THORIN_RUNTIME=${THORIN_PATH}/runtime

# Impala files to link
IMPALA_LINK_FILES=${THORIN_RUNTIME}/runtime.impala

all: random

random: random.bc utils.ll
	clang random.bc utils.ll -o random

utils.ll: utils.c
	clang -S -emit-llvm utils.c

random.bc: random.impala
	${IMPALA_BIN}/impala -emit-llvm ${IMPALA_LINK_FILES} $^

clean:
	rm -f random random.bc random.ll utils.ll
