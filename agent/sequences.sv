class sequences extends uvm_sequence #(transaction); 
	`uvm_object_utils(sequences)

	function new(string name = "sequences"); 
		super.new(name); 
	endfunction 

	task body();
		repeat(5)
			begin  
				req = transaction::type_id::create("req"); 
				start_item(req); 
				assert(req.randomize()); 
				finish_item(req);
			end 
	endtask 
endclass
