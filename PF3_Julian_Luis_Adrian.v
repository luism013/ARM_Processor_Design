/*
Author: Luis M. Rivera Negrón
Contributors: Adrian Soto Castillo, Julian A. Quiñones Pérez
Requisite of ICOM-4215
For: Prof. N. Rodriguez

Explanation: 
*/

module inverter(output reg Sts, input In, Inv);
    always @ (In)
        if(Inv)
            Sts <= ~In;
        else
            Sts <= In;
endmodule //ending inverter module

module adder(output reg [9:0] IncR_In, input[9:0] Mux_Out);
    initial IncR_In <= 1'b0;
    always @ (*)
        IncR_In <= Mux_Out+32'b0000000000000000000000000000001;
endmodule //ending adder module

module multiplexer(output reg [9:0] PA, input [9:0] QS0, input [9:0] QS1, input [9:0] QS2, input [9:0] QS3, input [1:0]selection); 
//for state selection
    always @ (*)
        begin
            case(selection)
                2'b00: PA <= QS0;
                2'b01: PA <= QS1;
                2'b10: PA <= QS2;
                2'b11: PA <= QS3;
            endcase //ending selection case
        end //ending always
endmodule //ending multiplexer module

module multiplexer2(output reg In, input MOC, input Cond, input [1:0]selection); 
//for state selection
    always @ (*)
        begin
            case(selection)
                2'b00: In <= MOC;
                2'b01: In <= Cond;
            endcase //ending selection case
        end //ending always
endmodule //ending multiplexer module

module increment_Register(output reg[9:0] Mux_In, input CLK ,input [9:0] Adder_Out);
    initial Mux_In <= 0;
    always @ (posedge CLK)//load only when the CLK signal is high
            Mux_In <= Adder_Out;
endmodule //ending increment_Register module

