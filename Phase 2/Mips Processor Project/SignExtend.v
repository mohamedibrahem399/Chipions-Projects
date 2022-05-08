module SignExtend(in, out);

input [15:0] in;

output reg [31:0] out;

always@(*)
begin 
	if ( in[15] == 1) out <= {16'hffff,in};
	else out <= {16'h0000,in};

end

endmodule
