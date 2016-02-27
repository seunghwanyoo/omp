# Matching Pursuit (MP) / Orthogonal Matching Pursuit (OMP)
This is a Matlab implementation of MP/OMP algorithm.

# Description of files
- demo_mp : test script for MP
- demo_omp : test script for OMP
- mp.m : function for MP
- omp.m : function for OMP

# MP / OMP
MP and OMP are greedy algorithms for sparse representation. It is used for choosing atoms from dictionary, solving the following optimization problem:

``` min ||x||0 subject to Ax = b ```

In general, solving the above problem is NP-hard problem, but it can be solved much faster with OMP ensuring that it finds the exact solution in some condition (sparsity of the solution).


