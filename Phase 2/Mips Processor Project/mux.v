module mux(
    Data_in_0,
    Data_in_1,
    sel,
    Data_out
    );
	 
    input [4:0] Data_in_0;
    input [4:0] Data_in_1;
    input sel;
    output reg [4:0] Data_out;

    always @(Data_in_0,Data_in_1,sel)
    begin
	case(sel)
		1'b1:
			begin
            			Data_out = Data_in_1;  
			end
		default
			begin
				 Data_out = Data_in_0;
			end
	endcase
  
    end
    
endmodule