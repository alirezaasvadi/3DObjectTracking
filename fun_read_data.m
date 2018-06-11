function [ pcd, im, tform, list ] = fun_read_data ( epoch, vector_idx, st, list )
    %% im & points
    im                      = imread(sprintf('%s/%06d.png', st.dr.img, epoch - 1));
    im_max_width            = size(im, 2); im_max_height = size(im, 1); im_min = 1;

    fid                     = fopen(sprintf('%s/%06d.bin', st.dr.pts, epoch - 1), 'rb');  % read from directory of points
    velodyne                = fread(fid, [4 inf], 'single')';                             % velodyne points [x, y, z, r]
    fclose(fid);

    %% local grid
    index_local             = (velodyne(:, 1) < st.x_max) & (velodyne(:, 1) > st.x_min) & ...
                              (velodyne(:, 2) < st.y_max) & (velodyne(:, 2) > st.y_min) & ...
                              (velodyne(:, 3) < st.z_max) & (velodyne(:, 3) > st.z_min);
    velodyne                = velodyne(index_local, :);

    %% get pixels from image
    velodyne_pixels         = (st.t.clb * velodyne')';
    velodyne_pixels(:, 1)   = velodyne_pixels(:, 1) ./ velodyne_pixels(:, 3);
    velodyne_pixels(:, 2)   = velodyne_pixels(:, 2) ./ velodyne_pixels(:, 3);
    velodyne_pixels(:, 3)   = velodyne_pixels(:, 3) ./ velodyne_pixels(:, 3);

    index_local_pixels      = (velodyne_pixels(:, 1) <= im_max_width)  & (velodyne_pixels(:, 1) >= im_min) & ...
                              (velodyne_pixels(:, 2) <= im_max_height) & (velodyne_pixels(:, 2) >= im_min);
                          
    pixels                  = velodyne_pixels(index_local_pixels, 1:2);
    velodyne_pixels         = velodyne(index_local_pixels, 1:3);
    velodyne_out            = velodyne(~index_local_pixels, 1:3);
    pcd.ego.pixel_loc       = pixels;
    pcd.ego.in_img          = velodyne_pixels;
    pcd.ego.out_img         = velodyne_out; 
    pcd.ego.all_pts         = velodyne;
    
    %% transformation of ego-vehicle in world coordinate
    tform                  = st.dr.pose(:, :, epoch);                                  % transformation matrix in camera coordinate
    car_rtn                 = tform(1:3, 1:3);                                      % rotation    3x3
    car_loc                 = tform(1:3, 4);                                        % translation 3x1
    velodyne                = velodyne(:, 1:3) * car_rtn' + repmat(car_loc', size(velodyne(:, 1:3), 1), 1);  % transformed velodyne points (Xp = RX + T)
    velodyne_pixels         = velodyne_pixels(:, 1:3) * car_rtn' + repmat(car_loc', size(velodyne_pixels(:, 1:3), 1), 1);
    velodyne_out            = velodyne_out(:, 1:3) * car_rtn' + repmat(car_loc', size(velodyne_out(:, 1:3), 1), 1);
    pcd.world.in_img        = velodyne_pixels;
    pcd.world.out_img       = velodyne_out;                 
    pcd.world.all_pts       = velodyne;
    
    %% ground truth (only required for testing)
    %  object locations
    T_ego = [car_rtn, car_loc; 0 0 0 1];

    if epoch <= st.end_fr %st.start_fr + (size(object_data, 2))
        % data     = object_data{epoch};
        data     = st.object_data{vector_idx};
        %% transformation of object in camera (ego-vehicle) coordinate
        T   = data.t';
        R   = ry_to_world(data.ry);
        T_cam = [R, T; 0 0 0 1];

        %% transformation of object on velodyne (ego-vehicle) coordinate
        T_vel  = st.t.v2c \ T_cam;                                             % cyclist location in camera -> cyclist location in velodyne

        %% transformation in world coordinate
        T_world = T_ego * T_vel;

        T_world = T_world * [rotation_mat([pi/2, 0, 0]), [0; 0; 0]; [0 0 0 1]];

        obj_rtn_world    = T_world(1:3, 1:3);
        obj_loc_world    = T_world(1:3, 4);
        obj_loc_list(vector_idx, 1:3)        = obj_loc_world;
        obj_loc_list(vector_idx, 3)          = obj_loc_list(vector_idx, 3) + data.h/2;
        obj_rtn_list(1:3, 1:3, vector_idx)   = obj_rtn_world;
        list.obj_loc_list(vector_idx, :)     = obj_loc_list(vector_idx, :);
        list.obj_rtn_list(:, :, vector_idx)  = obj_rtn_list(:, :, vector_idx);
        list.ego_loc_list(vector_idx, :)     = car_loc;
        list.ego_rtn_list(:, :, vector_idx)  = car_rtn;
%         list.obj_rtn_2d_list(vector_idx, :)  = -data.ry-pi/2;
    end
    
end