module baud_gen(
input rst, clock,
input [1:0] baud_rate,
output reg baud_out=0
);
/*
input rst,clock;
input [1:0] baud_rate;
output reg baud_out=0;
*/
reg [15:0] BaudRate=16'b1;
reg [15:0] counter=16'b0;

always @(posedge clock )
begin
if (counter == 0)
begin
	case(baud_rate)
	2'b00: //2400 baud
		begin
		BaudRate <= 16'd1302;
		end
	2'b01: //4800 baud
		begin
		BaudRate <= 16'd651;
		end
	2'b10: //9600 baud
		begin
		BaudRate <= 16'd325;
		end
	2'b11: //19.2K baud
		begin
		BaudRate <= 16'd162;
		end
	endcase
end

end


always @(posedge clock or posedge rst)
begin 

	if (rst) counter <= 16'b0;
	else if (counter==BaudRate)
		begin 
			counter = 0;
			baud_out =~ baud_out;
		end 
	else counter <= counter +1;
end 

endmodule 
