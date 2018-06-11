function [ im_tr ] = fun_load_im_gt ( i )
if i == 1
    load('1C1'); load('1R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('1C3'); load('1R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 2
    load('2C1'); load('2R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('2C3'); load('2R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 13
    load('13C1'); load('13R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('13C3'); load('13R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 14
    load('14C1'); load('14R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('14C3'); load('14R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 25
    load('25C1'); load('25R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('25C3'); load('25R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 28
    load('28C1'); load('28R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('28C3'); load('28R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 29
    load('29C1'); load('29R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('29C3'); load('29R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
elseif i == 31
    load('31C1'); load('31R1');
    im_tr.ms.list.cent_2d = opc;
    im_tr.ms.list.bb_2d   = opr;
    load('31C3'); load('31R3');
    im_tr.ms_cbwh.list.cent_2d = opc;
    im_tr.ms_cbwh.list.bb_2d   = opr;
end
end