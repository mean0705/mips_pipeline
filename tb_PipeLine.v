module tb_PipeLine();
	reg clk, rst;
	
	initial begin
		clk = 1;
		forever #5 clk = ~clk;
	end

	initial begin
		rst = 1'b1;
		$readmemh("test.txt", CPU.InstrMem.mem_array );
		$readmemh("data_mem.txt", CPU.DatMem.mem_array );
		$readmemh("reg.txt", CPU.RegFile.file_array );
		#10;
		rst = 1'b0;
	end
	
	always @( posedge clk ) begin
		$display( "%d, PC:", $time/10-1, CPU.pc );
		
		if ( CPU.instr[31:26] == 6'd0 ) begin
			if ( CPU.instr[5:0] == 6'd0 ) begin
			  if ( CPU.instr == 32'd0 ) $display( "%d, fetching : NOP", $time/10-1 );
			  else $display( "%d, fetching : SLL", $time/10-1 );
			end
			else if ( CPU.instr[5:0] == 6'd32 ) $display( "%d, fetching : ADD", $time/10-1 );
			else if ( CPU.instr[5:0] == 6'd34 ) $display( "%d, fetching : SUB", $time/10-1 );
			else if ( CPU.instr[5:0] == 6'd36 ) $display( "%d, fetching : AND", $time/10-1 );
			else if ( CPU.instr[5:0] == 6'd37 ) $display( "%d, fetching : OR", $time/10-1 );
			else if ( CPU.instr[5:0] == 6'd42 ) $display( "%d, fetching : SLT", $time/10-1 );
			else if ( CPU.instr[5:0] == 6'd25 ) $display( "%d, fetching : MULTU", $time/10-1 );		
			else if ( CPU.instr[5:0] == 6'd16 ) $display( "%d, fetching : MFHI", $time/10-1 );
			else if ( CPU.instr[5:0] == 6'd18 ) $display( "%d, fetching : MFLO", $time/10-1 );
		end
		else if ( CPU.instr[31:26] == 6'd35 ) $display( "%d, fetching : LW", $time/10-1 );
		else if ( CPU.instr[31:26] == 6'd43 ) $display( "%d, fetching : SW", $time/10-1 );
		else if ( CPU.instr[31:26] == 6'd4 ) $display( "%d, fetching : BEQ", $time/10-1 );
		else if ( CPU.instr[31:26] == 6'd2 ) $display( "%d, fetching : J", $time/10-1 );
		else if ( CPU.instr[31:26] == 6'd9 ) $display( "%d, fetching : ADDIU", $time/10-1 );
		else if ( CPU.instr[31:26] == 6'd5 ) $display( "%d, fetching : BNE", $time/10-1 );	
		
		
		if ( CPU.opcode == 6'd0 ) begin
			$display( "%d, wd: %d", $time/10-1, CPU.rfile_wd );
			
			if ( CPU.funct == 6'd0 ) begin
			  if ( CPU.instr_ID == 32'd0 ) $display( "%d, decoding : NOP\n", $time/10-1 );
			  else $display( "%d, decoding : SLL\n", $time/10-1 );
			end
			else if ( CPU.funct == 6'd32 ) $display( "%d, decoding : ADD\n", $time/10-1 );
			else if ( CPU.funct == 6'd34 ) $display( "%d, decoding : SUB\n", $time/10-1 );
			else if ( CPU.funct == 6'd36 ) $display( "%d, decoding : AND\n", $time/10-1 );
			else if ( CPU.funct == 6'd37 ) $display( "%d, decoding : OR\n", $time/10-1 );
			else if ( CPU.funct == 6'd42 ) $display( "%d, decoding : SLT\n", $time/10-1 );
			else if ( CPU.funct == 6'd25 ) $display( "%d, decoding : MULTU\n", $time/10-1 );		
			else if ( CPU.funct == 6'd16 ) $display( "%d, decoding : MFHI\n", $time/10-1 );
			else if ( CPU.funct == 6'd18 ) $display( "%d, decoding : MFLO\n", $time/10-1 );
		end
		else if ( CPU.opcode == 6'd35 ) $display( "%d, decoding : LW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd43 ) $display( "%d, decoding : SW\n", $time/10-1 );
		else if ( CPU.opcode == 6'd4 ) $display( "%d, decoding : BEQ\n", $time/10-1 );
		else if ( CPU.opcode == 6'd2 ) $display( "%d, decoding : J\n", $time/10-1 );
		else if ( CPU.opcode == 6'd9 ) $display( "%d, decoding : ADDIU\n", $time/10-1 );
		else if ( CPU.opcode == 6'd5 ) $display( "%d, decoding : BNE\n", $time/10-1 );	
	end
	
	mips_pipeline CPU( clk, rst );
	
endmodule
