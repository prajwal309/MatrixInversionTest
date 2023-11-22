# Motivation
This program is an attempt to see how different matrix inversion algorithm perform. The four algorithms that are tested are:
  1. dgetrf/dgetri
  2. MatInv: Algorithm from https://ieeexplore.ieee.org/document/7300068
  3. dsytrf/dsytri
  4. Cholesky Decomposition: dpotrf/dpotri

# Finding
We find that Cholesky Algorithm performs substantially better than any of the algorithm. Surprisingly dsytrf/dsytri (lapack inversion for symmetric matrix) is slower than dgetrf/dgetri (lapack inversion for general matrix inversion.) MatInv builds upon dgetrf/dgetri by chunking the matrix into the smaller size. 

The results are rather non-intuitive in that the performance did not only scale with the number of matrices but also was worse for 24 cores vs 4 cores.