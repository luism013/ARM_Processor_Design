/*
Author: Luis M. Rivera Negrón
Requisite of ICOM-4215
For: Prof. N. Rodriguez

Explanation: The test loads values into all 16 registers for the first 600-ish cycles.
Register0 has been hardwired to only have a 0 value. Output A and B will show the value
of the Register at the moment it was assigned, so it will rarely ever coordinate with
the PC value shown in the output table. After 750 cycles, we switch to assign a new value
to Register10, as per the instructions. 
*/

module binary_decoder(output reg E15, E14, E13, E12, E11, E10, E9, E8, E7, E6, E5, E4, E3, E2, E1, E0, input[3:0] DReg, input RFLD);
    always @(RFLD, DReg)
        if(!RFLD)
            begin
            E0 <= 0;
            E1 <= 0;
            E2 <= 0;
            E3 <= 0;
            E4 <= 0;
            E5 <= 0;
            E6 <= 0;
            E7 <= 0;
            E8 <= 0;
            E9 <= 0;
            E10 <= 0;
            E11 <= 0;
            E12 <= 0;
            E13 <= 0;
            E14 <= 0;
            E15 <= 0;
        end //ending if
        else
            begin
            E0 <= 0;
            E1 <= 0;
            E2 <= 0;
            E3 <= 0;
            E4 <= 0;
            E5 <= 0;
            E6 <= 0;
            E7 <= 0;
            E8 <= 0;
            E9 <= 0;
            E10 <= 0;
            E11 <= 0;
            E12 <= 0;
            E13 <= 0;
            E14 <= 0;
            E15 <= 0;
            case(DReg)
                4'b0000: E0 <= 1'b1;
                4'b0001: E1 <= 1'b1;
                4'b0010: E2 <= 1'b1;
                4'b0011: E3 <= 1'b1;
                4'b0100: E4 <= 1'b1;
                4'b0101: E5 <= 1'b1;
                4'b0110: E6 <= 1'b1;
                4'b0111: E7 <= 1'b1;
                4'b1000: E8 <= 1'b1;
                4'b1001: E9 <= 1'b1;
                4'b1010: E10 <= 1'b1;
                4'b1011: E11 <= 1'b1;
                4'b1100: E12 <= 1'b1;
                4'b1101: E13 <= 1'b1;
                4'b1110: E14 <= 1'b1;
                4'b1111: E15 <= 1'b1;
            endcase //ending switch case
        end //ending else
endmodule //ending binary decoder module

module register(output reg[31:0] QS, input CLK, input enable ,input [31:0] DS);
    initial QS <= 0;
    always @ (CLK)//load only when the CLK signal is high
        if(enable)
            QS <= DS;
endmodule //ending register module

module multiplexer(output reg [31:0] PA, input [31:0] QS0, input [31:0] QS1, input [31:0] QS2, input [31:0] QS3, input [31:0] QS4, input [31:0] QS5,
input [31:0] QS6, input [31:0] QS7, input [31:0] QS8, input [31:0] QS9, input [31:0] QS10, input [31:0] QS11,input [31:0] QS12, input [31:0] QS13, 
input [31:0] QS14, input [31:0] QS15, input [3:0]selection);
    always @ (*)
        begin
            case(selection)
                4'b0000: PA <= QS0;
                4'b0001: PA <= QS1;
                4'b0010: PA <= QS2;
                4'b0011: PA <= QS3;
                4'b0100: PA <= QS4;
                4'b0101: PA <= QS5;
                4'b0110: PA <= QS6;
                4'b0111: PA <= QS7;
                4'b1000: PA <= QS8;
                4'b1001: PA <= QS9;
                4'b1010: PA <= QS10;
                4'b1011: PA <= QS11;
                4'b1100: PA <= QS12;
                4'b1101: PA <= QS13;
                4'b1110: PA <= QS14;
                4'b1111: PA <= QS15;
            endcase //ending selection case
        end //ending always
endmodule //ending multiplexer module

module register_File(output wire [31:0] PA, output wire [31:0] PB , input [3:0] DReg, input RFLD, CLK, input [3:0]selectionA, input [3:0]selectionB, input [31:0] PC);
wire E15, E14, E13, E12, E11, E10, E9, E8, E7, E6, E5, E4, E3, E2, E1, E0; //wires from binary decoder to registers
wire [31:0] QS0, QS1, QS2, QS3, QS4, QS5, QS6, QS7, QS8, QS9, QS10, QS11, QS12, QS13, QS14, QS15; //wires from registers to multiplexers

binary_decoder dec(E15, E14, E13, E12, E11, E10, E9, E8, E7, E6, E5, E4, E3, E2, E1, E0, DReg, RFLD);

multiplexer muxA(PA, QS0, QS1, QS2, QS3, QS4, QS5, QS6, QS7, QS8, QS9, QS10, QS11, QS12, QS13, QS14, QS15, selectionA);
multiplexer muxB(PB, QS0, QS1, QS2, QS3, QS4, QS5, QS6, QS7, QS8, QS9, QS10, QS11, QS12, QS13, QS14, QS15, selectionB);

