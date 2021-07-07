function [hsv_image] = My_own_rgb2hsv(img)
  %functie care prelucreaza o imagine in format RGB si o transforma intr-una de
  %tip HSV, folosind algoritmul dat in cadrul enuntului
  heigth = size (img, 1);
  width = size (img, 2);
  img = img / 255;
  R_new = img(:,:,1);
  G_new = img(:,:,2);
  B_new = img(:,:,3);
  
  %initializare matrice cu pixeli maximi, minimi, respectiv delta din enunt
  C_max = max (max (R_new, G_new), B_new);
  C_min = min (min (R_new, G_new), B_new);
  delta = C_max - C_min;   
  %initializare cele 3 cazuri pentru H
  H = S = V = zeros (heigth, width);
  case1 = mod (((G_new - B_new) ./ delta), 6) / 6;
  case2 = (((B_new - R_new) ./ delta) + 2) / 6;
  case3 = (((R_new - G_new) ./ delta) + 4) / 6;
  
  %obtinerea lui H
  H(C_max == R_new) = case1(C_max == R_new);
  H(C_max == G_new) = case2(C_max == G_new);
  H(C_max == B_new) = case3(C_max == B_new);
  H(delta == 0) = 0;

  %obtinerea lui S
  index = (C_max != 0);
  if any(index)
    S(index) = delta(index) ./ C_max(index);
  else
    S(!index) = 0;
  endif
    
    %obtinerea lui V si construirea matricii hsv_image
    V = C_max;
    hsv_image(:,:,1) = H;
    hsv_image(:,:,2) = S;
    hsv_image(:,:,3) = V;
    
endfunction