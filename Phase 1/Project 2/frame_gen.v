module frame_gen  (rst, data_in, parity_out, parity_type, stop_bits, data_length, frame_out);
input [7:0] data_in; 
input [1:0] parity_type; //refer to the block comment above. 
input rst,stop_bits; //low when using 1 stop bit, high when using two stop bits.
input parity_out,data_length; //low when using 7 data bits, high when using 8.
output reg [11:0] frame_out;
reg stop=1;
reg start=0;
reg [3:0] i;
reg [3:0] width = 8;
reg [7:0] x; // save the reversed data
always@(*)
begin
/*
if (data_length)
	begin
	for (i=0;i<width;i=i+1)
	x[i] = data_in[(width-1)-i];
	end
else
	begin
	for (i=0;i<width-1;i=i+1)
	x[i] = data_in[(width-2)-i];
	end
*/
x=data_in;
end



always @(*)
begin
if (rst) frame_out <= 12'b0;
else 
begin
	case(parity_type)
	2'b00:
	begin
	if (data_length)
	begin
		if (stop_bits) frame_out <= {start,x,stop,stop};
		else frame_out <= {start,x,stop};
	end
	else
	begin
		if (stop_bits) frame_out <= {start,x[6:0],stop,stop};
		else frame_out <= {start,x[6:0],stop};
	end		
	end
	2'b01:
	begin
	if (data_length)
	begin
		if (stop_bits) frame_out <= {start,x,parity_out,stop,stop};
		else frame_out <= {start,x,parity_out,stop};
	end
	else
	begin
		if (stop_bits) frame_out <= {start,x[6:0],parity_out,stop,stop};
		else frame_out <= {start,x[6:0],parity_out,stop};
	end		
	end
	2'b10:
	begin
	if (data_length)
	begin
		if (stop_bits) frame_out <= {start,x,parity_out,stop,stop};
		else frame_out <= {start,x,parity_out,stop};
	end
	else
	begin
		if (stop_bits) frame_out <= {start,x[6:0],parity_out,stop,stop};
		else frame_out <= {start,x[6:0],parity_out,stop};
	end		
	end
	2'b11:
	begin
	if (data_length)
	begin
		if (stop_bits) frame_out <= {start,x,stop,stop};
		else frame_out <= {start,x,stop};
	end
	else
	begin
		if (stop_bits) frame_out <= {start,x[6:0],stop,stop};
		else frame_out <= {start,x[6:0],stop};
	end		
	end
	endcase
end
end
endmodule