module encoder(output reg[9:0] Mux_In, input [7:0] IR_Out, input [3:0] AdMode);
    initial Mux_In <= 0;
    always @ (*)
		begin
        	casez(IR_Out)
				8'b01011101: Mux_In = 10;
				8'b01011001: Mux_In = 14;
				8'b01010101: Mux_In = 18;
				8'b01010001: Mux_In = 22;
				8'b01111101: Mux_In = 26;
				8'b01110101: Mux_In = 30;
				8'b01111001: Mux_In = 34;
				8'b01110001: Mux_In = 38;
				8'b01011111: Mux_In = 42;
				8'b01010111: Mux_In = 50;
				8'b01011011: Mux_In = 46;
				8'b01010011: Mux_In = 54;
				8'b01111111: Mux_In = 78;
				8'b01110111: Mux_In = 86;
				8'b01111011: Mux_In = 82;
				8'b01110011: Mux_In = 90;
				8'b01001101: Mux_In = 58;
				8'b01000101: Mux_In = 63;
				8'b01001001: Mux_In = 68;
				8'b01000001: Mux_In = 73;
				8'b01101101: Mux_In = 94;
				8'b01100101: Mux_In = 99;
				8'b01101001: Mux_In = 104;
				8'b01100001: Mux_In = 109;
				8'b01011100: Mux_In = 114;
				8'b01010100: Mux_In = 122;
				8'b01011000: Mux_In = 118;
				8'b01010000: Mux_In = 126;
				8'b01111100: Mux_In = 130;
				8'b01110100: Mux_In = 138;
				8'b01111000: Mux_In = 134;
				8'b01110000: Mux_In = 142;
				8'b01011110: Mux_In = 146;
				8'b01010110: Mux_In = 154;
				8'b01011010: Mux_In = 150;
				8'b01010010: Mux_In = 158;
				8'b01111110: Mux_In = 182;
				8'b01110110: Mux_In = 190;
				8'b01111010: Mux_In = 186;
				8'b01110010: Mux_In = 194;
				8'b01001100: Mux_In = 162;
				8'b01000100: Mux_In = 176;
				8'b01001000: Mux_In = 167;
				8'b01000000: Mux_In = 177;
				8'b01101100: Mux_In = 198;
				8'b01100100: Mux_In = 208;
				8'b01101000: Mux_In = 203;
				8'b01100000: Mux_In = 213;

				8'b1010????: Mux_In = 537;  //Branch
				8'b1011????: Mux_In = 538;  //Branch and Link
				
				//ad mode 3
				8'b11101:
				      casez(AdMode)
				    4'b1101: Mux_In = 218;
				    4'b1111: Mux_In = 226;
				    endcase
                8'b10101:	
                      casez(AdMode)
				    4'b1101: Mux_In = 222;
				    4'b1111: Mux_In = 230;
				    4'b0??1: Mux_In = 8;
				    4'b???0: Mux_In = 526;
				    endcase
                8'b11100:
                      casez(AdMode)
				    4'b1101: Mux_In = 234;
				    4'b1111: Mux_In = 254;
				    4'b1011: Mux_In = 246;
				    endcase
                8'b10100:		
                      casez(AdMode)
				    4'b1101: Mux_In = 240;
				    4'b1011: Mux_In = 250;
				    4'b1111: Mux_In = 260;
				    endcase
                8'b11001:	
                      casez(AdMode)
				    4'b1101: Mux_In = 372;
				    4'b1111: Mux_In = 380;
				    endcase
                8'b10001:	
                      casez(AdMode)
				    4'b1101: Mux_In = 376;
				    4'b1111: Mux_In = 384;
				    4'b0??1: Mux_In = 528;
				    4'b???0: Mux_In = 529;
				    endcase
                8'b11000:	
                      casez(AdMode)
				    4'b1101: Mux_In = 388;
				    4'b1111: Mux_In = 408;
				    4'b1011: Mux_In = 400;
				    endcase
                8'b10000:
                      casez(AdMode)
				    4'b1101: Mux_In = 394;
				    4'b1111: Mux_In = 414;
				    4'b1011: Mux_In = 404;
				    endcase
                8'b11111:
                      casez(AdMode)
				    4'b1101: Mux_In = 266;
				    4'b1111: Mux_In = 274;
				    endcase
                8'b10111:	
                      casez(AdMode)
				    4'b1101: Mux_In = 270;
				    4'b1111: Mux_In = 278;
				    4'b0??1: Mux_In = 534;
				    4'b???0: Mux_In = 535;
				    endcase
                8'b11110:
                      casez(AdMode)
				    4'b1101: Mux_In = 282;
				    4'b1111: Mux_In = 302;
				    4'b1011: Mux_In = 294;
				    endcase
                8'b10110:	
                      casez(AdMode)
				    4'b1101: Mux_In = 288;
				    4'b1011: Mux_In = 298;
				    endcase
                8'b11011:	
                      casez(AdMode)
				    4'b1101: Mux_In = 420;
				    4'b1111: Mux_In = 428;
				    endcase
                8'b10011:
                      casez(AdMode)
				    4'b1101: Mux_In = 424;
				    4'b1111: Mux_In = 432;
				    4'b0??1: Mux_In = 531;
				    4'b???0: Mux_In = 532;
				    endcase
                8'b11010:	
                      casez(AdMode)
				    4'b1101: Mux_In = 436;
				    endcase
                8'b10010:	
                      casez(AdMode)
				    4'b1101: Mux_In = 442;
				    4'b1111: Mux_In = 462;
				    4'b1011: Mux_In = 452;
				    endcase
                8'b1101:
                      casez(AdMode)
				    4'b1101: Mux_In = 314;
				    4'b1111: Mux_In = 324;
				    endcase
                8'b101:
                      casez(AdMode)
				    4'b1101: Mux_In = 319;
				    4'b1111: Mux_In = 329;
				    endcase
                8'b1100:
                      casez(AdMode)
				    4'b1101: Mux_In = 334;
				    4'b1111: Mux_In = 358;
				    4'b1011: Mux_In = 348;
				    endcase
                8'b100:
                      casez(AdMode)
				    4'b1101: Mux_In = 341;
				    4'b1111: Mux_In = 365;
				    4'b1011: Mux_In = 353;
				    endcase
                8'b1001:
                      casez(AdMode)
				    4'b1101: Mux_In = 468;
				    4'b1111: Mux_In = 478;
				    endcase
                8'b1:
                      casez(AdMode)
				    4'b1101: Mux_In = 473;
				    4'b1111: Mux_In = 483;
				    endcase
                8'b1000:
                      casez(AdMode)
				    4'b1101: Mux_In = 488;
				    4'b1111: Mux_In = 512;
				    4'b1011: Mux_In = 502;
				    endcase
                8'b00000000:
                      casez(AdMode)
				    4'b1101: Mux_In = 495;
				    4'b1111: Mux_In = 260;
				    4'b1011: Mux_In = 507;
				    endcase
				
				8'b000????0:
				      casez(AdMode)
				    4'b0??1: Mux_In = 6;
				    4'b???0: Mux_In = 5;
				    endcase
				8'b001????0: Mux_In = 7;

				8'b000????1:
				      casez(AdMode)
				    4'b0??1: Mux_In = 541;
				    4'b???0: Mux_In = 542;
				    endcase
				8'b001????1: Mux_In = 543;

				//ad mode 4
				8'b100000?0: Mux_In = 544;
				8'b100010?0: Mux_In = 548;
				8'b100100?0: Mux_In = 560;
				8'b100110?0: Mux_In = 564;
				8'b100000?1: Mux_In = 552;
				8'b100010?1: Mux_In = 556;
				8'b100100?1: Mux_In = 568;
				8'b100110?1: Mux_In = 572;

				default: Mux_In = 0;
		   endcase
		end
endmodule //ending encoder module

