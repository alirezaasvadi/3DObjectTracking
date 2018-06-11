function s = klmi(input, object_class, model)
s.dt         = 0.1;                                      % time step

%% fusion 
if object_class == 'f'
if strcmp( model, 'simple' )
    % if CV model
    s.A        = eye(3);                                     % state transition matrix
    s.H        = [1 0 0;
                  0 1 0;
                  0 0 1;
                  1 0 0;
                  0 1 0;
                  0 0 1];
    R_im       = 5 * eye(3);                               % measurement noise covariances
    % R_im       = 3 * eye(3);                               % measurement noise covariances
    R_pcd      = 5 * eye(3);
    % R_pcd      = eye(3);
    s.R          = [R_im        zeros(3,3);
                    zeros(3,3)  R_pcd];                      % measurement error covariance
    s.Q          = eye(3);                                   % process noise covariance
    % s.Q          = 3 * eye(3);                               % process noise covariance
    s.x          = s.H \ input;                              % use linear least squares to estimate initial state from initial observation
    s.P          = eye(3);	
    
elseif strcmp( model, 'ca' )
    % if CA model
    s.A        = eye(9);                                     % state transition matrix
    s.A(1,2)   = s.dt; s.A(1,3) = 0.5*s.dt^2; s.A(2,3) = s.dt;
    s.A(4,5)   = s.dt; s.A(4,6) = 0.5*s.dt^2; s.A(5,6) = s.dt;
    s.A(7,8)   = s.dt; s.A(7,9) = 0.5*s.dt^2; s.A(8,9) = s.dt;
    s.H        = [1 0 0 0 0 0 0 0 0;                         % observation matrix
                  0 0 0 1 0 0 0 0 0;
                  0 0 0 0 0 0 1 0 0;
                  1 0 0 0 0 0 0 0 0;
                  0 0 0 1 0 0 0 0 0;
                  0 0 0 0 0 0 1 0 0];
    R_im         = 5 * eye(3);                               % measurement noise covariances
    % R_im         = 3 * eye(3);                               % measurement noise covariances
    R_pcd        = 5 * eye(3);
    % R_pcd        = eye(3);
    s.R          = [R_im        zeros(3,3);
                    zeros(3,3)  R_pcd];                      % measurement error covariance           
    s.Q          = eye(9);                                   % process noise covariance
    % s.Q          = 3 * eye(9);                               % process noise covariance
    s.x          = s.H \ input;                              % use linear least squares to estimate initial state from initial observation
    s.P          = eye(9);                                   % a priori estimate 'error covariance'
    % s.P          = 3 * eye(9);                               % a priori estimate 'error covariance'
end

%% histogram initialization
elseif object_class == 'h'              
    
s.A        = [1 s.dt 0.5*(s.dt^2); 0 1 s.dt; 0 0 1];     % state transition matrix
s.H        = [1 0 0];                                    % observation matrix
s.Q        = 0.1 * eye(3);                               % process noise covariance
s.R        = 1;                                          % measurement error covariance
s.x        = [input; 0; 0];                              % a priori 'state vector' estimate
s.P        = eye(3);                                     % a priori estimate 'error covariance'

%% ground initialization
elseif object_class == 'g'

s.A        = [1 s.dt 0.5*(s.dt^2); 0 1 s.dt; 0 0 1];     % state transition matrix
s.H        = [1 0 0];                                    % observation matrix
s.Q        = 5 * eye(3);                                 % process noise covariance
s.R        = 0.5;                                        % measurement error covariance
s.x        = [input; 0; 0];                              % a priori 'state vector' estimate
s.P        = 15 * eye(3);                                % a priori estimate 'error covariance'

%% object initialization based on the object class
elseif isnumeric(object_class)
 
%% pedestrian    
if  object_class == 1

s.A        = eye(9);                                     % state transition matrix
s.A(1,2)   = s.dt; s.A(1,3) = 0.5*s.dt^2; s.A(2,3) = s.dt;
s.A(4,5)   = s.dt; s.A(4,6) = 0.5*s.dt^2; s.A(5,6) = s.dt;
s.A(7,8)   = s.dt; s.A(7,9) = 0.5*s.dt^2; s.A(8,9) = s.dt;
s.H        = [1 0 0 0 0 0 0 0 0;                         % observation matrix
              0 0 0 1 0 0 0 0 0;
              0 0 0 0 0 0 1 0 0];
s.Q        = 3 * eye(9);                                 % process noise covariance
s.R        = eye(size(s.A, 1)/3);                        % measurement error covariance
s.x        = input;
s.P        = eye(9);                                     % a priori estimate 'error covariance'

%% cyclist
elseif object_class == 2   

s.A        = eye(9);                                     % state transition matrix
s.A(1,2)   = s.dt; s.A(1,3) = 0.5*s.dt^2; s.A(2,3) = s.dt;
s.A(4,5)   = s.dt; s.A(4,6) = 0.5*s.dt^2; s.A(5,6) = s.dt;
s.A(7,8)   = s.dt; s.A(7,9) = 0.5*s.dt^2; s.A(8,9) = s.dt;
s.H        = [1 0 0 0 0 0 0 0 0;                         % observation matrix
              0 0 0 1 0 0 0 0 0;
              0 0 0 0 0 0 1 0 0];
s.Q        = 3 * eye(9);                                 % process noise covariance
s.R        = eye(size(s.A, 1)/3);                        % measurement error covariance
s.x        = input;
s.P        = eye(9);                                     % a priori estimate 'error covariance'

%% vehicle
elseif object_class == 3    

s.A        = eye(9);                                     % state transition matrix
s.A(1,2)   = s.dt; s.A(1,3) = 0.5*s.dt^2; s.A(2,3) = s.dt;
s.A(4,5)   = s.dt; s.A(4,6) = 0.5*s.dt^2; s.A(5,6) = s.dt;
s.A(7,8)   = s.dt; s.A(7,9) = 0.5*s.dt^2; s.A(8,9) = s.dt;
s.H        = [1 0 0 0 0 0 0 0 0;                         % observation matrix
              0 0 0 1 0 0 0 0 0;
              0 0 0 0 0 0 1 0 0];
s.Q        = 3 * eye(9);                                 % process noise covariance
s.R        = eye(size(s.A, 1)/3);                        % measurement error covariance
s.x        = input;
s.P        = eye(9);                                     % a priori estimate 'error covariance' 
    
end
end