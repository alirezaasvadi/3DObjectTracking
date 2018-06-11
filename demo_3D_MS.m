%% clear memory & command window
clear; close all; clc;
% 
% st = setting_save(9);
% st.start_fr = 220;
% st.end_fr = 275;
% st.object_class = 3;
% [ object_data ] = init_object_data ( st, st.object_class );
% save_object_data( object_data, st );
% 
% figure('units','normalized','outerposition',[0 0 1 1]);

%% setting
for i = 1 : 50
dataset = i;
st      = setting(dataset);
st.num_fr = st.end_fr - st.start_fr + 1; disp([i st.num_fr]);
epoch   = st.start_fr;

% lists indexes
vector_idx             = 1;
% ground truth data
list.obj_loc_list      = zeros(st.end_fr-st.start_fr+1, 3);
list.obj_rtn_list      = zeros(3, 3, st.end_fr-st.start_fr+1);
list.ego_loc_list      = zeros(st.end_fr-st.start_fr+1, 3);
% ground kalman
gnd_klm_ang            = 0;
n_prev                 = 2;
klm_bins(st.bin^3).s   = [];
vrs                    = [];
obj                    = [];
clear runtime;

thresh = fun_gnd_klm_ang_select(i);

%% main
tic
for epoch = st.start_fr : st.end_fr
    
[pcd, im, tform, list ]              = fun_read_data(epoch, vector_idx, st, list);       % read pcd & im
[pcd, gnd_klm_ang]                   = fun_gnd_rm (st, pcd, epoch, gnd_klm_ang, thresh);          % removal of ground points

if epoch == st.start_fr % first scan
    [first_location, first_pose, obj]   = fun_first_model( st, vector_idx, pcd, tform);  % object 2d/3d bb/centroid & xyz/rc 
    [ ~, ~, obj.ry ]                 = decompose_rotation ( first_pose );             % get object pose
    if obj.class == 1 || obj.class == 2 % pedestrian and cyclists
        n_prev_loc_tr   = 0.05; % 5 cm, higher more frequently happens (dnm=8, stopped van, 1m)
        n_prev_rot_tr   = 0.4;  % 0.5 radian, lower ...
    else                                      % cars
        n_prev_loc_tr   = 0.4;  % 25 cm, higher more frequently happens (dnm=8, stopped van, 1m)
        n_prev_rot_tr   = 0.15;  % 0.5 radian, lower ...
    end
    [ obj, obj_gt ]                  = object_update ( obj, st );                     % update object struct

    bb_gt = bb_calc ( obj_gt, [list.obj_loc_list(vector_idx, 1), list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3)] );
    
    obj.velocity.mps = 0;
    obj.velocity.kph = 0;
    obj.list.velocity_gt.mps(vector_idx, :) = 0;
    obj.list.velocity_gt.kph(vector_idx, :) = 0;
    obj_angle_to_x = obj.ry;
else % remaining scans
    orig_cent_3d = obj.cent_3d;                                 % save original centroid for beginning of current frame
    
    %% 3d mean-shift iteration    
    tic
    loc_prev = obj.cent_3d;
    [ flag, obj, shift_norm ] = fun_3d_ms ( pcd, obj );
    obj.ry = atan2((loc_prev(2) - obj.cent_3d(2)), (loc_prev(1) - obj.cent_3d(1)));
    obj.bb_3d    = bb_calc ( obj, obj.cent_3d );
    mi_3d = 0;
    while (shift_norm > 0.05 && mi_3d <= 10)
        loc_prev = obj.cent_3d;
        [ flag, obj, shift_norm ] = fun_3d_ms ( pcd, obj );
        obj.ry = atan2((loc_prev(2) - obj.cent_3d(2)), (loc_prev(1) - obj.cent_3d(1)));
        obj.bb_3d    = bb_calc ( obj, obj.cent_3d );
        mi_3d = mi_3d + 1;
    end
    ms_cent = obj.cent_3d;
    runtime.ms3d(vector_idx, :) = toc;
    
    obj.velocity.mps = norm(obj.cent_3d - orig_cent_3d) / 0.1;
    obj.velocity.kph = obj.velocity.mps * 3.6;

    % update object pose    
    obj.ry       = atan2((obj.cent_3d(2) - orig_cent_3d(2)), (obj.cent_3d(1) - orig_cent_3d(1)));
    obj.r_3d     = rz_to_world( obj.ry );
    obj_ori_world  = obj.cent_3d - orig_cent_3d;
    
    numerator       = cross(obj_ori_world, [1 0 0]);
    denominator     = dot(obj_ori_world, [1 0 0]);  
    if denominator  == 0
    denominator     = eps;
    end
