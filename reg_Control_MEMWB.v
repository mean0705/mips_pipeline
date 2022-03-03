module reg_Control_MEMWB ( clk, rst, en_reg, d_in1, d_in2, d_out1, d_out2 );
    input clk, rst, en_reg;
    input d_in1, d_in2;
    output reg d_out1, d_out2; 

    always @( posedge clk ) begin
        if ( rst ) begin
			d_out1 <= 1'b0;
			d_out2 <= 1'b0;
		end	
        else if ( en_reg ) begin
			d_out1 <= d_in1;
			d_out2 <= d_in2;
		end	
    end

endmodule