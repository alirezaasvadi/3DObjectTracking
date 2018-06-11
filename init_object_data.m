function [ object_data ] = init_object_data ( st, object_class )
%% INIT_OBJECT_DATA
% output: object_data
% input:  st, object_class
% This function, given a setting file and a flag, extracts ground-truth
% from the provided dataset for an object of interest specified by both
% sequence number (in setting file) and the flag.
tracklets   = readLabels(st.dr.lbl, st.seq_idx);

    %% sequence 0
if st.dr.dnm == 0
    if object_class == 1 % pedestrian
    elseif object_class == 2 % cyclist
    elseif object_class == 3 % van
    elseif object_class == 4 % stopped van
        st.start_fr = 25;
        st.end_fr   = 109;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= st.end_fr)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 1
elseif st.dr.dnm == 1  
    if object_class == 5 % parked car
        st.start_fr = 1;
        st.end_fr   = 18;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 6)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 7) && (i <= 12)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 13) && (i <= 16)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 17) && (i <= 18)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 6 % parked car
        st.start_fr = 31;
        st.end_fr   = 88;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 34)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 35)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 36) && (i <= 39)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 40) && (i <= 44)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 44) && (i <= 46)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 47) && (i <= 51)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 52) && (i <= 56)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 57) && (i <= 66)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 57) && (i <= 66)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 67) && (i <= 68)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 69) && (i <= 88)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 2
elseif st.dr.dnm == 2
    if object_class == 1 % pedestrian
        st.start_fr = 90;
        st.end_fr   = 233;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
%             if (i >= st.start_fr) && (i <= 58)
%                 st.object_id = 3;
%                 object_data{vector_idx}  = tracklets{i}(st.object_id);
%                 vector_idx = vector_idx + 1;
%             elseif (i >= 59) && (i <= 70)
%                 st.object_id = 4;
%                 object_data{vector_idx}  = tracklets{i}(st.object_id);
%                 vector_idx = vector_idx + 1;
%             elseif (i >= 71)
            if (i >= 90) && (i <= 118)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 119) && (i <= 233)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2 % moving car
        st.start_fr = 80;
        st.end_fr   = 157;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 84)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 85) && (i <= 118)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 119) && (i <= 133)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 134) && (i <= 138)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 139) && (i <= 147)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 148) && (i <= 157)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % bus
        st.start_fr = 140;
        st.end_fr   = 217;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 147)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 148) && (i <= 158)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 159) && (i <= 172)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 173) && (i <= 217)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 3
elseif st.dr.dnm == 3
    if object_class == 1 % car
        st.start_fr = 23;
        st.end_fr   = 144;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 76)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 77) && (i <= 144)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 4
elseif st.dr.dnm == 4
    if object_class == 1 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 314;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 4)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 4) && (i <= 11)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 11) && (i <= st.end_fr)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2 % cyclist
    elseif object_class == 3 % van
    end
    %% sequence 5
elseif st.dr.dnm == 5
    if object_class == 1 % pedestrian
    elseif object_class == 2 % cyclist
        st.start_fr = 99;
        st.end_fr   = 199;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
