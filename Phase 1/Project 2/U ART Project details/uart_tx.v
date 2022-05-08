//Use this as a template design, follow the information available here, 
//follow the port names, widths, and data provided for them.
//For any unclear information, please refer to other documents provided in this folder. 


/*-------------------------------------------parity_type-------------------------------------------*/
// 00	no parity.										
// 01	odd parity.										
// 10	even parity.									
// 11	use the output parity_out as an odd parity bit and no parity in the serial frame(like 00). 
/*-------------------------------------------------------------------------------------------------*/

/*----baud_rate----*/
// 00	2400 baud.										
// 01	4800 baud.										
// 10	9600 baud.									
// 11	19.2K baud. 
/*----------------*/

//Assume the system clock frequency, for frequency division, is 50MHz.

module uart_tx(
	//DO NOT EDIT any part of this port declaration
	input 		clock, rst, send,
	input [1:0]	buad_rate,
	input [7:0] data_in, 
	input [1:0] parity_type, 	//refer to the block comment above. 
	input 		stop_bits, 		//low when using 1 stop bit, high when using two stop bits
	input 		data_length, 	//low when using 7 data bits, high when using 8.
	
	output reg 	data_out, 		//Serial data_out
	output reg 	p_parity_out, 	//parallel odd parity output, low when using the frame parity.
	output reg 	tx_active, 		//high when Tx is transmitting, low when idle.
	output reg 	tx_done 		//high when transmission is done, low when not.
);

	//You MAY EDIT these signals, or module instantiations.
	reg parity_out, baud_out;
	reg [10:0] frame_out;
	
	//sub_modules
	parity		parity_gen1 (rst, data_in, parity_type, parity_out);
	frame_gen	frame_gen1  (rst, data_in, parity_out, parity_type, stop_bits, data_length, frame_out);
	baud_gen	baud_gen1	(rst, clock, baud_rate, baud_out);
	
	piso		shift_reg1	(rst, frame_out, parity_type, stop_bits, data_length, send, baud_out, data_out, p_parity_out, tx_active, tx_done);
	

endmodule