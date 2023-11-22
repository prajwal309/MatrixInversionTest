#gfortran TestCase.f90 -o TestCase.o
rm TestCase.o
#gfortran -fopenmp -O3  -march=native matinv.f90 -llapack -liomp5 -lpthread -lm -ldl -o matinv.o
#gfortran -fopenmp -O3  -march=native matinv.f90  -o matinv.o -llapack -liomp5 -lpthread -lm -ldl

export OMP_NUM_THREADS=24
export MKL_NUM_THREADS=24
gfortran -fopenmp -O3  -march=native matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o  -llapack -liomp5 -lpthread -lm -ldl 
#gfortran -fopenmp -O3  -march=native matinv.f90 matinvNew.f90 TestCase.f90 -o TestCase.o  -llapack -liomp5 -lpthread -lm -ldl 

#gfortran -fopenmp -O3 -march=native TestCase.f90 -o TestCase.o 
./TestCase.o

