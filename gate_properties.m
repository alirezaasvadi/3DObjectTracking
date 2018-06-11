function [ gate ] = gate_properties ( obj )
gate.h   = obj.h;
gate_size = 2;
gate.l   = gate_size * obj.l;
gate.w   = gate_size * obj.w;
gate.ry  = obj.ry;
gate.r_3d = rz_to_world( gate.ry );

end