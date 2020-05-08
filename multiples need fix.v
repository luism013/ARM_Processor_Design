/* 
 * Do not change Module name 
*/
module Multiple(output [15:0] register, output [2:0] Next_State, input [2:0] Curr_State, input [31:0]IR, input MOC);
reg [4:0] counter= 3'd0;
reg [2:0] Curr_State=3'd0;
reg [2:0] Next_State=3'd0;

 

if(IR[20])
    begin
    case(IR[24:23])
    2'b00: begin //LDMDA 
    if(Curr_State!= 3'd547 && counter != 3'd0)begin
    Curr_State= 3'd560;
    Next_State= 3'd561;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd562;
    Curr_State=Next_State;
    IF(MOC)begin        //wait for moc
        Next_State= 3'd563;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd562;
        Next_State=3'd563;
        end
    
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
          Curr_State= 3'd560;
        Next_State= 3'd561;         //use a possible repeat
        Curr_State=Next_State;
        Next_State= 3'd562;
         Curr_State=Next_State;
         Next_State= 3'd563;
          Curr_State=Next_State;
        end
    end
    end
    2'b01: begin //LDMIA
    if(Curr_State!= 3'd547 && counter !=0)begin
    Curr_State= 3'd544;
    Next_State= 3'd545 ;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd546;
    Curr_State=Next_State;
        IF(MOC)begin        //wait for moc
        Next_State= 3'd547;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd546;
        Next_State=3'd547;
        end
        
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
         Curr_State= 3'd544;
         Next_State= 3'd545 ;         //use a possible repeat
         Curr_State=Next_State;
         Next_State= 3'd546;
         Curr_State=Next_State;
         Next_State= 3'd547;
         Curr_State=Next_State;
        end
    
    end
    end
    2'b10: begin //LDMDB 
    if(Curr_State!= 3'd547 && counter !=0)begin
    Curr_State= 3'd564;
    Next_State= 3'd565;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd566;
    Curr_State=Next_State;
    IF(MOC)begin        //wait for moc
        Next_State= 3'd567;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd566;
        Next_State=3'd567;
        end
        
   
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
        Curr_State= 3'd564;
        Next_State= 3'd565;         //use a possible repeat
        Curr_State=Next_State;
        Next_State= 3'd566;
        Curr_State=Next_State;
        Next_State= 3'd567;
        Curr_State=Next_State;
        end
    
    end
    end
    2'b11: begin // LDMIB
    if(Curr_State!= 3'd547 && counter !=0)begin
    Curr_State= 3'd548;
    Next_State= 3'd549 ;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd550;
    Curr_State=Next_State;
   IF(MOC)begin        //wait for moc
        Next_State= 3'd551;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd550;
        Next_State=3'd551;
        end
        
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
          Curr_State= 3'd548;
           Next_State= 3'd549 ;         //use a possible repeat
         Curr_State=Next_State;
         Next_State= 3'd550;
         Curr_State=Next_State;
         Next_State= 3'd551;
          Curr_State=Next_State;
        end
    
    end
    end
else begin
 begin
    case(IR[24:23])
    2'b00: begin //STMDA 
     if(Curr_State!= 3'd547 && counter !=0)begin
    Curr_State= 3'd568;
    Next_State= 3'd569;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd570;
    Curr_State=Next_State;
    Next_State= 3'd571;
    Curr_State=Next_State;
    IF(MOC)begin        //wait for moc
        Next_State= 3'd1;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd571;
        Next_State=3'd1;
        end
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
        Curr_State= 3'd568;
        Next_State= 3'd569;         //use a possible repeat
        Curr_State=Next_State;
        Next_State= 3'd570;
        Curr_State=Next_State;
        Next_State= 3'd571;
        Curr_State=Next_State;
        end
    
    end
    end
    2'b01: begin //STMIA
    if(Curr_State!= 3'd547 && counter !=0)begin
       Curr_State= 3'd552;
       Next_State= 3'd553 ;         //use a possible repeat
       Curr_State=Next_State;
        Next_State= 3'd554;
        Curr_State=Next_State;
        Next_State= 3'd555;
        Curr_State=Next_State;
        
         IF(MOC)begin        //wait for moc
        Next_State= 3'd1;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd555;
        Next_State=3'd1;
        end
        
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
          Curr_State= 3'd552;
           Next_State= 3'd553 ;         //use a possible repeat
          Curr_State=Next_State;
          Next_State= 3'd554;
          Curr_State=Next_State;
          Next_State= 3'd555;
          Curr_State=Next_State;
        end
    
    end
    end
    2'b10: begin //STMDB 
    if(Curr_State!= 3'd547 && counter !=0)begin
    Curr_State= 3'd572;
    Next_State= 3'd573;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd574;
    Curr_State=Next_State;
    Next_State= 3'd575;
    Curr_State=Next_State;
    
     IF(MOC)begin        //wait for moc
        Next_State= 3'd1;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd575;
        Next_State=3'd1;
        end
        
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
        Curr_State= 3'd572;
        Next_State= 3'd573;         //use a possible repeat
        Curr_State=Next_State;
        Next_State= 3'd574;
        Curr_State=Next_State;
        Next_State= 3'd575;
        Curr_State=Next_State;
        end
    
    end
    end
    2'b11: begin // STMIB
    if(Curr_State!= 3'd547 && counter !=0)begin
    Curr_State= 3'd544;
    Next_State= 3'd545 ;         //use a possible repeat
    Curr_State=Next_State;
    Next_State= 3'd546;
    Curr_State=Next_State;
    Next_State= 3'd547;
    Curr_State=Next_State;
    
     IF(MOC)begin        //wait for moc
        Next_State= 3'd1;
        Curr_State=Next_State;
        end
        else begin
        Curr_State=3'd547;
        Next_State=3'd1;
        end
        
        if(counter!=0)
        begin
        always(counter)
       
        register= register[counter];
        counter= counter-1;
        end
    else begin
          Curr_State= 3'd556;
           Next_State= 3'd557;         //use a possible repeat
         Curr_State=Next_State;
         Next_State= 3'd558;
         Curr_State=Next_State;
         Next_State= 3'd559;
          Curr_State=Next_State;
        end
    
    end
    end
    
end    
    
    
                 if(IR[0]) begin
                   register[counter] = 3'd0;
                   counter = counter + 1;
                end

                 if(IR[1]) begin
                   register[counter] = 3'd1;
                   counter = counter + 1;

                end
                if(IR[2]) begin
                  register[counter] = 3'd2;
                  counter = counter + 1;
                  
                end
                if(IR[3]) begin
                 register[counter] = 3'd3;
                  counter = counter + 1;
                  
                end
                if(IR[4]) begin
                 register[counter] = 3'd4;
                  counter = counter + 1;
                  
                end
                if(IR[5]) begin
                 register[counter] = 3'd5;
                  counter = counter + 1;
                  
                end
                if(IR[6]) begin
                 register[counter] = 3'd6;
                  counter = counter + 1;
                  
                end
                if(IR[7]) begin
                 register[counter] = 3'd7;
                  counter = counter + 1;
                  
                end
                if(IR[8]) begin
                 register[counter] = 3'd8;
                  counter = counter + 1;
                  
                end
                if(IR[9]) begin
                 register[counter] = 3'd9;
                  counter = counter + 1;
                  
                end
                if(IR[10]) begin
                 register[counter] = 3'd10;
                  counter = counter + 1;
                  
                end
                if(IR[11]) begin
                 register[counter] = 3'd11;
                  counter = counter + 1;
                  
                end
                if(IR[12]) begin
                 register[counter] = 3'd12;
                  counter = counter + 1;
                  
                end
                if(IR[13]) begin
                 register[counter] = 3'd13;
                  counter = counter + 1;
                  
                end
                if(IR[14]) begin
                 register[counter] = 3'd14;
                  counter = counter + 1;
                  
                end
                if(IR[15]) begin
                 register[counter] = 3'd15;
                  counter = counter + 1;
                  
                end
end
endmodule

//tester

module testMultiple;
//inputs
reg [31:0] IR;
reg [9:0] Curr_State;
reg MOC;


//outputs
wire [15:0] register;
wire [4:0] counter=3'd0;
wire [9:0] Next_State;

multiple(register,Next_State,Curr_State,IR,MOC);

initial #50 $finish;
    initial
        begin
        IR=32'b0111100011001100101001000000001;
        Curr_State=3'd1;
        

repeat(5) #10 IR[20]=0;
   #10  IR[20]=1; 
end
initial begin
$display("IR------------ L/S---- Curr_State-----Next-State---register---counter--------Time");
$monitor("%b---------- %b--------%d------%d------%d---%d-----------%d",IR,IR[20],Curr_State,Next_State,register,counter,$time );
end
endmodule




