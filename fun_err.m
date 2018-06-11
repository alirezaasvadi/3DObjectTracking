function [ err ] = fun_err( obj, list, runtime )
%% All error info in the format
%  algorithm result - groundtruth
    %% location error (m)
    temp             = obj.list.cent_3d - list.obj_loc_list;
    err.loc.pcd      = sqrt(sum(abs(temp).^2, 2));
    
    %% location error (pixels)
    temp             = obj.list.cent_2d.bb - obj.list.gt.cent_2d;
    err.loc.pxl      = sqrt(sum(abs(temp).^2, 2));
    
    %% distance from object to ego-vehicle
    temp             = list.obj_loc_list - list.ego_loc_list;
    err.distance     = sqrt(sum(abs(temp).^2, 2));
    
    %% velocity error (m/s & km/h)
    err.velocity.mps = obj.list.gt.velocity_mps(:, :) - obj.list.velocity_mps(:, :);
    err.velocity.kph = obj.list.gt.velocity_kph(:, :) - obj.list.velocity_kph(:, :);
    
    err.velocity.xx  = abs(obj.list.velocity_xx - obj.list.gt.velocity_xx);
    err.velocity.yy  = abs(obj.list.velocity_yy - obj.list.gt.velocity_yy);
    %% number of object points in each frame
    err.num_pts      = obj.list.gt.num_pts;
    
    for it = 1 : size(err.loc.pcd, 1)
        %% rotation error around z-axis (rad)
        % gt_vector = [ cos(list.obj_rtn_2d_list(it, :)) sin(list.obj_rtn_2d_list(it, :)) 0 ]; % [cos(angle) sin(angle) 0]
        % fu_vector = [ cos(obj.list.pose_2d(it, :)) sin(obj.list.pose_2d(it, :)) 0 ];
        % err.rtn(it, :) = 2 * atan(norm(gt_vector*norm(fu_vector) - norm(gt_vector)*fu_vector) / norm(gt_vector * norm(fu_vector) + norm(gt_vector) * fu_vector));
        % http://gamedev.stackexchange.com/questions/69475/how-do-i-use-the-dot-product-to-get-an-angle-between-two-vectors
        % err.rtn(it, :) = acos( dot(gt_vector, fu_vector) / (norm(gt_vector) * norm(fu_vector)) );        
        ms_ang = obj.list.pose_3d(:, 1, it);  %ms_ang = ms_ang(1:2);
        gt_ang = list.ego_rtn_list(:, 1, it); %gt_ang = gt_ang(1:2);
        err.rtn(it, :) = acos( dot(gt_ang, ms_ang) / (norm(gt_ang) * norm(ms_ang)) );        
        
        %% 3d bounding box overlap percentage (%)
        err.bb.bb3d(it, :)                = bb_overlap_3D( obj.list.bb_3d(:, :, it), obj.list.gt.bb_3d(:, :, it), obj );
        % number of frames where > 25%  = size((find(err.bb_3d >= 25)), 1)
        %% 2d bounding box overlap percentage (%)
        % err.bb.bb2d(it, :)                = bb_overlap_2D( obj.list.bb_2d(:, :, it), obj.list.gt.bb_2d(:, :, it) );
        % number of frames where > 50%  = size((find(err.bb_2d >= 50)), 1)
    end
    err.bb.success_pct = size((find(err.bb.bb3d >= 25)), 1)/size(err.bb.bb3d, 1)*100;
    % err.runtime = runtime.ms3d;
    err.bb2d_list = obj.list.bb_2d_in_img;
    err.bb2d_flag = obj.list.bb_2d_flag;
    err.runtime = runtime.gate;
end