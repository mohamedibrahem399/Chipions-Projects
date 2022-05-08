module Mux_2bits_sel_32bit(Data_in_0, Data_in_1, Data_in_2, sel, Data_out);
	 
    input [31:0] Data_in_0;
    input [31:0] Data_in_1,Data_in_2;
    input [1:0] sel;
    output reg[31:0] Data_out;

    always @(Data_in_0,Data_in_1,sel)
    begin
        case(sel)
		2'b00:
			begin
            			Data_out = Data_in_0;  
			end
		2'b01:
			begin
            			Data_out = Data_in_1;  
			end			
		2'b10:
			begin
            			Data_out = Data_in_2;  
			end
		default
			begin
				 Data_out = Data_out;
			end
	endcase
  
    end

endmodule 
