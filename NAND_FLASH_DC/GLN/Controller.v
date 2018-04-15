
module Controller ( clk, DIO, cntrl_in, cntrl_sel, cntrl_we, cntrl_re, 
        nfc_done, ALE, CLE, wEn, rEn, command_error, cEn, nfc_cmd, RWA, Reset, 
        nfc_start, status, cntrl_out, buf_cntrl_status, host_buf_status );
  inout [15:0] DIO;
  output [15:0] cntrl_in;
  input [2:0] nfc_cmd;
  input [15:0] RWA;
  input [15:0] cntrl_out;
  input clk, Reset, nfc_start, status, buf_cntrl_status, host_buf_status;
  output cntrl_sel, cntrl_we, cntrl_re, nfc_done, ALE, CLE, wEn, rEn,
         command_error, cEn;
  wire   N243, N249, N252, N258, N259, N260, N261, N262, N263, N264, N265,
         N266, N267, N268, N269, N270, N271, N272, N273, N274, N275, N276,
         N277, N279, N310, N344, N345, N346, N347, N348, N349, N350, N351,
         N352, N353, N354, N355, N358, N361, N364, N367, N370, N373, N376,
         N379, N382, N385, N388, N391, N394, N397, N400, N403, N406, N409,
         N412, N415, N418, N421, N424, N427, N430, N433, N436, N439, N442,
         N445, N448, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71,
         n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n87, n88, n89,
         n90, n91, n93, n94, n95, n101, n102, n103, n104, n105, n106, n107,
         n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155;
  wire   [31:0] next_state;
  tri   [15:0] DIO;
  tri   [15:0] cntrl_in;
  tri   \DIO_out[9] ;
  tri   \DIO_out[8] ;
  tri   \DIO_out[7] ;
  tri   \DIO_out[6] ;
  tri   \DIO_out[5] ;
  tri   \DIO_out[4] ;
  tri   \DIO_out[3] ;
  tri   \DIO_out[2] ;
  tri   \DIO_out[1] ;
  tri   \DIO_out[15] ;
  tri   \DIO_out[14] ;
  tri   \DIO_out[13] ;
  tri   \DIO_out[12] ;
  tri   \DIO_out[11] ;
  tri   \DIO_out[10] ;
  tri   \DIO_out[0] ;

  LATCHX1 \next_state_reg[0]  ( .CLK(N279), .D(N258), .Q(next_state[0]) );
  DFFSSRX1 \cur_state_reg[0]  ( .D(1'b0), .SETB(Reset), .RSTB(next_state[0]), 
        .CLK(clk), .Q(n153), .QN(n104) );
  LATCHX1 \command_reg[0]  ( .CLK(N354), .D(nfc_cmd[0]), .Q(n149) );
  LATCHX1 \command_reg[1]  ( .CLK(N354), .D(nfc_cmd[1]), .Q(n151), .QN(n105)
         );
  LATCHX1 \command_reg[2]  ( .CLK(N354), .D(nfc_cmd[2]), .Q(n150), .QN(n102)
         );
  LATCHX1 \next_state_reg[3]  ( .CLK(N279), .D(N261), .Q(next_state[3]) );
  DFFSSRX1 \cur_state_reg[3]  ( .D(1'b0), .SETB(Reset), .RSTB(next_state[3]), 
        .CLK(clk), .Q(n154), .QN(n101) );
  LATCHX1 \next_state_reg[1]  ( .CLK(N279), .D(N259), .Q(next_state[1]) );
  DFFSSRX1 \cur_state_reg[1]  ( .D(1'b0), .SETB(Reset), .RSTB(next_state[1]), 
        .CLK(clk), .Q(n155), .QN(n106) );
  LATCHX1 \next_state_reg[2]  ( .CLK(N279), .D(N260), .Q(next_state[2]) );
  DFFSSRX1 \cur_state_reg[2]  ( .D(1'b0), .SETB(Reset), .RSTB(next_state[2]), 
        .CLK(clk), .Q(n152), .QN(n103) );
  LATCHX1 command_error_reg ( .CLK(N353), .D(n91), .Q(command_error) );
  LATCHX1 \DIO_out_reg[15]  ( .CLK(N310), .D(N277), .Q(N355) );
  LATCHX1 \DIO_out_tri_enable_reg[15]  ( .CLK(N310), .D(n88), .QN(n50) );
  LATCHX1 \DIO_out_reg[14]  ( .CLK(N310), .D(N276), .Q(N358) );
  LATCHX1 \DIO_out_tri_enable_reg[14]  ( .CLK(N310), .D(n88), .QN(n51) );
  LATCHX1 \DIO_out_reg[13]  ( .CLK(N310), .D(N275), .Q(N361) );
  LATCHX1 \DIO_out_tri_enable_reg[13]  ( .CLK(N310), .D(n88), .QN(n52) );
  LATCHX1 \DIO_out_reg[12]  ( .CLK(N310), .D(N274), .Q(N364) );
  LATCHX1 \DIO_out_tri_enable_reg[12]  ( .CLK(N310), .D(n88), .QN(n53) );
  LATCHX1 \DIO_out_reg[11]  ( .CLK(N310), .D(N273), .Q(N367) );
  LATCHX1 \DIO_out_tri_enable_reg[11]  ( .CLK(N310), .D(n88), .QN(n54) );
  LATCHX1 \DIO_out_reg[10]  ( .CLK(N310), .D(N272), .Q(N370) );
  LATCHX1 \DIO_out_tri_enable_reg[10]  ( .CLK(N310), .D(n88), .QN(n55) );
  LATCHX1 \DIO_out_reg[9]  ( .CLK(N310), .D(N271), .Q(N373) );
  LATCHX1 \DIO_out_tri_enable_reg[9]  ( .CLK(N310), .D(n88), .QN(n56) );
  LATCHX1 \DIO_out_reg[8]  ( .CLK(N310), .D(N270), .Q(N376) );
  LATCHX1 \DIO_out_tri_enable_reg[8]  ( .CLK(N310), .D(n88), .QN(n57) );
  LATCHX1 \DIO_out_reg[7]  ( .CLK(N310), .D(N269), .Q(N379) );
  LATCHX1 \DIO_out_tri_enable_reg[7]  ( .CLK(N310), .D(n88), .QN(n58) );
  LATCHX1 \DIO_out_reg[6]  ( .CLK(N310), .D(N268), .Q(N382) );
  LATCHX1 \DIO_out_tri_enable_reg[6]  ( .CLK(N310), .D(n88), .QN(n59) );
  LATCHX1 \DIO_out_reg[5]  ( .CLK(N310), .D(N267), .Q(N385) );
  LATCHX1 \DIO_out_tri_enable_reg[5]  ( .CLK(N310), .D(n88), .QN(n60) );
  LATCHX1 \DIO_out_reg[4]  ( .CLK(N310), .D(N266), .Q(N388) );
  LATCHX1 \DIO_out_tri_enable_reg[4]  ( .CLK(N310), .D(n88), .QN(n61) );
  LATCHX1 \DIO_out_reg[3]  ( .CLK(N310), .D(N265), .Q(N391) );
  LATCHX1 \DIO_out_tri_enable_reg[3]  ( .CLK(N310), .D(n88), .QN(n62) );
  LATCHX1 \DIO_out_reg[2]  ( .CLK(N310), .D(N264), .Q(N394) );
  LATCHX1 \DIO_out_tri_enable_reg[2]  ( .CLK(N310), .D(n88), .QN(n63) );
  LATCHX1 \DIO_out_reg[1]  ( .CLK(N310), .D(N263), .Q(N397) );
  LATCHX1 \DIO_out_tri_enable_reg[1]  ( .CLK(N310), .D(n88), .QN(n64) );
  LATCHX1 \DIO_out_reg[0]  ( .CLK(N310), .D(N262), .Q(N400) );
  LATCHX1 \DIO_out_tri_enable_reg[0]  ( .CLK(N310), .D(n88), .QN(n65) );
  LATCHX1 \cntrl_in_tri_enable_reg[15]  ( .CLK(N345), .D(n87), .QN(n66) );
  LATCHX1 \cntrl_in_tri_enable_reg[14]  ( .CLK(N345), .D(n87), .QN(n67) );
  LATCHX1 \cntrl_in_tri_enable_reg[13]  ( .CLK(N345), .D(n87), .QN(n68) );
  LATCHX1 \cntrl_in_tri_enable_reg[12]  ( .CLK(N345), .D(n87), .QN(n69) );
  LATCHX1 \cntrl_in_tri_enable_reg[11]  ( .CLK(N345), .D(n87), .QN(n70) );
  LATCHX1 \cntrl_in_tri_enable_reg[10]  ( .CLK(N345), .D(n87), .QN(n71) );
  LATCHX1 \cntrl_in_tri_enable_reg[9]  ( .CLK(N345), .D(n87), .QN(n72) );
  LATCHX1 \cntrl_in_tri_enable_reg[8]  ( .CLK(N345), .D(n87), .QN(n73) );
  LATCHX1 \cntrl_in_tri_enable_reg[7]  ( .CLK(N345), .D(n87), .QN(n74) );
  LATCHX1 \cntrl_in_tri_enable_reg[6]  ( .CLK(N345), .D(n87), .QN(n75) );
  LATCHX1 \cntrl_in_tri_enable_reg[5]  ( .CLK(N345), .D(n87), .QN(n76) );
  LATCHX1 \cntrl_in_tri_enable_reg[4]  ( .CLK(N345), .D(n87), .QN(n77) );
  LATCHX1 \cntrl_in_tri_enable_reg[3]  ( .CLK(N345), .D(n87), .QN(n78) );
  LATCHX1 \cntrl_in_tri_enable_reg[2]  ( .CLK(N345), .D(n87), .QN(n79) );
  LATCHX1 \cntrl_in_tri_enable_reg[1]  ( .CLK(N345), .D(n87), .QN(n80) );
  LATCHX1 \cntrl_in_tri_enable_reg[0]  ( .CLK(N345), .D(n87), .QN(n81) );
  LATCHX1 cntrl_sel_reg ( .CLK(N344), .D(N243), .Q(cntrl_sel) );
  LATCHX1 cntrl_we_reg ( .CLK(N345), .D(n93), .Q(cntrl_we) );
  LATCHX1 cntrl_re_reg ( .CLK(N346), .D(n89), .Q(cntrl_re) );
  LATCHX1 cEn_reg ( .CLK(N347), .D(n91), .Q(cEn) );
  LATCHX1 nfc_done_reg ( .CLK(N348), .D(N249), .Q(nfc_done) );
  LATCHX1 CLE_reg ( .CLK(N350), .D(N252), .Q(CLE), .QN(n47) );
  LATCHX1 wEn_reg ( .CLK(N351), .D(n95), .Q(wEn), .QN(n82) );
  LATCHX1 \cntrl_in_reg[0]  ( .CLK(N345), .D(DIO[0]), .Q(N448) );
  LATCHX1 \cntrl_in_reg[1]  ( .CLK(N345), .D(DIO[1]), .Q(N445) );
  LATCHX1 \cntrl_in_reg[2]  ( .CLK(N345), .D(DIO[2]), .Q(N442) );
  LATCHX1 \cntrl_in_reg[3]  ( .CLK(N345), .D(DIO[3]), .Q(N439) );
  LATCHX1 \cntrl_in_reg[4]  ( .CLK(N345), .D(DIO[4]), .Q(N436) );
  LATCHX1 \cntrl_in_reg[5]  ( .CLK(N345), .D(DIO[5]), .Q(N433) );
  LATCHX1 \cntrl_in_reg[6]  ( .CLK(N345), .D(DIO[6]), .Q(N430) );
  LATCHX1 \cntrl_in_reg[7]  ( .CLK(N345), .D(DIO[7]), .Q(N427) );
  LATCHX1 \cntrl_in_reg[8]  ( .CLK(N345), .D(DIO[8]), .Q(N424) );
  LATCHX1 \cntrl_in_reg[9]  ( .CLK(N345), .D(DIO[9]), .Q(N421) );
  LATCHX1 \cntrl_in_reg[10]  ( .CLK(N345), .D(DIO[10]), .Q(N418) );
  LATCHX1 \cntrl_in_reg[11]  ( .CLK(N345), .D(DIO[11]), .Q(N415) );
  LATCHX1 \cntrl_in_reg[12]  ( .CLK(N345), .D(DIO[12]), .Q(N412) );
  LATCHX1 \cntrl_in_reg[13]  ( .CLK(N345), .D(DIO[13]), .Q(N409) );
  LATCHX1 \cntrl_in_reg[14]  ( .CLK(N345), .D(DIO[14]), .Q(N406) );
  LATCHX1 \cntrl_in_reg[15]  ( .CLK(N345), .D(DIO[15]), .Q(N403) );
  LATCHX1 rEn_reg ( .CLK(N352), .D(n94), .Q(rEn) );
  TNBUFFX1 \DIO_tri[0]  ( .A(\DIO_out[0] ), .EN(n49), .Y(DIO[0]) );
  TNBUFFX1 \DIO_tri[1]  ( .A(\DIO_out[1] ), .EN(n49), .Y(DIO[1]) );
  TNBUFFX1 \DIO_tri[2]  ( .A(\DIO_out[2] ), .EN(n49), .Y(DIO[2]) );
  TNBUFFX1 \DIO_tri[3]  ( .A(\DIO_out[3] ), .EN(n49), .Y(DIO[3]) );
  TNBUFFX1 \DIO_tri[4]  ( .A(\DIO_out[4] ), .EN(n49), .Y(DIO[4]) );
  TNBUFFX1 \DIO_tri[5]  ( .A(\DIO_out[5] ), .EN(n49), .Y(DIO[5]) );
  TNBUFFX1 \DIO_tri[6]  ( .A(\DIO_out[6] ), .EN(n49), .Y(DIO[6]) );
  TNBUFFX1 \DIO_tri[7]  ( .A(\DIO_out[7] ), .EN(n49), .Y(DIO[7]) );
  TNBUFFX1 \DIO_tri[8]  ( .A(\DIO_out[8] ), .EN(n49), .Y(DIO[8]) );
  TNBUFFX1 \DIO_tri[9]  ( .A(\DIO_out[9] ), .EN(n49), .Y(DIO[9]) );
  TNBUFFX1 \DIO_tri[10]  ( .A(\DIO_out[10] ), .EN(n49), .Y(DIO[10]) );
  TNBUFFX1 \DIO_tri[11]  ( .A(\DIO_out[11] ), .EN(n49), .Y(DIO[11]) );
  TNBUFFX1 \DIO_tri[12]  ( .A(\DIO_out[12] ), .EN(n49), .Y(DIO[12]) );
  TNBUFFX1 \DIO_tri[13]  ( .A(\DIO_out[13] ), .EN(n49), .Y(DIO[13]) );
  TNBUFFX1 \DIO_tri[14]  ( .A(\DIO_out[14] ), .EN(n49), .Y(DIO[14]) );
  TNBUFFX1 \DIO_tri[15]  ( .A(\DIO_out[15] ), .EN(n49), .Y(DIO[15]) );
  TNBUFFX1 \DIO_out_tri[0]  ( .A(N400), .EN(n65), .Y(\DIO_out[0] ) );
  TNBUFFX1 \DIO_out_tri[1]  ( .A(N397), .EN(n64), .Y(\DIO_out[1] ) );
  TNBUFFX1 \DIO_out_tri[2]  ( .A(N394), .EN(n63), .Y(\DIO_out[2] ) );
  TNBUFFX1 \DIO_out_tri[3]  ( .A(N391), .EN(n62), .Y(\DIO_out[3] ) );
  TNBUFFX1 \DIO_out_tri[4]  ( .A(N388), .EN(n61), .Y(\DIO_out[4] ) );
  TNBUFFX1 \DIO_out_tri[5]  ( .A(N385), .EN(n60), .Y(\DIO_out[5] ) );
  TNBUFFX1 \DIO_out_tri[6]  ( .A(N382), .EN(n59), .Y(\DIO_out[6] ) );
  TNBUFFX1 \DIO_out_tri[7]  ( .A(N379), .EN(n58), .Y(\DIO_out[7] ) );
  TNBUFFX1 \DIO_out_tri[8]  ( .A(N376), .EN(n57), .Y(\DIO_out[8] ) );
  TNBUFFX1 \DIO_out_tri[9]  ( .A(N373), .EN(n56), .Y(\DIO_out[9] ) );
  TNBUFFX1 \DIO_out_tri[10]  ( .A(N370), .EN(n55), .Y(\DIO_out[10] ) );
  TNBUFFX1 \DIO_out_tri[11]  ( .A(N367), .EN(n54), .Y(\DIO_out[11] ) );
  TNBUFFX1 \DIO_out_tri[12]  ( .A(N364), .EN(n53), .Y(\DIO_out[12] ) );
  TNBUFFX1 \DIO_out_tri[13]  ( .A(N361), .EN(n52), .Y(\DIO_out[13] ) );
  TNBUFFX1 \DIO_out_tri[14]  ( .A(N358), .EN(n51), .Y(\DIO_out[14] ) );
  TNBUFFX1 \DIO_out_tri[15]  ( .A(N355), .EN(n50), .Y(\DIO_out[15] ) );
  TNBUFFX1 \cntrl_in_tri[0]  ( .A(N448), .EN(n81), .Y(cntrl_in[0]) );
  TNBUFFX1 \cntrl_in_tri[1]  ( .A(N445), .EN(n80), .Y(cntrl_in[1]) );
  TNBUFFX1 \cntrl_in_tri[2]  ( .A(N442), .EN(n79), .Y(cntrl_in[2]) );
  TNBUFFX1 \cntrl_in_tri[3]  ( .A(N439), .EN(n78), .Y(cntrl_in[3]) );
  TNBUFFX1 \cntrl_in_tri[4]  ( .A(N436), .EN(n77), .Y(cntrl_in[4]) );
  TNBUFFX1 \cntrl_in_tri[5]  ( .A(N433), .EN(n76), .Y(cntrl_in[5]) );
  TNBUFFX1 \cntrl_in_tri[6]  ( .A(N430), .EN(n75), .Y(cntrl_in[6]) );
  TNBUFFX1 \cntrl_in_tri[7]  ( .A(N427), .EN(n74), .Y(cntrl_in[7]) );
  TNBUFFX1 \cntrl_in_tri[8]  ( .A(N424), .EN(n73), .Y(cntrl_in[8]) );
  TNBUFFX1 \cntrl_in_tri[9]  ( .A(N421), .EN(n72), .Y(cntrl_in[9]) );
  TNBUFFX1 \cntrl_in_tri[10]  ( .A(N418), .EN(n71), .Y(cntrl_in[10]) );
  TNBUFFX1 \cntrl_in_tri[11]  ( .A(N415), .EN(n70), .Y(cntrl_in[11]) );
  TNBUFFX1 \cntrl_in_tri[12]  ( .A(N412), .EN(n69), .Y(cntrl_in[12]) );
  TNBUFFX1 \cntrl_in_tri[13]  ( .A(N409), .EN(n68), .Y(cntrl_in[13]) );
  TNBUFFX1 \cntrl_in_tri[14]  ( .A(N406), .EN(n67), .Y(cntrl_in[14]) );
  TNBUFFX1 \cntrl_in_tri[15]  ( .A(N403), .EN(n66), .Y(cntrl_in[15]) );
  LATCHX1 ALE_reg ( .CLK(N349), .D(n90), .Q(ALE), .QN(n48) );
  INVX2 U97 ( .A(n112), .Y(n95) );
  INVX2 U98 ( .A(n114), .Y(n88) );
  INVX2 U99 ( .A(n111), .Y(n87) );
  INVX2 U100 ( .A(n115), .Y(n90) );
  NAND3X2 U101 ( .A1(n47), .A2(n82), .A3(n48), .Y(n49) );
  NAND3X4 U102 ( .A1(n114), .A2(n112), .A3(n113), .Y(N310) );
  NAND2X4 U103 ( .A1(n116), .A2(n111), .Y(N345) );
  INVX0 U104 ( .A(n107), .Y(n93) );
  INVX0 U105 ( .A(n108), .Y(n89) );
  INVX0 U106 ( .A(n109), .Y(N354) );
  OR2X1 U107 ( .A1(n110), .A2(N345), .Y(N352) );
  NAND2X0 U108 ( .A1(n111), .A2(n112), .Y(N351) );
  NAND2X0 U109 ( .A1(n113), .A2(n111), .Y(N350) );
  NAND4X0 U110 ( .A1(n114), .A2(n115), .A3(n116), .A4(n117), .Y(N349) );
  INVX0 U111 ( .A(N346), .Y(n117) );
  NAND3X0 U112 ( .A1(n118), .A2(n119), .A3(n120), .Y(N348) );
  INVX0 U113 ( .A(N353), .Y(n119) );
  AO21X1 U114 ( .A1(n91), .A2(n121), .A3(n87), .Y(N353) );
  NAND2X0 U115 ( .A1(n102), .A2(n122), .Y(n121) );
  NAND2X0 U116 ( .A1(n88), .A2(status), .Y(n118) );
  NAND3X0 U117 ( .A1(n123), .A2(n111), .A3(n124), .Y(N347) );
  NAND3X0 U118 ( .A1(n122), .A2(n102), .A3(n91), .Y(n124) );
  NAND2X0 U119 ( .A1(n125), .A2(n116), .Y(N344) );
  NAND4X0 U120 ( .A1(n120), .A2(n126), .A3(n125), .A4(n127), .Y(N279) );
  AND4X1 U121 ( .A1(n128), .A2(n114), .A3(n129), .A4(n130), .Y(n127) );
  NAND3X0 U122 ( .A1(n122), .A2(n102), .A3(n90), .Y(n128) );
  NAND2X0 U123 ( .A1(n149), .A2(n151), .Y(n122) );
  AOI21X1 U124 ( .A1(buf_cntrl_status), .A2(n95), .A3(N346), .Y(n125) );
  NAND2X0 U125 ( .A1(n108), .A2(n111), .Y(N346) );
  NAND2X0 U126 ( .A1(status), .A2(n94), .Y(n126) );
  INVX0 U127 ( .A(n116), .Y(n94) );
  AOI22X1 U128 ( .A1(host_buf_status), .A2(n110), .A3(status), .A4(n131), .Y(
        n120) );
  INVX0 U129 ( .A(n132), .Y(n131) );
  INVX0 U130 ( .A(n123), .Y(n110) );
  AO22X1 U131 ( .A1(cntrl_out[15]), .A2(n95), .A3(RWA[15]), .A4(n90), .Y(N277)
         );
  AO22X1 U132 ( .A1(cntrl_out[14]), .A2(n95), .A3(RWA[14]), .A4(n90), .Y(N276)
         );
  AO22X1 U133 ( .A1(cntrl_out[13]), .A2(n95), .A3(RWA[13]), .A4(n90), .Y(N275)
         );
  AO22X1 U134 ( .A1(cntrl_out[12]), .A2(n95), .A3(RWA[12]), .A4(n90), .Y(N274)
         );
  AO22X1 U135 ( .A1(cntrl_out[11]), .A2(n95), .A3(RWA[11]), .A4(n90), .Y(N273)
         );
  AO22X1 U136 ( .A1(cntrl_out[10]), .A2(n95), .A3(RWA[10]), .A4(n90), .Y(N272)
         );
  AO22X1 U137 ( .A1(cntrl_out[9]), .A2(n95), .A3(RWA[9]), .A4(n90), .Y(N271)
         );
  AO22X1 U138 ( .A1(cntrl_out[8]), .A2(n95), .A3(RWA[8]), .A4(n90), .Y(N270)
         );
  AO22X1 U139 ( .A1(cntrl_out[7]), .A2(n95), .A3(RWA[7]), .A4(n90), .Y(N269)
         );
  AO22X1 U140 ( .A1(cntrl_out[6]), .A2(n95), .A3(RWA[6]), .A4(n90), .Y(N268)
         );
  AO22X1 U141 ( .A1(cntrl_out[5]), .A2(n95), .A3(RWA[5]), .A4(n90), .Y(N267)
         );
  AO22X1 U142 ( .A1(cntrl_out[4]), .A2(n95), .A3(RWA[4]), .A4(n90), .Y(N266)
         );
  AO22X1 U143 ( .A1(cntrl_out[3]), .A2(n95), .A3(RWA[3]), .A4(n90), .Y(N265)
         );
  AO22X1 U144 ( .A1(cntrl_out[2]), .A2(n95), .A3(RWA[2]), .A4(n90), .Y(N264)
         );
  AO222X1 U145 ( .A1(RWA[1]), .A2(n90), .A3(n133), .A4(n153), .A5(cntrl_out[1]), .A6(n95), .Y(N263) );
  AO222X1 U146 ( .A1(RWA[0]), .A2(n90), .A3(n133), .A4(n104), .A5(cntrl_out[0]), .A6(n95), .Y(N262) );
  INVX0 U147 ( .A(n134), .Y(n133) );
  NAND4X0 U148 ( .A1(n135), .A2(n108), .A3(n116), .A4(n112), .Y(N261) );
  NAND3X0 U149 ( .A1(n90), .A2(n151), .A3(n136), .Y(n135) );
  NAND4X0 U150 ( .A1(n137), .A2(n116), .A3(n138), .A4(n130), .Y(N260) );
  NAND4X0 U151 ( .A1(n149), .A2(n139), .A3(n105), .A4(n102), .Y(n137) );
  NAND2X0 U152 ( .A1(n129), .A2(n115), .Y(n139) );
  OAI221X1 U153 ( .A1(n140), .A2(n141), .A3(status), .A4(n114), .A5(n113), .Y(
        N259) );
  AND2X1 U154 ( .A1(n115), .A2(n130), .Y(n113) );
  INVX0 U155 ( .A(N252), .Y(n130) );
  NAND2X0 U156 ( .A1(n91), .A2(n105), .Y(n141) );
  NAND4X0 U157 ( .A1(n138), .A2(n109), .A3(n112), .A4(n142), .Y(N258) );
  OA22X1 U158 ( .A1(n115), .A2(n143), .A3(status), .A4(n114), .Y(n142) );
  NAND2X0 U159 ( .A1(n105), .A2(n102), .Y(n143) );
  NAND2X0 U160 ( .A1(n144), .A2(n104), .Y(n115) );
  NAND2X0 U161 ( .A1(n145), .A2(n146), .Y(n112) );
  NAND3X0 U162 ( .A1(n87), .A2(n147), .A3(nfc_start), .Y(n109) );
  INVX0 U163 ( .A(Reset), .Y(n147) );
  NAND3X0 U164 ( .A1(n101), .A2(n104), .A3(n145), .Y(n111) );
  NAND3X0 U165 ( .A1(n91), .A2(n151), .A3(n136), .Y(n138) );
  INVX0 U166 ( .A(n140), .Y(n136) );
  OR2X1 U167 ( .A1(n150), .A2(n149), .Y(n140) );
  INVX0 U168 ( .A(n129), .Y(n91) );
  NAND2X0 U169 ( .A1(n134), .A2(n148), .Y(N252) );
  NAND4X0 U170 ( .A1(n155), .A2(n101), .A3(n104), .A4(n103), .Y(n148) );
  NAND3X0 U171 ( .A1(n106), .A2(n101), .A3(n152), .Y(n134) );
  NAND4X0 U172 ( .A1(n132), .A2(n123), .A3(n114), .A4(n129), .Y(N249) );
  NAND3X0 U173 ( .A1(n145), .A2(n101), .A3(n153), .Y(n129) );
  NAND4X0 U174 ( .A1(n153), .A2(n155), .A3(n101), .A4(n103), .Y(n114) );
  NAND3X0 U175 ( .A1(n146), .A2(n106), .A3(n152), .Y(n123) );
  NAND3X0 U176 ( .A1(n145), .A2(n154), .A3(n153), .Y(n132) );
  AND2X1 U177 ( .A1(n103), .A2(n106), .Y(n145) );
  NAND2X0 U178 ( .A1(n107), .A2(n108), .Y(N243) );
  NAND2X0 U179 ( .A1(n144), .A2(n153), .Y(n108) );
  AND3X1 U180 ( .A1(n155), .A2(n101), .A3(n152), .Y(n144) );
  OR2X1 U181 ( .A1(n116), .A2(status), .Y(n107) );
  NAND3X0 U182 ( .A1(n146), .A2(n103), .A3(n155), .Y(n116) );
  AND2X1 U183 ( .A1(n154), .A2(n104), .Y(n146) );
endmodule

