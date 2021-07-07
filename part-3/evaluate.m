function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  %functia care evalueaza daca o poza este sau nu o poza cu pisici
  
  percentage = 0;
  %Prima oara luam pozele cu pisici, daca y >= 0, atunci a ghicit bine, si
  %percentage va creste
  path_to_cats = strcat (path_to_testset, 'cats/');
  images = getImgNames (path_to_cats);
	[n d] = size (images);
  
  for i = 1:n
	  cat_image = images(i, 1:d);
	  path_to_image = strcat (path_to_cats, cat_image);
    %pozele de tip RGB
    if histogram == 'RGB'
      x = rgbHistogram (path_to_image, count_bins);
      y = w' * x';
      if y >= 0
        percentage++;
      endif
    else
      %pozele de tip HSV
      x = hsvHistogram (path_to_image, count_bins);
      y = w' * x';
      if y >= 0
        percentage++;
      endif
    endif
  endfor
  
  %al doilea pas este de a evalua si pozele care nu contin pisici; in acest caz,
  % y < 0 atunci predictia a fost factuta corect, si deci in acest caz, 
  %percentage va creste
  path_to_not_cats = strcat (path_to_testset, 'not_cats/');
  images = getImgNames (path_to_not_cats);
	[not_n not_d] = size (images);
  
  for i = 1:not_n
	  not_cat_image = images(i, 1:not_d);
	  path_to_image = strcat (path_to_not_cats, not_cat_image);
    %pozele de tip RGB
    if histogram == 'RGB'
      x = rgbHistogram (path_to_image, count_bins);
      y = w' * x';
      if y < 0
        percentage++;
      endif
    else
      %pozele de tip HSV
      x = hsvHistogram (path_to_image, count_bins);
      y = w' * x';
      if y < 0
        percentage++;
      endif
    endif
  endfor
  num_of_images = n + not_n;
  percentage = percentage / num_of_images;
endfunction