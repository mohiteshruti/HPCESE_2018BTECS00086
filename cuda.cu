%%cu

#include<stdio.h>

__global__ void Factorial(int *gpu_num,long int *gpu_res)
{
  int i;
  *gpu_res=1;
  for(i=1;i<=*gpu_num;i++)
  {
    *gpu_res = *gpu_res * i;      
  }
}

int main()
{
  int Number=4;  
  int *dev_number;
  long int *res, result;
  
  cudaMalloc((void**)&dev_number,sizeof(int));
  cudaMalloc((void**)&res,sizeof(long int));
  
  cudaMemcpy(dev_number,&Number,sizeof(int),cudaMemcpyHostToDevice);
 
  Factorial<<<1,1>>>(dev_number,res);

  cudaMemcpy(&result,res,sizeof(long int),cudaMemcpyDeviceToHost);

  printf("\n\t Factorial of number %d is %ld \n",Number,result); 

  return 0; 
}