%             if (i >= 65) && (i <= 67)
%                 st.object_id = 6;
%                 object_data{vector_idx}  = tracklets{i}(st.object_id);
%                 vector_idx = vector_idx + 1;
%             elseif (i == 68)
%                 st.object_id = 5;
%                 object_data{vector_idx}  = tracklets{i}(st.object_id);
%                 vector_idx = vector_idx + 1;
%             elseif (i > 68) && (i <= 72)
%                 st.object_id = 6;
%                 object_data{vector_idx}  = tracklets{i}(st.object_id);
%                 vector_idx = vector_idx + 1;
            if (i >= st.start_fr) && (i <= 100)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 101)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 101) && (i <= 106)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 106) && (i <= 109)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 109) && (i <= 116)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 106) && (i <= 121)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 139)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 140)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 141)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 141) && (i <= 149)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 149) && (i <= 165)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 165) && (i <= 170)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 171)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 171) && (i <= 184)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 184) && (i <= 186)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 186) && (i <= 188)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 188) && (i <= 193)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 194)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 194) && (i <= 197)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 197) && (i <= 199)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % van
        st.start_fr = 1;
        st.end_fr   = st.dr.nmg;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 1) && (i <= 10)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 10) && (i <= 14)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 14) && (i <= 20)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 20) && (i <= 26)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 26) && (i <= 28)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 28) && (i <= 39)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 39) && (i <= 44)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 44) && (i <= 53)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 53) && (i <= 55)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 55) && (i <= 58)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 58) && (i <= 63)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 63) && (i <= 67)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 68)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 68) && (i <= 72)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 72) && (i <= 100)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 101)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 101) && (i <= 106)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 106) && (i <= 109)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 109) && (i <= 116)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 116) && (i <= 121)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 139)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 139) && (i <= 148)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 148) && (i <= 165)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 165) && (i <= 170)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 171)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 171) && (i <= 184)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 184) && (i <= 186)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 186) && (i <= 193)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 194)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 194) && (i <= 197)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 197) && (i <= 199)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 199) && (i <= 203)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 203) && (i <= 209)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 209) && (i <= 223)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 223) && (i <= 228)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 228) && (i <= 233)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 233) && (i <= 239)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 239) && (i <= 241)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 241) && (i <= 245)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 245) && (i <= 248)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 248) && (i <= 254)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 254) && (i <= 256)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 257) || (i == 259)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 258)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 259) && (i <= 264)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 264) && (i <= 270)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 270) && (i <= 275)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 275) && (i <= 277)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 277) && (i <= 284)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 284) && (i <= 287)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 287) && (i <= 290)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 290) && (i <= 292)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 292) && (i <= 297)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 4 % cyclist
        st.start_fr = 161;
        st.end_fr   = 202;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 165)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 166) && (i <= 170)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 171)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 172) && (i <= 184)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 185) && (i <= 186)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 187) && (i <= 188)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 189) && (i <= 193)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 194)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 195) && (i <= 197)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 198) && (i <= 199)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 200) && (i <= 202)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    
    %% sequence 6
elseif st.dr.dnm == 6
    if object_class == 1 % car (S-M)
        st.start_fr = 86;
        st.end_fr   = 221;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 89)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 90) && (i <= 96)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 97) && (i <= 101)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 102)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 103) && (i <= 115)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 116) && (i <= 123)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 124) && (i <= 136)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 137) && (i <= 140)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 141) && (i <= 142)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 143) && (i <= 153)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 154) && (i <= 179)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 180) && (i <= 221)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 7
elseif st.dr.dnm == 7
    if object_class == 1 % car (S)
        st.start_fr = 360;
        st.end_fr   = 397;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 364)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 365) && (i <= 369)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 370) && (i <= 374)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 375) && (i <= 380)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 381) && (i <= 397)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2 % car (M)
        st.start_fr = 514;
        st.end_fr   = 564;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 516)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 517) && (i <= 530)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 531)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 532) && (i <= 541)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 542) && (i <= 555)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 556) && (i <= 564)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % car (parked)
        st.start_fr = 770;
        st.end_fr   = 800;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 800)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 4 % van (M)
        st.start_fr = 705;
        st.end_fr   = 746;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 746)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 8
elseif st.dr.dnm == 8
    if object_class == 1
    elseif object_class == 2 % car (moving)
        st.start_fr = 1;
        st.end_fr   = 390;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 2)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 3)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 4) && (i <= 6)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 7) && (i <= 8)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 9) && (i <= 11)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 12) && (i <= 14)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 15) && (i <= 17)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 18) && (i <= 24)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 25) && (i <= 58)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 59) && (i <= 390)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % moving van
        st.start_fr = 1;
        st.end_fr   = 24;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i == 1) || (i == 2) || ((i >= 4) && (i <= 6))
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 2) || (i == 3)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 2) || (i == 3)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 7) || (i == 8)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 9) && (i <= 14)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 15) && (i <= 17)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 18) && (i <= 24)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 4 % stopped van
        st.start_fr = 23;
        st.end_fr   = 58;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 18) && (i <= 24)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 25) && (i <= 58)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 9
