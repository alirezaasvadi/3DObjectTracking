function [ new_his ] = klmbins2his ( klm_bins )
    num_bins             = size(klm_bins, 2);
    his_value            = zeros(num_bins, 1);
    
    for i = 1 : num_bins
        if isempty(klm_bins(i).s)
            his_value(i) = 0;
        else
            his_value(i) = klm_bins(i).s.x(1);
        end
    end
    new_his = reshape(his_value, [8, 8, 8]);
end