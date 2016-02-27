# Matching Pursuit (MP) / Orthogonal Matching Pursuit (OMP)
This is a Matlab implementation of MP/OMP algorithm. Demo script runs the MP and OMP algorithms and compares their performace in terms of accuracy of recovery, sparsity, and speed.

# Description of files
- demo_omp : test script for MP/OMP
- mp.m : function for MP
- omp.m : function for OMP

# MP / OMP
MP and OMP are greedy algorithms for sparse representation. It is used for choosing atoms from dictionary, solving the following optimization problem:

``` min ||x||0 subject to Ax = b ```

In general, solving the above problem is NP-hard problem, but it can be solved much faster with OMP ensuring that it finds the exact solution in some condition (sparsity of the solution).