register reg0(QS0, CLK, E0, 32'b00000000000000000000000000000000);
register reg1(QS1, CLK, E1, PC);
register reg2(QS2, CLK, E2, PC);
register reg3(QS3, CLK, E3, PC);
register reg4(QS4, CLK, E4, PC);
register reg5(QS5, CLK, E5, PC);
register reg6(QS6, CLK, E6, PC);
register reg7(QS7, CLK, E7, PC);
register reg8(QS8, CLK, E8, PC);
register reg9(QS9, CLK, E9, PC);
register reg10(QS10, CLK, E10, PC);
register reg11(QS11, CLK, E11, PC);
register reg12(QS12, CLK, E12, PC);
register reg13(QS13, CLK, E13, PC);
register reg14(QS14, CLK, E14, PC);
register reg15(QS15, CLK, E15, PC); //program counter

endmodule //ending register file module

//--------------------------------- MODULE TESTS --------------------------------------------------------------------------

// BINARY DECODER MODULE TESTER ********************************************************** Result: Success
// module binary_decoder_test;
// parameter sym_time = 35;
// initial #sym_time $finish;
// reg ld = 1;
// //wire E15, E14, E13, E12, E11, E10, E9, E8, E7, E6, E5, E4, E3, E2, E1, E0;
// reg[3:0] DReg;
// binary_decoder dec(E15, E14, E13, E12, E11, E10, E9, E8, E7, E6, E5, E4, E3, E2, E1, E0, DReg, ld);
//
// initial begin
//     $display("exit3----exit----exit1----exit0----Selection----LD------------------Time");
//     $monitor("%b---------%b---------%b---------%b--------%b------%b-%d", E3, E2, E1, E0, DReg, ld, $time);
// end //intial begin ending
//
// initial begin
//     DReg = 4'd0;
//     repeat(6) #5 DReg = DReg+ 4'd1;
// end //DReg declaration ending
//
// initial begin;
//     repeat(6) #4 ld = ~ld;
// end //ld declaration ending
// endmodule //ending BD test module


// REGISTER MODULE TESTER ********************************************************** Result: success
// module register_test;
// parameter sym_time = 35;
// initial #sym_time $finish;
// reg enable, CLK;
// reg[31:0] DS;
// wire[31:0] QS;
// register data(QS, CLK, enable, DS);

// initial begin
//     $display("---------DS--------LD-------CLK-----------------QS------------------Time");
//     $monitor("%d         %b         %b         %d %d", DS, enable, CLK, QS, $time);
// end //intial display ending

// initial begin
//     DS = 32'b00000000000000000000000000000011;
//     repeat(6) #5 DS <= DS + 32'b00000000000000000000000000000011;
// end //DS declaration ending

// initial begin
//   CLK <= 1'b1;
//   repeat (6) #10 CLK <= ~CLK;
// end //CLK declaration ending

// initial begin;
//     enable = 1'b1;
//     repeat(6) #4 enable = ~enable;
// end //enable declaration ending
// endmodule //ending Register test module

// // MULTIPLEXER MODULE TESTER ********************************************************** Result: Success
// module test_multiplexer;
// parameter sym_time = 25;
// initial #sym_time $finish;
// wire [31:0] PA;
// reg [3:0] selection;
// reg [31:0] QS0, QS1, QS2, QS3, QS4, QS5, QS6, QS7, QS8, QS9, QS10, QS11, QS12, QS13, QS14, QS15;
// multiplexer mux(PA, QS0, QS1, QS2, QS3, QS4, QS5, QS6, QS7, QS8, QS9, QS10, QS11, QS12, QS13, QS14, QS15, selection);

// initial begin
//   $display(" PA---------------------------------Selection-----------------------Time");
//   $monitor(" %b ---- %b ---- %d", PA, selection,$time);
// end

// initial begin
//   selection = 4'b0000;
//   repeat(4) #5 selection = selection + 4'b0001;
// end

// initial begin
//   QS0 = 32'b00000000000000000000000000010000;
//   QS1 = 32'b00000000000000001100000000000001;
//   QS2 = 32'b00100000000000000000000000000010;
//   QS3 = 32'b00000000000000111000000000100011;
//   QS4 = 32'b00000000000000000000111100001111;
// end
// endmodule //ending multiplexer test module

// REGISTER FILE MODULE TESTER ********************************************************** Result: Success
module register_File_test;
parameter sym_time = 800;
initial #sym_time $finish;
wire [31:0] PA, PB;//output of reads of register file
reg [3:0]DReg;//inputs to binary decoder 
reg RFLD, CLK; 
reg [31:0] PC;//32 bits of input infor for registers
reg [3:0] selectionA, selectionB; //multiplexer A & B selection

register_File RF(PA, PB, DReg, RFLD, CLK, selectionA, selectionB, PC);
//simulation time

initial begin //handling PC
  PC <= 4;
  repeat(15) #40 PC <= PC + 4;
end //incrementing PC by 4 every 40 cycles for 15 iterations
//manejar clock
initial begin
  CLK <= 1'b1;
  repeat(80) #10 CLK = ~CLK;
end

initial begin //handling RFLD
  RFLD <= 1'b0;
  repeat (5) #20 RFLD <= ~RFLD;
end

initial begin //handling DReg
  DReg <= 4'b0000;
  repeat(16) #40 DReg <= DReg + 4'b0001;
end 

initial begin //handling selection for Multiplexer A
  selectionA <= 4'b0000;
  #600 repeat(7) #20 selectionA <= selectionA +4'b0001;
end

initial begin //handling selection for Multiplexer B
  selectionB <= 4'b1000;
  #600 repeat(7) #20 selectionB <= selectionB +4'b0001;
end

initial begin //loading register 10 to change it's value
  #750 DReg <= 10;
end

initial begin //giving PC new value to put into Reg10
#750 PC <=101;
end

initial begin //selecting Reg10 to output with Multiplexer A
  #750 begin 
  selectionA <= 10;
  end
end

initial begin //outputs to display
  $display("      OutputA       OutputB     PC   Clock   Load    MuxA     MuxB                   Time");
  $monitor("%d, %d, %d,     %b,     %b,     R%d,     R%d,  %d", PA, PB, PC, CLK, RFLD, selectionA, selectionB, $time);
end
endmodule //ending Register File test module