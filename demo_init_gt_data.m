%% clear memory & command window
clear; close all; clc;

st = setting_save( 7 );
st.start_fr = 770;
st.end_fr = 800;
st.object_class = 3;
[ object_data ]= init_object_data ( st, st.object_class );
save_object_data( object_data, st );