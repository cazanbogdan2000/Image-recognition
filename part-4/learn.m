function [w] = learn(X, y, lr, epochs)
  %Aplicam algoritmul prezentat in enunt
  %Initializare batch si alte variabile de care vom avea nevoie
  batch_size = 64;
  [heigth width] = size(X);
  N = heigth; %numarul de imagini
  %generarea unui w random cu elemente intre [-0.1, 0.1]
  w = randi([-1 1],width + 1, 1) / 100000;
  %scalarea matricei X dupa formula data
  for i = 1 : width
    X(:,i) = (X(:,i) - mean(X(:,i)))/std(X(:,i));
  endfor
  X = [X ones(heigth, 1)];
  %obtinerea lui w, aplicand algoritmul din enunt
  for epoch = 1 : epochs
    col_index = randperm(heigth,batch_size);
    X_batch = X(col_index,:);
    y_batch = y(col_index,:);
    for i = 1 : (width + 1)
      for j = 1 : batch_size
        sigma = (X_batch(j,:) * w - y_batch(j)) * X_batch(j,i);
      endfor
      w(i) = w(i) - lr / N * sigma;
    endfor
  endfor
  
endfunction
