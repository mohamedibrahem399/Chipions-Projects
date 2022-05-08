module DataMemory(Address,WriteData,ReadData,WriteEnable,CLK);
//WriteEnable == MemWrite
input WriteEnable,CLK;
input [31:0] Address,WriteData;

output reg [31:0]ReadData;

reg [31:0] memory [0:255];
integer i;

initial begin
	for(i=0;i<256;i=i+1) memory[i]<=0;
end


always@(posedge CLK)
begin
	if(WriteEnable)
		begin
			memory[Address]<= WriteData;
			ReadData <= memory[Address];// hena lazem a3mel store w ab3at ba3daha 3alla shan ana keda keda bab3at data.
		end
	else ReadData <= memory[Address];
end



endmodule
