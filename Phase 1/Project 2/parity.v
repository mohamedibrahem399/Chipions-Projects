module parity (rst, data_in, parity_type, parity_out);
input rst  ;
input [7:0] data_in ;
input [1:0] parity_type ;
output reg parity_out ;


integer ones =0 ;
integer i =0 ;


always @(*)
begin
if (rst)
    begin 
     parity_out = 0 ;
	  end 
else 
	 begin 
		case (parity_type)
		
  //2'b00 : //no parity.										
  //begin
  //end 
  
   2'b01 : // 01	odd parity.	
  begin
  ones = 0 ;
  for(i=0; i<=7; i=i+1)
    begin
        if(data_in[i]==1)
        ones = ones + 1;
    end
    if(ones%2==0)  
     parity_out <= 1;
    else
     parity_out <= 0;
  end 
  
  2'b11 : 
// 11	use the output parity_out as an odd parity bit and no parity in the serial frame(like 00).
  begin
   ones = 0 ;
  for(i=0; i<=7; i=i+1)
    begin
        if(data_in[i]==1)
        ones = ones + 1;
    end
    if(ones%2==0)  
     parity_out <= 1;
    else
     parity_out <= 0;
  end 
  
   2'b10 : // 10	even parity.	
  begin
  ones = 0 ;
  for(i=0; i<=7; i=i+1)
    begin
        if(data_in[i]==1)
        ones = ones + 1;
    end
    if(ones%2==0)  
     parity_out <= 0;
    else
     parity_out <= 1;
  end 
  endcase 
  end
  end
endmodule 

