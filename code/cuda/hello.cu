// 2025-08-04 knowpd

// nvcc: NVidia Cuda Compliler

// How to complie:
//  nvcc hello.cu -o a.out

#include <iostream>

// Kernel function to run on GPU
__global__ void hello_from_gpu() {
    printf("Hello from GPU thread %d of %d\n", threadIdx.x, blockDim.x);
}

int main() {
    std::cout << "Launching kernel from CPU..." << std::endl;

    hello_from_gpu<<<2, 5>>>();       // <<<numBlocks, threadsPerBlock>>>
    cudaDeviceSynchronize();          // Wait for GPU to finish
    return 0;
}

// OUTPUT:
//   $ ./a.out
//   Launching kernel from CPU...
//   Hello from GPU thread 0 of 5
//   Hello from GPU thread 1 of 5
//   Hello from GPU thread 2 of 5
//   Hello from GPU thread 3 of 5
//   Hello from GPU thread 4 of 5
//   Hello from GPU thread 0 of 5
//   Hello from GPU thread 1 of 5
//   Hello from GPU thread 2 of 5
//   Hello from GPU thread 3 of 5
//   Hello from GPU thread 4 of 5

// NOTE:
//   - A total of 10 threads are launched in parallel.
//   - This appears sequential, but it’s actually due to:
//     1. printf() being buffered or serialized — to avoid garbled console output, 
//        CUDA internally serializes printf output across threads.
//     2. Execution order is non-deterministic, but formatted output is printed in order to stdout.
//     3. GPU threads run in parallel, but printf does not reflect true execution timing.
