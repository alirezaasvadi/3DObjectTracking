function [ first_location, first_pose, obj ] = fun_first_model( st, vector_idx, pcd, T_ego, im)

    %% transformation of ego-vehicle in world coordinate   
    data        = st.object_data{vector_idx};
    object.h    = data.h;
    object.w    = data.w;
    object.l    = data.l;
    object.area = object.w * object.l;
    object.vol  = object.area * object.h;
    object.ry   = -data.ry-pi/2;
    
    %% transformation of object in camera (ego-vehicle) coordinate
    T      = data.t';
    R      = ry_to_world(data.ry);
    T_cam  = [R, T; 0 0 0 1];
   
    %% transformation of object on velodyne (ego-vehicle) coordinate
    T_vel  = st.t.v2c \ T_cam;                                             % cyclist location in camera -> cyclist location in velodyne

    %% transformation in world coordinate   
    T_world = T_ego * T_vel;   
    T_world = T_world * [rotation_mat([pi/2, 0, 0]), [0; 0; 0]; [0 0 0 1]];
    
    first_pose        = T_world(1:3, 1:3);  
    first_location    = T_world(1:3, 4);
    first_location    = first_location';
%     first_location(3) = first_location(3) + data.h / 2;
    
    %% object centroid
    obj.cent_3d       = first_location;
    obj.cent_3d(3)    = obj.cent_3d(3) + data.h/2;
    obj.cent_2d       = fun_proj_3d_2d (obj.cent_3d, T_ego, st, 1); 
    obj.cent_2d(3:4)  = [];
       
    %% get 2d/3d bounding box for object
    obj.bb_3d   = box_calc(data, first_location);      % list of vertices
    proj_2d = fun_proj_3d_2d (obj.bb_3d, T_ego, st); 
    
    obj.bb_2d   = [min(proj_2d(:, 1)), min(proj_2d(:, 2)), ...
                   max(proj_2d(:, 1)) - min(proj_2d(:, 1)), ...
                   max(proj_2d(:, 2)) - min(proj_2d(:, 2))]; % [xmin (col), ymin (row), width, height]

    %% colored points inside bounding box
    obj_ind     = inpolygon(pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                  [obj.bb_3d(1 : 4, 1); obj.bb_3d(1, 1)], [obj.bb_3d(1 : 4, 2); obj.bb_3d(1, 2)]);
    obj.xyz     = pcd.world.obs_pts(obj_ind, :);
    obj.rc      = pcd.ego.obs_pxs(obj_ind, :);
    obj.r_3d    = first_pose;
    
    if nargin == 5
        obj.col     = impixel(im, obj.rc(:, 1), obj.rc(:, 2)) ./ 255;          % RGB from 0 to 1
        obj_col     = obj.col*255;
        obj_qnt_col = floor(double(obj_col) / st.level) + 1;
    
        %% get histogram for object colors
        obj.his     = accumarray(obj_qnt_col, 1, [st.bin st.bin st.bin]);    
    end
    
    %% object class  
    if object.vol <= st.class(1)
        obj.class = 1;   % pedestrian
    elseif (object.vol <= st.class(2)) && (object.vol > st.class(1))
        obj.class = 2;   % cyclist
    else
        obj.class = 3;   % vehicle
    end
    
end

