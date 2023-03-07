function [Kmat] = adaptiveKmat(X,kmax,kmin)
X = X';
kmax = kmax+1;
[idx, distX] = knnsearch(X,X,'k',kmax);
[N,Dx] = size(X);
degree_x = tabulate(idx(:));
Kmat = degree_x(:,2);
Kmat(Kmat >= kmax)=kmax;
Kmat(Kmat <= kmin)=kmin;
if length(Kmat) < N
    Kmat(length(Kmat)+1:N) = kmin;
end
