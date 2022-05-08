module MAIN_CLK(CLK,PC_IN,PC_OUT);
input CLK;
input [31:0] PC_IN;
output reg [31:0] PC_OUT;

always@(posedge CLK)
	begin
		PC_OUT <= PC_IN;
	end

endmodule
