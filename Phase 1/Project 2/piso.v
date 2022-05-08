module piso	(rst, frame_out, parity_type, stop_bits, data_length, send, baud_out, data_out, p_parity_out, tx_active, tx_done);

input  rst, stop_bits;//low when using 1 stop bit, high when using two stop bits.
input [1:0] parity_type;
input  data_length; //low when using 7 data bits, high when using 8.

input [11:0] frame_out;// 12 bit 8 or 7 data  
input send ; 

input baud_out;
output reg  tx_active = 0 ; 

output reg  tx_done= 0;

output reg  p_parity_out; // flag // parallel odd parity output, low when using the frame parity.

output reg data_out=1;		// Serial data_out

reg [7:0] data_in ;
assign data_in = frame_out[10 : 3];

reg [3:0] dl_counter=0; // for shift reg
reg [7:0] tmp; 
  
reg [3:0] i1=1;



always @(frame_out)
	begin
		data_in = frame_out[10 : 3];
		data_out=1;
		tx_active = 0;
		tx_done = 0;
		tmp =data_in;
		dl_counter=0;

	end


always @(posedge baud_out, posedge  rst)
	begin
	
		if (rst)
			begin
				data_out<=1;
				tx_active <= 0;
				tx_done <= 0;
				i1<=1;

			end

		else if(send==1  && tx_active== 0 && tx_done==0)
			begin
				
				tmp<=data_in;
				tx_active <=1;
				tx_done<=0;
				i1<=1;
			end
		else if ( tx_active == 1 && tx_done== 0 && i1==1)
			begin
	
				if(data_length== 1 && i1==1 ) // 8
					begin
					
        				data_out<=tmp[7];
					tmp <={tmp[6:0],1'b0};
					dl_counter <= dl_counter +1;
					i1 <= dl_counter<=6;
					
					end

			else if (data_length== 0 && i1==1 ) // 7
				begin

        				data_out <=tmp[7];    
					tmp <={tmp[6:0],1'b0};
					dl_counter <= dl_counter +1;
					i1 <= dl_counter <=5;
				end
			else 
				begin 
					data_out<=tmp[7];
					tmp<={tmp[6:0],1'b0};
				end
				
				
			end
		else if (i1 ==0 && tx_done== 0 )
			begin
				tx_active <=1;
				tx_done <=1;
				i1 <= 0;
				data_out <=1;

			end
		else if (i1 ==0 && tx_done==1)
			begin
				tx_active<=0;
				tx_done <=0;
				i1<=1;
				data_out<=1;
				dl_counter<=0;
			end
	end

always @(posedge baud_out)
begin
p_parity_out <= ~(parity_type[0] ^ parity_type[1]);
end

endmodule
