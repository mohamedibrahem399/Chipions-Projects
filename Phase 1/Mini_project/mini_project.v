module mini_project (clk, reset, Tcount, Pcount, empty_flag, full_flag,Hold, Wtime, inx , iny );

input clk, reset,inx,iny;

input [1:0] Tcount;

output [2:0] Pcount;
output empty_flag ,full_flag ;
output [4:0] Wtime;
output Hold;

wire pci , pco;
wire inx = 1;
wire iny = 1;

FSM x1 (.clk(clk), .rst(reset) , .in(inx) , .out(pci) ); // for queue back sensor
FSM y1 (.clk(clk), .rst(reset) , .in(iny) , .out(pco) ); // for queue forward sensor

counter st1 (.clk(clk), .rst(reset) , .pcount(Pcount) , .pci(pci) , .pco(pco) , .ef(empty_flag) , .ff(full_flag), .H(Hold) );

wire [4:0] index;
assign index = {Tcount , Pcount};

new_rom st2 (.index(index), .clk(clk) , .ef(empty_flag) , .ff(full_flag) , .reset(reset), .wtime(Wtime));

endmodule





module mini_project_test;

reg reset_t, inx_t, iny_t ;
reg [1:0] Tcount_t;
reg clk_t = 1;
wire empty_flag_t, full_flag_t;
wire [4:0] Wtime_t;
wire [2:0] Pcount_t;
wire Hold_t;
mini_project g0  (.clk(clk_t), .reset(reset_t) , .Tcount(Tcount_t) , .Pcount(Pcount_t), .empty_flag(empty_flag_t), . full_flag( full_flag_t) , .Wtime(Wtime_t), .inx(inx_t), .iny(iny_t), .Hold(Hold_t) );


initial 
begin 
forever begin
clk_t=clk_t;
#10 clk_t <=~clk_t;
end
end

initial begin 

reset_t=0;Tcount_t=2'b01;inx_t=1;iny_t=1; // 000
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b01;inx_t=0;iny_t=1; //001
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b01;inx_t=1;iny_t=1; //010
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b01;inx_t=1;iny_t=0; //001
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b01;inx_t=1;iny_t=1; //000
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=0;iny_t=1; //001
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=1; //010
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=0; //001
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=1; // 000
if ( Pcount_t<3'b001 && empty_flag_t==1 && Hold_t == 1  ) $display("there is no one to go out of the queue");
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=0;//test no one in queue

if ( Pcount_t<3'b001 && empty_flag_t==1 && Hold_t == 1  ) $display("there is no one to go out of the queue");
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=0;iny_t=0; //001
if ( Pcount_t<3'b001 && empty_flag_t==1 && Hold_t == 1  ) $display("there is no one to go out of the queue");
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=0; //010

$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);


#150 Tcount_t=2'b10;inx_t=0;iny_t=0;

$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);


#150 Tcount_t=2'b10;inx_t=1;iny_t=0;

$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=0;iny_t=0;

$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=0;

$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=0;iny_t=0; // before full queue 

if ( Pcount_t<3'b001 && empty_flag_t==1 && Hold_t == 1  ) $display("there is no one to go out of the queue");
else if ( Pcount_t>3'b110 && full_flag_t==1 && Hold_t == 1) $display("the queue is full");
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=0;// test full queue 

if ( Pcount_t<3'b001 && empty_flag_t==1 && Hold_t == 1  ) $display("there is no one to go out of the queue");
else if ( Pcount_t==3'b111 && full_flag_t==1 && Hold_t == 1) $display("the queue is full");
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);

#150 Tcount_t=2'b10;inx_t=1;iny_t=1;// test full queue 2

if ( Pcount_t<3'b001 && empty_flag_t==1 && Hold_t == 1  ) $display("there is no one to go out of the queue");
else if (Pcount_t==3'b111 && full_flag_t==1 && Hold_t == 1) $display("the queue is full");
$display("the wating time for the next person is %d and the empty flag is %b and the full flag is %b",Wtime_t,empty_flag_t,full_flag_t);
$display("the Pcount is %b the Tcount is %b",Pcount_t,Tcount_t);


end


endmodule

