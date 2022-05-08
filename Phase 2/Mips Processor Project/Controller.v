module controller(op, funct, Memtoreg, MemWrite, Branch, ALUControl, ALUSrc, RegDst, RegWrite,jump);

input [5:0] op, funct;
output [2:0] ALUControl;
output  MemWrite, Branch, ALUSrc, RegWrite,jump;
output [1:0]  RegDst,Memtoreg;
wire [1:0] ALUOP;

Controller_Main_Decoder a1 (.op(op), .Memtoreg(Memtoreg), .MemWrite(MemWrite), .Branch(Branch), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .ALUOP(ALUOP),.jump(jump));
Controller_ALU_Decoder a2 (.funct(funct), .ALUOP(ALUOP), .ALUControl(ALUControl));
endmodule

