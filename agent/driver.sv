class driver extends uvm_driver #(transaction); 
	`uvm_component_utils(driver)

	virtual jk_if.drv_mp vif;
	//jk_if vif;  
	tb_config tb_cfg; 
	function new(string name = "driver", uvm_component parent); 
		super.new(name, parent); 
	endfunction 

	function void build_phase(uvm_phase phase); 
		super.build_phase(phase); 
		assert(uvm_config_db #(tb_config)::get(this, "", "tb_config", tb_cfg)); 
	endfunction 

	function void connect_phase(uvm_phase phase); 
		vif = tb_cfg.vif; 
	endfunction

	task run_phase(uvm_phase phase); 
		
		forever 
			begin 
				//req = transaction::type_id::create("req"); 
				seq_item_port.get_next_item(req); 
				send_to_dut(req); 
				seq_item_port.item_done(); 
			end
	
	endtask

	task send_to_dut(transaction xtn); 
		//wait(vif.drv_cb.rst == 0); 
		@(vif.drv_cb); 
		vif.drv_cb.rst <= xtn.rst; 
		vif.drv_cb.j <= xtn.j; 
		vif.drv_cb.k <= xtn.k; 
		`uvm_info(get_full_name, $sformatf("Printing from driver %s", xtn.sprint()), UVM_LOW)
	endtask  
endclass
