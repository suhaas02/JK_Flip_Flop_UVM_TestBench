module top();
	import uvm_pkg::*; 

	import jk_pkg::*; 
	`include "uvm_macros.svh" 
	bit clock; 

initial begin
	clock = 0; 	
	forever #5 clock = ~clock; 
end
	jk_if if0(clock); 
	/*initial $monitor("clock %d", clock); 
	//$display("%d", clock); */ 
	//jk_if if0(clock); 



	jk_ff DUV(.j(if0.j), .k(if0.k), .clock(clock), .rst(if0.rst), .q(if0.q)); 

	initial 
		begin
			`ifdef VCS
			$fsdbDumpvars(0,top);
			`endif 
 
			uvm_config_db #(virtual jk_if)::set(null, "*", "if0", if0); 
			uvm_top.enable_print_topology = 1; 
			run_test("test"); 
		end
endmodule 
