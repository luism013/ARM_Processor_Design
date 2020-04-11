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

module adder(output reg [31:0] IR_Out, input [31:0] Mux_Out);
    // initial Add_1 <= 1'b1;
    always @ (*)
        IR_Out <= Mux_Out+32'b0000000000000000000000000000001;
endmodule //ending adder module

module multiplexer(output reg [31:0] PA, input [31:0] QS0, input [31:0] QS1, input [31:0] QS2, input [31:0] QS3, input [1:0]selection); 
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

module increment_Register(output reg[31:0] Mux_In, input CLK ,input [31:0] Adder_Out);
    initial Mux_In <= 0;
    always @ (posedge CLK)//load only when the CLK signal is high
            Mux_In <= Adder_Out;
endmodule //ending increment_Register module

/*
more work needs to be done here. Need the state diagram table to map all operations and then, depending 
on the OP code sent by the IR, enconde the state to send to the multiplexer. Still need to check if the delay must
be programmed manually or left as is (with no delay). 
*/
module encoder(output reg[31:0] Mux_In,input [31:0] IR_Out);
    initial Mux_In <= 0;
    always @ (*)
            Mux_In <= IR_Out;
endmodule //ending encoder module

module next_State_Address_Selector(output reg[1:0] M1_0,input [2:0] N2_1_0, input Sts);
    initial M1_0 <= 0;
    always @ (*) //need to program the delay?
        begin
            case(N2_1_0)
                3'b000: M1_0 <= 2'b00;
                3'b001: M1_0 <= 2'b01;
                3'b010: M1_0 <= 2'b10;
                3'b011: M1_0 <= 2'b11;
                3'b100: 
                    if(Sts == 1'b0)
                        M1_0 <= 2'b00;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b10;
                3'b101: 
                    if(Sts == 1'b0)
                        M1_0 <= 2'b11;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b10;                
                3'b110: 
                    if(Sts == 1'b0)
                        M1_0 <= 2'b11;
                    else if(Sts == 1'b1)
                        M1_0 <= 2'b10;
            endcase //ending selection case
        end //ending always            
endmodule //ending encoder module

/*
for the microstore and control Register modules, I need the moore table in order to map
the outputs of the circuits into real data. 
*/
module microstore(output reg[31:0] Next_State, input [31:0] Curr_State); //a.k.a. ROM
endmodule //ending encoder module

module control_Register(output reg[15:0] Signals, output reg [2:0] N2_1_0, output reg Sts, Inv, output reg[1:0] S1_0);
endmodule //ending encoder module
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

// ADDER MODULE TESTER ********************************************************** Result: Nope
// module test_adder;
// parameter sym_time = 25;
// initial #sym_time $finish;
// reg [31:0] Mux_out;
// wire [31:0] IR_Out;
// adder sumador(IR_Out, Mux_Out);


// initial begin
//   $display(" Mux----Out----------------------Time");
//   $monitor(" %d ---- %d ---- %d",Mux_Out,IR_Out,$time);
// end

// initial begin
//   Mux_Out = 32'b0000000000000000000000000000001;
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

// ENCODER MODULE TESTER ********************************************************** Result: Success (part module needs revisiont)
// module encoder_test;
// parameter sym_time = 35;
// initial #sym_time $finish;
// reg[31:0] IR_Out;
// wire[31:0] Mux_In;
// encoder encodificador(Mux_In, IR_Out);

// initial begin
//     $display("---------IR-----------------Out------------------Time");
//     $monitor("%d         %d %d", IR_Out, Mux_In, $time);
// end //intial display ending

// initial begin
//     IR_Out = 32'b00000000000000000000000000000011;
//     repeat(6) #5 IR_Out <= IR_Out + 32'b00000000000000000000000000000011;
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