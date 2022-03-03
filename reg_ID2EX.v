module reg_ID2EX ( clk, rst, en_reg, d_in1, d_in2, d_in3, d_in4, d_in5, d_in6, d_in7, d_in8, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7, d_out8 );
    input clk, rst, en_reg;
    input [31:0] d_in1, d_in2, d_in3, d_in4, d_in8;
	input [4:0]	d_in5, d_in6;
	input [5:0] d_in7;
    output reg [31:0] d_out1, d_out2, d_out3, d_out4, d_out8;
	output reg [4:0] d_out5, d_out6;
	output reg [5:0] d_out7;
	
    always @( posedge clk ) begin
        if ( rst ) begin
			d_out1 <= 32'b0;
			d_out2 <= 32'b0;
			d_out3 <= 32'b0;
			d_out4 <= 32'b0;
			d_out5 <= 4'b0;
			d_out6 <= 4'b0;
			d_out7 <= 6'b0;
			d_out8 <= 1'b0;
		end	
        else if ( en_reg ) begin
			d_out1 <= d_in1;
			d_out2 <= d_in2;
			d_out3 <= d_in3;
			d_out4 <= d_in4;
			d_out5 <= d_in5;
			d_out6 <= d_in6;
			d_out7 <= d_in7;
			d_out8 <= d_in8;
		end	
    end

endmodule