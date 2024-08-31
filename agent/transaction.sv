class transaction extends uvm_sequence_item; 
	//`uvm_object_utils(transaction)

	rand bit rst; 
	rand bit j, k; 
	bit q;
	//, qn; 

	`uvm_object_utils_begin(transaction)
		`uvm_field_int(rst, UVM_ALL_ON)
		`uvm_field_int(j, UVM_ALL_ON)
		`uvm_field_int(k, UVM_ALL_ON)
		`uvm_field_int(q, UVM_ALL_ON)
	//	`uvm_field_int(qn, UVM_ALL_ON)
	`uvm_object_utils_end
	constraint range{rst dist{0:=10, 1:=2};}
	function new(string name = "transaction"); 
		super.new(name); 
	endfunction 
endclass
