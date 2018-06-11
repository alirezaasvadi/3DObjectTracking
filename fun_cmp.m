function [cmp, img] = fun_cmp(hist, rc_conv, im, st)
%FUN_CMP Summary of this function goes here
%   Detailed explanation goes here

%% qnt colors
obj_col      = impixel(im, rc_conv.all(:, 1), rc_conv.all(:, 2)) ./ 255;    % RGB from 0 to 1
obj_col      = obj_col * 255;
obj_qnt_col  = floor(double(obj_col) / st.level) + 1; 

%% confident maps using object histogram
cmp.llr.out = zeros(size(obj_qnt_col, 1), 1);
for i       = 1 : size(rc_conv.all, 1)
    cmp.llr.out(i, 1) = hist.llr(obj_qnt_col(i, 1), obj_qnt_col(i, 2), obj_qnt_col(i, 3));
end
cmp.llr.out = cmp.llr.out / max(cmp.llr.out(:));
            
%% images of confident maps
img.llr.out  = zeros(size(im, 1), size(im, 2));
img.llr.out(uint32(sub2ind([size(im, 1), size(im, 2)], rc_conv.all(:, 2), rc_conv.all(:, 1)))) = cmp.llr.out;

end

