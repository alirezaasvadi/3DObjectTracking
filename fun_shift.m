function [rc_conv,  cnt] = fun_shift(rc_conv, cnt_prev, img, cmp, im)
%FUN_SHIFT Summary of this function goes here
%   Detailed explanation goes here

%% cnt.llr.out <- rc_conv.all    
% cmp.llr.out  = img.llr.out(sub2ind([size(im, 1), size(im, 2)], ...
%                rc_conv.all(:, 2), rc_conv.all(:, 1)));    
cnt.llr.out  = [sum(rc_conv.all(:, 1) .* cmp.llr.out), ...
                sum(rc_conv.all(:, 2) .* cmp.llr.out)] / sum(cmp.llr.out);    

%% rc_conv.all <- cnt.llr.out           
displacement = cnt.llr.out - cnt_prev.llr.out;
rc_conv.in   = rc_conv.in + repmat(displacement, size(rc_conv.in, 1), 1);
rc_conv.out  = rc_conv.out + repmat(displacement, size(rc_conv.out, 1), 1);

%% avoid going outside the image
rc_conv.in(rc_conv.in(:, 1) < 1, 1) = 1;
rc_conv.in(rc_conv.in(:, 2) < 1, 2) = 1;
rc_conv.in(rc_conv.in(:, 1) > size(im, 2), 1) = size(im, 2);
rc_conv.in(rc_conv.in(:, 2) > size(im, 1), 2) = size(im, 1);

rc_conv.out(rc_conv.out(:, 1) < 1, 1) = 1;
rc_conv.out(rc_conv.out(:, 2) < 1, 2) = 1;
rc_conv.out(rc_conv.out(:, 1) > size(im, 2), 1) = size(im, 2);
rc_conv.out(rc_conv.out(:, 2) > size(im, 1), 2) = size(im, 1);

rc_conv.all  = round([rc_conv.in; rc_conv.out]);

end

