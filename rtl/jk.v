module jk_ff(j, k, clock, rst, q,qn); 
	input clock, rst, j, k; 
	output reg q;
	//qn; 
	output qn;

	always@(posedge clock)
		begin
			if(rst)
			 	q <= 1'b0; 
			else if(j == 0 && k == 0)
				q <= q; 
			else if(j == 0 && k == 1)
				q <= 0; 
			else if(j == 1 && k == 0)
				q <= 1; 
			else if(q == 1 && k == 1)
				q <= ~q;
			
		end



	assign qn = ~q; 	
endmodule 
