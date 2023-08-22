class uart_coverage;
  
  transaction trans_h,trans;
  mailbox grn_2cov;

covergroup RX_coverage;    
      option.per_instance=1;

  START_RX :coverpoint trans_h.rx_reg[10]{
bins START ={0};
illegal_bins invalid={1};
} 
  STOP_RX :coverpoint trans_h.rx_reg[0]{
  bins STOP ={1};
illegal_bins invalid={0};
}
  `ifdef ODD_PARITY
  PARITY_RX_1: coverpoint trans_h.rx_reg[9]{
bins odd={1};}

DATA_MIN: coverpoint trans.rx_reg[8:1]{
bins min={253};
}

 
  `endif
    
  `ifdef EVEN_PARITY
  PARITY_RX_0: coverpoint trans_h.rx_reg[9]{
  bins even={0};}

DATA_MAX: coverpoint trans.rx_reg[8:1]{
bins max={0};
}  
`endif
  
 DATA:coverpoint trans_h.rx_reg[8:1]{
bins msb_3bits={[1:7]};
bins msb_4bits={[8:15]};
bins msb_5bits={[16:31]};
bins msb_6bits={[32:63]};
bins msb_7bits={[64:127]};
bins msb_8bits={[128:252]};
}
endgroup  
  
 function new(mailbox grn_2cov);
   RX_coverage=new();
   //RX_coverage.PARITY_RX_1.option.weight=0;
   this.grn_2cov=grn_2cov;
 endfunction 
  
  virtual task start();
    fork
    forever begin          
    grn_2cov.get(trans);

trans_h=new trans;    
//$display("______________________%b___________________",trans_h.rx_reg);

RX_coverage.sample();
//$display("_____________________%d__________________",RX_coverage.get_inst_coverage());
  
  end
   join_none
  endtask
endclass 
