/*
Author: Luis M. Rivera Negrón
Contributors: Adrian Soto Castillo, Julian A. Quiñones Pérez
Requisite of ICOM-4215
For: Prof. N. Rodriguez

*/

module multiplexer(output reg [31:0] Out, input [31:0] In_0, input [31:0] In_1, input [31:0] In_2, input [31:0] In_3, input [1:0]selection); 
//for state selection
    always @ (*)
        begin
            case(selection)
                2'b00: Out <= In_0;
                2'b01: Out <= In_1;
                2'b10: Out <= In_2;
                2'b11: Out <= In_3;
            endcase //ending selection case
        end //ending always
endmodule //ending multiplexer module

module multiplexer2(output reg [31:0] Out, input In_0, input In_1, input selection); 
    always @ (*)
        begin
            case(selection)
                1'b0: Out <= In_0;
                1'b1: Out <= In_1;
            endcase //ending selection case
        end //ending always
endmodule //ending multiplexer module

module MDR_MAR_IR(output reg [31:0] QS, input [31:0] DS, input CLK, ld); //MDR, MAR and Instruction Register modules. 
    initial QS <= 0;
    always @ (posedge CLK)
        if(ld)
            QS <= DS;
endmodule

module Status_Register(output reg [3:0] QS, input [3:0] DS, input CLK, SR_ld);
    initial QS <= 0;
    always @ (posedge CLK)
        if(SR_ld)
            QS <= DS;
endmodule

// module Condition_tester(output reg [3:0] Cond, input [3:0] IR, input [3:0] Flags);
// initial Cond <= 0;
//     always @ (*)

// endmodule

//--------------------------------- MODULE TESTS --------------------------------------------------------------------------

// MAR_MDR_IR MODULE TESTER ********************************************************** Result: Success
// module test_MAR_MDR_IR;
// parameter sym_time = 25;
// initial #sym_time $finish;
// reg CLK, ld;
// reg [31:0] DS;
// wire [31:0] QS;
// MDR_MAR_IR ir(QS, DS, CLK, ld);


// initial begin
//   $display(" CLK----ld-------------DS---------------QS-------------------Time");
//   $monitor(" %b ---- %b ---- %d ---- %d ---- %d",CLK, ld, DS, QS,$time);
// end

// initial begin
//   CLK = 1'b1;
//   repeat(25) #1 CLK = ~CLK;
// end

// initial begin
//   ld = 1'b1;
//   repeat(6) #4 ld = ~ld;
// end

// initial begin
//   DS = 32'b0000000000000000000000000000001;
//   repeat(24) #1  DS = DS+32'b0000000000000000000000000000001;
// end
// endmodule //ending MAR/MDR/IR test module

// STATUS REGISTER MODULE TESTER ********************************************************** Result: Success
// module test_statusRegister;
// parameter sym_time = 25;
// initial #sym_time $finish;
// reg CLK, SR_ld;
// reg [3:0] DS;
// wire [3:0] QS;
// Status_Register sr(QS, DS, CLK, SR_ld);


// initial begin
//   $display(" CLK----SR_ld---DS------QS-----------------------Time");
//   $monitor(" %b ---- %b ---- %d ---- %d ---- %d",CLK, SR_ld, DS, QS,$time);
// end

// initial begin
//   CLK = 1'b1;
//   repeat(25) #1 CLK = ~CLK;
// end

// initial begin
//   SR_ld = 1'b1;
//   repeat(6) #4 SR_ld = ~SR_ld;
// end

// initial begin
//   DS = 4'b0001;
//   repeat(24) #1  DS = DS+4'b0001;
// end
// endmodule //ending Status Register test module



