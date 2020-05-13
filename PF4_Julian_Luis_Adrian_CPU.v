/*
Author: Luis M. Rivera Negrón
Contributors: Adrian Soto Castillo, Julian A. Quiñones Pérez
Requisite of ICOM-4215
For: Prof. N. Rodriguez

*/

`include "ALU new.v"
`include "PF1_Quinones_Perez_Julian_ram.v"
`include "PF3_Julian_Luis_Adrian_CU.v"
`include "SignExtenderAndShifter.v"
`include "PF1_Rivera_Negron_Luis_rf.v"

module multiplexer4(output reg [31:0] Out, input [31:0] In_0, input [31:0] In_1, input [31:0] In_2, input [31:0] In_3, input [1:0]selection); 
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

module multiplexer5(output reg [31:0] Out, input [31:0] In_0, input [31:0] In_1, input selection); 
    always @ (*)
        begin
            case(selection)
                1'b0: Out <= In_0;
                1'b1: Out <= In_1;
            endcase //ending selection case
        end //ending always
endmodule //ending multiplexer module

module multiplexer6(output reg [3:0] PA, input [3:0] QS0, input [3:0] QS1, input [3:0] QS2, input [3:0] QS3, input [1:0]selection); 
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

module multiplexer7(output reg [4:0] Out, input [3:0] In_0, input [4:0] In_1, input selection); 
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

module Condition_tester(output reg Cond, input [3:0] IR, input Z, N, C, V);
initial Cond <= 0;
    always @ (*)
    begin
        case(IR)
        4'b0000: Cond <= (Z == 1'b1 ? 1'b1: 1'b0);
        4'b0001: Cond <= (Z == 1'b0 ? 1'b1: 1'b0);
        4'b0010: Cond <= (C == 1'b1 ? 1'b1: 1'b0);
        4'b0011: Cond <= (C == 1'b0 ? 1'b1: 1'b0);
        4'b0100: Cond <= (N == 1'b1 ? 1'b1: 1'b0);
        4'b0101: Cond <= (N == 1'b0 ? 1'b1: 1'b0);
        4'b0110: Cond <= (V == 1'b1 ? 1'b1: 1'b0);
        4'b0111: Cond <= (V == 1'b0 ? 1'b1: 1'b0);
        4'b1000: Cond <= ((Z == 1'b0 && C == 1'b1) ? 1'b1: 1'b0);
        4'b1001: Cond <= ((Z == 1'b1 && C == 1'b0) ? 1'b1: 1'b0);
        4'b1010: Cond <= ( N == V ? 1'b1: 1'b0);
        4'b1011: Cond <= ( N != V ? 1'b1: 1'b0);
        4'b1100: Cond <= ((Z == 1'b0 && N == V) ? 1'b1: 1'b0);
        4'b1101: Cond <= ((Z == 1'b1 ^ N != V) ? 1'b1: 1'b0);
        4'b1110: Cond <= 1'b1;
        endcase
    end
endmodule

module CentralProcessingUnit(input CLK);
    wire RF_Ld, IR_Ld, MAR_Ld, MDR_Ld, RW, MOV, MOC, DT1, DT0, C_In, SR_Ld, MA_1,MA_0,MB_1,MB_0, MC_1, MC_0, MD, ME, Cond,Z,C,N,V, OP4,OP3,OP2,OP1,OP0;
    wire [3:0] MCIN_0, MCIN_2,MC_Out, MAIN_0, MAIN_1, MA_Out, MDIN_0, CCode, Flags, SR_Out;
    wire [31:0] ALU_Out, Data_Out, IR_Out, RFA_Out, RFB_Out, SSE_Out, MDR_Out, MAR_Out, MB_Out, ME_Out;
    wire [4:0] MD_Out;
    wire [9:0] CR;
    
    assign Flags = {Z,C,N,V};
    
    wire [1:0] DT;
    assign DT = {DT1,DT0};
    
    wire [1:0] MB_Select;
    assign MB_Select = {MB_1,MB_0};
    
    wire [1:0] MC_Select;
    assign MC_Select = {MC_1,MC_0};
    
    wire [1:0] MA_Select;
    assign MA_Select = {MA_1, MA_0};
    
    wire [4:0] OPCode;
    assign OPCode = {OP4,OP3,OP2,OP1,OP0};

    //wire RW1 = 1;
    
    register_File RF(RFA_Out, RFB_Out, MC_Out, RF_Ld, CLK, MA_Out, IR_Out[3:0], ALU_Out);
    ALU32 alu (ALU_Out, Z,C,N,V, RFA_Out, MB_Out, MD_Out, C_In);
    MDR_MAR_IR MAR(MAR_Out, ALU_Out, CLK, MAR_Ld);
    MDR_MAR_IR MDR(MDR_Out, ME_Out, CLK, MDR_Ld);
    MDR_MAR_IR IR(IR_Out, Data_Out, CLK, IR_Ld);
    Shift_Sign_Extender SSE(SSE_Out, C, IR_Out, RFB_Out);
    Status_Register SR(SR_Out, Flags, CLK, SR_Ld);


    Condition_tester cond_tester(Cond, IR_Out[31:28], SR_Out[3],SR_Out[2], SR_Out[1], SR_Out[0]);
    ram1024x8 RAM(Data_Out, MOV, RW, MAR_Out, MDR_Out, DT, MOC);
    
    control_unit CU(SR_Ld, RF_Ld, IR_Ld, MAR_Ld, MDR_Ld, RW, MOV, DT1, DT0, MA_1, MA_0, MB_1, MB_0, MC_1, MC_0, MD, ME, OP4, OP3, OP2, OP1, OP0, CR, IR_Out[27:20], IR_Out[7:4], CLK, MOC, Cond);
    
    multiplexer4 MuxB(MB_Out, RFB_Out, SSE_Out, MDR_Out, 32'b0000_0000_0000_0000_0000_0000_0000_0000, MB_Select);
    multiplexer5 MuxE(ME_Out, Data_Out, ALU_Out, ME);
    multiplexer6 MuxC(MC_Out, IR_Out[15:12], 4'b1111, IR_Out[19:16], 4'b1110, MC_Select);
    multiplexer6 MuxA(MA_Out, IR_Out[19:16], IR_Out[15:12], 4'b1111, 4'b0000, MA_Select);
    multiplexer7 MuxD(MD_Out, IR_Out[24:21], OPCode, MD);

    
endmodule



//**TEST MODULE
module CPUTest;
    reg CLK;
    reg [0:32] Address;
integer fi,fo,code,i;
reg [0:7] data;
parameter sim_time = 50000;
//===========================
CentralProcessingUnit cpu(CLK);
//simulation time
initial #sim_time $finish;

initial begin
  // Monitor signals for  nestor
  Address <= cpu.MAR_Out;
$monitor("CurrentState: {%d} \nMAR: {%d} \nIR      {%b}     \nPC:                           {%d}   \nMDRin:  {%b} \nMDRout: {%b} \nMARin:  {%b} \nMARout: {%b} \nRAM_out:{%b}  \nALU_out:{%b} \ntime:               {%d}	\nSSE_Out:{%b} \n R3:{%b}	\n Z: {%b} \n Z: {%b} 	\n N: {%b}  \n V: {%b} \n R14: {%b} \n   \n===================end====================\n",
cpu.CU.rom.Next_State, cpu.MAR_Out, cpu.IR.QS, cpu.RF.reg15.QS, cpu.ME_Out, cpu.MDR_Out, cpu.ALU_Out, cpu.MAR_Out, cpu.Data_Out, cpu.ALU_Out, $time, cpu.SSE_Out, cpu.RF.reg12.QS, cpu.SR_Out[3], cpu.SR_Out[2], cpu.SR_Out[1], cpu.RF.reg14.QS);

//$monitor("\n PC:{%d}  \n MAR:{%d}    \n R1:{%b}    \n R2:{%d}    \n R3:{%d}  \n R5:{%b}     \n R10:{%d}      \nR12:{%b} \n IR:{%b} \nZ:{%b} \nC:{%b} \nN:{%b} \nV:{%b}  \n \n IR:{%b}  \n", cpu.RF.reg15.QS, cpu.MAR_Out, cpu.RF.reg1.QS, cpu.RF.reg2.QS, cpu.RF.reg3.QS, cpu.RF.reg5.QS, cpu.RF.reg10.QS, cpu.RF.reg12.QS, cpu.IR_Out, cpu.SR_Out[3], cpu.SR_Out[2], cpu.SR_Out[1], cpu.SR_Out[0]);


end

initial begin
    fi = $fopen("test2.txt","r");
    Address = 10'd0;
    while (!$feof(fi)) begin
		code = $fscanf(fi,"%b",data);
		cpu.RAM.Mem[Address] = data;
		Address = Address + 1;
    end
    $fclose(fi);
end

initial begin

    for(i = 0; i < 200; i = i + 4)
    begin
        Address = i;
        $display("Address = %d , Memory = %b %b %b %b", Address,cpu.RAM.Mem[i],cpu.RAM.Mem[i+1],cpu.RAM.Mem[i+2],cpu.RAM.Mem[i+3], $time);
    end
    $display("end ram===========================================================");

end

initial begin

  CLK <= 1'b0;

end

initial begin
  
  repeat(500) #1 CLK <= ~CLK; 
  
end
initial begin
 # 501;
    for(i = 0; i < 200; i = i + 4)
    begin
        Address = i;
        $display("Address = %d , Memory = %b %b %b %b", Address,cpu.RAM.Mem[i],cpu.RAM.Mem[i+1],cpu.RAM.Mem[i+2],cpu.RAM.Mem[i+3], $time);
    end
    $display("end ram===========================================================");

end

endmodule













































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

// CONDITION TESTER MODULE TESTER ********************************************************** Result: Success
//module test_conditionTester;
//parameter sym_time = 25;
//initial #sym_time $finish;
//reg Z, C, N , V;
//reg [3:0] IR;
//wire Cond;
//Condition_tester ct(Cond, IR, Z, N, C, V);


//initial begin
//  $display(" Z----N----C----V-----IR------Cond---------------Time");
//  $monitor(" %b -- %b -- %b -- %b -- %b ---- %d",Z, N, C, V, IR, Cond, $time);
//end

//initial begin //first testing variable
//  Z = 1'b1;
//  repeat(25) #1 Z = ~Z;
//end

//initial begin //second testing variable
//  N = 1'b1;
//  repeat(24) #1  N = ~N;
//end

//initial begin //third testing variable
//  V = 1'b1;
//  repeat(24) #1  V = ~V;
//end

//initial begin //fourth testing variable
//  C = 1'b1;
//  repeat(24) #1  C = ~C;
//end

//initial begin //IR
//  IR = 4'b1000;
//  repeat(6) #4 IR = IR +4'b0001;
//end
//endmodule //ending Condition Tester test module

