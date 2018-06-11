function [ rc_mesh_hull, obj_his, cmp_2d_cnt ] = fun_im_hist ( st, im, proj_obj )
    %% Convex hull in 2D
    k   = convhull(proj_obj(:, 1), proj_obj(:, 2));
    % imshow(im); hold on;

    %% meshgrid
    [r, c]  = meshgrid(1:size(im, 2), 1:size(im, 1));
    rc_mesh = [r(:), c(:)];
    ind     = inpolygon(rc_mesh(:, 1), rc_mesh(:, 2), proj_obj(k, 1), proj_obj(k, 2));
    rc_mesh_hull = rc_mesh(ind, :);
    
    %% poly2mask
    % mask = poly2mask(rc_mesh(:, 1), rc_mesh(:, 2), size(im, 1), size(im, 2));
    
    %% 
    % mean_rc = mean(rc_mesh_hull);
    % hold on;
    % plot(rc_mesh_hull(:, 1), rc_mesh_hull(:, 2), '.y');
    % plot(mean_rc(1), mean_rc(2), '*r');
    % plot(bb_pixels(:, 1), bb_pixels(:, 2), '*b');
    % bb_draw ( object, mean_rc, 1 )
    % hold off;

    %% colored points inside bounding box
    obj_col     = impixel(im, rc_mesh_hull(:, 1), rc_mesh_hull(:, 2)) ./ 255;  % RGB from 0 to 1
    obj_col     = obj_col*255;
    obj_qnt_col = floor(double(obj_col) / st.level) + 1;

    %% get histogram for object colors
    obj_his     = accumarray(obj_qnt_col, 1, [st.bin st.bin st.bin]);

    %% clear ob_cmp
    obj_cmp     = zeros(size(obj_col, 1), 1);
    for i       = 1 : size(rc_mesh_hull, 1)
        obj_cmp(i, 1) = obj_his(obj_qnt_col(i, 1), obj_qnt_col(i, 2), obj_qnt_col(i, 3));
    end
    obj_cmp(obj_cmp < 0) = 0;

    %% get object location based on rgb histogram
    cmp_2d_cnt  = [sum(rc_mesh_hull(:, 1) .* obj_cmp), ...
                   sum(rc_mesh_hull(:, 2) .* obj_cmp)] ...
                   / sum(obj_cmp);
               
%     %% get mean-shift between location and previous location
%     mean_shift  = location - prev_location;
%     
%     %% update bounding box
%     bb          = [ bb(:, 1) + mean_shift(1), bb(:, 2) + mean_shift(2), bb(:, 3) + mean_shift(3) ];
end