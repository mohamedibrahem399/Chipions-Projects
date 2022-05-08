module FSM (clk,rst,in,out);
input clk,rst,in;
output out;
reg state;
reg out;

always @(posedge clk,posedge rst)
begin 

if(rst)begin
	state <= 1'b0;
	out <= 0;
	end
else
begin 
	case(state)
        1'b0:
	begin
	if(in) begin
	state <= 1'b0;
	out <=0; end
	else begin
	state <= 1'b1;
	out <=1; end
	end
	1'b1:
	begin
	if(in) begin
	state <= 1'b0;
	out <=1; end
	else begin
	state <= 1'b1;
	out <=0; end
	end 
	default: begin 
	state<= 1'b0;
	out<=0; end 
endcase
end 
end
endmodule 
