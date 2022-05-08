module Controller_ALU_Decoder(funct, ALUOP, ALUControl);

input [1:0] ALUOP;
input [5:0] funct;

output reg [2:0] ALUControl;

always @(ALUOP, funct)
begin

	case(ALUOP)
		2'b00: 
			begin
				ALUControl =010;//add
			
			end
		2'b01: 
			begin
				ALUControl =110;//subtract
			end
		2'b10: 
			begin
				case(funct)
					6'b100000: //add
						begin
							ALUControl =010;
						end
					6'b100010: //sub
						begin
							ALUControl =110;
						end
					6'b100100://and
						begin
							ALUControl =000;
						end
					6'b100101://or
						begin
							ALUControl =001;
						end
					6'b101010://slt
						begin
							ALUControl =111;
						end
					default
						begin
							ALUControl =010;//add
						end
				endcase
			end
		2'b11://or
			begin
				ALUControl =001;
			end

		default 
			begin
				ALUControl=ALUControl;

			end

	endcase	

end

endmodule
