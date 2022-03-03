module ALU_msb( a, b, SIG, cin, invB, less, cout, out, set );
	input a, b, cin, invB, less;
	input [1:0] SIG;
	output cout, out, set;

	wire e1, e2, e3, t1;

	and ( e1, a, b );

	or ( e2, a, b );

	xor ( t1, invB, b );
	FA FA( .a(a), .b(t1), .cin(cin), .cout(cout), .sum(e3) );
	assign set = e3 ;
	
	assign out = SIG[1] ? ( SIG[0] ? less : e3 ) : ( SIG[0] ? e2 : e1 );

endmodule