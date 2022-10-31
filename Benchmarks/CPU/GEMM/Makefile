#Copyright 2017 Intel Corporation.
#
#The source code, information and material ("Material") contained herein is owned
#by Intel Corporation or its suppliers or licensors, and title to such Material
#remains with Intel Corporation or its suppliers or licensors. The Material
#contains proprietary information of Intel or its suppliers and licensors. The
#Material is protected by worldwide copyright laws and treaty provisions.
#No part of the Material may be used, copied, reproduced, modified, published,
#uploaded, posted, transmitted, distributed or disclosed in any way without
#Intel's prior express written permission. No license under any patent, copyright
#or other intellectual property rights in the Material is granted to or conferred
#upon you, either expressly, by implication, inducement, estoppel or otherwise.
#Any license under such intellectual property rights must be express and approved
#by Intel in writing.
#
#Unless otherwise agreed by Intel in writing, you may not remove or alter this
#notice or any other notice embedded in Materials by Intel or Intel's suppliers or
#licensors in any way.


#Note: A copy of the license is included in the LICENSE file that accompanies the
#software.


CC	= icc
CFLAGS	= -O2 -qopenmp -Wall -static-intel

BLIS_LIBS = -L$(BLISLIB) -lblis
MKL_LIBS = -L$(MKLROOT)/lib/intel64 -Wl,-Bstatic -Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -Wl,--end-group -Wl,-Bdynamic

all : mkl blis

mkl  : sgemmbench.mkl dgemmbench.mkl

blis : sgemmbench.blis dgemmbench.blis

sgemmbench.mkl  : gemmbench.c
	$(CC) $(CFLAGS) -UUSE_DOUBLE -o $@ $^ $(MKL_LIBS)  -lpthread -lm

dgemmbench.mkl  : gemmbench.c
	$(CC) $(CFLAGS) -DUSE_DOUBLE -o $@ $^ $(MKL_LIBS)  -lpthread -lm

sgemmbench.blis : gemmbench.c
	$(CC) $(CFLAGS) -UUSE_DOUBLE -o $@ $^ $(BLIS_LIBS) -lpthread -lm

dgemmbench.blis : gemmbench.c
	$(CC) $(CFLAGS) -DUSE_DOUBLE -o $@ $^ $(BLIS_LIBS) -lpthread -lm

clean:
	rm -f *.o *~ sgemmbench.mkl dgemmbench.mkl sgemmbench.blis dgemmbench.blis
