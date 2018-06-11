%% main framework
%% clear memory & command window
clear variables; close; clc;

% for turn = 1 : 3
%% setting
% id: 1 to 50;
id = 1;
st = setting(id);
st.num_fr = st.end_fr - st.start_fr + 1; disp(st.num_fr);
epoch   = st.start_fr;

%% setting: figure location
% figure for plotting purposes
figure('Position', [-1080, 400, 960, 500]);                                % plot on left screen
% figure('Position', [0, 500, 960, 500]);                                    % plot on first screen
% figure('units','normalized','outerposition',[0 0 1 1])
% whitebg('w');

%% setting: variables
% lists indexes
vector_idx             = 1;
% ground truth data
list.obj_loc_list      = zeros(st.end_fr-st.start_fr+1, 3);
list.obj_rtn_list      = zeros(3, 3, st.end_fr-st.start_fr+1);
list.ego_loc_list      = zeros(st.end_fr-st.start_fr+1, 3);
clear f;
% ground kalman
gnd_klm_ang            = 0;
n_prev                 = 2;
klm_bins(st.bin^3).s   = [];
vrs                    = [];
obj                    = [];
% figure('units','normalized','outerposition',[0 0 1 1]);
whitebg('k');

%% main
for epoch = st.start_fr : st.end_fr
[pcd, im, tform, list ]              = fun_read_data(epoch, vector_idx, st, list);       % read pcd & im
% imshow(im);
% [pcd, gnd_klm_ang]                   = fun_gnd_rm(st, pcd, epoch, gnd_klm_ang);          % removal of ground points

%% 2D image
pos       = [st.object_data{vector_idx}.x1, st.object_data{vector_idx}.y1, st.object_data{vector_idx}.x2 - st.object_data{vector_idx}.x1 + 1, st.object_data{vector_idx}.y2 - st.object_data{vector_idx}.y1 + 1];

subplot(2,1,1);
title(['Frame #', num2str(epoch), '/', num2str(st.dr.nmg)]);
hold on;
imshow(im);
rectangle('Position', pos, 'EdgeColor','g');
hold off;
subplot(2,1,2);
title(['Index #', num2str(vector_idx), '/', num2str(st.num_fr)]);
hold on;
% scatter3(pcd.world.obs_pts(:, 1), pcd.world.obs_pts(:, 2), pcd.world.obs_pts(:, 3), 1, pcd.world.obs_pts(:, 3), 'filled');
scatter3(pcd.world.in_img(:, 1), pcd.world.in_img(:, 2), pcd.world.in_img(:, 3), 1, pcd.world.in_img(:, 3), 'filled');
plot3(list.obj_loc_list(vector_idx, 1), list.obj_loc_list(vector_idx, 2), list.obj_loc_list(vector_idx, 3), '.r', 'MarkerSize', 20);
hold off;

axis equal tight;
view([0, 90]);
% view([-92, 8]);
% axis([list.obj_loc_list(vector_idx, 1) - 3, list.obj_loc_list(vector_idx, 1) + 3, ...
%       list.obj_loc_list(vector_idx, 2) - 1.5, list.obj_loc_list(vector_idx, 2) + 1.5, ...
%       -1, 1]);
pause(0.01)
clf;
vector_idx = vector_idx + 1;
end