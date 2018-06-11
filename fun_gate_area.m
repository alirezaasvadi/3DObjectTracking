function [ obj, gate ] = fun_gate_area ( klm, obj, gate, pcd )
gate.bb_3d  = bb_calc ( gate, klm.location.next, 'src' );

src_ind     = inpolygon( pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                         [ gate.bb_3d(1:4, 1); gate.bb_3d(1, 1) ], ...
                         [ gate.bb_3d(1:4, 2); gate.bb_3d(1, 2) ]);

gate.rc     = pcd.ego.obs_pxs(src_ind, :);
gate.xyz    = pcd.world.obs_pts(src_ind, :);
obj.cent_3d = mean(gate.xyz, 1);
end