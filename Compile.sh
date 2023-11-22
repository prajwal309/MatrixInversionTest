
for i in {4,8,12,24}
do
  echo "Iteration $i"
  export OMP_NUM_THREADS=$i
  export MKL_NUM_THREADS=$i

  echo "Removing the Test Case." 

  rm TestCase.o

  #gfortran -fopenmp -O3  -march=native matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o  -llapack -liomp5 -lpthread -lm -ldl 
  #gfortran -fopenmp -O3  -march=native matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o  -llapack -liomp5 -lpthread -lm -ldl 
  gfortran -march=native matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o 
  
  #gfortran -fopenmp -O3 -march=native TestCase.f90 -o TestCase.o 
  ./TestCase.o $i

done

#Run the python code here
stop
#gfortran -fopenmp -O3  -march=native matinv.f90 -llapack -liomp5 -lpthread -lm -ldl -o matinv.o
#gfortran -fopenmp -O3  -march=native matinv.f90  -o matinv.o -llapack -liomp5 -lpthread -lm -ldl


