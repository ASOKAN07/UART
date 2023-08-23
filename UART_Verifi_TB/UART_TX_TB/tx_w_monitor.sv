class tx_w_monitor;

  virtual UART_IF.WRM_TX_M WRM_IF;
  mailbox wr_mon2ref;
  transaction trans,data2send;

  function new(virtual UART_IF.WRM_TX_M WRM_IF,mailbox wr_mon2ref);
   this.WRM_IF=WRM_IF;
   this.wr_mon2ref=wr_mon2ref;
  endfunction
  
  virtual task monitor();
    trans=new;
    @(WRM_IF.WRM_TX_CB);
    trans.wr_en=WRM_IF.WRM_TX_CB.wr_en;
    trans.wr_data=WRM_IF.WRM_TX_CB.d_in;
    trans.tx_full=WRM_IF.WRM_TX_CB.tx_full;
    data2send=new trans;  
    wr_mon2ref.put(data2send);  
  endtask
  
  virtual task start;
    fork
    forever begin
    monitor();
    end
    join_none  
  endtask
endclass