%     obj_angle_world = radtodeg(abs(atan(numerator / denominator)));
    obj_angle_world = abs(atan(numerator / denominator));
    obj_angle_to_x  = obj_angle_world(3);
    
    obj.bb_3d    = bb_calc ( obj, obj.cent_3d );
    [ obj ]  = fun_update_xyz ( obj, pcd );    
    [~, ~, obj_gt.ry] = decompose_rotation ( list.obj_rtn_list(:, :, vector_idx) );
    bb_gt = bb_calc ( obj_gt, [list.obj_loc_list(vector_idx, 1), list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3)] );
end

%% quantitative evaluation information
% proposed algorithm
obj.list.cent_3d(vector_idx, :)             = obj.cent_3d;
obj.list.velocity_mps(vector_idx, :)        = obj.velocity.mps;
obj.list.velocity_kph(vector_idx, :)        = obj.velocity.kph;
obj.list.pose_2d(vector_idx, :)             = obj_angle_to_x; %obj.ry;
obj.list.gt.pose_2d(vector_idx, :)          = obj_gt.ry;
obj.list.pose_3d(:, :, vector_idx)          = obj.r_3d;
obj.list.bb_3d(:, :, vector_idx)            = obj.bb_3d;

if vector_idx == 1
    obj.list.velocity_xx(vector_idx, :)     = 0;
    obj.list.velocity_yy(vector_idx, :)     = 0;
    obj.list.gt.velocity_xx(vector_idx, :)  = 0;
    obj.list.gt.velocity_yy(vector_idx, :)  = 0;
else
    obj.list.gt.velocity_mps(vector_idx, :) = norm(list.obj_loc_list(vector_idx, :) - list.obj_loc_list(vector_idx-1, :), 1) / 0.1;
    obj.list.gt.velocity_kph(vector_idx, :) = obj.list.gt.velocity_mps(vector_idx, :) * 3.6;
    
    obj.list.velocity_xx(vector_idx, :)     = cos(obj.ry) * obj.velocity.kph;
    obj.list.velocity_yy(vector_idx, :)     = sin(obj.ry) * obj.velocity.kph;
    obj.list.gt.velocity_xx(vector_idx, :)  = cos(obj_gt.ry) * obj.list.gt.velocity_kph(vector_idx, :);
    obj.list.gt.velocity_yy(vector_idx, :)  = sin(obj_gt.ry) * obj.list.gt.velocity_kph(vector_idx, :);
end

rect_2d = fun_proj_3d_2d_bb ( obj.bb_3d, tform, st, flag );
obj.list.bb_2d(:, :, vector_idx)            = [rect_2d(1)            rect_2d(2);
                                               rect_2d(1)            rect_2d(2)+rect_2d(4);
                                               rect_2d(1)+rect_2d(3) rect_2d(2)+rect_2d(4);
                                               rect_2d(1)+rect_2d(3) rect_2d(2);
                                               rect_2d(1)            rect_2d(2);];
h = pdist(([obj.list.bb_2d(1, 1, vector_idx) obj.list.bb_2d(1, 2, vector_idx);
            obj.list.bb_2d(2, 1, vector_idx) obj.list.bb_2d(2, 2, vector_idx)]),'euclidean');
l = pdist(([obj.list.bb_2d(1, 1, vector_idx) obj.list.bb_2d(1, 2, vector_idx);
            obj.list.bb_2d(4, 1, vector_idx) obj.list.bb_2d(4, 2, vector_idx)]),'euclidean');
