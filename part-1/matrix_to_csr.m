function [values, colind, rowptr] = matrix_to_csr(A)
  %functie  care realizeaza inmultirea unei matrice sub forma CSR cu un vector
  %folosind algoritmul dat in problema
  n = rows(A);
  nz = 1;
  elem_index = 0;
  for i = 1 : n
    ok = 0;
    for j = 1 : n
      if A(i,j) != 0
        values(nz) = A(i,j);
        colind(nz++) = j;
        elem_index++;
        if ok == 0
          rowptr(i) = elem_index;
          ok = 1;
        endif
      endif
    endfor
  endfor
  rowptr(++n) = nz;
endfunction