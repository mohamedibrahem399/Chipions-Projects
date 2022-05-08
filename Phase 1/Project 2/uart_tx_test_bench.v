module uart_tx_test ;

reg clk_t = 1;
reg  		rst, send, stop_bits, data_length;
reg [1:0] 	buad_rate;
reg [1:0] 	parity_type;
reg [7:0] 	data_in;

wire data_out , p_parity_out ,tx_active , tx_done;

uart_tx U1 (clk_t, rst, send ,buad_rate , data_in , parity_type , stop_bits , data_length ,data_out , p_parity_out ,tx_active , tx_done);


initial 
begin 
	forever begin
	clk_t=clk_t;
	#20ns clk_t <=~clk_t;
	end
end

initial 
begin 

// 1st trail with baud rate == 2'b11 //19.2k bauds === 162 clk  // we need 1 and zero of baud_out == 162*2= 324 clk (full baud_out_clk)
// reset the data

$monitor ( " make the run time 648 ");

buad_rate = 2'b11;

rst = 1 ;
send =0 ;
data_in = 8'b01010110;
parity_type = 2'b00 ;
stop_bits = 0;
data_length = 1; // 8 bits

#648// stopping the reset or setting the values

rst = 0 ;
buad_rate = 2'b11;
send =0 ;
data_in = 8'b01010110;
parity_type = 2'b10 ;
stop_bits = 0;
data_length = 1;

// sending process
#648 // start sending
send =1 ;
$monitor ( " make the run time 324 and press once then make it 648 again ");

#648 // sending process 1
send=1;


#648 // sending process 2
send=1;


#648 // sending process 3
send=1;


#648 // sending process 4
send=1;


#648 // sending process 5
send=1;


#648 // sending process 6
send=1;

#648 // sending process 7
send=1;


#648 // sending process 8
send=1;

#648 //  sending final
send =1 ;


$monitor ( " changing data length ");
#648 // changing data length
data_length = 0;
send=0;

// sending process
#648 // start sending
send =1 ;

#648 // sending process 1
send=1;


#648 // sending process 2
send=1;


#648 // sending process 3
send=1;


#648 // sending process 4
send=1;


#648 // sending process 5
send=1;


#648 // sending process 6
send=1;

#648 // sending process 7
send=1;


#648 // sending process 8
send=1;

#648 // sending final
send =1 ;

$monitor ( " changing the parity type and resetting stop_bits ");
#648 // changing the parity type and resetting stop_bits 
parity_type = 2'b01 ;
stop_bits = 0;
send=0;

#648
parity_type = 2'b11 ;

#648
parity_type = 2'b00 ;


//.-.-.-.-.-.-.-.-.-.--..-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
$monitor ( " trying another data input so start again the same things and stop bits ");
#648 // trying another data input so start again the same things ajd stop bits

data_in = 8'b01101110;
parity_type = 2'b10 ;
stop_bits = 1;
data_length = 1;
send=0;

// sending process
#648 // start sending
send =1 ;

#648 // sending process 1
send=1;


#648 // sending process 2
send=1;


#648 // sending process 3
send=1;


#648 // sending process 4
send=1;


#648 // sending process 5
send=1;


#648 // sending process 6
send=1;

#648 // sending process 7
send=1;


#648 // sending process 8
send=1;

#648 // sending final
send =1 ;

$monitor ( " changing the parity type and resetting stop_bits ");
#648 // changing the parity type and resetting stop_bits 
parity_type = 2'b01 ;
stop_bits = 0;
send=0;

#648
parity_type = 2'b11 ;

#648
parity_type = 2'b00 ;


//.-.-.-.-.-.-.-.-.-.--..-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
//.-.-.-.-.-.-.-.-.-.--..-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-
$monitor ( " 2nd trail with baud rate == 2'b10 // 9600 baud == 325 , we use 325*2 = 650    //1300");
$monitor ( " make the run time 1300 ");
#1300

// 2nd trail with baud rate == 2'b10 // 9600 baud == 325 , we use 325*2 = 650    //1300
// resetting data 

buad_rate = 2'b10;
rst = 1 ;
send =0 ;
data_in = 8'b01010110;
parity_type = 2'b10 ;
stop_bits = 0;
data_length = 1;

#1300// stopping the reset or setting the values
rst = 0 ;
buad_rate = 2'b10;
send =0 ;
data_in = 8'b10101110;
parity_type = 2'b00 ;
stop_bits = 0;
data_length = 0;

// sending process
#1300 // start sending
send =1 ;

#1300 // sending process 1
send=1;


#1300 // sending process 2
send=1;


#1300 // sending process 3
send=1;


#1300 // sending process 4
send=1;


#1300 // sending process 5
send=1;


#1300 // sending process 6
send=1;

#1300 // sending process 7
send=1;


#1300 // sending process 8
send=1;

#1300 // sending final
send =1 ;

// the others baud_rates are the same idea but with bigger delays
end
endmodule 
