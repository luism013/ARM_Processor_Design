/* 
 * Do not change Module name 
*/

module Shift_Sign_Extender (output reg [31:0] sOperand, output reg carry, input signed [31:0] IR, input signed [31:0] BReg);

    wire[2:0] op = IR[27:25];
    wire[1:0] shiftType = IR[6:5];
    wire dpshiftType = IR[4];
    integer rotateAmmount;
    reg[7:0] immediate_8bit;
    reg[31:0] tempReg;

    
    always @(IR)
    begin
       // $display("The Current Value from the Instruction Register is: %b", op);
        case(op)
            3'b101: begin   //Branch or Branch and Link Offset
                carry=0;
                $display("Branch Immediate Offset (NoShift)");
                sOperand[31:24] = 8'b00000000;
                sOperand[23:0] = IR[23:0];
            end
            3'b010: begin   //Address Mode 2 Immediate Offset
                carry=0;
                $display("Address Mode 2 Immediate Offset (NoShift)");
                sOperand[31:12] = 20'b0000_0000_0000_0000_0000;
                sOperand[11:0] = IR[11:0];
            end
            3'b001: begin //Data Processing Immediate Shifter Operand
                $display("Data Processing Immediate Shifter Operand");
                sOperand[31:8] = 24'b0000_0000_0000_0000_0000_0000;
                rotateAmmount = IR[11:8];
                carry = IR[rotateAmmount*2-1];
                immediate_8bit = IR[7:0] >> rotateAmmount*2;
                sOperand[7:0] = immediate_8bit; //IR[7:0];
                
            end
            
            3'b000: begin
                if(dpshiftType) begin   //AdMode 3 Immediate Offset
                        $display("Address Mode 3 Immediate Offset (no Shift)");
                        carry=0;
                        sOperand[31:8] = 0;
                        sOperand[7:0] = {IR[11:8],IR[3:0]};
                    end
                else //Data Processing Shift by Immediate Shifter
                    case(shiftType)
                        2'b00: begin
                            $display("Data Processing Shift By Immediate Shifter LSL");;
                            rotateAmmount = IR[11:7];
                            carry = BReg[32-rotateAmmount];
                            sOperand = BReg[31:0] << rotateAmmount;
                        end

                        2'b01: begin
                            $display("Data Processing Shift By Immediate Shifter LSR");
                            rotateAmmount = IR[11:7];
                            carry = BReg[rotateAmmount-1];
                            sOperand = BReg[31:0] >> rotateAmmount;
                        end
                        2'b10: begin 
                            $display("Data Processing Shift By Immediate Shifter ASR");
                            rotateAmmount = IR[11:7];
                            carry = BReg[rotateAmmount-1];
                            sOperand = $signed(BReg[31:0]) >>> rotateAmmount;
                        end
                        2'b11: begin
                            $display("Data Processing Shift By Immediate Shifter ROR");
                            rotateAmmount = IR[11:7];
                            carry = BReg[rotateAmmount-1];
                            case(IR[11:7])
                                5'b00000: begin
                                    sOperand = BReg;
                                end
                                
                                5'b00001: begin
                                    sOperand = {BReg[0], BReg[31:1]};
                                end
                                
                                5'b00010: begin
                                    sOperand = {BReg[1:0], BReg[31:2]};
                                end
                                
                                5'b00011: begin
                                    sOperand = {BReg[2:0], BReg[31:3]};
                                end
                                
                                5'b00100: begin
                                    sOperand = {BReg[3:0], BReg[31:4]};
                                end
                                
                                5'b00101: begin
                                    sOperand = {BReg[4:0], BReg[31:5]};
                                end
                                
                                5'b00110: begin
                                    sOperand = {BReg[5:0], BReg[31:6]};
                                end
                                
                                5'b00111: begin
                                    sOperand = {BReg[6:0], BReg[31:7]};
                                end
                                
                                5'b01000: begin
                                    sOperand = {BReg[7:0], BReg[31:8]};
                                end
                                
                                5'b01001: begin
                                    sOperand = {BReg[8:0], BReg[31:9]};
                                end
                                
                                5'b01010: begin
                                    sOperand = {BReg[9:0], BReg[31:10]};
                                end
                                
                                5'b01011: begin
                                    sOperand = {BReg[10:0], BReg[31:11]};
                                end
                                
                                5'b01100: begin
                                    sOperand = {BReg[11:0], BReg[31:12]};
                                end
                                
                                5'b01101: begin
                                    sOperand = {BReg[12:0], BReg[31:13]};
                                end
                                
                                5'b01110: begin
                                    sOperand = {BReg[13:0], BReg[31:14]};
                                end
                                
                                5'b01111: begin
                                    sOperand = {BReg[14:0], BReg[31:15]};
                                end
                                
                                5'b10000: begin
                                    sOperand = {BReg[15:0], BReg[31:16]};
                                end
                                
                                5'b10001: begin
                                    sOperand = {BReg[16:0], BReg[31:17]};
                                end
                                
                                5'b10010: begin
                                    sOperand = {BReg[17:0], BReg[31:18]};
                                end
                                
                                5'b10011: begin
                                    sOperand = {BReg[18:0], BReg[31:19]};
                                end
                                
                                5'b10100: begin
                                    sOperand = {BReg[19:0], BReg[31:20]};
                                end
                                
                                5'b10101: begin
                                    sOperand = {BReg[20:0], BReg[31:21]};
                                end
                                
                                5'b10110: begin
                                    sOperand = {BReg[21:0], BReg[31:22]};
                                end
                                
                                5'b10111: begin
                                    sOperand = {BReg[22:0], BReg[31:23]};
                                end
                                
                                5'b11000: begin
                                    sOperand = {BReg[23:0], BReg[31:24]};
                                end
                                
                                5'b11001: begin
                                    sOperand = {BReg[24:0], BReg[31:25]};
                                end
                                
                                5'b11010: begin
                                    sOperand = {BReg[25:0], BReg[31:26]};
                                end
                                
                                5'b11011: begin
                                    sOperand = {BReg[26:0], BReg[31:27]};
                                end
                                
                                5'b11100: begin
                                    sOperand = {BReg[27:0], BReg[31:28]};
                                end
                                
                                5'b11101: begin
                                    sOperand = {BReg[28:0], BReg[31:29]};
                                end
                                
                                5'b11110: begin
                                    sOperand = {BReg[29:0], BReg[31:30]};
                                end
                                
                                5'b11111: begin
                                    sOperand = {BReg[30:0], BReg[31]};
                                end
                                
                                
                            endcase
                        end
                    endcase
            end
            
            default: ;
            
        endcase
    end
