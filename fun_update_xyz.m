function [ obj ] = fun_update_xyz ( obj, pcd )
    ind_obj = inpolygon ( pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                        [ obj.bb_3d(1:4,1); obj.bb_3d(1,1) ], [ obj.bb_3d(1:4,2); obj.bb_3d(1,2) ] );
    obj.xyz = pcd.world.obs_pts(ind_obj, :);
end