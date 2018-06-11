%% clear memory & command window
clear; close all; clc;

% st = setting_save(9);
% st.start_fr = 330;
% st.end_fr = 803;
% st.object_class = 4;
% [ object_data ]= init_object_data ( st, st.object_class );
% save_object_data( object_data, st );
% whitebg('k')
%% setting
for i = 22 %: 50
dataset = i;
st      = setting(dataset);
st.num_fr = st.end_fr - st.start_fr + 1; disp(st.num_fr);
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
figure('units','normalized','outerposition',[0 0 1 1]);

%% main
tic
for epoch = st.start_fr %: st.end_fr
[pcd, im, tform, list ]              = fun_read_data(epoch, vector_idx, st, list);       % read pcd & im
[pcd, gnd_klm_ang]                   = fun_gnd_rm_bu(st, pcd, epoch, gnd_klm_ang);          % removal of ground points
[ obj, obj_gt ]                  = object_update ( obj, st );                     % update object struct

bb_gt = bb_calc ( obj_gt, [list.obj_loc_list(vector_idx, 1), list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3)] );
rect_3d = fun_proj_3d_2d_bb ( bb_gt, tform, st, flag );

bb_2d   = [rect_3d(1)            rect_3d(2);
           rect_3d(1)            rect_3d(2)+rect_3d(4);
           rect_3d(1)+rect_3d(3) rect_3d(2)+rect_3d(4);
           rect_3d(1)+rect_3d(3) rect_3d(2);
           rect_3d(1)            rect_3d(2)];

for j = 1 : 5
if bb_2d(j, 1) > size(im, 2)
    bb_2d(j, 1) = size(im, 2);
elseif bb_2d(j, 1) < 0
    bb_2d(j, 1) = 0;
end

if bb_2d(j, 2) > size(im, 1)
    bb_2d(j, 2) = size(im, 1);
elseif bb_2d(j, 2) < 0
    bb_2d(j, 2) = 0;
end
end
%% plot
% figure
% imshow(im); hold on;
% plot(bb_2d(:, 1), bb_2d(:, 2), 'r', 'LineWidth', 3);
% hold off;
% figure
hold on;
pcshow(pcd.world.in_img);
bb_draw( obj_gt, [list.obj_loc_list(vector_idx, 1), list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3)], 2, st);
hold off;
axis equal tight;
% title(['Sequence #', num2str(dataset), ', frame #', num2str(epoch), '/', num2str(st.end_fr)]);
% str = sprintf('%d', dataset);
% export_fig(str, '-pdf')
% f(vector_idx,:) = getframe(gcf);

%%
pause(0.01);
if epoch < st.end_fr;
    vector_idx = vector_idx + 1;
    clf;
end

end

end