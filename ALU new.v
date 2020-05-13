/* 
 * Do not change Module name 
*/
module ALU32(output reg [31:0]O, output reg Z,Co,N,V, input [31:0]A,B, input [4:0]sel, input Cin);
reg sign, overflow;
//f is the operation control
always @ (sel,A,B)
begin
casez(sel)
5'b00000:   begin  {Co, O}=A & B;
Co=0;
V=0;
end
5'b00001:   begin  {Co,O} =A ^ B;//xor
Co=0;
V=0;
end
5'b00010: {Co,O}=A-B;
5'b00011: {Co,O}=B-A;
5'b00100: {Co,O}=A+B;

5'b00101: {Co,O}=A+B+Cin; 
5'b00110:  {Co,O}=A-B-(!Cin);
5'b00111:  {Co,O}=B-A-(!Cin);
//flag updates
5'b01000: begin  {Co,O}=A&B;
Co=0;
V=0;
end
5'b01001: begin  {Co,O}=A^B;           //eor or xor
V=0;
Co=0;
end
5'b01010: {Co,O}=A-B;
5'b01011:  {Co,O}=A+B;
//end flags updaters
5'b01100:  begin 
{Co,O}= A|B;
Co=0;
V=0;
end
5'b01101:  {Co,O}=B;
5'b01110: begin {Co,O}=A&(~B);
Co=0;
V=0;
end
5'b01111: begin
O=(~B);
Co=0;
V=0;
end
5'b10000:  begin
{Co,O}=A;
Co=0;
V=0;
end

5'b10001:  {Co,O}=A +4;
5'b10010:  {Co,O}=A+B+4; //Overflow detection 
5'b11110: {Co,O}= A+1;
5'b11111:  {Co,O}=B+1; 


default: O=32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;



endcase

sign = ((sel == 00011) || (sel == 00111))? A[31]:B[31]; 
overflow <= ((((sel == 5'b00010) || (sel == 5'b00011) || (sel == 5'b00110) || (sel == 5'b00111) || (sel == 5'b01010)) && (A[31] != B[31])) || (((sel == 5'b00100) || (sel == 5'b00101) || (sel == 5'b01011) || (sel == 5'b10001) || (sel == 5'b10010)) && (A[31] == B[31]))); // subtraction and addition
V = (overflow) && (sign != O[31]);

//unsigned overflow
//if(Co==1 && )
//V=1;
//else
//begin




//signed case overflow

//if((B===32'b01111111111111111111111111111111) && (sel!= 5'b01101 ))
   
  //  V=1;
    //else
    //begin
/*if(A===32'b01111111111111111111111111111111 && sel!= 5'b10000 ) 
    V=Co;
    else
   begin*/
    
    
   // if((O[31]==1) && (A[31]==0 && B[31]==0))
    //V=1;
    //else
    //V=0;
   
 //   end
   // end
    
    
    
//end of signed cases

//zero cases
if(O===32'b00000000000000000000000000000000)
   Z=1;
else
   Z=0;
//negative just for signed cases
if(O[31]==1)
N=1;
else 
N=0;



    end
endmodule

