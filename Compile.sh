#!/bin/bash
module load intel-oneapi/2023.1 

rm fort.*
for i in {4,8,12,24}
do
  echo "Iteration $i"
  export OMP_NUM_THREADS=$i
  export MKL_NUM_THREADS=$i

  echo "Removing the Test Case." 

  rm TestCase.o

  #ifort -qmkl=parallel  -L${MKLROOT}/lib/intel64 -liomp5 -lpthread -O3 -ldl -lm -xHost -qopt-zmm-usage=high matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o
  ifort -O3 -xHost -liomp5  matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o -qmkl=parallel 
  
  ./TestCase.o $i

done

#Run the python code here
stop
#gfortran -fopenmp -O3  -march=native matinv.f90 -llapack -liomp5 -lpthread -lm -ldl -o matinv.o
#gfortran -fopenmp -O3  -march=native matinv.f90  -o matinv.o -llapack -liomp5 -lpthread -lm -ldl



done

#Run the python code here
stop
#gfortran -fopenmp -O3  -march=native matinv.f90 -llapack -liomp5 -lpthread -lm -ldl -o matinv.o
#gfortran -fopenmp -O3  -march=native matinv.f90  -o matinv.o -llapack -liomp5 -lpthread -lm -ldl


