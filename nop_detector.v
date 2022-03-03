module nop_detector( clk, rst, instr, en_pc, NOPSrc, maxcount );
	input clk, rst;
	input [31:0] instr;
	output reg en_pc, NOPSrc;
	output reg [6:0] maxcount;
	
	reg [6:0] counter;
	
	always @ ( instr ) begin
		
        if ( instr[31:26] == 6'd0 && instr[5:0] == 6'd25 ) begin
            maxcount <= 32;
	        en_pc <= 0;
        end
        else if ( instr[31:26] == 6'd4 ) begin
            maxcount <= 2;
	        en_pc <= 0;
        end
        else if ( instr[31:26] == 6'd5 ) begin
            maxcount <= 2;
	        en_pc <= 0;
        end
        else if ( instr[31:26] == 6'd2 ) begin
            maxcount <= 2;
	        en_pc <= 0;
        end
        else begin
		  maxcount <= 0;	
	      en_pc <= 1;
        end		
	end
	
	always @ ( posedge clk ) begin
	    if ( rst ) begin
	        counter <= 0;
	   	    maxcount <= 0;
			en_pc <= 1;
			NOPSrc <= 0;
			
	    end
	    else begin
		    if ( counter == 1'b0 && en_pc == 1'b1 ) NOPSrc <= 0;
			else NOPSrc <= 1;
			
	        counter <= counter + 1;
	        if ( counter == maxcount ) begin
	          en_pc <= 1;
		      counter <= 0;
			  maxcount <= 0;
	        end	
	    end	
	end


endmodule