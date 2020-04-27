module ram1024x8 (output reg [31:0] DataOut, input Enable, ReadWrite, input [9:0] Address, input[31:0] DataIn, input[1:0] DataType, output reg MOC);
  reg[7:0] Mem[0:1023]; //1024 localizaciones de 8bits (1024 bytes); 2D Array
  always @(Enable,ReadWrite)    //Perform on change of Enable Signal or ReadWrite
    if(Enable)  //Read or Write only if memory is enabled
        case(DataType)
        2'b00: begin        //Byte
            if(ReadWrite)begin
                DataOut[31:8] = 24'b0000_0000_0000_0000_0000_0000;
                DataOut[7:0] = Mem[Address];
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                end
            else
                begin
                Mem[Address] = DataIn[7:0];
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                end
        end
    
        2'b01: begin        //Half-Word
            if(ReadWrite) begin
                DataOut[31:16] = 24'b0000_0000_0000_0000;
                DataOut[15:8] = Mem[Address];
                DataOut[7:0] = Mem[Address + 1];
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                end
            else 
                begin
                Mem[Address] = DataIn[15:8];
                Mem[Address + 1] = DataIn[7:0];
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
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
                #1; 
                MOC = 1'b0;
                end
            else 
                begin
                Mem[Address] = DataIn[31:24];
                Mem[Address + 1] = DataIn[23:16];
                Mem[Address + 2] = DataIn[15:8];
                Mem[Address + 3] = DataIn[7:0];
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                end
        end
        
        2'b11: begin        //DoubleWord
            if(ReadWrite) begin
                DataOut[31:24] = Mem[Address];
                DataOut[23:16] = Mem[Address + 1];
                DataOut[15:8] = Mem[Address + 2];
                DataOut[7:0] = Mem[Address + 3];
                
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                
                DataOut[31:24] = Mem[Address];
                DataOut[23:16] = Mem[Address + 1];
                DataOut[15:8] = Mem[Address + 2];
                DataOut[7:0] = Mem[Address + 3];
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                end
            else 
                begin
                Mem[Address] = DataIn[31:24];
                Mem[Address + 1] = DataIn[23:16];
                Mem[Address + 2] = DataIn[15:8];
                Mem[Address + 3] = DataIn[7:0];
                
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                
                Mem[Address + 4] = DataIn[31:24];
                Mem[Address + 5] = DataIn[23:16];
                Mem[Address + 6] = DataIn[15:8];
                Mem[Address + 7] = DataIn[7:0];
                
                MOC = 1'b1;
                #1; 
                MOC = 1'b0;
                end
        end
        
        endcase
        
        
endmodule   //End of RAM Module


module Ram_Test;

integer inFile, outFile, code, i; reg[7:0] data; 
reg Enable, ReadWrite; reg[31:0] DataIn;
reg[9:0] Address; wire[31:0] DataOut; reg [1:0] DataType;
    
ram1024x8 ram1 (DataOut, Enable, ReadWrite, Address, DataIn, DataType, MOC)  ;   //Instantiate RAM Component
    
// ****************************************************************Precharge RAM**********************************************************************
initial #3000 $finish;  //Set finish time to 3000 time cycles from execution
initial begin 
	inFile = $fopen("PF1_Quinones_Perez_Julian_ramdata.txt","r");    //Open Input File
	Address = 10'b00_0000_0000;              //Begin Data insert at Address 0
	DataType = 2'b00;                       //Insert Data as Bytes
	while(!$feof(inFile)) begin             //Scan File until EOF
		code = $fscanf(inFile,"%b", data);
		ram1.Mem[Address] = data;
		Address = Address + 1;  //Increment Memory Location by one byte
	end
	$fclose(inFile);
end
//*******************************************************************Read Precharge Data*************************************************************
initial begin
	DataType = 2'b00;
	Enable = 1'b0; 
	ReadWrite = 1'b1;
	Address = #1 10'b00_0000_0000;   //Sets address to 0 before loop execution
	$display("Precharged RAM Data:");
	repeat(16) begin
		#5 Enable = 1'b1;
		#5 Enable = 1'b0;
		Address = Address + 1;
	end
	
	
	//**************************************************************Write To RAM******************************************************************
	
	//Write a Byte to location 0
	#5 Enable = 1'b0;
    Address = #1 10'b00_0000_0000;
    DataType = #1 2'b00;
    DataIn = #1 32'b0000_0000_0000_0000_0000_0000_0000_1100;
    ReadWrite = #1 1'b0;
    #5 Enable = 1'b1;
    
    //Write a half-word to location 2
    #5 Enable = 1'b0;
    Address = #1 10'b00_0000_0010;
    DataType = #1 2'b01;
    DataIn = #1 32'b0000_0000_0000_0000_0110_1001_0011_1110;
    #5 Enable = 1'b1;
    
    //Write a half-word to location 4
    #5 Enable = 1'b0;
    Address = #1 10'b0000000100;
    DataType = #1 2'b01;
    DataIn = #1 32'b0000_0000_0000_0000_0000_0001_1010_1100;
    #5 Enable = 1'b1;
    
    //Write a Word to location 8
    #5 Enable = 1'b0;
    Address = #1 10'b00_0000_1000;
    DataType = #1 2'b10;
    DataIn = #1 32'b1110_0110_1000_0000_0000_0000_0000_1100;
    #5 Enable = 1'b1;
    #5 Enable = 1'b0;
    
    //DOUBLE WORD WRITE TEMPLATE
    //Address = #1 10'b00_0000_1000;
    //DataType = #1 2'b11;
    //DataIn = 32'b1111_1111_1111_1111_1110_0000_0000_1100;
    //#1 Enable = 1'b1;
    //#1 DataIn = 32'b0000_0000_0000_0000_0000_0000_0000_0000;
    //#5 Enable = 1'b0;
    
    //***********************************************************Read Written Data******************************************************************
	
	$display("\n Data after Write: ");
	
	DataType = 2'b00;
	Enable = 1'b0; 
	ReadWrite = 1'b1;
	Address = #1 10'b0000000000;
    #5 Enable = 1'b1;
	#5 Enable = 1'b0;
	
	DataType = 2'b01;
	Address = Address + 2;
	#5 Enable = 1'b1;
    #5 Enable = 1'b0;
    
    Address = Address + 2;
	#5 Enable = 1'b1;
    #5 Enable = 1'b0;
    
    DataType = 2'b10;
	Address = Address + 4;
	#5 Enable = 1'b1;
    #5 Enable = 1'b0;
	
	//**************************************************************Read all Data********************************************************************
	
	$display("\n Display of all Data After Write: ");
	
	DataType = 2'b00;
	Enable = 1'b0; 
	ReadWrite = 1'b1;
	Address = #1 10'b00_0000_0000;   //Sets address to 0 before loop execution
	repeat(16) begin
		#5 Enable = 1'b1;
		#5 Enable = 1'b0;
		Address = Address + 1;
	end
	

	
	$finish;
end
always @(posedge Enable)
begin
	#1;
	if(ReadWrite)
	    $display("Data in %d = %h %d",Address,DataOut,$time);
end
endmodule