function [G_J, c_J] = Jacobi_factorization(A, b)
  %functie care calculeaza matricea si vectorul de iteratie a unei matrice A
  %cu vectorul coloana b, dupa formula bine cunoscuta, nimic special
  N = diag(diag(A));
  P = N - A;
  Inv_N = inv(N);
  G_J = Inv_N * P;
  c_J = Inv_N * b;
endfunction
