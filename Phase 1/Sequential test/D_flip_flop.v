module dff (clk, d , rest , q);
input clk, d , rest;
output q ;
reg q;


always @(posedge clk, posedge rest)
	begin
	if (rest)
		q = 0;
	else 
		q = d;
	end

endmodule

module dff_test();
reg d_t, clk_t ,reset_t; 
wire q_t;
dff t1(.clk(clk_t) , .d(d_t) , .rest(reset_t) , .q(q_t));

initial 
begin
reset_t=1;
clk_t=0; d_t=1;
#100
reset_t=0; clk_t=1; d_t=1;
#100
reset_t=0; clk_t=0; d_t=0;
#100
reset_t=0; clk_t=1; d_t=0;
#100
reset_t=0; clk_t=0; d_t=0;
#100
reset_t=1; clk_t=1; d_t=0;
end 
endmodule
