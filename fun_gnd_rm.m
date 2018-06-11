function [ pcd, gnd_klm_ang ] = fun_gnd_rm (st, pcd, epoch, gnd_klm_ang, thresh)
    %% compute line slopes in [x, z]
    pts_end         = [pcd.world.in_img(:, 1) pcd.world.in_img(:, 3)];     % end points
    pts_org         = repmat([0 -st.z_base], size(pts_end, 1), 1);         % origin points
    pts_ang         = rad2deg(atan2((pts_end(:, 2) - pts_org(:, 2)), (pts_end(:, 1) - pts_org(:, 1))));

    if epoch == 643
    end
    %% find angle with maximum repetition
    [den, xi]       = ksdensity(pts_ang);                                  % KDE [density, xmesh]
    [pks, locs]     = findpeaks(den, 'MinPeakHeight', 0.25 * max(den)...   % detect peaks
                                   ,'MinPeakProminence', 0.25 * max(den), 'MinPeakDistance', 0.2);   
    ind_max_pk      = find(pks == max(pks));       
    % find the highest peak
    if isempty(ind_max_pk)
    fav_ang         = gnd_klm_ang.prd(1);
    else
    fav_ang         = xi(locs(ind_max_pk(1)));                             % favorite angle    
    end
    
    %% applying KF to ground removal
    % if first scan, initialize parameters
    if epoch        == st.start_fr
        gnd_klm_ang     = klmi(fav_ang, 'g');
        gnd_klm_ang.prd = gnd_klm_ang.A * gnd_klm_ang.x;
    % for next frames, obtain KF iteration
    else
        if abs(fav_ang - gnd_klm_ang.prd) > 0.3                            % set it later!
            fav_ang         = gnd_klm_ang.prd(1);
        end
        gnd_klm_ang.z   = fav_ang;
        gnd_klm_ang     = kalmanf_simplified(gnd_klm_ang);
        gnd_klm_ang.prd = gnd_klm_ang.A * gnd_klm_ang.x;
    end
    
    %% detect the ground points  
    % 1. angle threshold
    tr_ang          = thresh.ang;                                          % threshold
    fav_ang         = gnd_klm_ang.x(1) + tr_ang;                           % correction
    % 2. distance threshold
    tr_dist         = thresh.dist;
    fav_nrm         = [-sin(deg2rad(fav_ang)), 0, cos(deg2rad(fav_ang))];          % convert angle to the normal 
    nrm             = repmat(fav_nrm, size(pcd.world.in_img, 1), 1);               % plane normal (repeated)              
    p_0             = repmat([0, 0, -st.z_base], size(pcd.world.in_img, 1), 1);    % plane point (repeated)
    distance        = dot((pcd.world.in_img - p_0)', nrm')';                       % absolute distance to plane
    % find points under the plane
    d_value         = repmat(-sum([0, 0, -st.z_base] .* fav_nrm), size(pcd.world.in_img, 1), 1);   % ax + by + cz + d = 0
    z_value         = - (sum(nrm(:, 1:2) .* pcd.world.in_img(:, 1:2), 2) + d_value) ./ nrm(:, 3);  % z = -(ax + by + d) / c
    delta_z         = pcd.world.in_img(:, 3) - z_value;                                            % delta z
    ind_gnd         = (pts_ang < fav_ang) | (distance <= tr_dist) | (delta_z < 0); % ground points [angle] [dist] [under plane]
    
    %% remove the ground points 
    pcd.world.gnd_pts = pcd.world.in_img(ind_gnd, :); 
    pcd.world.obs_pts = pcd.world.in_img(~ind_gnd, :);
    pcd.ego.gnd_pts   = pcd.ego.in_img(ind_gnd, :); 
    pcd.ego.obs_pts   = pcd.ego.in_img(~ind_gnd, :);    
    pcd.ego.gnd_pxs   = pcd.ego.pixel_loc(ind_gnd, :);   
    pcd.ego.obs_pxs   = pcd.ego.pixel_loc(~ind_gnd, :);
    
end