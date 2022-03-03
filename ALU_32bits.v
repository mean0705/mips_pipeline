module ALU_32bits( A, B, SIG, dataOut, zero, shamt, en_mul, BNE, clk, rst );
	input [31:0] A, B;
	input [4:0] shamt;
	input [2:0] SIG;
	input clk, rst, en_mul, BNE;

	output reg [31:0] dataOut;
	output reg zero;

	wire [63:0] Product;
	wire [31:0] c ,shift_result, ALU_result, Hi, Lo;
	wire set;
	
	ALU_1bit ALU_0( .a(A[0]), .b(B[0]), .SIG(SIG[1:0]), .cin(SIG[2]), .invB(SIG[2]), .less(set), .cout(c[0]), .out(ALU_result[0]) );
	ALU_1bit ALU_1( .a(A[1]), .b(B[1]), .SIG(SIG[1:0]), .cin(c[0]), .invB(SIG[2]), .less(1'b0), .cout(c[1]), .out(ALU_result[1]) );
	ALU_1bit ALU_2( .a(A[2]), .b(B[2]), .SIG(SIG[1:0]), .cin(c[1]), .invB(SIG[2]), .less(1'b0), .cout(c[2]), .out(ALU_result[2]) );
	ALU_1bit ALU_3( .a(A[3]), .b(B[3]), .SIG(SIG[1:0]), .cin(c[2]), .invB(SIG[2]), .less(1'b0), .cout(c[3]), .out(ALU_result[3]) );
	ALU_1bit ALU_4( .a(A[4]), .b(B[4]), .SIG(SIG[1:0]), .cin(c[3]), .invB(SIG[2]), .less(1'b0), .cout(c[4]), .out(ALU_result[4]) );
	ALU_1bit ALU_5( .a(A[5]), .b(B[5]), .SIG(SIG[1:0]), .cin(c[4]), .invB(SIG[2]), .less(1'b0), .cout(c[5]), .out(ALU_result[5]) );
	ALU_1bit ALU_6( .a(A[6]), .b(B[6]), .SIG(SIG[1:0]), .cin(c[5]), .invB(SIG[2]), .less(1'b0), .cout(c[6]), .out(ALU_result[6]) );
	ALU_1bit ALU_7( .a(A[7]), .b(B[7]), .SIG(SIG[1:0]), .cin(c[6]), .invB(SIG[2]), .less(1'b0), .cout(c[7]), .out(ALU_result[7]) );
	ALU_1bit ALU_8( .a(A[8]), .b(B[8]), .SIG(SIG[1:0]), .cin(c[7]), .invB(SIG[2]), .less(1'b0), .cout(c[8]), .out(ALU_result[8]) );
	ALU_1bit ALU_9( .a(A[9]), .b(B[9]), .SIG(SIG[1:0]), .cin(c[8]), .invB(SIG[2]), .less(1'b0), .cout(c[9]), .out(ALU_result[9]) );
	ALU_1bit ALU_10( .a(A[10]), .b(B[10]), .SIG(SIG[1:0]), .cin(c[9]), .invB(SIG[2]), .less(1'b0), .cout(c[10]), .out(ALU_result[10]) );
	ALU_1bit ALU_11( .a(A[11]), .b(B[11]), .SIG(SIG[1:0]), .cin(c[10]), .invB(SIG[2]), .less(1'b0), .cout(c[11]), .out(ALU_result[11]) );
	ALU_1bit ALU_12( .a(A[12]), .b(B[12]), .SIG(SIG[1:0]), .cin(c[11]), .invB(SIG[2]), .less(1'b0), .cout(c[12]), .out(ALU_result[12]) );
	ALU_1bit ALU_13( .a(A[13]), .b(B[13]), .SIG(SIG[1:0]), .cin(c[12]), .invB(SIG[2]), .less(1'b0), .cout(c[13]), .out(ALU_result[13]) );
	ALU_1bit ALU_14( .a(A[14]), .b(B[14]), .SIG(SIG[1:0]), .cin(c[13]), .invB(SIG[2]), .less(1'b0), .cout(c[14]), .out(ALU_result[14]) );
	ALU_1bit ALU_15( .a(A[15]), .b(B[15]), .SIG(SIG[1:0]), .cin(c[14]), .invB(SIG[2]), .less(1'b0), .cout(c[15]), .out(ALU_result[15]) );
	ALU_1bit ALU_16( .a(A[16]), .b(B[16]), .SIG(SIG[1:0]), .cin(c[15]), .invB(SIG[2]), .less(1'b0), .cout(c[16]), .out(ALU_result[16]) );
	ALU_1bit ALU_17( .a(A[17]), .b(B[17]), .SIG(SIG[1:0]), .cin(c[16]), .invB(SIG[2]), .less(1'b0), .cout(c[17]), .out(ALU_result[17]) );
	ALU_1bit ALU_18( .a(A[18]), .b(B[18]), .SIG(SIG[1:0]), .cin(c[17]), .invB(SIG[2]), .less(1'b0), .cout(c[18]), .out(ALU_result[18]) );
	ALU_1bit ALU_19( .a(A[19]), .b(B[19]), .SIG(SIG[1:0]), .cin(c[18]), .invB(SIG[2]), .less(1'b0), .cout(c[19]), .out(ALU_result[19]) );
	ALU_1bit ALU_20( .a(A[20]), .b(B[20]), .SIG(SIG[1:0]), .cin(c[19]), .invB(SIG[2]), .less(1'b0), .cout(c[20]), .out(ALU_result[20]) );
	ALU_1bit ALU_21( .a(A[21]), .b(B[21]), .SIG(SIG[1:0]), .cin(c[20]), .invB(SIG[2]), .less(1'b0), .cout(c[21]), .out(ALU_result[21]) );
	ALU_1bit ALU_22( .a(A[22]), .b(B[22]), .SIG(SIG[1:0]), .cin(c[21]), .invB(SIG[2]), .less(1'b0), .cout(c[22]), .out(ALU_result[22]) );
	ALU_1bit ALU_23( .a(A[23]), .b(B[23]), .SIG(SIG[1:0]), .cin(c[22]), .invB(SIG[2]), .less(1'b0), .cout(c[23]), .out(ALU_result[23]) );
	ALU_1bit ALU_24( .a(A[24]), .b(B[24]), .SIG(SIG[1:0]), .cin(c[23]), .invB(SIG[2]), .less(1'b0), .cout(c[24]), .out(ALU_result[24]) );
	ALU_1bit ALU_25( .a(A[25]), .b(B[25]), .SIG(SIG[1:0]), .cin(c[24]), .invB(SIG[2]), .less(1'b0), .cout(c[25]), .out(ALU_result[25]) );
	ALU_1bit ALU_26( .a(A[26]), .b(B[26]), .SIG(SIG[1:0]), .cin(c[25]), .invB(SIG[2]), .less(1'b0), .cout(c[26]), .out(ALU_result[26]) );
	ALU_1bit ALU_27( .a(A[27]), .b(B[27]), .SIG(SIG[1:0]), .cin(c[26]), .invB(SIG[2]), .less(1'b0), .cout(c[27]), .out(ALU_result[27]) );
	ALU_1bit ALU_28( .a(A[28]), .b(B[28]), .SIG(SIG[1:0]), .cin(c[27]), .invB(SIG[2]), .less(1'b0), .cout(c[28]), .out(ALU_result[28]) );
	ALU_1bit ALU_29( .a(A[29]), .b(B[29]), .SIG(SIG[1:0]), .cin(c[28]), .invB(SIG[2]), .less(1'b0), .cout(c[29]), .out(ALU_result[29]) );
	ALU_1bit ALU_30( .a(A[30]), .b(B[30]), .SIG(SIG[1:0]), .cin(c[29]), .invB(SIG[2]), .less(1'b0), .cout(c[30]), .out(ALU_result[30]) );
	ALU_msb ALU_31( .a(A[31]), .b(B[31]), .SIG(SIG[1:0]), .cin(c[30]), .invB(SIG[2]), .less(1'b0), .cout(c[31]), .out(ALU_result[31]), .set(set) );

	Shifter Shifter( .target(B), .shamt(shamt), .result(shift_result) );

	Multiplier Multiplier( ._Multiplicand(A), ._Multiplier(B), .product(Product), .en_mul(en_mul), .clk(clk), .rst(rst) );
	HiLo HiLo( .product(Product), .HiOut(Hi), .LoOut(Lo), .clk(clk), .rst(rst), .en_hiLo(en_mul) );

	always @ ( A or B or SIG ) begin
		if ( SIG == 3'b101 ) dataOut = shift_result;
		else if ( SIG == 3'b011 ) dataOut = Hi;
		else if ( SIG == 3'b100 ) dataOut = Lo;
		else dataOut = ALU_result;
  
		if ( dataOut == 32'd0 ) zero = 1;
		else zero = 0;
  
		if ( BNE ) zero = ~zero ;
	end  



endmodule  