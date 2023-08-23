class tx_w_driver;

virtual UART_IF.WRD_TX_M WRD_IF;
//tx_coverage tx_cov_h;
mailbox gen2tx_drv;
transaction trans,t1;
   function new(virtual UART_IF.WRD_TX_M WRD_IF,mailbox gen2tx_drv);
  this.WRD_IF=WRD_IF;
  this.gen2tx_drv=gen2tx_drv;
  t1=new();
endfunction 
 
  virtual task drive();
    WRD_IF.WRD_TX_CB.wr_en<=1'b1;
    WRD_IF.WRD_TX_CB.d_in<=trans.data;
    trans.tx_full<=WRD_IF.WRD_TX_CB.tx_full;
    trans.wr_en<=1'b1;
    @(WRD_IF.WRD_TX_CB); 
    WRD_IF.WRD_TX_CB.wr_en<=1'b0;
     trans.wr_en<=1'b0;
    WRD_IF.WRD_TX_CB.d_in<=7'dx; 
  endtask
  
  virtual task  start();
    fork  
      forever    begin 
        wait(WRD_IF.WRD_TX_CB.tx_full==1'b0);
        @(WRD_IF.WRD_TX_CB);
        gen2tx_drv.get(trans); 
         drive();
     
      end
    join_none
  endtask
 
endclass