obj.list.cent_2d.bb(vector_idx, :) = [ obj.list.bb_2d(3, 1, vector_idx)-l/2 obj.list.bb_2d(3, 2, vector_idx)-h/2 ];

alg.bb2d_x = rect_2d(1);
alg.bb2d_y = rect_2d(2);
alg.bb2d_w = rect_2d(3);
alg.bb2d_h = rect_2d(4);
alg.flag   = 0;
if (rect_2d(1) < 0); alg.bb2d_x = 0; alg.flag = 1; end
if (rect_2d(2) < 0); alg.bb2d_y = 0; alg.flag = 1; end
if (rect_2d(1)+rect_2d(3)) >= size(im, 2); alg.bb2d_w = size(im, 2)-rect_2d(1); alg.flag = 1; end
if (rect_2d(2)+rect_2d(4)) >= size(im, 1); alg.bb2d_h = size(im, 1)-rect_2d(2); alg.flag = 1; end

obj.list.bb_2d_in_img(:, :, vector_idx)     = [alg.bb2d_x            alg.bb2d_y;
                                               alg.bb2d_x            alg.bb2d_y+alg.bb2d_h;
                                               alg.bb2d_x+alg.bb2d_w alg.bb2d_y+alg.bb2d_h;
                                               alg.bb2d_x+alg.bb2d_w alg.bb2d_y;
                                               alg.bb2d_x            alg.bb2d_y;];
obj.list.bb_2d_flag(vector_idx) = alg.flag;
% ground truth
obj.list.gt.bb_3d(:, :, vector_idx)         = bb_gt;
rect_3d = fun_proj_3d_2d_bb ( bb_gt, tform, st, flag );
obj.list.gt.bb_2d(:, :, vector_idx)         = [rect_3d(1)            rect_3d(2);
                                               rect_3d(1)            rect_3d(2)+rect_3d(4);
                                               rect_3d(1)+rect_3d(3) rect_3d(2)+rect_3d(4);
                                               rect_3d(1)+rect_3d(3) rect_3d(2);
                                               rect_3d(1)            rect_3d(2)];
imh = pdist(([obj.list.gt.bb_2d(1, 1, vector_idx) obj.list.gt.bb_2d(1, 2, vector_idx);
            obj.list.gt.bb_2d(2, 1, vector_idx) obj.list.gt.bb_2d(2, 2, vector_idx)]),'euclidean');
iml = pdist(([obj.list.gt.bb_2d(1, 1, vector_idx) obj.list.gt.bb_2d(1, 2, vector_idx);
            obj.list.gt.bb_2d(4, 1, vector_idx) obj.list.gt.bb_2d(4, 2, vector_idx)]),'euclidean');
obj.list.gt.cent_2d(vector_idx, :) = [ obj.list.gt.bb_2d(3, 1, vector_idx)-l/2 obj.list.gt.bb_2d(3, 2, vector_idx)-h/2 ];

obj.list.gt.num_pts(vector_idx, 1) = size(find(inpolygon( pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), ...
                                         [ obj.list.gt.bb_3d(1:4, 1, vector_idx); obj.list.gt.bb_3d(1, 1, vector_idx) ], ...
                                         [ obj.list.gt.bb_3d(1:4, 2, vector_idx); obj.list.gt.bb_3d(1, 2, vector_idx) ] )), 1);

gt.bb2d_x = rect_3d(1);
gt.bb2d_y = rect_3d(2);
gt.bb2d_w = rect_3d(3);
gt.bb2d_h = rect_3d(4);
gt.flag   = 0;
if (rect_3d(1) < 0); gt.bb2d_x = 0; gt.flag = 1; end
if (rect_3d(2) < 0); gt.bb2d_y = 0; gt.flag = 1; end
if (rect_3d(1)+rect_3d(3)) >= size(im, 2); gt.bb2d_w = size(im, 2)-rect_3d(1); gt.flag = 1; end
if (rect_3d(2)+rect_3d(4)) >= size(im, 1); gt.bb2d_h = size(im, 1)-rect_3d(2); gt.flag = 1; end

