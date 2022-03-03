module Multiplier( _Multiplicand, _Multiplier, product, en_mul, clk, rst );
	input [31:0] _Multiplicand;
	input [31:0] _Multiplier;
	input clk, rst, en_mul;
	output reg [63:0] product;
	
	reg [2:0] cycle;
	reg [6:0] count ;
	reg [63:0] MCND ;
	reg [31:0] MPY ;
		
	always @ ( posedge clk or posedge rst ) begin
		if ( rst ) begin 
			count = 6'b0;
			cycle = 2'b0;
			product = 64'b0;
		end
		else begin
			if ( en_mul && cycle != 2'd1 && cycle != 2'd2 ) begin
				if ( count == 0 ) begin
					MCND = _Multiplicand;
					MPY = _Multiplier;
					product = 64'b0;
				end
	
				if ( count <= 32 ) begin
					if ( MPY[0] ) product = product + MCND;
	  
					MCND = MCND << 1 ;
					MPY = MPY >> 1 ;
					count = count + 1;
				end
			end	
		end
	
		if ( cycle < 2'd3 ) cycle = cycle + 1;
	end

	always @ ( negedge en_mul ) begin
		product = 64'd0;
		count = 6'b0;
	end	

endmodule