function [A, b] = generate_probabilities_system(rows)
  A_dimension = rows * (rows + 1) / 2;
  A = zeros (A_dimension);
  b = zeros (A_dimension, 1);
  %initializam prima probabilitate, intrucat este un caz particular mai
  %special, si oricum este aceeasi pentru orice valoare a lui "rows"
  A(1,1) = 4;
  A(1,2) = -1;
  A(1,3) = -1;
  
  %daca nu ne aflam pe ultima linie, fiecare probabilitate respecta o regula,
  %pe care o vom detalia in README
  probability = 2;
  for i = 2:rows-1
    end_column = i * (i + 1) / 2;
    begin_column = i * (i - 1) / 2 + 1;
    for j = begin_column:end_column
      %daca ne aflam intr-o celula la marginea din dreapta
      if j == begin_column
        A(probability,j) = 5;
        A(probability, j-i+1) = -1;
        A(probability, j+1) = -1;
        A(probability, j+i) = -1;
        A(probability, j+i+1) = -1;
        probability++;
        %daca ne aflam intr-o celula la marginea din stanga
      elseif j == end_column
        A(probability, j) = 5;
        A(probability, j-i) = -1;
        A(probability, j-1) = -1;
        A(probability, j+i) = -1;
        A(probability, j+i+1) = -1;
        probability++;
       else
        %daca ne aflam intr-o celula aflata in centrul labirintului
        A(probability, j) = 6;
        A(probability, j-1) = -1;
        A(probability, j+1) = -1;
        A(probability, j-i) = -1;
        A(probability, j-i + 1) = -1;
        A(probability, j+i) = -1;
        A(probability, j+i+1) = -1;
        probability++;
      endif
    endfor
  endfor
  %daca ne aflam pe ultima linie a labirintului, vom avea un altfel de
  %comportament
  end_column = rows * (rows + 1) / 2;
  begin_column = rows * (rows - 1) / 2 + 1;
  for i = begin_column:end_column
    if i == begin_column
      A(probability, i) = 4;
      A(probability, i+1) = -1;
      A(probability, i-rows+1) = -1;
      probability++;
    elseif i == end_column
      A(probability, i) = 4;
      A(probability, i-1) = -1;
      A(probability, i-rows) = -1;
      probability++;
    else
      A(probability, i) = 5;
      A(probability, i+1) = -1;
      A(probability, i-1) = -1;
      A(probability, i-rows) = -1;
      A(probability, i-rows+1) = -1;
      probability++;
    endif
    b(i) = 1;
  endfor
endfunction