module next_State_Address_Selector(output reg[1:0] M1_0,input [2:0] N2_1_0, input Sts);
    initial M1_0 <= 0;
    always @ (*)
        begin
            case(N2_1_0)
                3'b000: M1_0 <= 2'b00;
                3'b001: M1_0 <= 2'b01;
                3'b010: M1_0 <= 2'b10;
                3'b011: M1_0 <= 2'b11;
                3'b100: 
                    if(Sts == 1'b0)
                        M1_0 <= 2'b10;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b00;
                3'b101: 
                    if(Sts == 1'b0)
                        M1_0 <= 2'b11;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b10;                
                3'b110: 
                    if(Sts == 1'b0)
                        M1_0 <= 2'b11;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b00;
				3'b111: //new selection added.
                    if(Sts == 1'b0)
                        M1_0 <= 2'b10;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b01;
            endcase //ending selection case
        end //ending always            
endmodule //ending encoder module

/*
for the microstore and control Register modules, I need the moore table in order to map
the outputs of the circuits into real data. 
*/
module microstore(output reg[9:0] Next_State, input [9:0] Curr_State, input CLK); //a.k.a. ROM
initial Next_State <= 0;
always @ (posedge CLK)
	Next_State <= Curr_State;
endmodule //ending encoder module

module control_Register(output reg SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
MD, ME, OP4, OP3, OP2, OP1, OP0, N2, N1, N0, Inv, S1, S0, output reg[9:0] CR, input[9:0] Next_State, input CLK);
always @ (posedge CLK)
	begin
		case(Next_State)
			10'd0:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 1;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd1:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 1;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd2:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 1;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 1;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd3:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 1;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 3;
			end
			10'd4:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 0;
				Inv <= 0;
				S1 <= 0;
				S0 <= 1;
				CR <= 1;
			end
			10'd5:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd6:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd7:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd8:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd9:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd10:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd11:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd12:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 12;
			end
			10'd13:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd14:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd15:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd16:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 16;
			end
			10'd17:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd18:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd19:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd20:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 20;
			end
			10'd21:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd22:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd23:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd24:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 24;
			end
			10'd25:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd26:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd27:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd28:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 28.0;
			end
			10'd29:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd30:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd31:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd32:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 32.0;
			end
			10'd33:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd34:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd35:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd36:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 36.0;
			end
			10'd37:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd38:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd39:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd40:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 40.0;
			end
			10'd41:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd42:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd43:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd44:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 44;
			end
			10'd45:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd46:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd47:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd48:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 48;
			end
			10'd49:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd50:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd51:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd52:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 52;
			end
			10'd53:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd54:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd55:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd56:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 56;
			end
			10'd57:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd58:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd59:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd60:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 60.0;
			end
			10'd61:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd62:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd63:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd64:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd65:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 65.0;
			end
			10'd66:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd67:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd68:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd69:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd70:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 70.0;
			end
			10'd71:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd72:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd73:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd74:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd75:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 75.0;
			end
			10'd76:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd77:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd78:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd79:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd80:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 80;
			end
			10'd81:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd82:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd83:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd84:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 84;
			end
			10'd85:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd86:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd87:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd88:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 88;
			end
			10'd89:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd90:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd91:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd92:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 92;
			end
			10'd93:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd94:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd95:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd96:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 96.0;
			end
			10'd97:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd98:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd99:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd100:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd101:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 101.0;
			end
			10'd102:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd103:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd104:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd105:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd106:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 106.0;
			end
			10'd107:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;

				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd108:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd109:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd110:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd111:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 111.0;
			end
			10'd112:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd113:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd114:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd115:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd116:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd117:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 117.0;
			end
			10'd118:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd119:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd120:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd121:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 121.0;
			end
			10'd122:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd123:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd124:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd125:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 125.0;
			end
			10'd126:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd127:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd128:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd129:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 129.0;
			end
			10'd130:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd131:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd132:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd133:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 133.0;
			end
			10'd134:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd135:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd136:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd137:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 137.0;
			end
			10'd138:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd139:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd140:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd141:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 141.0;
			end
			10'd142:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd143:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd144:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd145:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 145.0;
			end
			10'd146:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd147:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd148:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd149:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 149.0;
			end
			10'd150:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd151:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd152:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd153:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 153.0;
			end
			10'd154:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd155:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd156:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd157:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 157.0;
			end
			10'd158:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd159:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd160:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd161:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 161.0;
			end
			10'd162:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd163:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd164:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd165:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 165.0;
			end
			10'd166:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd167:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd168:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd169:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd170:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 170.0;
			end
			10'd171:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd172:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd173:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd174:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd175:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 175.0;
			end
			10'd176:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd177:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd178:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd179:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd180:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 180.0;
			end
			10'd181:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd182:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd183:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd184:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd185:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 185.0;
			end
			10'd186:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd187:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd188:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd189:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 189.0;
			end
			10'd190:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd191:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd192:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd193:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 193.0;
			end
			10'd194:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd195:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd196:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd197:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 197.0;
			end
			10'd198:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd199:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd200:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd201:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 201.0;
			end
			10'd202:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd203:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd204:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd205:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd206:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 206.0;
			end
			10'd207:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
			end
			10'd208:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd209:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd210:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd211:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 211.0;
			end
			10'd212:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;

			end
			10'd213:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd214:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd215:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd216:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 216.0;
			end
			10'd217:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd218:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd219:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
			end
			10'd220:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 220.0;
			end
			10'd221:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
 
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd222:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd223:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd224:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 224.0;
			end
			10'd225:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd226:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd227:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd228:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 228.0;
			end
			10'd229:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd230:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd231:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd232:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 232.0;
			end
			10'd233:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd234:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd235:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd236:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 236;
			end
			10'd237:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd238:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 238.0;
			end
			10'd239:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd240:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd241:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd242:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 242;
			end
			10'd243:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd244:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 244.0;
			end
			10'd245:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd246:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd247:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd248:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd249:
			begin
				SR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 249.0;
			end
			10'd250:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd251:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd252:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd253:
			begin
				SR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 253.0;
			end
			10'd254:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd255:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd256:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd257:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 257.0;
			end
			10'd258:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd259:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 259.0;
			end
			10'd260:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd261:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd262:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd263:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 263.0;
			end
			10'd264:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd265:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 265.0;
			end
			10'd266:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd267:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd268:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 268.0;
			end
			10'd269:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd270:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd271:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd272:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 272.0;
			end
			10'd273:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd274:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd275:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd276:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 276.0;
			end
			10'd277:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd278:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd279:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd280:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 280.0;
			end
			10'd281:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd282:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd283:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd284:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 284.0;
			end
			10'd285:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd286:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 286.0;
			end
			10'd287:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd288:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd289:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd290:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 290;
			end
			10'd291:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd292:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 292.0;
			end
			10'd293:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd294:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd295:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd296:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd297:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 297.0;
			end
			10'd298:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd299:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd300:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd301:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 301.0;
			end
			10'd302:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd303:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd304:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd305:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 305.0;
			end
			10'd306:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd307:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 307.0;
			end
			10'd308:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd309:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd310:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd311:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 311.0;
			end
			10'd312:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd313:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 313.0;
			end
			10'd314:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd315:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd316:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 316.0;
			end
			10'd317:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd318:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd319:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd320:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd321:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 321.0;
			end
			10'd322:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd323:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd324:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd325:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd326:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 326.0;
			end
			10'd327:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd328:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd329:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd330:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd331:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 331.0;
			end
			10'd332:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd333:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd334:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd335:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd336:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 336.0;
			end
			10'd337:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd338:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 338.0;
			end
			10'd339:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd340:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd341:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd342:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd343:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 343.0;
			end
			10'd344:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd345:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 345.0;
			end
			10'd346:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd347:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd348:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd349:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd350:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd351:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 351.0;
			end
			10'd352:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd353:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd354:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd355:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd356:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 356.0;
			end
			10'd357:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd358:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd359:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd360:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd361:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 361;
			end
			10'd362:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd363:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 363;
			end
			10'd364:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd365:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd366:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd367:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd368:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 368;
			end
			10'd369:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd370:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 370;
			end
			10'd371:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd372:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd373:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd374:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 374.0;
			end
			10'd375:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd376:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd377:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd378:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 378.0;
			end
			10'd379:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd380:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd381:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd382:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 382.0;
			end
			10'd383:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd384:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd385:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd386:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 386.0;
			end
			10'd387:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd388:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd389:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd390:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 390;
			end
			10'd391:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd392:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 392.0;
			end
			10'd393:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd394:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd395:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd396:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 396;
			end
			10'd397:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd398:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 398.0;
			end
			10'd399:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd400:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd401:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd402:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd403:
			begin
				SR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 403.0;
			end
			10'd404:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd405:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd406:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd407:
			begin
				SR_ld <= 0.0;
				RF_ld <= 1.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 407.0;
			end
			10'd408:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd409:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd410:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd411:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 411.0;
			end
			10'd412:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd413:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 413.0;
			end
			10'd414:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd415:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd416:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd417:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 417.0;
			end
			10'd418:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd419:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 419.0;
			end
			10'd420:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd421:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd422:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 422.0;
			end
			10'd423:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd424:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd425:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd426:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 426.0;
			end
			10'd427:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd428:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd429:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd430:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 430.0;
			end
			10'd431:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd432:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd433:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd434:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 434.0;
			end
			10'd435:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd436:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd437:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd438:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 438.0;
			end
			10'd439:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd440:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 440.0;
			end
			10'd441:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd442:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd443:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd444:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 444;
			end
			10'd445:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd446:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 446.0;
			end
			10'd447:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd448:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd449:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd450:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd451:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 451.0;
			end
			10'd452:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd453:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd454:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd455:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 455.0;
			end
			10'd456:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd457:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd458:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd459:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 459.0;
			end
			10'd460:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd461:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 1.0;
				Inv <= 0.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 461.0;
			end
			10'd462:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd463:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd464:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd465:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 465.0;
			end
			10'd466:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd467:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				CR <= 467;
			end
			10'd468:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd469:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd470:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 470.0;
			end
			10'd471:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd472:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd473:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd474:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd475:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 0.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 475.0;
			end
			10'd476:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd477:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd478:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd479:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd480:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 480.0;
			end
			10'd481:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd482:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd483:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd484:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd485:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 485.0;
			end
			10'd486:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd487:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd488:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd489:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd490:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 490.0;
			end
			10'd491:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd492:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 492.0;
			end
			10'd493:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd494:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd495:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd496:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd497:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 497.0;
			end
			10'd498:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd499:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 1.0;
				R_W <= 1.0;
				MOV <= 1.0;
				DT1 <= 1.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 1.0;
				N0 <= 0.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 499.0;
			end
			10'd500:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 1;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd501:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd502:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd503:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd504:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd505:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 505.0;
			end
			10'd506:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd507:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd508:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd509:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd510:
			begin
				SR_ld <= 0.0;
				RF_ld <= 0.0;
				IR_ld <= 0.0;
				MAR_ld <= 0.0;
				MDR_ld <= 0.0;
				R_W <= 0.0;
				MOV <= 1.0;
				DT1 <= 0.0;
				DT0 <= 1.0;
				MA1 <= 0.0;
				MA0 <= 0.0;
				MB1 <= 0.0;
				MB0 <= 0.0;
				MC1 <= 0.0;
				MC0 <= 0.0;
				MD <= 0.0;
				ME <= 0.0;
				OP4 <= 0.0;
				OP3 <= 0.0;
				OP2 <= 0.0;
				OP1 <= 0.0;
				OP0 <= 0.0;
				N2 <= 1.0;
				N1 <= 0.0;
				N0 <= 1.0;
				Inv <= 1.0;
				S1 <= 0.0;
				S0 <= 0.0;
				CR <= 510.0;
			end
			10'd511:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 0;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd512:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd513:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd514:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd515:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 515;
			end
			10'd516:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd517:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 517;
			end
			10'd518:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 1;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd519:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd520:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd521:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd522:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 522;
			end
			10'd523:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 1;
				N0 <= 1;
 
			end
			10'd524:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
  
				CR <= 524;
			end
			10'd525:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				DT1 <= 1;
				DT0 <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 1;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd526:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd527:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd528:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd529:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd530:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd531:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd532:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd533:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd534:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd535:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd536:
			begin
				SR_ld <= 1;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd537:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd538:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd539:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd540:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd541:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd542:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd543:
			begin
				SR_ld <= 1;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 0;
				N1 <= 0;
				N0 <= 1;
 
			end
			10'd544:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
			end
			10'd545:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd546:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 546;
			end
			10'd547:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 0;
				S1 <= 1;
				S0 <= 0;
				CR <= 544;
			end
			10'd548:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd549:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd550:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 550;
			end
			10'd551:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 0;
				S1 <= 1;
				S0 <= 0;
				CR <= 548;
			end
			10'd552:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd553:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd554:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd555:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 552;
			end
			10'd556:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd557:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd558:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd559:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 552;
			end
			10'd560:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd561:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd562:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 562;
			end
			10'd563:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 0;
				S1 <= 1;
				S0 <= 0;
				CR <= 560;
			end
			10'd564:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd565:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd566:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 1;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 0;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 566;
			end
			10'd567:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 1;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 0;
				S1 <= 1;
				S0 <= 0;
				CR <= 564;
			end
			10'd568:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd569:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd570:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd571:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 1;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 571;
			end
			10'd572:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 1;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 1;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 1;
				OP2 <= 0;
				OP1 <= 1;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd573:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 1;
				R_W <= 0;
				MOV <= 0;
  
				MA1 <= 0;
				MA0 <= 1;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 1;
				ME <= 1;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd574:
			begin
				SR_ld <= 0;
				RF_ld <= 0;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 0;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 0;
  
			end
			10'd575:
			begin
				SR_ld <= 0;
				RF_ld <= 1;
				IR_ld <= 0;
				MAR_ld <= 0;
				MDR_ld <= 0;
				R_W <= 0;
				MOV <= 1;
  
				MA1 <= 0;
				MA0 <= 0;
				MB1 <= 0;
				MB0 <= 0;
				MC1 <= 0;
				MC0 <= 0;
				MD <= 0;
				ME <= 0;
				OP4 <= 1;
				OP3 <= 0;
				OP2 <= 0;
				OP1 <= 0;
				OP0 <= 0;
				N2 <= 1;
				N1 <= 1;
				N0 <= 1;
				Inv <= 1;
				S1 <= 0;
				S0 <= 0;
				CR <= 575;
			end
		endcase
	end
endmodule //ending control register module

module control_unit(output reg SR_ld, Rf_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
MD, ME, OP4, OP3, OP2, OP1, OP0, output reg[9:0] CR, input [7:0] IR, input [3:0] AdMode, input CLK, MOC, Cond);
// wire[8:0]Next_State;
wire in, Sts, N2, N1, N0, Inv, S1, S0; //wire for inverter input

wire[9:0] Curr_State;
wire [9:0] Next_State;
wire [9:0] IncR_In;
wire [9:0] Mux_In0, Mux_In1, Mux_In2, Mux_In3; //input for state multiplexer
wire [1:0] M1_0;

wire SR_in, Rf_in, IR_in, MAR_in, MDR_in, RW_in, MOV_in, DT1_in, DT0_in, MA1_in, MA0_in, MB1_in, MB0_in, MC1_in, MC0_in,
MD_in, ME_in, OP4_in, OP3_in, OP2_in, OP1_in, OP0_in; //control register outputs for external
wire[9:0] CR_in;

wire [1:0] S1_0;
assign S1_0 = {S1, S0};

wire [2:0] N2_1_0;
assign N2_1_0 = {N2, N1, N0};

multiplexer2 mux2(in, MOC, Cond, S1_0); //feeds inverter
inverter invert(Sts, in, Inv); //done
next_State_Address_Selector next(M1_0, N2_1_0, Sts);
multiplexer mux1(Curr_State, Mux_In0, 10'b0000000001, CR, Mux_In3,M1_0); //feeds microstore and adder
encoder enc(Mux_In0, IR, AdMode); //done
adder add(IncR_In, Curr_State); //done
increment_Register increment(Mux_In3, CLK, IncR_In); //done
microstore rom(Next_State, Curr_State, CLK); //done
control_Register cont(SR_in, Rf_in, IR_in, MAR_in, MDR_in, RW_in, MOV_in, DT1_in, DT0_in, MA1_in, MA0_in, MB1_in, MB0_in, MC1_in, MC0_in,
MD_in, ME_in, OP4_in, OP3_in, OP2_in, OP1_in, OP0_in, N2, N1, N0, Inv, S1, S0, CR_in,Curr_State, CLK); //done

always @(*)
	begin
	SR_ld <= SR_in;
	Rf_ld <= Rf_in;
	IR_ld <= IR_in;
	MAR_ld <= MAR_in;
	MDR_ld <= MDR_in;
	R_W <= RW_in;
	MOV = MOV_in;
	DT0 <= DT0_in;
	DT1 <= DT1_in;
	MA1 <= MA1_in;
	MA0 <= MA0_in;
	MB1 <= MB1_in;
	MB0 <= MB0_in;
	MC1 <= MC1_in;
	MC0 <= MC0_in;
	MD <= MD_in;
	ME <= ME_in;
	OP4 <= OP4_in;
	OP3 <= OP3_in;
	OP2 <= OP2_in;
	OP1 <= OP1_in;
	OP0 <= OP0_in;
	CR <= CR_in;
	end
endmodule //ending control unit module
//--------------------------------- MODULE TESTS --------------------------------------------------------------------------

// INVERTER MODULE TESTER ********************************************************** Result: Success
// module test_Inverter;
// parameter sym_time = 25;
// initial #sym_time $finish;
// reg In, Inv;
// wire Sts;
// inverter inversor(Sts, In, Inv);


// initial begin
//   $display(" In----Inv----Sts----------------------Time");
//   $monitor(" %b ---- %b ---- %b ---- %d",In,Inv,Sts,$time);
// end

// initial begin
//   In = 1'b1;
//   repeat(13) #2 In = ~In;
// end

// initial begin
//   Inv = 1'b1;
//   repeat(6) #4 Inv = ~Inv;
// end
// endmodule //ending inverter test module

// ADDER MODULE TESTER ********************************************************** Result: Success
// module test_adder;
// parameter sym_time = 25;
// initial #sym_time $finish;
// reg[31:0] Mux_Out;
// wire[31:0] IncR_In;
// adder sumador(IncR_In, Mux_Out);

// initial begin
//   $display(" --------Mux-------------Out----------------------Time");
//   $monitor(" %d ---- %d ---- %d",Mux_Out,IncR_In,$time);
// end

// initial begin
//   Mux_Out = 32'b00000000000000000000000000000011;
//   repeat(6) #4 Mux_Out = Mux_Out + 32'b00000000000000000000000000000011;
// end
// endmodule //ending adder test module

// MULTIPLEXER MODULE TESTER ********************************************************** Result: Success
// module test_multiplexer;
// parameter sym_time = 25;
// initial #sym_time $finish;
// wire [31:0] PA;
// reg [1:0] selection;
// reg [31:0] QS0, QS1, QS2, QS3;
// multiplexer mux(PA, QS0, QS1, QS2, QS3, selection);

// initial begin
//   $display("------PA------Selection-------------------Time");
//   $monitor(" %d ---- %b ---- %d", PA, selection,$time);
// end

// initial begin
//   selection = 2'b00;
//   repeat(4) #7 selection = selection + 2'b01;
// end

// initial begin
//   QS0 = 32'b00000000000000000000000000010000;
//   QS1 = 32'b00000000000000001100000000000001;
//   QS2 = 32'b00100000000000000000000000000010;
//   QS3 = 32'b00000000000000111000000000100011;
// end
// endmodule //ending multiplexer test module

// INCREMENT REGISTER MODULE TESTER ********************************************************** Result: success
// module increment_register_test;
// parameter sym_time = 35;
// initial #sym_time $finish;
// reg CLK;
// reg[31:0] Adder_Out;
// wire[31:0] Mux_In;
// increment_Register registro(Mux_In, CLK, Adder_Out);

// initial begin
//     $display("---------In-------CLK-----------------Out------------------Time");
//     $monitor("%d         %b         %d %d", Adder_Out, CLK, Mux_In, $time);
// end //intial display ending

// initial begin
//     Adder_Out = 32'b00000000000000000000000000000011;
//     repeat(6) #5 Adder_Out <= Adder_Out + 32'b00000000000000000000000000000011;
// end //DS declaration ending

// initial begin
//   CLK <= 1'b1;
//   repeat (6) #10 CLK <= ~CLK;
// end //CLK declaration ending
// endmodule //ending Register test module

// ENCODER MODULE TESTER ********************************************************** Result: Success
// module encoder_test;
// parameter sym_time = 35;
// initial #sym_time $finish;
// reg[6:0] IR_Out;
// wire[8:0] Mux_In;
// encoder encodificador(Mux_In, IR_Out);

// initial begin
//     $display("IR----------------Out-----------------Time");
//     $monitor("%b         %d %d", IR_Out, Mux_In, $time);
// end //intial display ending

// initial begin
//     IR_Out = 7'b1100000;
//     repeat(30) #1 IR_Out <= IR_Out + 7'b0000100;
// end //DS declaration ending
// endmodule //ending Register test module

// NEXT STATE ADDRESS SELECTOR MODULE TESTER ********************************************************** Result: Success
// module encoder_test;
// parameter sym_time = 35;
// initial #sym_time $finish;
// wire[1:0] M1_0;
// reg[2:0] N2_1_0;
// reg Sts;

// next_State_Address_Selector seleccionador(M1_0, N2_1_0, Sts);

// initial begin
//     $display("[N2-0]-----Sts------[M1-0]----------------Time");
//     $monitor("%b         %b         %b %d", N2_1_0, Sts, M1_0, $time);
// end //intial display ending

// initial begin
//     N2_1_0 = 3'b000;
//     repeat(6) #5 N2_1_0 <= N2_1_0 + 3'b001;
// end //N2_1_0 declaration ending

// initial begin
//     Sts = 1'b0;
//     repeat(6) #5 Sts <= ~Sts;
// end //DS declaration ending
// endmodule //ending Register test module

// MICROSTORE MODULE TESTER ********************************************************** Result: Success
// module test_microstore;
// parameter sym_time = 25;
// initial #sym_time $finish;
// wire[8:0] Next_State;
// reg[8:0] Curr_State;
// reg CLK;
// microstore rom(Next_State, Curr_State, CLK);

// initial begin
//   $display(" -Curr-----Next----CLK----------------------Time");
//   $monitor(" %d ---- %d ---- %b ---- %d",Curr_State,Next_State, CLK,$time);
// end

// initial begin
//   Curr_State = 8'b0;
//   repeat(8) #4 Curr_State = Curr_State + 8'b00000001;
// end

// initial begin
//   CLK = 0;
//   repeat(20) #2 CLK = ~CLK;
// end
// endmodule //ending adder test module

// Control Unit MODULE TESTER ********************************************************** Result: Success
// module test_controlUnit;
// parameter sym_time = 500;
// initial #sym_time $finish;

// wire SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
// MD, ME, OP4, OP3, OP2, OP1, OP0;
// wire[9:0] CR;

// reg [7:0] IR;
// reg [3:0] AdMode;
// reg CLK, MOC, Cond;

// control_unit cu(SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
// MD, ME, OP4, OP3, OP2, OP1, OP0, CR, IR, AdMode, CLK, MOC, Cond);

// wire[9:0] Mux_In;
// encoder enc(Mux_In, IR, AdMode);

// initial begin
//   $display(" ---IRin------AdMode----CLK----MOC----Cond---SR-----RF-----IR----MAR----MDR---R_W----MOV----DT1----DT0----MA1---MA0----MB1----MB0----MC1----MC0----MD----ME-----OP4-OP0---------CR-----------Mux_In---------------------Time");
//   $monitor(" %b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b%b%b%b%b ---- %b ----- %d ---- %d",IR, AdMode, CLK, MOC, Cond, SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV,DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,MD, ME, OP4, OP3, OP2, OP1, OP0, CR, Mux_In, $time);
// end

// initial begin
//   CLK = 0;
//   repeat(500) #1 CLK = ~CLK;
// end

// initial begin
//   MOC = 0;
//   repeat(250) #2 MOC = ~MOC;
// end

// initial begin
//   Cond = 0;
//   repeat(125) #4 Cond = ~Cond;
// end

// initial begin
//   IR = 8'b01011101;
//   repeat(250) #2 IR = IR+8'b01011101;
// end

// initial begin
//   AdMode = 4'b1101;
//   repeat(250) #4 AdMode = 4'b0110;
// end
// endmodule //ending adder test module

// Control Unit MODULE TESTER FOR DELIVERABLE ********************************************************** 
// module test_controlUnit;
// parameter sym_time = 100;
// initial #sym_time $finish;

// wire SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
// MD, ME, OP4, OP3, OP2, OP1, OP0;

// wire S1, S0;
// wire [1:0] S1_0;
// assign S1_0 = {S1, S0};

// wire[9:0] CR;

// reg [7:0] IR;
// reg [3:0] AdMode;

// wire[9:0] CurrState;
// reg CLK, MOC, Cond;

// control_unit cu(SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
// MD, ME, OP4, OP3, OP2, OP1, OP0, CR, IR, AdMode, CLK, MOC, Cond);

// wire [1:0] M1_0;

// wire[9:0] Mux_In;
// multiplexer2 mux2(in, MOC, Cond, S1_0); //feeds inverter
// inverter invert(Sts, in, Inv); //done
// encoder enc(Mux_In, IR, AdMode);

// initial begin
//   $display(" ---IRin------AdMode----CLK----MOC----Cond---SR-----RF-----IR----MAR----MDR---R_W----MOV----DT1----DT0----MA1---MA0----MB1----MB0----MC1----MC0----MD----ME-----OP4-OP0---------CR-----------Mux_In---------------------Time");
//   $monitor(" %b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b%b%b%b%b ---- %b ----- %d ---- %d",IR, AdMode, CLK, MOC, Cond, SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV,DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,MD, ME, OP4, OP3, OP2, OP1, OP0, CR, Mux_In, $time);
// end

// initial begin
//   CLK = 0;
//   repeat(500) #1 CLK = ~CLK;
// end

// initial begin
//   MOC = 0;
//   repeat(250) #2 MOC = ~MOC;
// end

// initial begin
//   Cond = 0;
//   repeat(125) #4 Cond = ~Cond;
// end

// initial begin
// //   IR = 8'b01011101;
//    IR = 8'b00101000; //add(r-r)
//    #20;
//    IR = 8'b01010100; //strb
//    #20;
//    IR = 8'b10100000; //beq

// //    #20;
// end

// initial begin
//   AdMode = 4'b1101;
//   repeat(250) #4 AdMode = 4'b0110;
// end
// endmodule //ending adder test module


module test_controlUnit;
parameter sym_time = 60;
initial #sym_time $finish;

wire SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
MD, ME, OP4, OP3, OP2, OP1, OP0;

wire[9:0] CR;

reg [7:0] IR;
reg [3:0] AdMode;

wire[9:0] CurrState;
reg CLK, MOC, Cond;

control_unit cu(SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
MD, ME, OP4, OP3, OP2, OP1, OP0, CR, IR, AdMode, CLK, MOC, Cond);

wire[9:0] Mux_In;
encoder enc(Mux_In, IR, AdMode);

wire in, Sts, N2, N1, N0, Inv, S1, S0; //wire for inverter input

wire[9:0] Curr_State;
wire [9:0] Next_State;
wire [9:0] IncR_In;
wire [9:0] Mux_In1, Mux_In2, Mux_In3; //input for state multiplexer
wire [1:0] M1_0;

wire SR_in, Rf_in, IR_in, MAR_in, MDR_in, RW_in, MOV_in, DT1_in, DT0_in, MA1_in, MA0_in, MB1_in, MB0_in, MC1_in, MC0_in,
MD_in, ME_in, OP4_in, OP3_in, OP2_in, OP1_in, OP0_in; //control register outputs for external
wire[9:0] CR_in;

wire [2:0] N2_1_0;
assign N2_1_0 = {N2, N1, N0};

wire [1:0] S1_0;
assign S1_0 = {S1, S0};

multiplexer2 mux2(in, MOC, Cond, S1_0); //feeds inverter
inverter invert(Sts, in, Inv); //done
next_State_Address_Selector next(M1_0, N2_1_0, Sts);
multiplexer mux1(Curr_State, Mux_In, 10'b0000000001, CR, Mux_In3,M1_0); //feeds microstore and adder
adder add(IncR_In, Curr_State); //done
increment_Register increment(Mux_In3, CLK, IncR_In); //done
microstore rom(Next_State, Curr_State, CLK); //done
control_Register cont(SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV, DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,
MD, ME, OP4, OP3, OP2, OP1, OP0, N2, N1, N0, Inv, S1, S0, CR, Curr_State, CLK); //done


// initial begin
//   $display(" ---IRin------AdMode----CLK----MOC----Cond---SR-----RF-----IR----MAR----MDR---R_W----MOV----DT1----DT0----MA1---MA0----MB1----MB0----MC1----MC0----MD----ME-----OP4-OP0---------CR-------------Enc------ Curr-----Next---------------------Time");
//   $monitor(" %b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b ---- %b ---- %b ----%b ---- %b ---- %b%b%b%b%b ---- %b ----- %d ---- %d ---- %d ---- %d",IR, AdMode, CLK, MOC, Cond, SR_ld, RF_ld, IR_ld, MAR_ld, MDR_ld, R_W, MOV,DT1, DT0, MA1, MA0, MB1, MB0, MC1, MC0,MD, ME, OP4, OP3, OP2, OP1, OP0, CR, Mux_In, Next_State, Curr_State, $time);
// end

initial begin
  $display(" ---IRin------AdMode----CLK----MOC----Cond-----Enc------ Curr-----Next----------Outputs--------SR_ld---RF_ld---IR_ld--MAR_ld--MDR_ld--R_W---MOV--- DT1_0--MA1_0--MB1_0----MC1_0---MD-----ME-----OP4:0-----N2_1_0----Inv--S1_0------------CR--------------            Time");
  $monitor(" %b ---- %b ---- %b ---- %b ---- %b -----%d ----%d ----%d ------ - - - - - - -  - --- -%b ---- %b ---- %b ---- %b ------ %b---- %b ---- %b ---- %b%b ---- %b%b ---- %b%b ---- %b%b--- %b ---- %b ---- %b%b%b%b%b ---- %b ---- %b ----%b---------- %b----%d",IR, AdMode, CLK, MOC, Cond, Mux_In, Next_State, Curr_State,/*outputs of CU*/ SR_ld,RF_ld,IR_ld,MAR_ld,MDR_ld,R_W,MOV,DT1,DT0,MA1,MA0,MB1,MB0,MC1,MC0,MD,ME,OP4,OP3,OP2,OP1,OP0,N2_1_0, Inv, S1_0,CR, $time);
  //Operand toether as 5 bit, Mux togethers as 2 bit
  
end

initial begin
	#1;
  CLK = 0;
  repeat(500) #1 CLK = ~CLK;
end

initial begin
  MOC = 0;
  repeat(250) #2 MOC = ~MOC;
end

initial begin
  Cond = 1;
  repeat(250) #2 Cond = ~Cond;
end

initial begin
//   IR = 8'b01011101;
   #5
   IR = 8'b00101000; //add(imm)
   #15;
   IR = 8'b01010100; //strb
   #15;
   IR = 8'b10100000; //beq

//    #20;
end

initial begin
  AdMode = 4'b1101;
  repeat(250) #4 AdMode = 4'b0110;
end
endmodule //ending adder test module