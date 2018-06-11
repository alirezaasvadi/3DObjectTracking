function [hist, cmp, img, cnt, rc_conv, klm_bins, vrs] = fun_hist_llr_2 ( rc_conv_prev, epoch, obj, im, st, klm_bins, vrs )
%% convex hulls polygons
rc_conv      = fun_polygons ( obj, im );
if isempty(rc_conv.in)
    rc_conv.in  = rc_conv_prev.in;
    rc_conv.out = rc_conv_prev.out;
end

%% object histogram
% colored points in inner convexhull
obj_col      = impixel(im, rc_conv.in(:, 1), rc_conv.in(:, 2)) ./ 255;    % RGB from 0 to 1
obj_col      = obj_col * 255;
obj_qnt_col  = floor(double(obj_col) / st.level) + 1;
% get histogram for object pixels
obj_his      = accumarray(obj_qnt_col, 1, [st.bin st.bin st.bin]);    

%% background histogram
% colored points between inner & outter convexhulls
bg_col       = impixel(im, rc_conv.out(:, 1), rc_conv.out(:, 2)) ./ 255;  % RGB from 0 to 1
bg_col       = bg_col * 255;
bg_qnt_col   = floor(double(bg_col) / st.level) + 1;
% get histogram for background pixels
bg_his       = accumarray(bg_qnt_col, 1, [st.bin st.bin st.bin]); 

%% log-likelihood ratio (llr)
bg_his (bg_his == 0) = 1;
llr                 = log(obj_his ./ bg_his);
llr(llr < 0)        = 0;
llr                 = llr ./ max(llr(:));

hist.obj            = obj_his;
hist.bg             = bg_his;
hist.non_adp_llr    = llr;

[ klm_bins, vrs ]   = adp_hist ( st, epoch, llr, klm_bins, vrs );
hist.llr        = klmbins2his ( klm_bins );

%% confident maps using llr  
rc_conv.all  = [rc_conv.in; rc_conv.out];
all_qnt_col  = [obj_qnt_col; bg_qnt_col];
cmp.llr.out  = zeros(size(all_qnt_col, 1), 1);
for i        = 1 : size(rc_conv.all, 1)
    cmp.llr.out(i, 1) = hist.llr(all_qnt_col(i, 1), all_qnt_col(i, 2), all_qnt_col(i, 3));
end
cmp.llr.out  = cmp.llr.out / max(cmp.llr.out(:));
if epoch == 119
end
cnt.llr.out  = [sum(rc_conv.all(:, 1) .* cmp.llr.out), ...
                sum(rc_conv.all(:, 2) .* cmp.llr.out)] / sum(cmp.llr.out);
            
%% images of confident maps
img.llr.out  = zeros(size(im, 1), size(im, 2));
img.llr.out(uint32(sub2ind([size(im, 1), size(im, 2)], rc_conv.all(:, 2), rc_conv.all(:, 1)))) = cmp.llr.out;

end