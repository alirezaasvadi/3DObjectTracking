function st = stt(st)

%% main directories [1: moving, 18: car stoped] 
addpath(genpath([pwd, '\funs']))                                                                    % add to path the related functions
% st.dr.dnm  = 1;                                   % (14) 1, 12, 17, [18-curve], [20-downtown]      % sub-directory number (dname - 1)
st.dr.cam  = 2;                                                                                     % left/right camera
st.dr.dst  = 'training'; %  'testing'                                                               % training/testing dataset
% st.dr.mdr  = '..\..\dataset_tracking';                                                     % main directoy of dataset
st.dr.mdr  = 'C:\Users\Pedro Girão\Desktop\MsC_thesis_testing\main_framework\dataset_tracking';
st.dr.pts  = fullfile(st.dr.mdr, st.dr.dst, sprintf('velodyne/%04d', st.dr.dnm - 1));               % directory of velodyne points
st.dr.img  = fullfile(st.dr.mdr, st.dr.dst, sprintf('image_%02d/%04d', st.dr.cam, st.dr.dnm - 1));  % directory of color images
st.dr.lbl  = fullfile(st.dr.mdr, st.dr.dst, sprintf('label_%02d', st.dr.cam));                      % directory of tracklet labels
st.dr.oxt  = fullfile(st.dr.mdr, st.dr.dst, 'oxts');                                                % directory of pose
st.dr.rec  = fullfile(st.dr.mdr, 'result', filesep);                                                % directory of record
st.dr.nsq  = numel(dir(fullfile(st.dr.mdr, st.dr.dst, sprintf('image_%02d', st.dr.cam)))) - 2;      % total number of tracking sequences
st.dr.nmg  = length(dir(fullfile(st.dr.img, '*.png')));                                             % get number of images for this dataset
%% calibration
st.dr.clb  = fullfile(st.dr.mdr, st.dr.dst, 'calib');                                               % directory of calibration
clb_tmp    = dlmread(sprintf('%s/%04d.txt', st.dr.clb, st.dr.dnm - 1), ' ', 0, 1);                  % [read data, delimiter, row offset, column offset]
st.t.p2    = reshape(clb_tmp(st.dr.cam + 1, 1 : 12), [4, 3])'; st.t.p2(4, :) = [0 0 0 1];           % load 3x4 P2 camera calibration matrix
st.t.rct   = reshape(clb_tmp(5, 1 : 9), [3, 3])'; st.t.rct(:, 4) = 0; st.t.rct(4,:) = [0 0 0 1];    % load 3x3 image calibration matrix
st.t.v2c   = reshape(clb_tmp(6, 1 : 12), [4, 3])'; st.t.v2c(4,:) = [0 0 0 1];                       % load 3x4 velodyne to camera matrix (R|t)
st.t.clb   = st.t.p2 * st.t.rct * st.t.v2c; st.dt.clb = st.t.clb(1:4, 1:3)';                        % project velodyne points to image plane
trm        = load(sprintf('%s/%04d', fullfile(st.dr.mdr, st.dr.dst, 'pose'), st.dr.dnm - 1));       % read from directory of poses           
st.dt.pose = trm.pose;                                                                              % transformation matrix in camera coordinate
%% local grid
st.bias    = 1.73;
st.vm.xf   = +120;                                            % x direction and front (x: +5 ~ +35)
st.vm.xb   = +5;                                             % x direction and behind
st.vm.yl   = +120;                                            % y direction and left  (y: -15 ~ +15)
st.vm.yr   = -120;                                            % y direction and right
st.vm.zu   = +2   - st.bias;                                 % z direction and up, bias: 1.73 (z: -1 ~ +2.5)
st.vm.zd   = -1   - st.bias;                                 % z direction and down
st.vm.bs   = +3;                                             % blind spot radius
%% vehicle model
addpath(genpath([pwd, '\model3d']))
% st.mdl     = model3d(fullfile('model3d', 'passat.3ds'));
% st.mdl     = qrot(st.mdl, [0 0 1], pi/2);
% st.mdl     = st.mdl + [0 0 -st.bias];
%% plot
figure('units','normalized','outerposition',[0 0 1 1])

end

