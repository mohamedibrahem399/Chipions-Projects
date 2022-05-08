module Top_Module(CLK,PC_IN);
input CLK;
input [31:0] PC_IN;
wire [31:0] PC_IN ;//= 32'h00000001; // inst == (op(31:26), A1(25:21), A2(20:16), A3(15:11), SignExtend(15:0), funct(5:0))
//32'b000000 10001 00011   01010   01000    100000:
//32'b OP     A1   A2|A3  A3    SignExtend  funct
//32'b 6 bits   5 bits  5 bits   5 bits    5+5+6 bits     6 bits
assign PC_IN = 32'h00000001;
wire [31:0] PC_OUT,PCPlus4,PCBranch;

wire [31:0] inst;

wire [2:0] ALUControl;

wire  MemWrite, Branch, ALUSrc, RegWrite,jump;
wire [1:0]  RegDst,Memtoreg;

wire [4:0] WriteReg;

wire [31:0] WriteData, ReadingData1, ReadingData2,WriteData_final ;

wire [31:0] Signlmm,SrcB;
wire [31:0] ALU_Out;
wire CarryOut,zeroflag;

wire [31:0] jump_address;
wire [31:0] PC_Behind_jump;

//wire PCSrc;

MAIN_CLK a1(.CLK(CLK),.PC_IN(PC_IN), .PC_OUT(PC_OUT));

InstructionMemory a2 (.PC(PC_OUT),.inst(inst));

RegisterFile  a3 (.ReadingReg1(inst[25:21]), .ReadingReg2(inst[20:16]), .WriteReg(WriteReg), .WriteData(WriteData_final), .ReadingData1(ReadingData1), .ReadingData2(ReadingData2), .WriteEnable(RegWrite), .CLK(CLK));

controller a4 (.op(inst[31:26]), .funct(inst[5:0]), .Memtoreg(Memtoreg), .MemWrite(MemWrite), .Branch(Branch), .ALUControl(ALUControl), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite),.jump(jump));
//Controller_Main_Decoder c1 (.op(inst[31:26]), .Memtoreg(Memtoreg), .MemWrite(MemWrite), .Branch(Branch), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .ALUOP(ALUOP),.jump(jump));
//Controller_ALU_Decoder c2 (.funct(inst[5:0]), .ALUOP(ALUOP), .ALUControl(ALUControl));

Mux_2bits_sel M1 (.Data_in_0(inst[20:16]) , .Data_in_1(inst[15:11]) , .Data_in_2(5'b11111) , .sel(RegDst) , .Data_out(WriteReg));
//mux  M1 ( .Data_in_0(inst[20:16]) , .Data_in_1(inst[15:11]) , .sel(RegDst) , .Data_out(WriteReg) );

SignExtend a5(.in(inst[15:0]), .out(Signlmm));

mux32bit M2( .Data_in_0(ReadingData2) , .Data_in_1(Signlmm) , .sel(ALUSrc) , .Data_out(SrcB));

ALU a6( .SrcA(ReadingData1) , .SrcB(SrcB) , .ALUControl(ALUControl) , .ALU_Out(ALU_Out) , .CarryOut(CarryOut) , .zeroflag(zeroflag) );

DataMemory a7(.Address(ALU_Out) , .WriteData(ReadingData2) , .ReadData(WriteData) , .WriteEnable(MemWrite) , .CLK(CLK) );


Mux_2bits_sel_32bit M6(.Data_in_0(ALU_Out) , .Data_in_1(WriteData), .Data_in_2(PCPlus4),.sel(Memtoreg),.Data_out(WriteData_final));
//mux32bit M3( .Data_in_0(ALU_Out) , .Data_in_1(WriteData) , .sel(Memtoreg) , .Data_out(WriteData_final));

Adder add1 ( .a(PC_OUT) , .b(0+3'b100) , .sum(PCPlus4) );

Adder add2 ( .a(Signlmm <<2) , .b(PCPlus4) , .sum(PCBranch) );

//assign PCSrs = zeroflag & Branch;

mux32bit M4( .Data_in_0(PCPlus4) , .Data_in_1(PCBranch) , .sel(zeroflag & Branch) , .Data_out(PC_Behind_jump));

assign jump_address = {PCPlus4[31:28],inst[25:0],2'b00};

mux32bit M5( .Data_in_0(PC_Behind_jump) , .Data_in_1(jump_address) , .sel(jump) , .Data_out(PC_IN));


endmodule
