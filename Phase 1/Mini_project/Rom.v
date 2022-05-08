module new_rom(index,clk,ef,ff,reset,wtime);
input [4:0] index;//index is a five-bit number - the 2-MSBs is tcount | the 3-LSBs is pcount 
input clk,ef,ff,reset;
output [4:0] wtime;
function [4:0] wait_time;
input [4:0] fn_input,empty_flag,full_flag,reset_;

begin
	//reset
	if(reset==1) begin
	fn_input=0;
	wait_time=5'b0000;
	end
	//empty flag check
	else if (ef==1)//no of people ==1, no of teller==1
	wait_time=5'b0000;
	//full flag check
	else if (ff==1) wait_time=5'b11111;

//tcount=1
	else if (1==1)
	begin
	case (fn_input)
	5'b01001: wait_time=5'b00011;	//pcount =1 --wtime=3
	5'b01010: wait_time=5'b00110;	//pcount =2 --wtime=6
	5'b01011: wait_time=5'b01001;	//pcount =3 --wtime=9
	5'b01100: wait_time=5'b01100;	//pcount =4 --wtime=12
	5'b01101: wait_time=5'b01111;	//pcount =5 --wtime=15
	5'b01110: wait_time=5'b10010;	//pcount =6 --wtime=18
	5'b01111: wait_time=5'b10101;	//pcount =7 --wtime=21
//tcount=2

	5'b10001: wait_time=5'b00011;   //pcount =1 --wtime=3
	5'b10010: wait_time=5'b00101;   //pcount =2 --wtime=5
	5'b10011: wait_time=5'b00110;   //pcount =3 --wtime=6
	5'b10100: wait_time=5'b01000;   //pcount =4 --wtime=8
	5'b10101: wait_time=5'b01001;   //pcount =5 --wtime=9
	5'b10110: wait_time=5'b01011;   //pcount =6 --wtime=11
	5'b10111: wait_time=5'b01100;   //pcount =7 --wtime=12
//tcount=3

	5'b11001: wait_time=5'b00011;   //pcount =1 --wtime=3
	5'b11010: wait_time=5'b00100;   //pcount =1 --wtime=4
	5'b11011: wait_time=5'b00101;   //pcount =1 --wtime=5
	5'b11100: wait_time=5'b00110;   //pcount =1 --wtime=6
	5'b11101: wait_time=5'b00111;   //pcount =1 --wtime=7
	5'b11110: wait_time=5'b01000;   //pcount =1 --wtime=8
	5'b11111: wait_time=5'b01001;   //pcount =1 --wtime=9
//default
	default: wait_time=5'b0000;

endcase 
end


end
endfunction

assign wtime=wait_time(index,ef,ff,reset);
endmodule

