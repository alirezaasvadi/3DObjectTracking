function [ bb_overlap_3D_percentage ] = bb_overlap_3D ( bb, bb_gt, obj )
    %% using polybool function
    bb_vertexes    = [bb(1:5,1)';    bb(1:5,2)'];                              xbb     = bb_vertexes(1,:);    ybb    = bb_vertexes(2,:);
    bb_gt_vertexes = [bb_gt(1:5,1)'; bb_gt(1:5,2)'];                           xbb_gt  = bb_gt_vertexes(1,:); ybb_gt = bb_gt_vertexes(2,:);
    [ xa, ya ] = polybool ( 'intersection', xbb, ybb, xbb_gt, ybb_gt );
%     w = warning('query','last'); id = w.identifier; warning('off',id);

    %% get overlapping area
    bb_overlap_area = polyarea ( xa, ya ); % top-view overlap (2D)
    f_ob            = min(bb(:, 3));                                       % base of object bb height
    f_gt            = min(bb_gt(:, 3));                                    % base of ground truth bb height
    h_hat           = obj.h - abs(f_gt - f_ob);                            % h^ overlapping height
    bb_intersection_3D  = bb_overlap_area * h_hat;                         % intersection volume
    
    bb_union_3D         = 2 * (obj.h * obj.w * obj.l) - bb_intersection_3D;             % union of bbs volume
    % bb_overlap_3D_percentage = bb_intersection_3D / (object.area * object.h) * 100;
    
    bb_overlap_3D_percentage = bb_intersection_3D / bb_union_3D * 100;     % intersection-over-union method
    % considered threshold of 25% for good result
end