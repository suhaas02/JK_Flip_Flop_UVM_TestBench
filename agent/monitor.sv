class monitor extends uvm_monitor; 
	`uvm_component_utils(monitor)

	virtual jk_if.mon_mp vif; 
	tb_config tb_cfg; 
	transaction xtn;
	uvm_analysis_port #(transaction) monitor_port; 
	function new(string name = "monitor", uvm_component parent); 
		super.new(name, parent); 
		monitor_port = new("monitor_port", this); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		assert(uvm_config_db #(tb_config)::get(this, "", "tb_config", tb_cfg)); 
	endfunction 

	function void connect_phase(uvm_phase phase); 
		vif = tb_cfg.vif; 
	endfunction

	task run_phase(uvm_phase phase); 
		//transaction xtn;
		xtn = transaction::type_id::create("xtn"); 
		forever 
			collect_data(); 
	endtask
	
	task collect_data(); 
		//wait(vif.mon_cb.rst == 0);
		@(vif.mon_cb);
		xtn.q = vif.mon_cb.q; 
	//	xtn.qn = vif.mon_cb.qn; 
		monitor_port.write(xtn); 
		`uvm_info(get_full_name, $sformatf("printing from monitor %s", xtn.sprint()), UVM_LOW) 

	endtask   
endclass
