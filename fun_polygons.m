function rc_conv = fun_polygons ( obj, im )
%FUN_POLYGONS Summary of this function goes here
%   Detailed explanation goes here

    %% Convex hull in 2D
    k           = convhull(obj.rc(:, 1), obj.rc(:, 2));
    scale       = sqrt(2);
    sup_pts_in  = obj.rc(k, 1 : 2);
    cent_pt_in  = mean(sup_pts_in);
    radius      = sup_pts_in - repmat(cent_pt_in, size(sup_pts_in, 1), 1);
    sup_pts_out = repmat(cent_pt_in, size(sup_pts_in, 1), 1) + scale * radius;
    
    %% avoid going outside the image
    sup_pts_out(sup_pts_out(:, 1) < 1, 1) = 1;
    sup_pts_out(sup_pts_out(:, 2) < 1, 2) = 1;
    sup_pts_out(sup_pts_out(:, 1) > size(im, 2), 1) = size(im, 2);
    sup_pts_out(sup_pts_out(:, 2) > size(im, 1), 2) = size(im, 1);
       
    %% points inside polygons
    [r, c]          = meshgrid(1 : size(im, 2), 1 : size(im, 1));
    rc_meshgrid     = [r(:), c(:)];
    ind_out         = inpolygon(rc_meshgrid(:, 1), rc_meshgrid(:, 2), sup_pts_out(:, 1), sup_pts_out(:, 2));
    rc_meshgrid_out = rc_meshgrid(ind_out, :);
    ind_in          = inpolygon(rc_meshgrid_out(:, 1), rc_meshgrid_out(:, 2), sup_pts_in(:, 1), sup_pts_in(:, 2));
    rc_meshgrid_in  = rc_meshgrid_out(ind_in, :);
    rc_meshgrid_out(ind_in, :) = [];

    rc_conv.in         = rc_meshgrid_in;
    rc_conv.out        = rc_meshgrid_out;
    rc_conv.cent_pt_in = cent_pt_in;
    rc_conv.sup_pts_in = sup_pts_in;
    rc_conv.all        = [rc_conv.in; rc_conv.out];
end

