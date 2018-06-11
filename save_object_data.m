function save_object_data( object_data, st )
idx     = 1;
limit   = size(object_data, 2);
for i = 1 : limit%st.start_fr : st.end_fr
    object_data_output{1, idx}  = object_data{1, i};
    idx = idx + 1;
end

object      = sprintf('object_data_%04d_%03d_%03d_', st.dr.dnm, st.start_fr, st.end_fr);
object_type = sprintf(object_data_output{1}.type);
object_name = strcat(object, object_type);

if exist(strcat(object_name, '.mat'), 'file') == 2 % if object data for this case doesn't exist
else
    save(sprintf(object_name), 'object_data_output');
end
end