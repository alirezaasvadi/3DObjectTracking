clear; close; clc;
% load('gt_cent');
% load('ms_cent');

% ms_ry(1) = 0;
% gt_ry(1) = 0;
% for k = 2 : 154
%     ms_ry(k) = atan2((ms_cent(k, 2) - ms_cent(k-1, 2)), (ms_cent(k, 1) - ms_cent(k-1, 1)));
%     gt_ry(k) = atan2((gt_cent(k, 2) - gt_cent(k-1, 2)), (gt_cent(k, 1) - gt_cent(k-1, 1)));
% end


% k = 2;
% ms_vec = ms_cent(k, 1:3) - ms_cent(k-1, 1:3);
% gt_vec = gt_cent(k, 1:3) - gt_cent(k-1, 1:3);
% delta  = atan2(gt_vec, ms_vec);

% for k = 1:2%1 : 154
% 
% hold on
% plot3(ms_cent(k, 1), ms_cent(k, 2), ms_cent(k, 3), '*r', 'LineWidth', 1, 'MarkerSize', 3);  
% plot3(gt_cent(k, 1), gt_cent(k, 2), gt_cent(k, 3), '*g', 'LineWidth', 1, 'MarkerSize', 3); 
% hold off
% pause(0.01)
% 
% end
% axis equal
% 
% ms_vec = ms_cent(k, 1:3) - ms_cent(k-1, 1:3);
% gt_vec = gt_cent(k, 1:3) - gt_cent(k-1, 1:3);
% delta  = atan2(gt_vec, ms_vec);

% %% angle difference    
% numerator       = norm(cross(ms_vec, gt_vec));
% denominator     = dot(ms_vec, gt_vec);  
% angle           = radtodeg(abs(atan(numerator / denominator)));


%% example
a_0 = [0, 0, 0];
a_1 = [1, 0, 0];

b_0 = [0, 0, 0];
b_1 = [0, 1, 0];

hold on
plot3(a_0(1), a_0(2), a_0(3), '*b', 'LineWidth', 1, 'MarkerSize', 3);  
plot3(a_1(1), a_1(2), a_1(3), '*g', 'LineWidth', 1, 'MarkerSize', 3); 
plot3(b_0(1), b_0(2), b_0(3), '*b', 'LineWidth', 1, 'MarkerSize', 3); 
plot3(b_1(1), b_1(2), b_1(3), '*r', 'LineWidth', 1, 'MarkerSize', 3); 
hold off

a   = a_1 - a_0;
b   = b_1 - b_0;

%% mtd 1:    
numerator       = cross(a, b);
denominator     = dot(a, b);  
if denominator  == 0
denominator     = eps;
end
angle           = radtodeg(abs(atan(numerator / denominator)));
disp(angle)
