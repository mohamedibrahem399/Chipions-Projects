module ProgramCounter(in,out,CLK);

input CLK;
input [31:0] in;
output reg [31:0] out=0;
/*
initial begin 
	out<=0;
end
*/

always@(posedge CLK)
begin 
	out <= in; 
end

endmodule

