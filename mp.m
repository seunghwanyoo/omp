function x = mp(A,b,S)

% Matching Pursuit (MP)
% 
% Input:
%   A: dictionary (matrix)
%   b: signal 
%   S: sparsity level
% Output:
%   x: coeff vector for sparse representation

[N,K] = size(A);
if (N ~= size(b))
    error('Dimension not matched');
end

x = zeros(K,1);      % coefficient (output)
r = b;               % residual
omega = zeros(S,1);  % selected support
cnt = 0;
while (cnt < S)
    cnt = cnt+1;
    x_tmp = zeros(K,1);
    inds = setdiff([1:K],omega); % iterate all columns except for the chosen ones
    for i = inds
        x_tmp(i) = A(:,i)' * r;
    end
    [~,ichosen] = max(abs(x_tmp));
    x(ichosen) = x_tmp(ichosen);  % update x
    omega(cnt) = ichosen;
    r = r - A(:,ichosen) .* x(ichosen);  % update r
end
