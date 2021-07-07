function [centroids] = clustering_pc(points, NC)
  %functie care realizeaza operatia de clusterizare, urmand pasii din cadrul
  %enuntului primit
  %Pasul 1, initializare cele NC clustere si centroizi dupa algoritmul dat
  nr_points = size (points, 1);
  for i = 1:NC
    j = 1;
    while i + (j - 1) * NC <= nr_points
      clusters(j,:) = points(i+(j-1)*NC,:);
      j++;
    endwhile
    j--;
    sum = zeros (1, size (points, 2));
    for k = 1:j
      sum += clusters(k,:);
    endfor
    centroids(i,:) = sum / j;
  endfor
  %Pe scurt repetarea pasilor 2, 3 si 4 pana cand centrozii ajung la valoarea
  %la care trebuie, sau pana cand numarul maxim al pasilor este atins
  max_iter = 25;
  for i = 1:max_iter
    %initializarea celor NC grupuri goale
    sum = zeros (NC, size (points, 2));
    nr_elem = zeros (1, NC);
    %inserarea unui punct in clusterul de care apartine, a.k.a the closest 
    %centroid
    for j = 1:nr_points
      min_dist = 1e+6;
      pos_cen = 0;
      for k = 1:NC
        if min_dist > norm (points(j,:) - centroids(k,:))
          min_dist = norm (points(j,:) - centroids(k,:));
          pos_cen = k;
        endif
      endfor
      sum(pos_cen,:) += points(j,:);
      nr_elem(pos_cen)++;
    endfor
    %recalcularea pozitiilor centroizilor
    for j = 1:NC
      if nr_elem(j) > 0
        centroids(j,:) = sum(j,:) / nr_elem(j);
      endif
    endfor
  endfor
endfunction
