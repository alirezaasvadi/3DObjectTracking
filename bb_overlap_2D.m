function [ bb_overlap_2D_percentage ] = bb_overlap_2D ( bb, bb_gt )
    bb_vertexes    = [bb(1:5,1)';    bb(1:5,2)'];                              xbb     = bb_vertexes(1,:);    ybb    = bb_vertexes(2,:);
    bb_gt_vertexes = [bb_gt(1:5,1)'; bb_gt(1:5,2)'];                           xbb_gt  = bb_gt_vertexes(1,:); ybb_gt = bb_gt_vertexes(2,:);

    %% get union and overlapping area    
    [x_un, y_un] = polybool('union', xbb, ybb, xbb_gt, ybb_gt);
    [x_in, y_in] = polybool('intersection', xbb, ybb, xbb_gt, ybb_gt);

    union_area = polyarea(x_un', y_un');
    isect_area = polyarea(x_in', y_in');
    
    bb_overlap_2D_percentage = ( isect_area / union_area) * 100;
    % considered threshold of 50% for good result
end