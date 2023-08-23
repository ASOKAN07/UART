class tx_coverage;
  
transaction trans_h,trans;
mailbox sb2tx_cov;

covergroup Tx_coverage;
option.per_instance=1;
START_TX :coverpoint trans.d_rcv[10]{
  bins START ={0};
  illegal_bins invalid={1};  }
  
STOP_TX :coverpoint trans.d_rcv[0]{
  bins STOP ={1};
  illegal_bins invalid={0};  }

`ifdef EVEN_PARITY_1
  PARITY_TX_1: coverpoint trans.d_rcv[9]{ bins parity_1={1};} 
`endif
  
`ifdef EVEN_PARITY_0
  PARITY_TX_0: coverpoint trans.d_rcv[9]{ bins parity_0={0};}
`endif

DATA:coverpoint trans.d_rcv[8:1]{
bins msb_3bits={[0:7]};
bins msb_4bits={[8:15]};
bins msb_5bits={[16:31]};
bins msb_6bits={[32:63]};
bins msb_7bits={[64:127]};
bins msb_8bits={[128:255]};
}
endgroup  
  
function new(mailbox sb2tx_cov);
 this.sb2tx_cov=sb2tx_cov;
 Tx_coverage=new();
endfunction 
  
virtual task start();
  fork
    forever begin          
    sb2tx_cov.get(trans);
     //trans= new trans;    
     Tx_coverage.sample();
 end
 join_none
endtask
endclass 
