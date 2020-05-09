/* 
 * Do not change Module name 
*/
module Multiple(output reg [15:0] register, output reg [9:0] Next_State, output reg [9:0]Curr_State, input  [31:0]IR, input MOC,input CLK);

//out of declaration
reg [2:0] counter;
reg [3:0] Base_Register;
initial counter<=2'b0;
initial Base_Register<= IR[19:16];
 
    always @(IR) 
    if(IR[27:25]==3'b100)begin
    
if(IR[20])  begin
    casez(IR[24:23])
    2'b00: begin //LDMDA 
        if(counter==0) begin
    Curr_State= 10'd560;
    Next_State= 10'd561;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 10'd562;
     Curr_State=Next_State;
    if(MOC)begin        //wait for moc
       Next_State= 10'd563;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=10'd562;
         Next_State=10'd563;
        end
    //countdown
        if(counter!=0)  begin
         register= register[counter];
         counter= counter-1;
        end
    else begin
        Curr_State= 10'd560;
        Next_State= 10'd561;         //use a possible repeat
         Curr_State=Next_State;
         Next_State= 10'd562;
          Curr_State=Next_State;
          Next_State= 10'd563;
          Curr_State=Next_State;
        end
    end
    end
    2'b01: begin //LDMIA
         if(counter==0) begin
     Curr_State= 10'd544;
     Next_State= 10'd545 ;         //use a possible repeat
     Curr_State=Next_State;
     Next_State= 10'd546;
     Curr_State=Next_State;
        if(MOC)begin        //wait for moc
         Next_State= 10'd547;
         Curr_State=Next_State;
        end
        else begin
         Curr_State=10'd546;
         Next_State=10'd547;
        end
        
        if(counter==0)
        begin
         register= register[counter];
         counter= counter-1;
        end
    else begin
         Curr_State= 10'd544;
         Next_State= 10'd545 ;         //use a possible repeat
        Curr_State=Next_State;
         Next_State= 10'd546;
         Curr_State=Next_State;
          Next_State= 10'd547;
          Curr_State=Next_State;
        end
    
    end
    end
    2'b10: begin //LDMDB 
         if(counter==0) begin
     Curr_State= 10'd564;
     Next_State= 10'd565;         //use a possible repeat
     Curr_State=Next_State;
     Next_State= 10'd566;
     Curr_State=Next_State;
    if(MOC)begin        //wait for moc
         Next_State= 10'd567;
         Curr_State=Next_State;
        end
        else begin
         Curr_State=10'd566;
         Next_State=10'd567;
        end
        
   
        if(counter==0)
        begin
         register= register[counter];
         counter= counter-1;
        end
    else begin
         Curr_State= 10'd564;
         Next_State= 10'd565;         //use a possible repeat
         Curr_State=Next_State;
         Next_State= 10'd566;
         Curr_State=Next_State;
         Next_State= 10'd567;
         Curr_State=Next_State;
        end
    
    end
    end
    2'b11: begin // LDMIB
    while(counter>0)begin
     Curr_State= 10'd548;
     Next_State= 10'd549 ;         //use a possible repeat
        Curr_State=Next_State;
     Next_State= 10'd550;
     Curr_State=Next_State;
     if(MOC)begin        //wait for moc
          Next_State= 10'd551;
          Curr_State=Next_State;
        end
        else begin
               Curr_State=10'd550;
               Next_State=10'd551;
        end
        
        if(counter!=0)
        begin
       
       
         register= register[counter];
         counter= counter-1;
        end
    else begin
           Curr_State= 10'd548;
          Next_State= 10'd549 ;         //use a possible repeat
          Curr_State=Next_State;
          Next_State= 10'd550;
          Curr_State=Next_State;
          Next_State= 10'd551;
           Curr_State=Next_State;
        end
    
    end
    end
    
    
    endcase
    
  end  
else begin
 
    case(IR[24:23])
    2'b00: begin //STMDA 
      while(counter>0) begin
     Curr_State= 10'd568;
     Next_State= 10'd569;         //use a possible repeat
     Curr_State=Next_State;
     Next_State= 10'd570;
     Curr_State=Next_State;
     Next_State= 10'd571;
     Curr_State=Next_State;
    if(MOC)  begin        //wait for moc
         Next_State= 10'd1;
         Curr_State=Next_State;
        end
        else begin
         Curr_State=10'd571;
         Next_State=10'd1;
        end
        if(counter!=0)  begin
         register= register[counter];
         counter= counter-1;
        end
    else begin
         Curr_State= 10'd568;
        Next_State= 10'd569;         //use a possible repeat
        Curr_State=Next_State;
         Next_State= 10'd570;
         Curr_State=Next_State;
         Next_State= 10'd571;
         Curr_State=Next_State;
        end
    
    end
    end
    2'b01: begin //STMIA
         while(counter>0) begin
        Curr_State= 10'd552;
        Next_State= 10'd553 ;         //use a possible repeat
        Curr_State=Next_State;
         Next_State= 10'd554;
         Curr_State=Next_State;
         Next_State= 10'd555;
         Curr_State=Next_State;
        
         if(MOC)begin        //wait for moc
         Next_State= 10'd1;
         Curr_State=Next_State;
        end
        else begin
         Curr_State=10'd555;
         Next_State=10'd1;
        end
        if(counter!=0)
        begin
         register= register[counter];
         counter= counter-1;
        end
    end
    end
    2'b10: begin //STMDB 
       while(counter>0) begin // mal, hacer que entre y repita
        Curr_State= 10'd572;
       Next_State= 10'd573;         //use a possible repeat
       Curr_State=Next_State;
       Next_State= 10'd574;
       Curr_State=Next_State;
       Next_State= 10'd575;
       Curr_State=Next_State;
    
     if(MOC) begin        //wait for moc
             Next_State= 10'd1;
             Curr_State=Next_State; //go back to 1
        end
        else  begin
               Curr_State=10'd575;
               Next_State=10'd1;
        end
        
    if(counter!=0)
        begin
        
       
         register= register[counter];
         counter= counter-1;
        end
    
    
    end
    end
    2'b11: begin // STMIB
    
    while(counter>0)
         begin
       Curr_State= 10'd556;
       Next_State= 10'd557 ;         //use a possible repeat
       Curr_State=Next_State;
       Next_State= 10'd558;
       Curr_State=Next_State;
       Next_State= 10'd559;
       Curr_State=Next_State;
    
     if(MOC)begin        //wait for moc
             Next_State= 10'd1;
             Curr_State=Next_State;
            end
        else begin
         Curr_State=10'd547;
         Next_State=10'd1;
        end
        
        if(counter!=0)
        begin
           register= register[counter];
           counter= counter-1;
           
        end
     end
    
    end
    
 endcase 
  
    
            
            if(IR[0]) begin
                    register[counter] = 4'd0;
                    counter = counter + 1;
                end

            if(IR[1]) begin
                    register[counter] = 4'd1;
                    counter = counter + 1;

                end
            if(IR[2]) begin
                   register[counter] = 4'd2;
                   counter = counter + 1;
                  
                end
            if(IR[3]) begin
                  register[counter] = 4'd3;
                   counter = counter + 1;
                  
                end
            if(IR[4]) begin
                  register[counter] = 4'd4;
                   counter = counter + 1;
                  
                end
            if(IR[5]) begin
                  register[counter] = 4'd5;
                   counter = counter + 1;
                  
                end
            if(IR[6]) begin
                  register[counter] = 4'd6;
                   counter = counter + 1;
                  
                end
            if(IR[7]) begin
                  register[counter] = 4'd7;
                   counter = counter + 1;
                  
                end
            if(IR[8]) begin
                  register[counter] = 4'd8;
                   counter = counter + 1;
                  
                end
            if(IR[9]) begin
                  register[counter] = 4'd9;
                   counter = counter + 1;
                  
                end
            if(IR[10]) begin
                  register[counter] = 4'd10;
                   counter = counter + 1;
                  
                end
            if(IR[11]) begin
                  register[counter] = 4'd11;
                   counter = counter + 1;
                  
                end
            if(IR[12]) begin
                  register[counter] = 4'd12;
                   counter = counter + 1;
                  
                end
            if(IR[13]) begin
                  register[counter] = 4'd13;
                   counter = counter + 1;
                  
                end
            if(IR[14]) begin
                  register[counter] = 4'd14;
                   counter = counter + 1;
                  
                end
            if(IR[15]) begin
                  register[counter] = 4'd15;
                   counter = counter + 1;
                  
                end
    end
    end 
endmodule

//tester

module testMultiple;
//inputs
reg [31:0] IR;
reg MOC;
reg Base_Register;
reg CLK;
//outputs
wire [15:0] register;
wire [2:0] counter;
wire [9:0] Next_State;
wire [9:0] Curr_State;

Multiple testMul(register,Next_State,Curr_State,IR,MOC,CLK);

initial #50 $finish;
    initial
        begin             //20bit
        IR=32'b11101000101110100010000010100100;
        MOC=1'b1;
        
        

end
initial begin
$display("IR------------ ------------ ------IR24-23----L/S----- Curr_State----Next-State------CLK---register-----Base_Reg---counter---------------Time");
$monitor("%b----%b--------%b-------- %d ------  %d --------- %b -----%d ---------%b ------- %d - -%d",IR,IR[24:23],IR[20],Curr_State,Next_State,CLK,register,testMul.Base_Register,testMul.counter,$time );


end
endmodule




