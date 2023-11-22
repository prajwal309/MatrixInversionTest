import numpy as np
import matplotlib.pyplot as plt

def NumOperations(N):
    return N*N*N+0.5*N*N-0.5*N

print(NumOperations(1002)*304/2/1e9) 