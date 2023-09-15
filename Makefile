### MKL libraries
###
###
MKL= -L${MKLROOT}/lib/intel64  -lmkl_intel_lp64 -lmkl_gnu_thread -lmkl_core -lgomp -lpthread -lm -ldl

### OpenBLAS libraries 
OPENBLASROOT=${OPENBLAS_ROOT}
### BLIS library
BLISROOT=/u/dssc/scocom00/myblis

float: ${folder}/gemm_mkl.x ${folder}/gemm_oblas.x ${folder}/gemm_blis.x

${folder}/gemm_mkl.x: gemm.c
	gcc -DUSE_FLOAT -DMKL $^ -m64 -I${MKLROOT}/include $(MKL)  -o $@

${folder}/gemm_oblas.x: gemm.c
	gcc -DUSE_FLOAT -DOPENBLAS $^ -m64 -I${OPENBLASROOT}/include -L/${OPENBLASROOT}/lib -lopenblas -lpthread -o $@ -fopenmp

${folder}/gemm_blis.x: gemm.c
	gcc -DUSE_FLOAT  -DBLIS $^ -m64 -I${BLISROOT}/include/blis -L/${BLISROOT}/lib -o $@ -lpthread  -lblis -fopenmp -lm




double: ${folder}/dgemm_mkl.x ${folder}/dgemm_oblas.x ${folder}/dgemm_blis.x

${folder}/dgemm_mkl.x: gemm.c
	gcc -DUSE_DOUBLE -DMKL $^ -m64 -I${MKLROOT}/include $(MKL)  -o $@

${folder}/dgemm_oblas.x: gemm.c
	gcc -DUSE_DOUBLE -DOPENBLAS $^ -m64 -I${OPENBLASROOT}/include -L/${OPENBLASROOT}/lib -lopenblas -lpthread -o $@ -fopenmp

${folder}/dgemm_blis.x: gemm.c
	gcc -DUSE_DOUBLE  -DBLIS $^ -m64 -I${BLISROOT}/include/blis -L/${BLISROOT}/lib -o $@ -lpthread  -lblis -fopenmp -lm

clean:
	rm -rf ${folder}/*.x
