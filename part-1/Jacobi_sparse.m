function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
  %functie care primeste ca parametri matricea de iteratie Jacobi sub forma CSR
  %si vectorul de iteratie Jacobi si calculeaza solutiile sistemului prin 
  %respectiva metoda
  x0 = zeros (length(G_rowptr)-1,1);
  prev_x = x0;
  while 1
    %inmultirea cu CSR se va efectua folosind functia de inmultire a unei 
    %matrici CSR cu  un vector
    x = csr_multiplication (G_values, G_colind, G_rowptr, prev_x) + c;
    err = norm (x - prev_x);
    if err < tol
      return;
    endif
    prev_x = x;
  endwhile
endfunction