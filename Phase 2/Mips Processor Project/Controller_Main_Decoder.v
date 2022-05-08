module Controller_Main_Decoder(op, Memtoreg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, ALUOP,jump);

input [5:0] op;
output reg [1:0]  RegDst,Memtoreg;
output reg  MemWrite, Branch, ALUSrc, RegWrite,jump;
output reg [1:0] ALUOP;


always @(op)
begin
	case(op)
		6'b000000:  // add or sup
			begin
				RegWrite =1;
				RegDst	 =2'b01;
				ALUSrc	 =0;
				Branch	 =0;
				MemWrite =0;
				Memtoreg =2'b00;
				ALUOP    =2'b10;
				jump     =0    ;
			end
		6'b100011:  //lw
			begin
				RegWrite =1    ;
				RegDst	 =2'b00;
				ALUSrc	 =1    ;
				Branch	 =0    ;
				MemWrite =0    ;
				Memtoreg =2'b01;
				ALUOP    =2'b00;
				jump     =0    ;
			end
		6'b101011:  //sw
			begin
				RegWrite =0    ;
			//	RegDst	 =2'bxx;
				ALUSrc	 =1    ;
				Branch	 =0    ;
				MemWrite =1    ;
			//	Memtoreg =2'bxx;
				ALUOP    =2'b00;
				jump     =0    ;
			end
		6'b000100:  //beq
			begin
				RegWrite =0    ;
			//	RegDst	 =2'bxx;
				ALUSrc	 =0    ;
				Branch	 =1    ;
				MemWrite =0    ;
			//	Memtoreg =2'bxx;
				ALUOP    =2'b01;
				jump     =0    ;
			end
		6'b001000:  //addi
			begin
				RegWrite =1    ;
				RegDst	 =2'b00;
				ALUSrc	 =1    ;
				Branch	 =0    ;
				MemWrite =0    ;
				Memtoreg =2'b00;
				ALUOP    =2'b00;
				jump     =0    ;
			end
		6'b001101:  //ori
			begin
				RegWrite =1    ;
				RegDst	 =2'b00;
				ALUSrc	 =1    ;
				Branch	 =0    ;
				MemWrite =0    ;
				Memtoreg =2'b00;
				ALUOP    =2'b11;
				jump     =0    ;
			end
		6'b000010:  //j
			begin
				RegWrite =0    ;
			//	RegDst	 =2'bxx;
			//	ALUSrc	 =x    ;
			//	Branch	 =x    ;
				MemWrite =0    ;
			//	Memtoreg =2'bxx;
			//	ALUOP    =2'bxx;
				jump     =1    ;
			end
		6'b000010:  //jal
			begin
				RegWrite =1    ;
				RegDst	 =2'b10;
			//	ALUSrc	 =x    ;
			//	Branch	 =x    ;
				MemWrite =0    ;
				Memtoreg =2'b10;
			//	ALUOP    =2'bxx;
				jump     =1    ;
			end
		default 
			begin
				RegWrite =RegWrite    ;
				RegDst	 =RegDst   ;
				ALUSrc	 =ALUSrc    ;
				Branch	 =Branch    ;
				MemWrite =MemWrite    ;
				Memtoreg =Memtoreg    ;
				ALUOP    =ALUOP ;
				jump     =jump;
			end




	endcase	

end

endmodule