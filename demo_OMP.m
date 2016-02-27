% This is a wrapper to compare MP and OMP for sparse recovery
% on simulated data.  
%
% COMPARISONS PRINTED IN FIGURE:
% (left): Average support comparison of original/reconstructed x
% (middle): Average reconsruction error between original/reconstructed x 
% (right): Average run time of algorithms
%
% Written by Jeremy Watt and Reza Borhani
% Modified by Seunghwan Yoo

% Variables to play with 
dimx = 200;                 % # columns of A
dimy = 100;                 % # rows of A
spars_levels = 1:1:30;      % sparsity range of original x in simulations
num_its = 30;     %100      % # of instances to reconstruct per system

% Containers for printing results
mp_supp = zeros(length(spars_levels),num_its);  
mp_error = zeros(length(spars_levels),num_its);
mp_time = zeros(length(spars_levels),num_its);
omp_supp = zeros(length(spars_levels),num_its); 
omp_error = zeros(length(spars_levels),num_its);
omp_time = zeros(length(spars_levels),num_its);  

% Construct A for system Ax=b
A = randn(dimy,dimx);                       % System matrix for Ax=b
col_norms =  diag(1./sqrt(sum((A.*A))));
A = A*col_norms;                            % Normalize columns

%%% Main %%%
for S = 1:length(spars_levels)
    fprintf(' sparsity: %i\n',S);
    for j = 1:num_its
        %%% Construct x for system Ax = b %%%
        x = zeros(dimx,1); 
        num_spars = randperm(dimx);
        support = num_spars(1:spars_levels(S));
        x(support) = sign(randn(size(support)));
        b = A*x;    
        
        %%% Run sparse recovery algorithms %%%
        tic;
        % MP
        xmp = mp(A,b,S);
        mp_time(S,j) = toc;
        mp_support = find(xmp ~= 0);
        %mp_supp(S,j) = (max(length(support),length(mp_support)) - length(intersect(support,mp_support)))/ max(length(support),length(mp_support));
        mp_supp(S,j) = length(intersect(support,mp_support)) / max(length(support),length(mp_support));
        mp_error(S,j) = norm(A*xmp-b,'fro')/norm(b,'fro');
        
        tic
        % OMP
        xomp = omp(A,b,S);
        omp_time(S,j) = toc;
        omp_support = find(xomp ~= 0);
        %omp_supp(S,j) = (max(length(support),length(omp_support)) - length(intersect(support,omp_support)))/ max(length(support),length(omp_support));
        omp_supp(S,j) = length(intersect(support,omp_support)) / max(length(support),length(omp_support));
        omp_error(S,j) = norm(A*xomp-b,'fro')/norm(b,'fro');
        
    end
end

%%% Print out results %%%
figure,
subplot(1,3,1)
me = mean(mp_supp,2);
plot(me,'r');
hold on
me = mean(omp_supp,2);
plot(me,'b');

legend('MP','OMP')
xlabel('support of original signal')
ylabel('fraction of original vs recovered support')
title('Support overlap in original vs recovered signals')

subplot(1,3,2)
me = mean(mp_error,2);
plot(me,'r');
hold on
me = mean(omp_error,2);
plot(me,'b');

legend('MP','OMP')
xlabel('sparsity of original signal')
ylabel('error in reconstruction')
title('reconstruction error')

subplot(1,3,3)
me = mean(mp_time,2);
plot(me,'r');
hold on
me = mean(omp_time,2);
plot(me,'b');

legend('MP','OMP')
xlabel('support of original signal')
ylabel('average run-time')
title('Average run-times for algorithms')
