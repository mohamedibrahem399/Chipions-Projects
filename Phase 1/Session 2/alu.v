module full_adder_1b (input a, b, cin, output sum, cout);
assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module a_s_8b (a8,b8,s,sum8,cout8);
input [7:0] a8,b8;
input s;
output [7:0] sum8;
output cout8;

wire [6:0] cin8;

full_adder_1b g0 (.a(a8[0]) , .b(s^b8[0]) , .cin(s)       , .sum(sum8[0]) , .cout(cin8[0]));
full_adder_1b g1 (.a(a8[1]) , .b(s^b8[1]) , .cin(cin8[0]) , .sum(sum8[1]) , .cout(cin8[1]));
full_adder_1b g2 (.a(a8[2]) , .b(s^b8[2]) , .cin(cin8[1]) , .sum(sum8[2]) , .cout(cin8[2]));
full_adder_1b g3 (.a(a8[3]) , .b(s^b8[3]) , .cin(cin8[2]) , .sum(sum8[3]) , .cout(cin8[3]));
full_adder_1b g4 (.a(a8[4]) , .b(s^b8[4]) , .cin(cin8[3]) , .sum(sum8[4]) , .cout(cin8[4]));
full_adder_1b g5 (.a(a8[5]) , .b(s^b8[5]) , .cin(cin8[4]) , .sum(sum8[5]) , .cout(cin8[5]));
full_adder_1b g6 (.a(a8[6]) , .b(s^b8[6]) , .cin(cin8[5]) , .sum(sum8[6]) , .cout(cin8[6]));
full_adder_1b g7 (.a(a8[7]) , .b(s^b8[7]) , .cin(cin8[6]) , .sum(sum8[7]) , .cout(cout8));

endmodule



module alu(ina,inb , opcode, carry_flag , zero_flag, out, cout);
input [7:0] ina,inb;
input [2:0] opcode;
output [7:0] out;
output cout;
output carry_flag,zero_flag;

reg [7:0] z;
wire [7:0] z1;
wire c;
a_s_8b g0(.a8(ina) , .b8(inb) , .s(opcode[0]) , .sum8(z1) , .cout8(c) );


assign zero_flag= (ina  == 8'b00000000) & (inb == 8'b00000000);
assign carry_flag = ina > inb;


always @( ina, inb , opcode)
case (opcode)

3'b000 : z=z1;
3'b001 : z=z1;
3'b010 : z= ina & inb;
3'b011 : z= ina | inb;

3'b100 : z= ina ^ inb;
3'b101 : z= ina > inb;
3'b110 : z= ina << 1;
3'b111 : z= inb << 1;

default : z= 8'b00000000;

endcase

assign out=z;
assign cout =c;


endmodule


module test_alu ;

reg [7:0] tina,tinb;
reg [2:0] topcode;
wire[7:0] tout;
wire tcout,tcarry_flag,t_zero_flag;


alu t(.ina(tina) , .inb(tinb) , .opcode(topcode) , .carry_flag(tcarry_flag) , .zero_flag(t_zero_flag) , .out(tout) ,.cout(tcout) );

initial

begin
tina= 8'b01010101; tinb= 8'b00011100;
topcode= 3'b000;

#100; topcode=3'b001;

#100; topcode=3'b010;
#100;
tinb= 8'b01010101; tina= 8'b00011100;
topcode= 3'b011;
#100;
tinb= 8'b01010101; tina= 8'b00011100;
topcode= 3'b100;

#100; topcode=3'b101;
#100; topcode=3'b110;
#100; topcode=3'b111;


end

endmodule