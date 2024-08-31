interface jk_if(input bit clock);
	logic rst;
	logic j; 
	logic k; 
	logic q; 
	logic qn; 

	clocking drv_cb@(posedge clock); 
		default input #1 output #1; 
		output rst, j, k; 
	endclocking 

	clocking mon_cb@(posedge clock); 
		default input #1 output #1; 
		input q, qn; 
	endclocking 

	modport drv_mp(clocking drv_cb); 
	modport mon_mp(clocking mon_cb); 
endinterface 