elseif st.dr.dnm == 9
    if object_class == 1
    elseif object_class == 2 % car (parked)
        st.start_fr = 1;
        st.end_fr   = 65;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 21)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 22) && (i <= 65)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % truck
        st.start_fr = 220;
        st.end_fr   = 275;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
%             if (i >= st.start_fr) && (i <= 202)
%                 st.object_id = 12; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i == 203)
%                 st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i >= 204) && (i <= 207)
%                 st.object_id = 12; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i == 208)
%                 st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i >= 209) && (i <= 210)
%                 st.object_id = 15; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i >= 211) && (i <= 213)
%                 st.object_id = 16; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i == 214)
%                 st.object_id = 17; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i >= 215) && (i <= 217)
%                 st.object_id = 15; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i == 218)
%                 st.object_id = 16; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
%             elseif (i == 219) || (i == 224)
%                 st.object_id = 15; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            if (i == st.start_fr)
                st.object_id = 14; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 221)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 222) && (i <= 223)
                st.object_id = 14; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 224)
                st.object_id = 15; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 225) && (i <= 228)
                st.object_id = 14; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 229)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 230) && (i <= 232)
                st.object_id = 14; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 233)
                st.object_id = 16; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 234) && (i <= 238)
                st.object_id = 15; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 239) && (i <= 241)
                st.object_id = 14; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 242) && (i <= 244)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 245) && (i <= 246)
                st.object_id = 12; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 247) && (i <= 250)
                st.object_id = 11; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 251)
                st.object_id = 10; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 252) && (i <= 254)
                st.object_id = 9; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 255) && (i <= 256)
                st.object_id = 8; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 257)
                st.object_id = 7; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 258) && (i <= 260)
                st.object_id = 6; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 261) && (i <= 264)
                st.object_id = 5; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 265) && (i <= 269)
                st.object_id = 4; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 270) && (i <= 272)
                st.object_id = 3; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 273) && (i <= 274)
                st.object_id = 2; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 275)
                st.object_id = 1; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 4 % truck
        st.start_fr = 330;
        st.end_fr   = 802;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 802)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 12
elseif st.dr.dnm == 12
    if object_class == 1
        st.start_fr = 15;
        st.end_fr   = 77;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : size(tracklets, 2)
            if (i > 66) && (i <= 77)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 41) && (i <= 66)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 14) && (i <= 41)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2
    elseif object_class == 3
    end
    %% sequence 13
elseif st.dr.dnm == 13
    if object_class == 1
        st.start_fr = 300;
        st.end_fr   = st.dr.nmg;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : size(tracklets, 2)
            if (i >= 300) && (i <= 305)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 305) && (i <= 311)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 311) && (i <= 314)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 314) && (i <= 340)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2
        st.start_fr = 77;
        st.end_fr   = 175;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 130) && (i <= 175)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 101) && (i <= 129)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 98) && (i <= 100)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 96) && (i <= 97)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 93) && (i <= 95)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 92)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 77) || (i == 82) || (i == 91)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 78) && (i <= 81)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 86) || (i == 89) || (i == 90)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 83) || (i == 87) || (i == 88)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 84)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 85)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 15
