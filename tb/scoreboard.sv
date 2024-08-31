class scoreboard extends uvm_scoreboard; 
	`uvm_component_utils(scoreboard) 
	uvm_tlm_analysis_fifo #(transaction) fifoh; 	
	transaction xtn, xtn_ref; 
	
	covergroup coverage; 
		j: coverpoint xtn.j; 
		k: coverpoint xtn.k; 
		q: coverpoint xtn.q; 
		qn: coverpoint xtn.qn; 
	endgroup 
	
	function new(string name = "scoreboard", uvm_component parent); 
		super.new(name, parent); 
		fifoh = new("fifoh", this); 
		coverage = new;
	endfunction 

	task run_phase(uvm_phase phase);
		forever 
			begin 
				//transaction xtn;  
				fifoh.get(xtn);
				assert($cast(xtn_ref, xtn.clone()));  
				data_out_ref(xtn_ref); 
				check_data(xtn_ref, xtn); 
				coverage.sample(); 
				
			end
	endtask   

	task data_out_ref(ref transaction xtn); 
		if(xtn.rst) begin 
			xtn.q = 1'b0;
			xtn.qn = 1; 
		end 
		else if(xtn.j == 0 && xtn.k == 0)
			begin 	
				xtn.q = xtn.q; 
				xtn.qn = xtn.qn; 
			end 
		else if(xtn.j == 0 && xtn.k == 1)
			begin 
				xtn.q = 0; 
				xtn.qn = 1; 
			end 
		else if(xtn.j == 1 && xtn.k == 0)
			begin 
				xtn.q = 1; 
				xtn.qn = 0; 
			end 
		else
			begin 
				xtn.q = ~xtn.q; 
				xtn.qn = ~xtn.qn; 
			end
	endtask 

	task check_data(transaction xtn_ref, transaction xtn);
		if(xtn.compare(xtn_ref))
			`uvm_info(get_type_name, "Successfully compared", UVM_LOW)
	endtask  
endclass
