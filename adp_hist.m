function [ klm_bins, vrs ]  = adp_hist ( st, epoch, obj_his, klm_bins, vrs )
    
    %% find non-empty seeds and initialize KFs for the first scan
    if epoch             == st.start_fr                % do for the first scan
        vrs.b_prev               = find(obj_his);              % linear indexing
        vrs.bb_prev              = obj_his > eps;
        vrs.bb_prev = vrs.bb_prev(:);                              % binary indexing
        
        for i                = 1 : length(vrs.b_prev)
            klm_bins(vrs.b_prev(i)).s       = klmi(obj_his(vrs.b_prev(i)), 'h');
        end        
	%% find non-empty seeds and initialize KFs for the next scan
    else
        vrs.bb                      = obj_his > eps;
        vrs.bb                      = vrs.bb(:);                           % binary indexing
        
        %% compare non-empty seeds
        ind_upd                     = find(vrs.bb & vrs.bb_prev);                       % index for normal updating
        ind_init                    = find(xor(vrs.bb, vrs.bb_prev) & vrs.bb);          % index for initialization
        ind_elm                     = find(xor(vrs.bb, vrs.bb_prev) & vrs.bb_prev);     % index for elimination
        
        %% normal updating
        for i                           = 1 : length(ind_upd)
            klm_bins(ind_upd(i)).s.z    = obj_his(ind_upd(i));
            klm_bins(ind_upd(i)).s      = kalmanf_simplified(klm_bins(ind_upd(i)).s);
        end
        
        %% initialization
        for i                           = 1 : length(ind_init)
            klm_bins(ind_init(i)).s     = klmi(obj_his(ind_init(i)), 'h');
        end
        
        %% elimination        
        for i                           = 1 : length(ind_elm)
            klm_bins(ind_elm(i)).s      = [];
        end
    end
    
    %% use the current non-empty bins as previous non-empty bins in the next scan
    if epoch ~= st.start_fr; vrs.bb_prev = vrs.bb; end
end