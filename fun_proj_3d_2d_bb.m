function [ rect ] = fun_proj_3d_2d_bb ( points_3d, tform, st, flag )
if nargin == 3   
    DT = delaunayTriangulation ( points_3d );    % Delaunay triangulation in 3-D (bug fix:colinearity!) 
end

if ((nargin == 3) && (~isempty(DT.ConnectivityList))) || (nargin == 4)
    % transform from world to ego-vehicle coordinates
    translated       = points_3d - repmat(tform(1:3, 4)', size(points_3d, 1), 1);
    points_ego       = (tform(1:3, 1:3) \ translated')';

    % transform from ego coordinates to pixel space
    points_2d        = (st.t.clb * [points_ego, zeros(size(points_ego, 1), 1)]')';
    points_2d(:, 1)  = points_2d(:, 1) ./ points_2d(:, 3);
    points_2d(:, 2)  = points_2d(:, 2) ./ points_2d(:, 3);
    
    % 'Position', [x (c) y (r) w h]
    x_min = min(points_2d(:, 1));    
    y_min = min(points_2d(:, 2));  
    w     = max(points_2d(:, 1)) - min(points_2d(:, 1)); 
    h     = max(points_2d(:, 2)) - min(points_2d(:, 2)); 
    rect  = [x_min, y_min, w, h];
    
else
  if size(points_3d, 1) < 3
	disp('internal: not enough points in obj.xyz to triangulate.');
  else
	disp('internal: points are collinear.')  
  end
end
end