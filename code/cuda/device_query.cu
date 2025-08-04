// 2025-08-04 knowpd

// How to compile:
//   nvcc device_query.cu -o a.out

#include <iostream>
int main() {
    int deviceCount;
    cudaGetDeviceCount(&deviceCount);
    std::cout << "CUDA-capable device count: " << deviceCount << std::endl;
    return 0;
}

// OUTPUT:
//   $ ./a.out
//   CUDA-capable device count: 1
