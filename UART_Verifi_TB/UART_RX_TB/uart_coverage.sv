class uart_coverage;
  
  transaction trans_h,trans;
  mailbox grn_2cov;

covergroup RX_coverage;    
option.per_instance=1;

  START_RX :coverpoint trans_h.rx_reg[10]{
  bins START ={0};
  illegal_bins invalid={1};}
 
  STOP_RX :coverpoint trans_h.rx_reg[0]{
  bins STOP ={1};
  illegal_bins invalid={0};}

  `ifdef EVEN_PARITY_1
  PARITY_RX_1: coverpoint trans_h.rx_reg[9]{
  bins parity_1={1};} 
  `endif
    
 `ifdef EVEN_PARITY_0
  PARITY_RX_0: coverpoint trans_h.rx_reg[9]{
  bins even={0};}
 `endif
  
 DATA:coverpoint trans_h.rx_reg[8:1]{
 bins msb_3bits={[1:7]};
 bins msb_4bits={[8:15]};
 bins msb_5bits={[16:31]};
 bins msb_6bits={[32:63]};
 bins msb_7bits={[64:127]};
 bins msb_8bits={[128:255]};
 }
endgroup  
  
 function new(mailbox grn_2cov);
   RX_coverage=new();
   this.grn_2cov=grn_2cov;
 endfunction 
  
 virtual task start();
    fork
    forever
	begin          
    	grn_2cov.get(trans);
    	trans_h=new trans;    
	RX_coverage.sample();
 	end
   join_none
  endtask

endclass 
