function [sol] = hsvHistogram(path_to_image, count_bins)
  %citirea unei imagini si prelucrarea acesteia din format RGB in format HSV
  [Ximg] = imread (path_to_image);
  lambda_interval = 1.01 / count_bins;
  img = cast (Ximg, 'double');
  [height width] = size(img (:,:,1));
  [hsv_image] = My_own_rgb2hsv (img);
  sol = [];
  %obtinerea vectorului ce reprezinta histograma imaginii
  %Pentru calcularea numarului de pixeli dintr-un anumit interval, am utilizat
  %functia histc
for i = 1:3
    new_img = hsv_image(:,:,i);
    img_vect = new_img(:);
    nr = histc (img_vect, 0:lambda_interval:1.01)';
    nr(end) = [];
    sol = [sol nr];
  endfor
endfunction