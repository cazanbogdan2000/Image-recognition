function [sol] = rgbHistogram(path_to_image, count_bins)
  %Citirea imaginii si initializarea datelor necesare
  [img] = imread(path_to_image);
  lambda_interval = 256 / count_bins;
  [height width] = size(img(:,:,1));
  sol = [];
  
  %obtinerea vectorului ce reprezinta histograma imaginii
  %Pentru calcularea numarului de pixeli dintr-un anumit interval, am utilizat
  %functia histc
  for i = 1:3
    new_img = img(:,:,i);
    img_vect = new_img(:);
    nr = histc (img_vect, 0:lambda_interval:256)';
    nr(end) = [];
    sol = [sol nr];
  endfor
endfunction