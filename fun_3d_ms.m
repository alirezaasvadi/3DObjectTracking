function [ flag, obj, shift_norm ] = fun_3d_ms ( pcd, obj )
    flag.err_3d = 0;
    obj.cent_3d_prev = obj.cent_3d;
    %% points inside bounding box
    obj_ind     = inpolygon(pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                  [obj.bb_3d(1 : 4, 1); obj.bb_3d(1, 1)], [obj.bb_3d(1 : 4, 2); obj.bb_3d(1, 2)]);
    if sum(obj_ind) == 0
        flag.err_3d = 1;
        shift_norm  = 0;
    else
        obj.xyz     = pcd.world.obs_pts(obj_ind, :);

        %% get mean-shift between location and previous location
        shift  = mean(obj.xyz) - obj.cent_3d_prev;

        %% save object 3d centroid
        obj.cent_3d = mean(obj.xyz, 1);

        %% shift norm
        shift_norm  = sqrt(shift(1)^2 + shift(2)^2 + shift(3)^2);
    end
end