obj.list.gt.bb_2d_in_img(:, :, vector_idx)  = [gt.bb2d_x           gt.bb2d_y;
                                               gt.bb2d_x           gt.bb2d_y+gt.bb2d_h;
                                               gt.bb2d_x+gt.bb2d_w gt.bb2d_y+gt.bb2d_h;
                                               gt.bb2d_x+gt.bb2d_w gt.bb2d_y;
                                               gt.bb2d_x           gt.bb2d_y;];
obj.list.gt.bb_2d_flag(vector_idx) = gt.flag;
%     imshow(im)
%     hold on;
%     plot(obj.list.gt.bb_2d(:, 1, vector_idx), obj.list.gt.bb_2d(:, 2, vector_idx), 'g');
%     plot([obj.list.gt.bb_2d(1, 1, vector_idx)+bb2d_w], [obj.list.gt.bb_2d(1, 2, vector_idx)+bb2d_h], '.r', 'MarkerSize', 15)
sequence_stats(i, :) = [floor(gt.bb2d_w) floor(gt.bb2d_h) floor(gt.bb2d_h)*floor(gt.bb2d_w)...
                        obj_gt.h obj_gt.w obj_gt.l];
%% plot
% % % disp(rad2deg(obj_angle_to_x - obj_gt.ry));
% % hold on;
% % % disp([obj.r_3d(1, 1), obj.r_3d(2, 1), obj.r_3d(3, 1)]);
% % % disp([list.ego_rtn_list(1, 1, vector_idx), list.ego_rtn_list(2, 1, vector_idx), list.ego_rtn_list(3, 1, vector_idx)]);
% % % plt.whole_pcd = scatter3(pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), pcd.world.obs_pts(:, 3)+st.z_base, 1, pcd.world.obs_pts(:, 3),'filled');
% % % plot3(obj.list.cent_3d(1:vector_idx, 1), obj.list.cent_3d(1:vector_idx, 2), obj.list.cent_3d(1:vector_idx, 3), '.r', 'MarkerSize', 15);
% % % plot3(list.obj_loc_list(1:vector_idx, 1), list.obj_loc_list(1:vector_idx, 2), list.obj_loc_list(1:vector_idx, 3), '.b', 'MarkerSize', 15);
% % plot3(obj.list.cent_3d(vector_idx, 1), obj.list.cent_3d(vector_idx, 2), obj.list.cent_3d(vector_idx, 3), '.r', 'MarkerSize', 15);
% % plot3(list.obj_loc_list(vector_idx, 1), list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3), '.b', 'MarkerSize', 15);
% % obj_xx = quiver3( obj.cent_3d(1),  obj.cent_3d(2), obj.cent_3d(3), obj.r_3d(1, 1), obj.r_3d(2, 1), obj.r_3d(3, 1), 1);
% % % obj_yy = quiver3( obj.cent_3d(1),  obj.cent_3d(2), obj.cent_3d(3), obj.r_3d(1, 2), obj.r_3d(2, 2), obj.r_3d(3, 2), 1);
% % % obj_zz = quiver3( obj.cent_3d(1),  obj.cent_3d(2), obj.cent_3d(3), obj.r_3d(1, 3), obj.r_3d(2, 3), obj.r_3d(3, 3), 1);
% % set(obj_xx, 'Color', 'r', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
% % % set(obj_yy, 'Color', 'g', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
% % % set(obj_zz, 'Color', 'b', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
% % ego_xx = quiver3( list.obj_loc_list(vector_idx, 1),  list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3), list.ego_rtn_list(1, 1, vector_idx), list.ego_rtn_list(2, 1, vector_idx), list.ego_rtn_list(3, 1, vector_idx), 1);
% % % ego_yy = quiver3( list.obj_loc_list(vector_idx, 1),  list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3)+st.z_base, list.ego_rtn_list(1, 2, vector_idx), list.ego_rtn_list(2, 2, vector_idx), list.ego_rtn_list(3, 2, vector_idx), 1);
% % % ego_zz = quiver3( list.obj_loc_list(vector_idx, 1),  list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3)+st.z_base, list.ego_rtn_list(1, 3, vector_idx), list.ego_rtn_list(2, 3, vector_idx), list.ego_rtn_list(3, 3, vector_idx), 1);
% % set(ego_xx, 'Color', 'r', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
% % % set(ego_yy, 'Color', 'g', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
% % % set(ego_zz, 'Color', 'b', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
% % hold off;
% % axis equal tight;
% % % if rad2deg(obj_angle_to_x - obj_gt.ry) < 1
% % %     pause;
% % % end
% 
% 
% % whitebg('k');
% hold on;
% % pcshow(pcd.world.obs_pts);
% 
% % whole point cloud
% plt.whole_pcd = scatter3(pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), pcd.world.obs_pts(:, 3)+st.z_base, 1, pcd.world.obs_pts(:, 3),'filled');
% % object points
% plt.obj_pcd   = scatter3(obj.xyz(:, 1), obj.xyz(:, 2), obj.xyz(:, 3)+st.z_base, 3, 'y','filled');
% % ground points
% plt.gnd_pcd   = scatter3(pcd.world.gnd_pts(:, 1), pcd.world.gnd_pts(:, 2), pcd.world.gnd_pts(:, 3)+st.z_base, 1, 'r', 'filled');
% % % outside points
% % plt.out_pcd   = scatter3(pcd.world.out_img(:, 1), pcd.world.out_img(:, 2), pcd.world.out_img(:, 3)+st.z_base, 1, 'b', 'filled');
% 
% if vector_idx ~= 1
%     % ego vehicle location
% %     plot3(list.ego_loc_list(1:vector_idx, 1), list.ego_loc_list(1:vector_idx, 2), list.ego_loc_list(1:vector_idx, 3)+st.z_base, 'm');
%     % quiver for ego location
%     ego_xx = quiver3( list.ego_loc_list(vector_idx, 1),  list.ego_loc_list(vector_idx, 2), list.ego_loc_list(vector_idx, 3)+st.z_base, list.ego_rtn_list(1, 1, vector_idx), list.ego_rtn_list(2, 1, vector_idx), list.ego_rtn_list(3, 1, vector_idx), 1);
%     ego_yy = quiver3( list.ego_loc_list(vector_idx, 1),  list.ego_loc_list(vector_idx, 2), list.ego_loc_list(vector_idx, 3)+st.z_base, list.ego_rtn_list(1, 2, vector_idx), list.ego_rtn_list(2, 2, vector_idx), list.ego_rtn_list(3, 2, vector_idx), 1);
%     ego_zz = quiver3( list.ego_loc_list(vector_idx, 1),  list.ego_loc_list(vector_idx, 2), list.ego_loc_list(vector_idx, 3)+st.z_base, list.ego_rtn_list(1, 3, vector_idx), list.ego_rtn_list(2, 3, vector_idx), list.ego_rtn_list(3, 3, vector_idx), 1);
%     set(ego_xx, 'Color', 'r', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
%     set(ego_yy, 'Color', 'g', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
%     set(ego_zz, 'Color', 'b', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
%     
%     % 2d / 3d centroid
% 	% plt.proj_2d3d   = plot3(p_3d(1), p_3d(2), p_3d(3), '.y', 'MarkerSize', 30);
%     % 3d mean-shift centroid
%     % plt.ms_3        = plot3(ms_cent(1), ms_cent(2), ms_cent(3), '.g', 'MarkerSize', 30);
%     % quiver for KF location
%     obj_xx = quiver3( obj.cent_3d(1),  obj.cent_3d(2), obj.cent_3d(3)+st.z_base, obj.r_3d(1, 1), obj.r_3d(2, 1), obj.r_3d(3, 1), 1);
%     obj_yy = quiver3( obj.cent_3d(1),  obj.cent_3d(2), obj.cent_3d(3)+st.z_base, obj.r_3d(1, 2), obj.r_3d(2, 2), obj.r_3d(3, 2), 1);
%     obj_zz = quiver3( obj.cent_3d(1),  obj.cent_3d(2), obj.cent_3d(3)+st.z_base, obj.r_3d(1, 3), obj.r_3d(2, 3), obj.r_3d(3, 3), 1);
%     set(obj_xx, 'Color', 'r', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
%     set(obj_yy, 'Color', 'g', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
%     set(obj_zz, 'Color', 'b', 'LineWidth', 0.5, 'MaxHeadSize', 0.5);
%     % tracking of all previous locations
% %     plot3(obj.list.cent_3d(1:vector_idx, 1), obj.list.cent_3d(1:vector_idx, 2), obj.list.cent_3d(1:vector_idx, 3)+st.z_base, 'y');
%     % prediction of next KF location
% %     if obj.class == 1
% %         plot3(klm.location.next(1), klm.location.next(4), klm.location.next(7)+st.z_base, '.w', 'LineWidth', 1, 'MarkerSize', 3);%, 'Color', [0.75 0.75 0.75]);
% %         plot3(klm.location.next(1), klm.location.next(4), klm.location.next(7)+st.z_base, '*w', 'LineWidth', 1, 'MarkerSize', 3);%, 'Color', [0.75 0.75 0.75]);
% %     else
% %         plot3(klm.location.next(1), klm.location.next(4), klm.location.next(7)+st.z_base, '.w', 'LineWidth', 1, 'MarkerSize', 3);%, 'Color', [0.75 0.75 0.75]);
% %         plot3(klm.location.next(1), klm.location.next(4), klm.location.next(7)+st.z_base, '*w', 'LineWidth', 1, 'MarkerSize', 3);%, 'Color', [0.75 0.75 0.75]);
% %     end
% %     % uniting prediction to current location
% %     plot3([obj.list.cent_3d(vector_idx, 1), klm.location.next(1)], ...
% %           [obj.list.cent_3d(vector_idx, 2), klm.location.next(4)], ...
% %           [obj.list.cent_3d(vector_idx, 3), klm.location.next(7)]+st.z_base, '-w', 'LineWidth', 1); %, 'Color', [0.5 0.5 0.5]);
%     % object speed over object
%     velocity_str = [sprintf('%.1f', obj.velocity.kph), ' km/h'];
%     t = text(obj.cent_3d(1)+2, obj.cent_3d(2)+2, obj.cent_3d(3)+1+st.z_base, velocity_str, 'Color', 'k', 'HorizontalAlignment', 'left', 'FontSize', 10, 'FontWeight', 'bold');
%     t.BackgroundColor = 'white';
% end
% bb_draw ( obj, obj.cent_3d, 1, st );
% bb_draw ( obj_gt, list.obj_loc_list(vector_idx, :), 2, st );
% plt.fuse_cent = plot3(obj.cent_3d(1), obj.cent_3d(2), obj.cent_3d(3)+st.z_base, '.b', 'MarkerSize', 30);
% % hold on; plot(st.mdl); hold off 
% view([0, 90]);
% % view([-105, 63]);
% % view([-82, 28]);
% % view([-74, 53]);
% % view([-45, 20]);
% axis equal tight;
% % axis([(obj.cent_3d(1) - 5), (obj.cent_3d(1) + 5), ...
% %       (obj.cent_3d(2) - 5), (obj.cent_3d(2) + 5), ...
% %       (obj.cent_3d(3) - 1), (obj.cent_3d(3) + 3)]);
% title(['Frame #', num2str(epoch), '/', num2str(st.end_fr)]);
% % f(vector_idx,:) = getframe(gcf);

%%
if epoch < st.end_fr;
    vector_idx = vector_idx + 1;
%     if epoch == st.start_fr
%         pause;
%     end
%     pause(0.01);
%     clf;
end
if epoch == st.end_fr
    err_3D_MS_10iter(i) = fun_err( obj, list, runtime );
end
%     % fun_record_movie ( f, dataset );
% end

end
runtime.all = toc;

end

save err_3D_MS_10iter err_3D_MS_10iter;