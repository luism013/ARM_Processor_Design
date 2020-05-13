module ram1024x8 (output reg [31:0] DataOut, input Enable, ReadWrite, input [31:0] Address, input[31:0] DataIn, input[1:0] DataType, output reg MOC);
  reg[7:0] Mem[0:536870912]; //1024 localizaciones de 8bits (1024 bytes); 2D Array
  always @(Enable,ReadWrite)    //Perform on change of Enable Signal or ReadWrite
  begin
    MOC = 1'b0;
    #2;
    if(Enable)  //Read or Write only if memory is enabled
        case(DataType)
        2'b00: begin        //Byte
            if(ReadWrite)begin
                DataOut[31:8] = 24'b0000_0000_0000_0000_0000_0000;
                DataOut[7:0] = Mem[Address];
                MOC = 1'b1;
                end
            else
                begin
                Mem[Address] = DataIn[7:0];
                #2;
                MOC = 1'b1;
                end
        end
    
        2'b01: begin        //Half-Word
            if(ReadWrite) begin
                DataOut[31:16] = 24'b0000_0000_0000_0000;
                DataOut[15:8] = Mem[Address];
                DataOut[7:0] = Mem[Address + 1];
                MOC = 1'b1;
                end
            else 
                begin
                Mem[Address] = DataIn[15:8];
                Mem[Address + 1] = DataIn[7:0];
                #2;
                MOC = 1'b1;
                end
        end
            
        2'b10: begin        //Word
            if(ReadWrite)
                begin
                DataOut[31:24] = Mem[Address];
                DataOut[23:16] = Mem[Address + 1];
                DataOut[15:8] = Mem[Address + 2];
                DataOut[7:0] = Mem[Address + 3];
                MOC = 1'b1;
                end
            else 
                begin
                Mem[Address] = DataIn[31:24];
                Mem[Address + 1] = DataIn[23:16];
                Mem[Address + 2] = DataIn[15:8];
                Mem[Address + 3] = DataIn[7:0];
                #2;
                MOC = 1'b1;
                end
        end
        
        2'b11: begin        //DoubleWord
            if(ReadWrite) begin
                DataOut[31:24] = Mem[Address];
                DataOut[23:16] = Mem[Address + 1];
                DataOut[15:8] = Mem[Address + 2];
                DataOut[7:0] = Mem[Address + 3];
                #2;
                MOC = 1'b1;
                #20; 
                MOC = 1'b0;
                
                DataOut[31:24] = Mem[Address];
                DataOut[23:16] = Mem[Address + 1];
                DataOut[15:8] = Mem[Address + 2];
                DataOut[7:0] = Mem[Address + 3];
                #2;
                MOC = 1'b1;
                end
            else 
                begin
                Mem[Address] = DataIn[31:24];
                Mem[Address + 1] = DataIn[23:16];
                Mem[Address + 2] = DataIn[15:8];
                Mem[Address + 3] = DataIn[7:0];
                #2;
                MOC = 1'b1;
                #20; 
                MOC = 1'b0;

                Mem[Address + 4] = DataIn[31:24];
                Mem[Address + 5] = DataIn[23:16];
                Mem[Address + 6] = DataIn[15:8];
                Mem[Address + 7] = DataIn[7:0];
                #2;
                MOC = 1'b1;
                end
        end
        
        endcase
     end
        
endmodule   //End of RAM Module

