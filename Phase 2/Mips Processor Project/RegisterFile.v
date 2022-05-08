module RegisterFile(ReadingReg1,ReadingReg2,WriteReg,WriteData,ReadingData1,ReadingData2,WriteEnable,CLK);
input WriteEnable, CLK;
input [4:0] ReadingReg1,ReadingReg2, WriteReg; // A1, A2, A3;
input [31:0] WriteData;

output reg [31:0] ReadingData1,ReadingData2;

// array of 32 register each one of them 32 bit

reg [31:0] file [0:31];

initial begin
	$readmemh("RegValues.txt",file);
end

always@(posedge CLK)
begin
	case(WriteEnable)
	1:
		begin	
			file[WriteReg] <= WriteData;
			ReadingData1 <= file[ReadingReg1];
			ReadingData2 <= file[ReadingReg2];
		end
	default:
		begin
			ReadingData1 <= file[ReadingReg1];
			ReadingData2 <= file[ReadingReg2];
		end
	endcase

end

endmodule 
