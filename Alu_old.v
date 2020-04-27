
module ALU32(output reg [31:0]O, output reg Co,Z,V,N, input [31:0]A,B, input [2:0]f, input Cin);//main module

//f is the operation control
always @ (f,A,B)
begin
case(f)
3'b000:  {Co,O}=A+B; //Overflow detection
          
             
        
3'b001:  {Co,O}=A+B+Cin; //Overflow detection
              
        
3'b010:  {Co,O}=A-B;
            
        //chech for negative if A<B
3'b011:  begin O =A & B;
Co=0;
V=0;
end
3'b100:  O= A|B;
3'b101:  O=A;
3'b110:  O= A>>1;
3'b111:  O= A<<1;
default: begin;

end
endcase

if(O===32'b00000000000000000000000000000000) //if statement for zeros
   Z=1;
else
   Z=0;
 
if(O[31]===1) //2 bit compliment flag
    N=1;
else
    N=0;
 if(Co==1)//if statement for overflow flag
   V=1;
else
   V=0;


    end
endmodule

module testALU; //tester
//inputs
reg  [31:0]A,B;
 reg [2:0] sel;
reg Ci;

//output
wire [31:0] O;
wire Co,Z,N,V;
ALU32 alut(O,Co,Z,V,N,A,B,sel,Ci); //initializacion of module

initial #100 $finish;
  initial //initialized values, tested with other as well
    begin
    sel=3'b000;
    
    
    A= 32'b11111111111111111111111111111111;
    B= 32'b00000000000000000000000000000000;
    Ci= 1'b1; //carryIN
   
    
    repeat(7) #10 sel= sel + 3'b001; //repeated process
    end
    initial begin
      $display("f2 f1 f3 Co Z  V  N      A31 A30 A29    O31 O30 O29   --in  Decimal:   A         B          O                   --Time");
      $monitor("%b  %b  %b  %b  %b  %b  %b  ---- %b   %b   %b       %b  %b   %b   ---      %d   %d   %d  %d", sel[2],sel[1],sel[0],Co,Z,V,N,A[31],A[30],A[29],O[31],O[30],O[29], A,B,O, $time );//monitor display
    
    end
endmodule