elseif st.dr.dnm == 15
    if object_class == 1 % car (S-M)
        st.start_fr = 68;
        st.end_fr   = 255;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : size(tracklets, 2)
            if (i >= st.start_fr) && (i <= 70)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 71) && (i <= 72)
                st.object_id = 12; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 73)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 74) && (i <= 79)
                st.object_id = 12; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 80)
                st.object_id = 11; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 81) && (i <= 83)
                st.object_id = 10; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 84) && (i <= 112)
                st.object_id = 9; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 113)
                st.object_id = 8; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 114) && (i <= 143)
                st.object_id = 7; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 144) && (i <= 148)
                st.object_id = 6; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 149) && (i <= 230)
                st.object_id = 5; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 231) && (i <= 237)
                st.object_id = 4; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 238) && (i <= 255)
                st.object_id = 3; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2 % bus (parked)
        st.start_fr = 37;
        st.end_fr   = 64;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : size(tracklets, 2)
            if (i >= st.start_fr) && (i <= 39)
                st.object_id = 6; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 40) && (i <= 42)
                st.object_id = 8; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 43)
                st.object_id = 7; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 44) && (i <= 48)
                st.object_id = 9; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 49) && (i <= 50)
                st.object_id = 10; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 51)
                st.object_id = 11; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 52) && (i <= 53)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 54) && (i <= 63)
                st.object_id = 14; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 64)
                st.object_id = 13; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % car
        st.start_fr = 93;
        st.end_fr   = 143;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : size(tracklets, 2)
            if (i >= st.start_fr) && (i <= 112)
                st.object_id = 10; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 113)
                st.object_id = 9; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 114) && (i <= 143)
                st.object_id = 8; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 4 % pedestrian
        st.start_fr = 54;
        st.end_fr   = 376;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : size(tracklets, 2)
            if (i >= st.start_fr) && (i <= 63)
                st.object_id = 7; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 64) && (i <= 66)
                st.object_id = 6; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 67) && (i <= 72)
                st.object_id = 5; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 73) && (i <= 81)
                st.object_id = 6; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 82) && (i <= 112)
                st.object_id = 5; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 113) && (i <= 143)
                st.object_id = 4; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 144) && (i <= 148)
                st.object_id = 3; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 149) && (i <= 376)
                st.object_id = 2; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end    
    end
    %% sequence 16
elseif st.dr.dnm == 16
    % back 2, left
    if object_class == 1 % pedestrian
        st.start_fr = 21;
        st.end_fr   = 132;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 23)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 23) && (i <= 46)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 46) && (i <= 48)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 48) && (i <= 55)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 55) && (i <= 57)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 57) && (i <= 70)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 71)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 71) && (i <= 73)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 73) && (i <= 103)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 103) && (i <= 111)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 111) && (i <= 118)
                st.object_id = 19;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 118) && (i <= 121)
                st.object_id = 20;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 132)
                st.object_id = 21;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 133)
                st.object_id = 20;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 134)
                st.object_id = 19;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 134) && (i <= 141)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 141) && (i <= 146)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 146) && (i <= 160)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 160) && (i <= 170)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
        % front 2, right
    elseif object_class == 1.1 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 132;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 12)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 12) && (i <= 17)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 17) && (i <= 20)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 20) && (i <= 23)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 23) && (i <= 46)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 46) && (i <= 48)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 48) && (i <= 55)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 55) && (i <= 57)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 57) && (i <= 70)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 71)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 71) && (i <= 73)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 73) && (i <= 103)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 103) && (i <= 111)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 111) && (i <= 118)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 118) && (i <= 121)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 132)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
        % front 2, left
    elseif object_class == 1.2 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 131;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 12)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 12) && (i <= 17)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 17) && (i <= 20)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 20) && (i <= 23)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 23) && (i <= 46)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 46) && (i <= 48)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 48) && (i <= 55)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 55) && (i <= 57)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 57) && (i <= 70)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 71)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 71) && (i <= 73)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 73) && (i <= 103)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 103) && (i <= 111)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 111) && (i <= 118)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 118) && (i <= 121)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 131)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
        % middle 3, left
    elseif object_class == 1.3 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 141;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 12)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 12) && (i <= 17)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 17) && (i <= 20)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 20) && (i <= 23)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 23) && (i <= 46)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 46) && (i <= 48)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 48) && (i <= 55)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 55) && (i <= 57)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 57) && (i <= 70)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 71)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 71) && (i <= 73)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
                
            elseif (i > 73) && (i <= 103)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 103) && (i <= 111)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 111) && (i <= 118)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 118) && (i <= 121)
                st.object_id = 19;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 132)
                st.object_id = 20;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 133)
                st.object_id = 19;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 134)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 134) && (i <= 141)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
        % middle 3, middle
    elseif object_class == 1.4 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 140;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 12)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 12) && (i <= 17)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 17) && (i <= 20)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 20) && (i <= 23)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 23) && (i <= 46)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 46) && (i <= 48)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 48) && (i <= 55)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 55) && (i <= 57)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 57) && (i <= 70)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 71)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 71) && (i <= 73)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 73) && (i <= 103)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 103) && (i <= 111)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 111) && (i <= 118)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 118) && (i <= 121)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 121) && (i <= 132)
                st.object_id = 19;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 133)
                st.object_id = 18;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 134)
                st.object_id = 17;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 134) && (i <= 140)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.5 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 41;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 1) && (i <= 12)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 13) && (i <= 41)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 17
