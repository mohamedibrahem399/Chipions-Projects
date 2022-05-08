module ALU(
           input [31:0] SrcA,SrcB,                   
           input [2:0] ALUControl,
           output [31:0] ALU_Out, 
           output CarryOut ,
	   output zeroflag 
    );
    reg [31:0] ALU_Result;
//    reg zf ;
    wire [32:0] tmp;
    assign ALU_Out = ALU_Result; 
 //   assign zeroflag = zf ;
    assign tmp = {1'b0,SrcA} + {1'b0,SrcB};
    assign CarryOut = tmp[32];
    assign zeroflag = ALU_Result == 0;
    always @(*)
    begin

	case (ALUControl)
		3'b000: //  Logical and 
			begin
				ALU_Result = SrcA & SrcB;
			end
		3'b001: // Logical or
			begin
				ALU_Result = SrcA | SrcB;
			end
		3'b010: // Addition
			begin
				 ALU_Result = SrcA  + SrcB ;
			end
		3'b100: // Logical nand 
			begin
				ALU_Result = ~(SrcA & SrcB);
			end
		3'b101: //  Logical nor
			begin
				ALU_Result = ~(SrcA | SrcB);
			end
		3'b110: // Subtraction
			begin
				 ALU_Result = SrcA - SrcB ;
			end
		3'b111: // SLT
			begin
				ALU_Result = (SrcA<SrcB)?32'd1:32'd0 ;
			end
		default
			begin
				ALU_Result = ALU_Result;
			end
	endcase


		/*  
		  if (ALU_Result == 0)
		     zf = 1 ;
		  else 
		     zf= 0 ;*/
    end

endmodule
