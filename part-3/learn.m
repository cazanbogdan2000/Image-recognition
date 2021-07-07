function [w] = learn(X, y)
  %functie care obtine vectorul w prin aplicarea Householder in obtinerea
  %unei matrice superior triunghiulara si apoi calcularea solutiilor prin
  %algoritmul de SST
  [heigth width] = size(X);
  X_tilda = [X, ones(heigth, 1)];
  [Q R] = Householder(X);
  b_new = Q' * y;
  w = SST (R, b_new);
endfunction
