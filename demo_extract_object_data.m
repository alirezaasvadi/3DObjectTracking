%% KITTI TRACKING BENCHMARK DEMONSTRATION
% Input:  Tracking dataset
% Output: 3D bounding boxes
% Alireza Asvadi, 2015 Dec.
%% clear memory & command window
clc
clear variables
close all
%% main

% figure('Position', [-1080, 400, 960, 500]);                                % plot on left screen
for dnm = 10;           % (14) 1, 12, 17, [18-curve], [20-downtown]      % sub-directory number (dname - 1)
    st.dr.dnm = dnm;
    st        = stt(st);
    tracklets = readLabels(st.dr.lbl, st.dr.dnm - 1);                            % load labels
    %% plot
    for i_img = 220 : st.dr.nmg;                                                  % main loop
        
        %% pre-plot
        hold on
        subplot(4, 1, 1)                                                             % plot image
        img       = imread(sprintf('%s/%06d.png', st.dr.img, i_img-1)); imshow(img)
        subplot(4, 1, 2:4)                                                           % plot velodyne points
        fid.pts   = fopen(sprintf('%s/%06d.bin', st.dr.pts, i_img-1), 'rb');         % read from directory of points (number of frames in each seq.)
        velodyne  = fread(fid.pts, [4 inf], 'single')';                              % velodyne points [x, y, z, r] (total number of pointsx4)
        fclose(fid.pts);                                                             % close fid
        pts.pts   = velodyne(:, 1:3);                                                % velodyne points [x, y, z] (total number of pointsx3)
        ins.grd   = ((pts.pts(:,1) > (-st.vm.xb)) & (pts.pts(:,1) < st.vm.xf) & ...  % filter points to inside
            (pts.pts(:,2) > (st.vm.yr)) & (pts.pts(:,2) < st.vm.yl) & ...   % /outside the local grid
            (pts.pts(:,3) > (st.vm.zd)) & (pts.pts(:,3) < st.vm.zu));
        pts.pts   = pts.pts(ins.grd, 1:3);                                           % velodyne points in local grid
        plot3(pts.pts(:, 1), pts.pts(:, 2), pts.pts(:, 3) , '.b', 'MarkerSize', 10)   % plot points
        xlabel('X'); ylabel('Y'); zlabel('Z'); view(-25, 45); axis equal tight; grid on;
        %% main
        location  = [];                                                              % for every scan keep the location of objects
        n         = 0;                                                               % initialize tyhe counter for every scan
        for i_obj =  1 : numel(tracklets{i_img})                                      % for all annotated tracklets do
            object    = tracklets{i_img}(i_obj);
            if ~strcmp(object.type, 'DontCare')                                          % 'Car', 'Van', 'Truck', 'Pedestrian', 'Person_sitting',
                n         = n + 1;                                                           % 'Cyclist', 'Tram', 'Misc' or 'DontCare'
                %% 2D image
                pos       = [object.x1, object.y1, object.x2 - object.x1 + 1, object.y2 - object.y1 + 1];
                %% 3D image
                [corners, face] = computeBox3D(tracklets{i_img}(i_obj), st.t.p2);            % plot 3D bounding box
                %% 3D points
                loc       = st.t.v2c \ [object.t, 1]'; %disp(loc(1:3)');                       % 3D object location x,y,z in 'velodyne' coordinates
                if (loc(1) < st.vm.xf) && (loc(2) > st.vm.yr) && (loc(2) < st.vm.yl);        % if it is inside the local grid
                    fprintf('----- '); fprintf('%d\t\t', i_obj);
                    fprintf('%.2f\t', loc(1:3)'); fprintf(' -----\n');
                    % if((loc(1) > 20) && (loc(2) < -12))
                    % if((loc(2) < 0))
                    %% save location
                    location(n, 1:3) = loc(1:3)';                                                % every object location in one line
                    %% plot
                    % boxes on the image
                    subplot(4, 1, 1)
                    rectangle('Position', pos, 'EdgeColor','g');
                    patch('Vertices', corners', 'Faces', face, 'EdgeColor', [1 0 0], 'FaceAlpha', 0);
                    % boxes on the points
                    subplot(4, 1, 2:4)
                    hold on
                    box(object, loc);
                    plot3(loc(1), loc(2), loc(3), '.g', 'MarkerSize', 10);
                    axis equal tight;
%                     axis([2, 30, -6, 6, -1, 1]);
                    % view([-103, 10]);
                    view([0,90]);
                    % view([-90,90]);
                    grid on; grid minor;
                    hold off
                    % end
                end
            end
        end
        fprintf('----------------- Epoch %d ----------------\n\n\n', i_img);
        % 14-41 (3)
        % 42-66 (2)
        % 67-77 (1)
        subplot(4, 1, 2:4)
        % hold on; plot(st.mdl); hold off                                              % plot car model
        hold off
        title(['Frame #', num2str(i_img), '/', num2str(st.dr.nmg)]);
        pause%(0.001);
        clf
        %% save locations
        % save(fullfile( pwd, 'gt_gnd', num2str(st.dr.dnm), num2str(i_img)),'location')
        
    end
    
end

