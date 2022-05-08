module jkff (j,k,q,clk,reset);
input j,k,clk,reset;
output q;
reg q;
always @(posedge clk , posedge reset)
begin 

if (reset)
	q = 0;
else
	begin 
		if (j==0 & k==0) //hold
			q = q;
		else if (j==0 & k==1) // reset
			q = 0 ;
		else if (j==1 & k==0)// set
			q = 1;
		else if (j==1 & k==1) // toggle 
			q = !q;

	end

end

endmodule

