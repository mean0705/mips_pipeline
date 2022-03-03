module FA(a, b, cin, cout, sum);
	input a, b, cin;
	output cout, sum;

	wire tmp1, tmp2, tmp3;

	and ( tmp1, a, b );
	and ( tmp2, a, cin );
	and ( tmp3, b, cin );

	xor ( sum, a, b, cin );
	or ( cout, tmp1, tmp2, tmp3 );

endmodule
