from numba import cuda
import numpy as np
# to measure exec time
from timeit import default_timer as timer

# normal function to run on cpu
def func(a):
    for i in range(100000000):
        a[i]+= 1

# function optimized to run on gpu
@cuda('void(float64[:]', device=True, inline=True)
def func2(a):
    for i in range(100000000):
        a[i]+= 1

if __name__=="__main__":
    n = 100000000
    a = np.ones(n, dtype = np.float64)

    start = timer()
    func(a)
    print("sem GPU:", timer()-start)

    start = timer()
    func2(a)
    print("com GPU:", timer()-start)
