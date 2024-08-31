class tb_config extends uvm_object; 
	`uvm_object_utils(tb_config)

	virtual jk_if vif; 

	function new(string name = "tb_config"); 
		super.new(name); 	
	endfunction 
endclass
