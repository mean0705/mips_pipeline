module HiLo( product, HiOut, LoOut, clk, rst, en_hiLo );
	input [63:0] product;
	input clk, rst, en_hiLo;
	output [31:0] HiOut, LoOut;

	reg [63:0] HiLo;

	assign HiOut = HiLo[63:32] ;
	assign LoOut = HiLo[31:0] ;


	always @ ( posedge clk or posedge rst )
	begin
		if ( rst ) HiLo = 64'b0;
		else if ( en_hiLo ) HiLo = product;
	end


endmodule