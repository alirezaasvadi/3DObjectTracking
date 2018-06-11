function [ p_2d, p_3d ] = fun_proj_2d_3d ( proj, cent_2d, epoch )
    %% divide object pixels into quadrants with 2d centroid in middle
    % in image = quadrant
    % in 3d    = space
    quadrant.upper_left  = ((proj.rc(:, 1) <= cent_2d(1)) == 1 & (proj.rc(:, 2) <= cent_2d(2)) == 1);
    space.upper_left     = proj.xyz(quadrant.upper_left, :);
    quadrant.upper_left  = proj.rc(quadrant.upper_left, :);
    quadrant.upper_right = ((proj.rc(:, 1) >= cent_2d(1)) == 1 & (proj.rc(:, 2) <= cent_2d(2)) == 1);
    space.upper_right    = proj.xyz(quadrant.upper_right, :);
    quadrant.upper_right = proj.rc(quadrant.upper_right, :);
    quadrant.lower_left  = ((proj.rc(:, 1) <= cent_2d(1)) == 1 & (proj.rc(:, 2) >= cent_2d(2)) == 1);
    space.lower_left     = proj.xyz(quadrant.lower_left, :);
    quadrant.lower_left  = proj.rc(quadrant.lower_left, :);
    quadrant.lower_right = ((proj.rc(:, 1) >= cent_2d(1)) == 1 & (proj.rc(:, 2) >= cent_2d(2)) == 1);
    space.lower_right    = proj.xyz(quadrant.lower_right, :);
    quadrant.lower_right = proj.rc(quadrant.lower_right, :);
    
    %% obtain closest point to 2d centroid in each quadrant
    for it = 1 : size(quadrant.upper_left, 1)
        dist.upper_left(it, :) = sqrt((quadrant.upper_left(it, 1) - cent_2d(1))^2 + ((quadrant.upper_left(it, 2) - cent_2d(2))^2));
        [~, idx.upper_left] = min( dist.upper_left );
    end
    for it = 1 : size(quadrant.upper_right, 1)
        dist.upper_right(it, :) = sqrt((quadrant.upper_right(it, 1) - cent_2d(1))^2 + ((quadrant.upper_right(it, 2) - cent_2d(2))^2));
        [~, idx.upper_right] = min( dist.upper_right );
    end
    for it = 1 : size(quadrant.lower_left, 1)
        dist.lower_left(it, :) = sqrt((quadrant.lower_left(it, 1) - cent_2d(1))^2 + ((quadrant.lower_left(it, 2) - cent_2d(2))^2));
        [~, idx.lower_left] = min( dist.lower_left );
    end
    for it = 1 : size(quadrant.lower_right, 1)
        dist.lower_right(it, :) = sqrt((quadrant.lower_right(it, 1) - cent_2d(1))^2 + ((quadrant.lower_right(it, 2) - cent_2d(2))^2));
        [~, idx.lower_right] = min( dist.lower_right );
    end
    if length(fieldnames(idx)) < 4
    % if less than 4 surrounding points interpolate between existing
        f_im = zeros(4, 2);
        f_sp = zeros(4, 3);        
        if isfield(idx, 'upper_left')
            f_im(1, :) = quadrant.upper_left(idx.upper_left, :);
            f_sp(1, :) = space.upper_left(idx.upper_left, :);
        end
        if isfield(idx, 'upper_right')
            f_im(2, :) = quadrant.upper_right(idx.upper_right, :);
            f_sp(2, :) = space.upper_right(idx.upper_right, :);
        end
        if isfield(idx, 'lower_left')
            f_im(3, :) = quadrant.lower_left(idx.lower_left, :);
            f_sp(3, :) = space.lower_left(idx.lower_left, :);
        end
        if isfield(idx, 'lower_right')
            f_im(4, :) = quadrant.lower_right(idx.lower_right, :);
            f_sp(4, :) = space.lower_right(idx.lower_right, :);
        end
        f_im = f_im(all(f_sp, 2), :); f_sp = f_sp(all(f_sp, 2), :);
        if size(f_im, 1) > 1
            p_2d = mean(f_im);
        else
            p_2d = f_im;
        end
        if size(f_sp, 1) > 1
            p_3d = mean(f_sp);
        else
            p_3d = f_sp;
        end
    else
    % obtain the 4 nearest surrounding laser points
    % in image
    f1 = quadrant.upper_left(idx.upper_left, :);
    f2 = quadrant.upper_right(idx.upper_right, :);
    f3 = quadrant.lower_left(idx.lower_left, :);
    f4 = quadrant.lower_right(idx.lower_right, :);
    % in 3d
    f1_3d = space.upper_left(idx.upper_left, :);
    f2_3d = space.upper_right(idx.upper_right, :);
    f3_3d = space.lower_left(idx.lower_left, :);
    f4_3d = space.lower_right(idx.lower_right, :);
    
    % estimate the final 3d position of pixel p
    % interpolate top and bottom points to obtain image pixel p
    % first: simple interpolation
    pt      = [ (f1(1) + f2(1))/2, (f1(2) + f2(2))/2 ];
    pb      = [ (f3(1) + f4(1))/2, (f3(2) + f4(2))/2 ];
    p       = [ (pt(1) + pb(1))/2, (pt(2) + pb(2))/2 ];
    s1      = (p(1)-f1(1)) / (f2(1)-f1(1));
    s2      = (p(1)-f3(1)) / (f4(1)-f3(1));
    % interpolated p estimation
    % pixel space
    pt      = f1 + s1*(f2-f1);
    pb      = f3 + s2*(f4-f3);
    s3      = (p - pb) / (pt - pb);
    p_2d    = pb + s3*(pt - pb);
    % 3d coordinates
    pt_3d   = f1_3d + s1*(f2_3d - f1_3d);
    pb_3d   = f3_3d + s1*(f4_3d - f3_3d);
    p_3d    = pb_3d + s3*(pt_3d - pb_3d);
    end
