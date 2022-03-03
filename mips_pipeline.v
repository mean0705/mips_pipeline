module mips_pipeline( clk, rst );
	input clk, rst;
	
	wire[31:0] instr, instr_IF, instr_ID;
	
	wire [5:0] opcode, funct, funct_EX;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset, sll_result;
    wire [25:0] jumpoffset;
	
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr, jump_addr_EX, jump_addr_MEM;
				
	wire [4:0] rd_EX, rt_EX, rfile_wn_MEM, rfile_wn_EX;
	wire [31:0] pc_ID, pc_EX, pc_MEM, extend_immed_EX, alu_out_MEM, alu_out_WB, dmem_rdata_WB,		
                rfile_rd2_EX, rfile_rd2_MEM, rfile_rd1_EX;
				
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump,
	     RegWrite_EX, Branch_EX, RegDst_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUSrc_EX, Jump_EX,
		 RegWrite_MEM, Branch_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, Zero_MEM, Jump_MEM,
		 RegWrite_WB, MemtoReg_WB, NOPSrc, en_pc, en_mul, BNE, BNE_EX; 
	wire [6:0] maxcount, maxcount_ID, maxcount_EX;
    wire [1:0] ALUOp, ALUOp_EX;
    wire [2:0] Operation;


	reg_PC PC( .clk(clk), .rst(rst), .en_reg(en_pc), .d_in(pc_next), .d_out(pc) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );
		
	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr_IF) );
	
	mux2 #(32) NOPMUX( .sel(NOPSrc), .a(instr_IF), .b(32'd0), .y(instr) );
	
	nop_detector NOP( .clk(clk), .rst(rst), .instr(instr_IF), .en_pc(en_pc), .NOPSrc(NOPSrc), .maxcount(maxcount) );
	
	//-----------------------------IF/ID--------------------
	reg_IF2ID IF2ID( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(pc_incr), .d_in2(instr), .d_in3(en_pc), .d_in4(maxcount), .d_out1(pc_ID), .d_out2(instr_ID), .d_out3(en_pc_ID), .d_out4(maxcount_ID) );
	//-----------------------------IF/ID--------------------
	
	assign opcode = instr_ID[31:26];
    assign rs = instr_ID[25:21];
    assign rt = instr_ID[20:16];
    assign rd = instr_ID[15:11];
    assign shamt = instr_ID[10:6];
    assign funct = instr_ID[5:0];
    assign immed = instr_ID[15:0];
    assign jumpoffset = instr_ID[25:0];
	
	
	assign jump_addr = { pc_ID[31:28], jumpoffset << 2 };
	
	reg_file RegFile( .clk(clk), .RegWrite(RegWrite_WB), .RN1(rs), .RN2(rt), .WN(rfile_wn), .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );	
	
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );
	
    control CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), ._BNE(BNE) );
					   	
	//-----------------------------ID/EX--------------------			
	reg_Control_IDEX IDEX( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(RegWrite), .d_in2(MemtoReg), .d_in3(MemRead), .d_in4(MemWrite), .d_in5(Branch), .d_in6(ALUSrc), .d_in7(ALUOp), .d_in8(RegDst), .d_in9(en_pc_ID), .d_in10(BNE), .d_in11(Jump),  .d_in12(maxcount_ID), 
                      	.d_out1(RegWrite_EX), .d_out2(MemtoReg_EX), .d_out3(MemRead_EX), .d_out4(MemWrite_EX), .d_out5(Branch_EX), .d_out6(ALUSrc_EX), .d_out7(ALUOp_EX), .d_out8(RegDst_EX), .d_out9(en_pc_EX), .d_out10(BNE_EX), .d_out11(Jump_EX), .d_out12(maxcount_EX) );			
						
	reg_ID2EX ID2EX( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(pc_ID), .d_in2(rfile_rd1), .d_in3(rfile_rd2), .d_in4(extend_immed), .d_in5(rd), .d_in6(rt), .d_in7(funct), .d_in8(jump_addr),
                      	.d_out1(pc_EX), .d_out2(rfile_rd1_EX), .d_out3(rfile_rd2_EX), .d_out4(extend_immed_EX), .d_out5(rd_EX), .d_out6(rt_EX), .d_out7(funct_EX), .d_out8(jump_addr_EX));						
	//-----------------------------ID/EX--------------------
	
	assign b_offset = extend_immed_EX << 2;	
		
    add32 BRADD( .a(pc_EX), .b(b_offset), .result(b_tgt) );
	
	alu_ctl ALUCTL( .ALUOp(ALUOp_EX), .Funct(funct_EX), .ALUOperation(Operation), .nop(en_pc_EX), .en_mul(en_mul), .maxcount(maxcount_EX) );
	
	ALU_32bits ALU( .A(rfile_rd1_EX), .B(alu_b), .SIG(Operation), .dataOut(alu_out), .zero(Zero), .shamt(extend_immed_EX[10:6]), .en_mul(en_mul), .BNE(BNE_EX), .clk(clk), .rst(rst) );
	
    mux2 #(32) ALUMUX( .sel(ALUSrc_EX), .a(rfile_rd2_EX), .b(extend_immed_EX), .y(alu_b) );	
	mux2 #(5) RFMUX( .sel(RegDst_EX), .a(rt_EX), .b(rd_EX), .y(rfile_wn_EX) );


	//-----------------------------EX/MEM--------------------	
	reg_Control_EXMEM EXMEM( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(RegWrite_EX), .d_in2(MemtoReg_EX), .d_in3(MemRead_EX), .d_in4(MemWrite_EX), .d_in5(Branch_EX), .d_in6(Jump_EX),  
							.d_out1(RegWrite_MEM), .d_out2(MemtoReg_MEM), .d_out3(MemRead_MEM), .d_out4(MemWrite_MEM), .d_out5(Branch_MEM), .d_out6(Jump_MEM) );
	reg_EX2MEM EX2MEM( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(b_tgt), .d_in2(Zero), .d_in3(alu_out), .d_in4(rfile_rd2_EX), .d_in5(rfile_wn_EX), .d_in6(jump_addr_EX),
                      	.d_out1(pc_MEM), .d_out2(Zero_MEM), .d_out3(alu_out_MEM), .d_out4(rfile_rd2_MEM), .d_out5(rfile_wn_MEM), .d_out6(jump_addr_MEM) );			
	//-----------------------------EX/MEM--------------------
	
	
    and BR_AND(PCSrc, Branch_MEM, Zero_MEM);

	memory DatMem( .clk(clk), .MemRead(MemRead_MEM), .MemWrite(MemWrite_MEM), .wd(rfile_rd2_MEM), .addr(alu_out_MEM), .rd(dmem_rdata) );	   
				   
	mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(pc_MEM), .y(branch_addr) );
    mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr_MEM), .y(pc_next) );	
				   
	//-----------------------------MEM/WB--------------------
	reg_Control_MEMWB MEMWB( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(RegWrite_MEM), .d_in2(MemtoReg_MEM), .d_out1(RegWrite_WB), .d_out2(MemtoReg_WB) );
	
	reg_MEM2WB MEM2WB( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in1(dmem_rdata), .d_in2(alu_out_MEM), .d_in3(rfile_wn_MEM), .d_out1(dmem_rdata_WB), .d_out2(alu_out_WB), .d_out3(rfile_wn) );
	//-----------------------------MEM/WB--------------------

	
	mux2 #(32) WRMUX( .sel(MemtoReg_WB), .a(alu_out_WB), .b(dmem_rdata_WB), .y(rfile_wd) );		

	
endmodule
