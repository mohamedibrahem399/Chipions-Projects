module counter (clk,rst,pcount ,pci , pco , ef , ff, H );

input clk , rst , pci ,pco ;

output [2:0] pcount ; 
output ef ,ff ,H ;

reg [2:0] pcount = 3'b000;

reg ef_1 = 1;
reg ff_1 = 0;

reg H ;
reg add; 

always @(posedge clk, rst )
begin
H <= (~pci & ~pco) | (pco & pci) | (pco & ef_1) | (pci & ff_1);
add <= (pci & ~pco);
if(rst)
	begin
	pcount <= 0;
	ff_1 <= 0;
	ef_1<= 1;
		
end

else if (H==1 )
pcount <= pcount ;

else if (add == 1)
begin 

	if (pcount <= 3'b110 || ef_1==1)
	begin
	pcount <= pcount +1 ;
	ff_1 <= 1'b0;
	ef_1<=  1'b0;
	end
	else if( 3'b110 < pcount )
	begin
	pcount <= pcount;
	ff_1 <=1;
	ef_1 <=0;
	end
end 


else if (add == 0) 
begin
	if(3'b000 < pcount <= 3'b111)
	begin
	pcount <= pcount-1;
	ff_1=0;
	ef_1=0;
	end
	if (pcount == 3'b000)
	begin
	ef_1 <= 1'b1 ;
	ff_1=0;
	pcount <= pcount;
	end
end 

end
assign ef = ef_1;
assign ff = ff_1;


endmodule