end
    
    
    
%     clf;
%     figure; imshow(im); hold on;
%     plot(cent_2d(1),   cent_2d(2),   '*c');
%     
%     plot(quadrant.upper_left(:,1),  quadrant.upper_left(:,2),  '.r');
%     plot(f1(1),  f1(2),  'or', 'LineWidth', 5);
%     plot(quadrant.upper_right(:,1), quadrant.upper_right(:,2), '.g');
%     plot(f2(1),  f2(2),  'og', 'LineWidth', 5);
%     plot(quadrant.lower_left(:,1),  quadrant.lower_left(:,2),  '.b');
%     plot(f3(1),  f3(2),  'ob', 'LineWidth', 5);
%     plot(quadrant.lower_right(:,1), quadrant.lower_right(:,2), '.y');
%     plot(f4(1),  f4(2),  'oy', 'LineWidth', 5);
%     
%     plot([f1(1) f2(1)], [f1(2) f2(2)], 'c');
%     plot([f3(1) f4(1)], [f3(2) f4(2)], 'c');
%     plot(pt(1),  pt(2),  '.c', 'MarkerSize', 5);
%     plot(pb(1),  pb(2),  '.c', 'MarkerSize', 5);
%     plot([pt(1) pb(1)], [pt(2) pb(2)], 'c');
%     plot(p(1),   p(2),   '.c', 'MarkerSize', 30);
%     hold off;
%     
%     figure; whitebg('k');
%     pcshow(pcd.ego.obs_pts); hold on;
%     plot3(obj.cent_3d(1), obj.cent_3d(2), obj.cent_3d(3), '.b', 'MarkerSize', 30);
%     plot3(p_3d(1), p_3d(2), p_3d(3), '.r', 'MarkerSize', 30);
%     hold off;