class environment extends uvm_env; 
	`uvm_component_utils(environment)

	agent agt_h; 
	scoreboard sbh; 
	function new(string name ="environment", uvm_component parent); 
		super.new(name, parent); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		agt_h = agent::type_id::create("agt_h", this); 
		sbh = scoreboard::type_id::create("sbh", this); 
	endfunction 

	function void connect_phase(uvm_phase phase); 
		agt_h.mon_h.monitor_port.connect(sbh.fifoh.analysis_export); 
	endfunction 

endclass
	
