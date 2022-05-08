module moore_proj( clk, reset, inp, out );
input inp , clk , reset;
output out;

reg [2 : 0] state;
reg out;

always @(posedge clk , posedge reset)
begin
	if (reset)
		state = 3'b000;
	else 
		begin
			case (state)

				3'b000:
					begin 
						if(inp==1) state <= 3'b001;
						else state <= 3'b000;

					end 

				3'b001:
					begin 
						if(inp==1) state <= 3'b001;
						else state <= 3'b010;
					end 

				3'b010:
					begin
						if(inp==1) state <= 3'b011;
						else state <= 3'b000;
					end


				3'b011:	

					begin 
						if(inp==1) state <= 3'b100;
						else state <= 3'b010;
					end 
				3'b100:	

					begin 
						if(inp==1) state <= 3'b001;
						else state <= 3'b010;
					end 
				default 
					state<=3'b 000;

			endcase
		end
end

always @(posedge clk , posedge reset)
begin

if (reset)
	out<=0;
else if (state == 3'b011 & inp==1)
	out<=1;
else 
	out<=0;
end

endmodule

module moore_proj_test;

reg clk_t, reset_t, inp_t;
wire out_t;

moore_proj g0  (.clk(clk_t), .reset(reset_t) , .inp(inp_t) , .out(out_t) );


initial begin  
reset_t=0; inp_t=0;clk_t=1;

#50 reset_t=0; inp_t=0;clk_t=0;

#50 inp_t=1;clk_t=1;
#50 inp_t=1;clk_t=0;

#50 inp_t=0;clk_t=1;
#50 inp_t=0;clk_t=0;

#50 inp_t=1;clk_t=1;
#50 inp_t=1;clk_t=0;

#50 inp_t=1;clk_t=1;
#50 inp_t=1;clk_t=0;

#50 inp_t=0;clk_t=1;
#50 inp_t=0;clk_t=0;

#50 inp_t=1;clk_t=1;
#50 inp_t=1;clk_t=0;

#50 inp_t=1;clk_t=1;
#50 inp_t=1;clk_t=0;

#50 inp_t=1;clk_t=1;
#50 inp_t=1;clk_t=0;

#50 inp_t=0;clk_t=1;
#50 inp_t=0;clk_t=0;

#50 inp_t=0;clk_t=1;
#50 inp_t=0;clk_t=0;
end


endmodule
