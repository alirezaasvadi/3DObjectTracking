function [ obj, obj_gt ] = object_update ( obj, st )
data    = st.object_data{1};
obj.h   = data.h;                 obj_gt.h = obj.h;
obj.l   = data.l;                 obj_gt.l = obj.l;
obj.w   = data.w;                 obj_gt.w = obj.w;
obj.ry  = -data.ry-pi/2;          obj_gt.ry= obj.ry;
obj.r_3d = rz_to_world( obj.ry );

end