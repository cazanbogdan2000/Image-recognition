function [cost] = compute_cost_pc(points, centroids)
  %functie care calculeaza costul minim, adica distanta unui punct de centroidul
  %din clusterul din care cele doua elemente apartin (aceea find, de fapt,
  %distanta, costul minim)
  cost = 0;
  for i = 1:size (points, 1)
    min_dist = 1e+6;
    for j = 1:size (centroids, 1)
      %distanta se poate calcula dupa formula generala, insa intrucat nu
      %cunoastem dimensiunea spatiului in care se afla punctele, vom calculca 
      %norma, care e <=> cu distanta
      if min_dist > norm (points(i,:) - centroids(j,:))
        min_dist = norm (points(i,:) - centroids(j,:));
      endif
    endfor
    cost += min_dist;
  endfor
endfunction