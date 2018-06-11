function [ proj ] = fun_proj_area ( obj, pcd )
proj_area = bb_calc ( obj, obj.cent_3d, 'src' );
% proj_area = bb_calc ( obj, obj.cent_3d ); % same as bounding box

src_ind     = inpolygon( pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                         [ proj_area(1:4, 1); proj_area(1, 1) ], ...
                         [ proj_area(1:4, 2); proj_area(1, 2) ]);

proj.rc     = pcd.ego.obs_pxs(src_ind, :);
proj.xyz    = pcd.world.obs_pts(src_ind, :);
end