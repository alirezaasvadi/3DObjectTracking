function [ obj_ry_world ] = rz_to_world ( obj_rz )
%RY TO WORLD Summary of this function goes here
%   Detailed explanation goes here

    %% object rotation in world coordinate
    % input: obj_ry
    % output: obj_ry_world
    
    ps    = [0, 0, obj_rz];
    
    rx    = [ 1       ,  0           ,  0           ;            % rotation around x-axis
              0       ,  cos(ps(1))  , -sin(ps(1))  ; 
              0       ,  sin(ps(1))  ,  cos(ps(1)) ];
      
    ry    = [ cos(ps(2)),  0         ,  sin(ps(2))  ;            % rotation around y-axis 
              0         ,  1         ,  0           ; 
             -sin(ps(2)),  0         ,  cos(ps(2)) ];
     
    rz    = [ cos(ps(3)), -sin(ps(3)),  0           ;            % rotation around z-axis 
              sin(ps(3)),  cos(ps(3)),  0           ; 
              0         ,  0         ,  1          ];
      
    obj_ry_world = rx * ry * rz;                                        % total rotation around xyz-axes    

end

