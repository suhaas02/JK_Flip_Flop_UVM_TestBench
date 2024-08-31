class agent extends uvm_agent; 
	`uvm_component_utils(agent)
	driver drv_h; 
	sequencer seqr_h; 
	monitor mon_h; 

	function new(string name = "agent", uvm_component parent); 
		super.new(name, parent); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		mon_h = monitor::type_id::create("mon_h", this); 
		seqr_h = sequencer::type_id::create("seqr_h", this); 
		drv_h = driver::type_id::create("drv_h", this); 
	endfunction 

	function void connect_phase(uvm_phase phase); 
		drv_h.seq_item_port.connect(seqr_h.seq_item_export); 
	endfunction 
endclass
