#include <iostream>
#include <cuda.h>
#define VECTOR_ELEMENTS 1024
__global__
void vecAdd(float *d_A,float  *d_B,float *d_C,int n){
    int index=threadIdx.x+blockDim.x+blockIdx.x;
    if(index<n){
        d_C[index]=d_A[index]+d_B[index];
    }
}
int main() {
    //HOST
    float *h_A=new float [VECTOR_ELEMENTS];
    float *h_B=new float [VECTOR_ELEMENTS];

    float *h_C=new float [VECTOR_ELEMENTS];
//DEVICE
    float *d_A,*d_B,*d_C,*xx;
    int size=VECTOR_ELEMENTS*sizeof (float );
    cudaMalloc(&d_A,size);
    cudaMalloc(&d_B,size);
    cudaMalloc(&d_C,size);
    cudaMalloc(&xx,1024*1014*1024);

//Inicializar vectores en el host
    for (int i=0;i<VECTOR_ELEMENTS;i++){
        h_A[i]=1.f;
        h_B[i]=2.f;
        h_C[i]=0.0f;

    }
    //copiar host to device
    cudaMemcpy(d_A,h_A,size,cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,h_B,size,cudaMemcpyHostToDevice);
    //executar kernel
    vecAdd<<<4,256>>>(d_A,d_B,d_C,VECTOR_ELEMENTS);
    //copiar device to host
    cudaMemcpy(h_C,d_C,size,cudaMemcpyDeviceToHost);
    for (int i=0;i<10;i++){
        printf("%.0f, ",h_C[i]);
    }
    return 0;
}
