function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  %functia care obtine matricea X si vectorul y, prin aplicarea functiei de 
  %RGB sau de HSV pentru fiecare poza in parte, si apoi introducand fiecare
  %vector histograma in cadrul matricei X
  
  %Prima oara luam pozele cu pisici si aplicam functiile de obtinere a
  %histogramei
  path_to_cats = strcat (path_to_dataset, 'cats/');
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
  y = ones (n,1);
  
  %Dupa aceea luam si pozele care nu sunt cu pisici si, la fel ca inainte,
  %vom adauga histogramele pozelor la matricea X(using append, of course :) )
  path_to_not_cats = strcat (path_to_dataset, 'not_cats/');
  images = getImgNames (path_to_not_cats);
  [not_n not_d] = size (images);
  not_cat_image = images(:, 1:not_d);
  path_to_not_image = strcat (path_to_not_cats, not_cat_image);
  
  %pozele de tip RGB  
  if histogram == 'RGB'
    for i = 1:not_n
      X(n + i,:) = rgbHistogram (path_to_not_image(i,:), count_bins);
    endfor
  else
    %pozele de tip HSV
    for i = 1:not_n
      X(n+i,:) = hsvHistogram (path_to_not_image(i,:), count_bins);
    endfor
  endif
  y = [y; -ones(not_n, 1)];

endfunction
