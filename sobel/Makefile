# Clang 3.6.2 include.path
CLANG_INC_PATH=/home/rafael/Utilities/llvm/build/lib/clang/3.6.2/include
# LLVM 3.6.2 include path
LLVM_INC_PATH=/home/rafael/Utilities/llvm/build/include
# HIPAcc include path
HIPACC_INC_PATH=/home/rafael/Utilities/hipacc/build/release/include/dsl

# Compilation options
HIPACC=hipacc
COMPILER_OPTIONS=-std=c++11 -I /usr/include -I ${CLANG_INC_PATH} -I ${LLVM_INC_PATH} -I ${LLVM_INC_PATH}/c++/v1 -I ${HIPACC_INC_PATH}
HIPACC_OPTIONS=-emit-cuda -target Maxwell-50

sobel.cu: sobel.cpp
	${HIPACC} sobel.cpp ${COMPILER_OPTIONS} ${HIPACC_OPTIONS} -o sobel.cu
