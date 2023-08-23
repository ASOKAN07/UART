class tx_r_monitor;
  
  virtual UART_IF.RDM_TX_M RDM_IF;

  mailbox rd_mon2ref;
  transaction trans;

  function new(virtual UART_IF.RDM_TX_M RDM_IF,mailbox rd_mon2ref);
   this.RDM_IF=RDM_IF;
   this.rd_mon2ref=rd_mon2ref;
 endfunction 
  
 virtual task monitor();
   wait(RDM_IF.RDM_TX_CB.tx==1'b0);
   trans.d_rcv[0]=RDM_IF.RDM_TX_CB.tx;
   repeat(10) begin
     repeat(7) begin  @(RDM_IF.RDM_TX_CB) ; end 
//$display($time,"-------------%b ---------",trans.d_rcv);     

trans.d_rcv=trans.d_rcv<<1'b1; 
     trans.d_rcv[0]=RDM_IF.RDM_TX_CB.tx;
     end
     rd_mon2ref.put(trans);
//$display("----rd monitor-----%b------",trans.d_rcv);
 endtask

 virtual task  start();
   fork
     forever begin 
     trans=new();
     monitor();
     end
   join_none
 endtask  
endclass
