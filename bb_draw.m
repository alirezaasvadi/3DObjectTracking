function h = bb_draw ( object, loc, flag, st )

%% 3D information
dim   = [object.h object.w object.l]; %disp(dim)                           % 3D object dimensions: height, width, length (in meters)
rot   = object.ry; %disp(rot)                                              % rotation ry around Y-axis in camera coordinates [-pi..pi] 

if flag == 1 % algorithm
    cl    = [ 0, 0, 1 ];                                                   % color
elseif flag == 2 % ground truth
    cl    = [ 1, 0, 0 ];                                                   % color
elseif flag == 3 % ground truth
    cl    = [ 1, 1, 0 ];
end
%% Box
u     = ((sqrt(dim(2)^2 + dim(3)^2))/2) * cos(rot + atan(dim(2)/dim(3)));  % Half of 'l' in the vehicle direction
v     = ((sqrt(dim(2)^2 + dim(3)^2))/2) * sin(rot + atan(dim(2)/dim(3)));  % Half of 'w' perpendicular to the vehicle direction
if flag == 1 || flag == 3 % algorithm
    st    = [ loc(1) - u, loc(2) - v, loc(3)-object.h/2+st.z_base];                  % start point
elseif flag == 2 % ground truth
    st    = [ loc(1) - u, loc(2) - v, loc(3)-object.h/2+st.z_base];                  % start point
end

sz    = [ dim(3), dim(2),  dim(1) ];                                       % size
ps    = [ 0, 0, rot ];                                                     % pose

al    = 0.03;                                                               % alpha
h = vox(st, sz, ps, cl, al);
end

function h = vox(st, sz, ps, cl, al)

%% vertices
vt.o  = [ 0       0       0      ;  % 1
          sz(1)   0       0      ;  % 2
          sz(1)   sz(2)   0      ;  % 3
          0       sz(2)   0      ;  % 4
          0       sz(2)   sz(3)  ;  % 5
          0       0       sz(3)  ;  % 6
          sz(1)   0       sz(3)  ;  % 7
          sz(1)   sz(2)   sz(3) ];  % 8
%% transformation
rx    = [ 1       ,  0           ,  0           ;                          % rotation around x-axis
          0       ,  cos(ps(1))  , -sin(ps(1))  ; 
          0       ,  sin(ps(1))  ,  cos(ps(1)) ]; 
ry    = [ cos(ps(2)),  0         ,  sin(ps(2))  ;                          % rotation around y-axis 
          0         ,  1         ,  0           ; 
         -sin(ps(2)),  0         ,  cos(ps(2)) ];   
rz    = [ cos(ps(3)), -sin(ps(3)),  0           ;                          % rotation around z-axis 
          sin(ps(3)),  cos(ps(3)),  0           ; 
          0         ,  0         ,  1          ];     
r     = rx * ry * rz;                                                      % total rotation around xyz-axes
%% transformed vertices      
vt.t  = (r * vt.o')';
vt.t  = vt.t + repmat([st(1) st(2) st(3)], 8, 1);
% vt_list = vt.t;
% x_vertex = [vt_list(1 : 4, 1); vt_list(1, 1)];
% y_vertex = [vt_list(1 : 4, 2); vt_list(1, 2)];
% z_vertex = [vt_list(1 : 4, 3); vt_list(1, 3)];
% bb = [x_vertex y_vertex z_vertex];
%% voxel faces      
fc    = [ 1 2 3 4;  % a 
          3 4 5 8;  % b 
          1 4 5 6;  % c 
          1 6 7 2;  % d 
          2 3 8 7;  % e 
          5 6 7 8]; % f 
% plot box (voxel) - using patch
h     = patch('Vertices', vt.t, 'Faces', fc, 'EdgeColor', cl, 'FaceColor', cl, 'LineWidth', 1.5);
set( h, 'FaceAlpha', al);
end