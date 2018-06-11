function s = kalmanf_simplified(s)

%% Predict
s.x        = s.A * s.x;                             % prediction for state vector and covariance
s.P        = s.A * s.P * s.A' + s.Q;                % covariance of the state vector estimate

%% Update
K          = s.P * s.H' / (s.H * s.P * s.H' + s.R); % compute Kalman gain
s.x        = s.x + K * (s.z - s.H * s.x);           % correction based on observation
s.P        = s.P - K * s.H * s.P;

end

