ule tb();
//inputs
reg rst ,stop_bits,data_length ;
 reg [7:0]  data ;
 reg [1:0]  parity_type ;
//outputs
 wire[11:0] frame_out;
 wire parity_out_tb ;
//=================
UART_parity tb_parity(.rst(rst),.data_in(data),.parity_type(parity_type),.parity_out(parity_out_tb));
frame_gen frame_tb (.rst(rst), .data_in(data), .parity_out(parity_out_tb), .parity_type(parity_type), .stop_bits(stop_bits), .data_length(data_length), .frame_out(frame_out));

initial 
begin
rst=0; parity_type=2'b10; data=8'hff; stop_bits=1'b0; data_length=1'b1;

#5
$display("The following is Parity Test");
$display("parity out is: %b || parity type is: %u ",parity_out_tb,parity_type);
#10
$display("The following is frame Test");
$display("expected frame is start_bit: 0 , data:11111111 , parity_out: 0 , stop_bits: 11 ");
#10
$display("output frame is %b",frame_out);
//==========================================
rst=0; parity_type=2'b10; data=8'h07; stop_bits=1'b0; data_length=1'b1;

#5
$display("The following is Parity Test");
$display("parity out is: %b || parity type is: %u ",parity_out_tb,parity_type);
#10
$display("The following is frame Test");
$display("expected frame is start_bit: 0 , data:00000111 , parity_out: 1 , stop_bits: 11 ");
#10
$display("output frame is %b",frame_out);
//================================================
rst=0; parity_type=2'b10; data=8'b10000110; stop_bits=1'b0; data_length=1'b0;
// corner case  :  even parity, 7-bit mode stop bit=0
#5
$display("The following is Parity Test");
$display("parity out is: %b || parity type is: %u ",parity_out_tb,parity_type);
#10
$display("The following is frame Test");
$display("expected frame is start_bit: 0 , data:000000110 , parity_out: 1 , stop_bits:1 1 ");
#10
$display("output frame is %b",frame_out);
//========================================================
rst=0; parity_type=2'b01; data=8'hff; stop_bits=1'b0; data_length=1'b1;

#5
$display("The following is Parity Test");
$display("parity out is: %b || parity type is: %u ",parity_out_tb,parity_type);
#10
$display("The following is frame Test");
$display("expected frame is start_bit: 0 , data:11111111 , parity_out: 1 , stop_bits:1 1 ");
#10
$display("output frame is %b",frame_out);
//===========================================================
rst=0; parity_type=2'b01; data=8'h90; stop_bits=1'b0; data_length=1'b0;

#5
$display("The following is Parity Test");
$display("parity out is: %b || parity type is: %u ",parity_out_tb,parity_type);
#10
$display("The following is frame Test");
$display("expected frame is start_bit: 0 , data:00010000 , parity_out: 0 , stop_bit: 1 ");
#10
$display("output frame is %b",frame_out);
$display("the end");
end



endmodule 
