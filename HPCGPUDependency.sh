#!/bin/bash

source /usr/usc/intel/14.0/setup.sh
source /usr/usc/cuda/default/setup.sh
source /usr/usc/git/default/setup.sh
source /usr/usc/gnu/gcc/default/setup.sh
source /usr/usc/clang/default/setup.sh
source /usr/usc/hdf5/default/setup.sh

# CUDNN
export CPATH=/usr/usc/cuDNN/7.0.64/bin:$CPATH
export LD_LIBRARY_PATH=/usr/usc/cuDNN/7.0.64/lib64:$LD_LIBRARY_PATH

# LLVM
export PATH=/usr/usc/llvm/default/bin:$PATH
export LD_LIBRARY_PATH=/usr/usc/llvm/default/lib:$LD_LIBRARY_PATH