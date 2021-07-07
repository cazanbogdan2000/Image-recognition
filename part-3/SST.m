function [x] = SST(A, b);
  %daca height > width, nu ne pasa, ultimele linii sunt == 0
  [n m] = size(A);
  x = zeros (min (m,n), 1);
  if n > m
    for i = m:-1:1
      x(i) = (b(i) - A(i, i+1 : m) * x(i + 1 : m)) / A(i,i);
    endfor
  else
    %daca e invers, atunci e de rau, trebuie sa aproximam solutiile
    x = A \ b;
  endif
endfunction
    