elseif st.dr.dnm == 17
    if object_class == 1 % pedestrian
        st.start_fr = 19;
        st.end_fr   = 63;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 19) && (i <= 41)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 41) && (i <= 62)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 63)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2 % cyclist
        st.start_fr = 11;
        st.end_fr   = 41;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
%             if (i >= 1) && (i <= 8)
%                 st.object_id = 7;
%                 object_data{vector_idx}  = tracklets{i}(st.object_id);
%                 vector_idx = vector_idx + 1;
%             elseif (i >= 9) && (i <= 11)
            if (i == 11)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 12) && (i <= 18)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 19) && (i <= 41)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 3 % pedestrian
        st.start_fr = 9;
        st.end_fr   = 62;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 41)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i >= 42) && (i <= 62)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 4 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 112;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 8)
                st.object_id = 3; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 9) && (i <= 11)
                st.object_id = 4; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 12) && (i <= 18)
                st.object_id = 5; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 19) && (i <= 41)
                st.object_id = 6; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 42) && (i <= 62)
                st.object_id = 4; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 63) && (i <= 64)
                st.object_id = 3; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 65) && (i <= 67)
                st.object_id = 2; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 68) && (i <= 112)
                st.object_id = 1; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 5 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 145;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 8)
                st.object_id = 4; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 9) && (i <= 11)
                st.object_id = 5; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 12) && (i <= 18)
                st.object_id = 6; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 19) && (i <= 41)
                st.object_id = 7; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 42) && (i <= 62)
                st.object_id = 5; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 63) && (i <= 64)
                st.object_id = 4; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 65) && (i <= 67)
                st.object_id = 3; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 68) && (i <= 112)
                st.object_id = 2; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 113) && (i <= 145)
                st.object_id = 1; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 18
elseif st.dr.dnm == 18
    if object_class == 1 % car
        st.start_fr = 76;
        st.end_fr   = 339;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 76) && (i <= 244)
                st.object_id = 2; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 245) && (i <= 339)
                st.object_id = 1; object_data{vector_idx}  = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    end
    %% sequence 19
