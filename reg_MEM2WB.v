module reg_MEM2WB ( clk, rst, en_reg, d_in1, d_in2, d_in3, d_out1, d_out2, d_out3);
    input clk, rst, en_reg;
    input [31:0] d_in1, d_in2;
	input [4:0] d_in3;
    output reg [31:0] d_out1, d_out2; 
	output reg [4:0] d_out3;
	
    always @( posedge clk ) begin
        if ( rst ) begin
			d_out1 <= 32'b0;
			d_out2 <= 32'b0;
			d_out3 <= 4'b0;
		end	
        else if ( en_reg ) begin
			d_out1 <= d_in1;
			d_out2 <= d_in2;
			d_out3 <= d_in3;
		end	
    end

endmodule