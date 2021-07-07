function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  %functia care evalueaza daca o predictie a fost facuta corect sau nu
  percentage = 0;
  %Prima oara luam pozele cu pisici, daca y >= 0, atunci a ghicit bine, si
  %percentage va creste
  path_to_cats = strcat (path_to_testset, 'cats/');
  images = getImgNames (path_to_cats);
	[n d] = size (images);
  cat_image = images(:, 1:d);
  path_to_image = strcat (path_to_cats, cat_image);
  %pozele de tip RGB
  if histogram == 'RGB'
    for i = 1 : n
      X(i,:) = rgbHistogram (path_to_image(i,:), count_bins);
    endfor
  else
    %pozele de tip HSV
    for i = 1:n
      X(i,:) = hsvHistogram (path_to_image(i,:), count_bins);
    endfor
  endif
  
  %al doilea pas este de a evalua si pozele care nu contin pisici; in acest caz,
  % y < 0 atunci predictia a fost factuta corect, si deci in acest caz, 
  %percentage va creste
  path_to_not_cats = strcat (path_to_testset, 'not_cats/');
  images = getImgNames (path_to_not_cats);
  [not_n not_d] = size (images);
  not_cat_image = images (:, 1:not_d);
	path_to_not_image = strcat(path_to_not_cats, not_cat_image);
  %pozele de tip RGB
  if histogram == 'RGB'
    for i = 1:not_n
      X(n+i,:) = rgbHistogram (path_to_not_image(i,:), count_bins);
    endfor
  else
    %pozele de tip HSV
    for i = 1:not_n
      X(n+i,:) = hsvHistogram (path_to_not_image(i,:), count_bins);
    endfor
  endif
  
  [heigth width] = size(X);
  %scalam matricea X nou obtinuta
  for i = 1 : width
    X(:,i) = (X(:,i) - mean(X(:,i)))/std(X(:,i));
  endfor
  %calculam percentage obtinut, prin inmultirea fiecarei linii din X cu y 
  X = [X ones(heigth, 1)];
  for k = 1 : heigth
    y = w' * X';
    if k <= n && y(k) >= 0
      percentage++;
    elseif k > n && y(k) < 0
      percentage++;
    endif
  endfor
  num_of_images = n + not_n;
  percentage = percentage / num_of_images;
endfunction