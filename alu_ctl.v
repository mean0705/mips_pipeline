module alu_ctl( ALUOp, Funct, ALUOperation, nop, en_mul, maxcount );
	input nop;
    input [1:0] ALUOp;
    input [5:0] Funct;
	input [6:0] maxcount;
	output reg en_mul;
    output reg [2:0] ALUOperation;

    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	parameter F_sll = 6'd0;
	parameter F_multu = 6'd25;
	parameter F_mfhi = 6'd16;
	parameter F_mflo = 6'd18;

    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;
	parameter ALU_sll = 3'b101;
	parameter ALU_mfhi = 3'b011;
	parameter ALU_mflo = 3'b100;
	

    always @(ALUOp or Funct)
    begin
        case (ALUOp) 
            2'b00 : ALUOperation = ALU_add;
            2'b01 : ALUOperation = ALU_sub;
            2'b10 : case (Funct) 
                        F_add : ALUOperation = ALU_add;
                        F_sub : ALUOperation = ALU_sub;
                        F_and : ALUOperation = ALU_and;
                        F_or  : ALUOperation = ALU_or;
                        F_slt : ALUOperation = ALU_slt;
						F_sll : ALUOperation = ALU_sll;
						F_mfhi : ALUOperation = ALU_mfhi;
						F_mflo : ALUOperation = ALU_mflo;
                        default ALUOperation = 3'bxxx;
                    endcase
            default ALUOperation = 3'bxxx;
        endcase
		
		if ( Funct == F_multu && !nop ) en_mul = 1'b1;
		else if ( Funct == F_sll && !nop && maxcount == 7'd32 ) en_mul = 1'b1; // normal nop
		else en_mul = 1'b0;
    end
endmodule

