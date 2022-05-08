module InstructionMemory(PC,inst);

input [31:0]PC;
output reg [31:0]inst;

reg [31:0] instructions [0:255];


// There should be an instruction file to load instructions from it
 
initial begin
	$readmemh("file.txt",instructions);
end

always@(PC)
begin
	inst <= instructions[PC];
end

endmodule 