endmodule


module SSTest;

reg[31:0]IR, BReg; wire[31:0] sOperand; wire carry;

Shift_Sign_Extender sse1 (sOperand,carry, IR, BReg);


initial #1000 $finish;

initial begin

    $monitor("Shifter Operand = %b---------Carry Output = %b \n", sOperand, carry);
    BReg = 32'b1111_0011_0001_1111_0011_1101_1100_0111;
    #10;
    //IR[27:25]=3'b001;
    IR = 32'b0011_0010_0000_0000_0000_0001_1111_1100;   //DP Immediate Shifter Operand
    #10;
    IR = 32'b0011_0000_0000_0000_0000_0001_0000_0000;   //Shift by Immediate Shifter LSL
    #10;
    IR = 32'b0011_0000_0000_0000_0000_0001_0010_0000;   //Shift by Immediate Shifter LSR
    #10;
    IR = 32'b0011_0000_0000_0000_0000_0001_1100_0000;   //Shift by Immediate Shifter ASR
    #10;
    IR = 32'b0011_0000_0000_0000_0000_0010_1110_0000;   //Shift by Immediate Shifter ROR
    #10;
    IR = 32'b1110_0101_0101_0110_0101_0000_0001_0100;   //Admode 2 (LDRB R5-20)
    #10;
    IR = 32'b0001_0001_0000_0110_0101_0001_1011_1100;   //STRNEH R5
    #10;
    IR = 32'b0000_1011_0110_0110_1000_0000_0000_0001;   // Branch and Link
end

endmodule