elseif st.dr.dnm == 19
    if object_class == 1 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 71;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= 1) && (i <= 8)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 8) && (i <= 71)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.1 % pedestrian
        st.start_fr = 200;
        st.end_fr   = 387;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 205)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 205) && (i <= 209)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 209) && (i <= 212)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 212) && (i <= 215)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 215) && (i <= 222)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 222) && (i <= 226)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 226) && (i <= 232)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 232) && (i <= 239)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 239) && (i <= 242)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 242) && (i <= 387)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.2 % pedestrian
        st.start_fr = 400;
        st.end_fr   = 759;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 408)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 408) && (i <= 429)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 429) && (i <= 431)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 431) && (i <= 759)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.3 % pedestrian
        st.start_fr = 189;
        st.end_fr   = 344;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 192)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 192) && (i <= 197)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 197) && (i <= 205)
                st.object_id = 11;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 205) && (i <= 209)
                st.object_id = 10;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 209) && (i <= 212)
                st.object_id = 9;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 212) && (i <= 215)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 215) && (i <= 222)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 222) && (i <= 225)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 226)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 226) && (i <= 232)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 232) && (i <= 236)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 236) && (i <= 239)
                st.object_id = 8;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 239) && (i <= 242)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 242) && (i <= 248)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 248) && (i <= 250)
                st.object_id = 7;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 250) && (i <= 285)
                st.object_id = 6;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 285) && (i <= 287)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 288)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 288) && (i <= 293)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 293) && (i <= 344)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.4 % pedestrian
        st.start_fr = 400;
        st.end_fr   = 758;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 408)
                st.object_id = 5;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 408) && (i <= 429)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 429) && (i <= 431)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 431) && (i <= 758)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.5 % pedestrian
        st.start_fr = 200;
        st.end_fr   = 244;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 205)
                st.object_id = 16;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 205) && (i <= 209)
                st.object_id = 15;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 209) && (i <= 212)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 212) && (i <= 215)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 215) && (i <= 220)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 220) && (i <= 222)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 222) && (i <= 225)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i == 226)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 226) && (i <= 232)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 232) && (i <= 236)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 236) && (i <= 239)
                st.object_id = 14;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 239) && (i <= 242)
                st.object_id = 13;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 242) && (i <= 244)
                st.object_id = 12;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 1.6 % pedestrian
        st.start_fr = 1;
        st.end_fr   = 125;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 8)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 8) && (i <= 23)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 23) && (i <= 47)
                st.object_id = 4;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 47) && (i <= 71)
                st.object_id = 3;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 71) && (i <= 90)
                st.object_id = 2;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            elseif (i > 90) && (i <= 125)
                st.object_id = 1;
                object_data{vector_idx}  = tracklets{i}(st.object_id);
                vector_idx = vector_idx + 1;
            end
        end
    elseif object_class == 2 % parked van
        st.start_fr = 1;
        st.end_fr   = 146;
        vector_idx  = 1;
        object_data = cell(1, st.end_fr-st.start_fr+1);
        for i = st.start_fr : st.end_fr
            if (i >= st.start_fr) && (i <= 8)
                st.object_id = 6; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 9) && (i <= 23)
                st.object_id = 5; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 24) && (i <= 41)
                st.object_id = 6; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 42) && (i <= 47)
                st.object_id = 5; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 48) && (i <= 77)
                st.object_id = 4; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 78)
                st.object_id = 5; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 79) && (i <= 85)
                st.object_id = 6; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 86) && (i <= 90)
                st.object_id = 7; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 91) && (i <= 101)
                st.object_id = 6; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 102) && (i <= 112)
                st.object_id = 7; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 113)
                st.object_id = 9; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 114) && (i <= 120)
                st.object_id = 8; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 121) && (i <= 125)
                st.object_id = 9; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 126) && (i <= 129)
                st.object_id = 8; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 130) && (i <= 136)
                st.object_id = 7; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 137) && (i <= 138)
                st.object_id = 8; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 139) && (i <= 142)
                st.object_id = 9; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i == 143)
                st.object_id = 10; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 144) && (i <= 145)
                st.object_id = 9; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            elseif (i >= 146) && (i <= 149)
                st.object_id = 10; object_data{vector_idx} = tracklets{i}(st.object_id); vector_idx = vector_idx + 1;
            end
        end
    end
else
    object_data = cell(st.start_fr, st.end_fr);
    for i       = st.start_fr : size(tracklets, 2)
        object_data{i}  = tracklets{i}(st.object_id);
    end
end
end