module full_adder_1b (input a, b, cin, output sum, cout);
	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (a & cin) | (b & cin);
endmodule

module a_s_8b (a8,b8,s,sum8,cout8);
  input [7:0] a8,b8;
  input s;
  wire[6:0] cin8;
  output [7:0] sum8;
  output cout8;

	full_adder_1b g0 (.a(a8[0]) , .b(s^b8[0]) , .cin(s) , .sum(sum8[0]) , .cout(cin8[0]));
	full_adder_1b g1 (.a(a8[1]) , .b(s^b8[1]) , .cin(cin8[0]) , .sum(sum8[1]) , .cout(cin8[1]));
	full_adder_1b g2 (.a(a8[2]) , .b(s^b8[2]) , .cin(cin8[1]) , .sum(sum8[2]) , .cout(cin8[2]));
	full_adder_1b g3 (.a(a8[3]) , .b(s^b8[3]) , .cin(cin8[2]) , .sum(sum8[3]) , .cout(cin8[3]));
	full_adder_1b g4 (.a(a8[4]) , .b(s^b8[4]) , .cin(cin8[3]) , .sum(sum8[4]) , .cout(cin8[4]));
	full_adder_1b g5 (.a(a8[5]) , .b(s^b8[5]) , .cin(cin8[4]) , .sum(sum8[5]) , .cout(cin8[5]));
	full_adder_1b g6 (.a(a8[6]) , .b(s^b8[6]) , .cin(cin8[5]) , .sum(sum8[6]) , .cout(cin8[6]));
	full_adder_1b g7 (.a(a8[7]) , .b(s^b8[7]) , .cin(cin8[6]) , .sum(sum8[7]) , .cout(cout8));

endmodule

module a_s_8b_test;
  reg [7:0] ta8,tb8;
  reg ts;
  wire [7:0] tsum8;
  wire tcout8;

	a_s_8b g0 (.a8(ta8) , .b8(tb8) , .s(ts) , .sum8(tsum8) , .cout8(tcout8));

  initial 

	begin
	  ta8= 8'b00001111;
	  tb8= 8'b00001100;

	  ts= 1'b0;

	  #100;
 	  ts= 1'b1;

	  #100
	  ta8= 8'b01010110;
	  tb8= 8'b00111111;
	  ts=1'b0;

	  #100
	  ts=1'b1;
  end

endmodule