module jkff_using_dff (j,k,clk,reset,q);

input j, k , clk , reset;
inout q;
reg  q ;
reg d_needed;
assign d_needed=0;
always @(posedge clk , posedge reset)
begin 

assign d_needed = (j & (!q)) | ( (!k) & q);
end

dff g0 (.clk(clk) , .d(d_needed) , .rest(reset) , .q(q));
endmodule

module jkff_using_dff_test();
reg j_t, k_t , clk_t , reset_t; 
wire q_t;

jkff_using_dff g1(.clk(clk_t) , .j(j_t), .k(k_t)  , .reset(reset_t) , .q(q_t));

initial 
begin
reset_t=1;
clk_t=0; j_t=1; k_t=0;
#100
reset_t=0; clk_t=0; j_t=1; k_t=0;
#100
reset_t=0; clk_t=1; j_t=1; k_t=0;
#100
reset_t=0; clk_t=0; j_t=0; k_t=1;
#100
reset_t=0; clk_t=1; j_t=0; k_t=1;
#100
reset_t=0; clk_t=0; j_t=0; k_t=0;
#100
reset_t=1; clk_t=1; j_t=0; k_t=0;
#100
reset_t=0; clk_t=0; j_t=1; k_t=1;
#100
reset_t=1; clk_t=1; j_t=1; k_t=1;
#100
reset_t=0; clk_t=0; j_t=1; k_t=1;


end 
endmodule