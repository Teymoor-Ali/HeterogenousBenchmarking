#!/bin/bash

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


#################################################################################################
#											    	#
#  Purpose: Runs the xGEMM benchmark with a specified number of threads, problem size, and 	#
#	    math library.									#
#												#
#  Usage: ./run.sh <NUM_THREADS> <SIZE_N> <MATH_LIBRARY>					#
#  												#
#	  NUM_THREADS: Number of threads to run benchmark with.					#
#	  SIZE_N: Problem size to run benchmark with. "all" runs a preselected set of sizes.	#
#	  MATH_LIBRARY: Select "mkl" for Intel(R) Math Kernel Library or "blis" for BLIS*	#
#		        (BLAS-like Library Instantiation Software Framework).			#
#################################################################################################


NUMA="numactl -i all"

export OMP_NUM_THREADS=${1}

let cpu_m1=${OMP_NUM_THREADS}-1
export KMP_AFFINITY="granularity=thread,proclist=[0-${cpu_m1}:1],explicit"

if [[ ${2} == "all" ]]
then
  SZ="100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000"
else
  SZ=${2}
fi

MATH_LIB=${3}

if [[ ${MATH_LIB} == "mkl" && -f sgemmbench.mkl && -f dgemmbench.mkl ]]
then

  for size_n in ${SZ}
  do
	${NUMA} ./sgemmbench.mkl  ${size_n}
  done

  for size_n in ${SZ}
  do
	${NUMA} ./dgemmbench.mkl  ${size_n}
  done

elif [[ ${MATH_LIB} == "blis" && -f sgemmbench.blis && -f dgemmbench.blis ]]
then

  for size_n in ${SZ}
  do
	${NUMA} ./sgemmbench.blis ${size_n}
  done

  for size_n in ${SZ}
  do
	${NUMA} ./dgemmbench.blis ${size_n}
  done

else

	echo "No valid library selected or present; Please, select 'mkl' or 'blis' and make sure you have run Makefile to build the selected library."

fi

