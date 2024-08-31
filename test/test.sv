class test extends uvm_test; 
	`uvm_component_utils(test)
	environment env_h; 

	tb_config tb_cfg; 
	sequences seq_h; 
	function new(string name = "test", uvm_component parent); 
		super.new(name, parent); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		tb_cfg = tb_config::type_id::create("tb_cfg"); 
		assert(uvm_config_db #(virtual jk_if)::get(this, "", "if0", tb_cfg.vif)); 

		uvm_config_db #(tb_config)::set(this, "*", "tb_config", tb_cfg); 
		env_h = environment::type_id::create("env_h", this); 
	endfunction 

	task run_phase(uvm_phase phase); 
		phase.raise_objection(this); 
		seq_h = sequences::type_id::create("seq_h"); 
		seq_h.start(env_h.agt_h.seqr_h);
		#100;
		
		phase.drop_objection(this);  
	endtask 

endclass
	
	
