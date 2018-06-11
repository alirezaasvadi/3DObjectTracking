
function st = setting (i)                                                            % setting [directory, number of frames, map setting]

%% object selector
addpath(genpath([pwd, '\gt_data']))
% addpath(genpath([pwd, '\model3d']))

% object data
load object_list
object_name = object_list{i};
st.dr.dnm   = str2num(object_name(15:16));   % dataset name
st.start_fr = str2num(object_name(18:20));
st.end_fr   = str2num(object_name(22:24));
st.obj_type = object_name(26:end);
% object tracklet
load(object_name);
st.object_data   = object_data_output;

%% setting: input information
% st.dr.dnm   = i;
st.frame    = 0;
st.dr.cam   = 2;                                                                                % left2/right3 camera
st.dr.dst   = 'training';                                                                       % training/testing dataset 
st.dr.mdr   = 'E:\dataset_ext\dataset_tracking';                                                % main directoy of dataset
% st.dr.mdr   = 'C:\Users\Pedro Girão\Desktop\MsC_thesis_testing\main_framework\dataset_tracking';% main directoy of dataset
st.dr.pts   = fullfile(st.dr.mdr, st.dr.dst, sprintf('velodyne/%04d', st.dr.dnm));              % directory of velodyne points
st.dr.img   = fullfile(st.dr.mdr, st.dr.dst, sprintf('image_%02d/%04d', st.dr.cam, st.dr.dnm)); % directory of color images
st.dr.lbl   = fullfile(st.dr.mdr, st.dr.dst, sprintf('label_%02d', st.dr.cam));                 % directory of tracklet labels
st.dr.oxt   = fullfile(st.dr.mdr, st.dr.dst, 'oxts');                                           % directory of pose
st.dr.nsq   = numel(dir(fullfile(st.dr.mdr, st.dr.dst, sprintf('image_%02d', st.dr.cam)))) - 2; % total number of tracking sequences
st.dr.nmg   = length(dir(fullfile(st.dr.img, '*.png')));                                        % get number of images for this dataset
st.seq_idx  = st.dr.dnm;                                                                                % index of sequence data (0000.txt)
% st.start_fr = st.frame + 1;
% st.end_fr   = st.dr.nmg;

%% setting: calibration
st.dr.clb  = fullfile(st.dr.mdr, st.dr.dst, 'calib');                                               % directory of calibration
st.clb.tmp = dlmread(sprintf('%s/%04d.txt', st.dr.clb, st.dr.dnm), ' ', 0, 1);                      % [read data, delimiter, row offset, column offset]
st.t.p2    = reshape(st.clb.tmp(st.dr.cam + 1, 1 : 12), [4, 3])'; st.t.p2(4, :) = [0 0 0 1];        % load 3x4 P2 camera calibration matrix
st.t.rct   = reshape(st.clb.tmp(5, 1 : 9), [3, 3])'; st.t.rct(:, 4) = 0; st.t.rct(4,:) = [0 0 0 1]; % load 3x3 image calibration matrix
st.t.v2c   = reshape(st.clb.tmp(6, 1 : 12), [4, 3])'; st.t.v2c(4,:) = [0 0 0 1];                    % load 3x4 velodyne to camera matrix (R|t)
st.t.clb   = st.t.p2 * st.t.rct * st.t.v2c; st.dt.clb = st.t.clb(1:4, 1:3)';                        % project velodyne points to image plane
st.trm     = load(sprintf('%s/%04d', fullfile(st.dr.mdr, st.dr.dst, 'pose'), st.dr.dnm));           % read from directory of poses           
st.dr.pose = st.trm.pose;

%% setting: local grid
st.z_base = 1.73;                                                          % velodyne elevation 
st.x_min  = -5;                                                            % movement direction
st.x_max  = 150;
st.y_min  = -20;                                                           % right
st.y_max  = 20;                                                            % left
st.z_max  = 2 - st.z_base;
st.z_min  = -0.5 - st.z_base;                                           % blind spot radius                                                                 % transformation matrix in camera coordinate

%% setting: histogram
st.bin   = 8;                                                              % total number of bins = bin ^ 3
st.level = 256 / st.bin;

%% setting: object classification
st.class = [1.8, 4];   % [pedestrian, cyclist, vehicle]

%% ego-car model
% st.mdl     = model3d(fullfile('model3d', 'passat.3ds'));
% st.mdl     = qrot(st.mdl, [0 0 1], pi/2);

end

