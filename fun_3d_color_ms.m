function [ obj, shift_norm ] = fun_3d_color_ms ( pcd, obj, im, st )
    obj.cent_3d_prev = obj.cent_3d;
    %% points inside bounding box
    obj_ind     = inpolygon(pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                            [obj.bb_3d(1 : 4, 1); obj.bb_3d(1, 1)], [obj.bb_3d(1 : 4, 2); obj.bb_3d(1, 2)]);
    obj.xyz     = pcd.world.obs_pts(obj_ind, :);
    obj.rc      = pcd.ego.obs_pxs(obj_ind, :);
    obj.col     = impixel(im, obj.rc(:, 1), obj.rc(:, 2)) ./ 255;
    obj_col     = obj.col*255;
    obj_qnt_col = floor(double(obj_col) / st.level) + 1;

    %% clear object confident map
    obj_cmp     = zeros(size(obj, 1), 1);
    
    %% obtain new object confident map
    for i       = 1 : size(obj.xyz, 1)
        obj_cmp(i, 1) = obj.his(obj_qnt_col(i, 1), obj_qnt_col(i, 2), obj_qnt_col(i, 3));
    end
    obj_cmp(obj_cmp < 0) = 0;

    %% get object location based on rgb histogram
    obj.cent_3d    = [sum(obj.xyz(:, 1) .* obj_cmp), ...
                      sum(obj.xyz(:, 2) .* obj_cmp), ...
                      sum(obj.xyz(:, 3) .* obj_cmp)] ...
                      / sum(obj_cmp);
    
    %% get mean-shift between location and previous location
    shift  =  obj.cent_3d - obj.cent_3d_prev;
    
    %% shift norm
    shift_norm  = sqrt(shift(1)^2 + shift(2)^2 + shift(3)^2);
end