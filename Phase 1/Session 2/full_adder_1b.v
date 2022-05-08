module full_adder_1b (input a, b, cin, output sum, cout);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule

module full_adder_test; 

reg ta, tb, tcin;
wire tsum , tcout;

full_adder_1b t (.a(ta) , .b(tb) , .cin(tcin) , .sum(tsum) , .cout(tcout));
initial 
begin
ta= 1'b0; tb= 1'b0;  tcin= 1'b0;

#100;
ta= 1'b0 ; tb= 1'b0 ; tcin= 1'b1 ;


#100;
ta= 1'b0 ; tb= 1'b1 ; tcin= 1'b0 ;

#100;
ta= 1'b0 ; tb= 1'b1 ; tcin= 1'b1 ;

#100;
ta= 1'b1 ; tb= 1'b0 ; tcin= 1'b0 ;

#100;
ta= 1'b1 ; tb= 1'b0 ; tcin= 1'b1 ;

#100;
ta= 1'b1 ; tb= 1'b1 ; tcin= 1'b0 ;

#100;
ta= 1'b1 ; tb= 1'b1 ; tcin= 1'b1 ;

end



endmodule
