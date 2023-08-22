class rx_wr_driver;
  transaction trans,t1;
  virtual UART_IF.WRD_RX_M WRD_IF;
  mailbox gen2rx_drv;

  function new(virtual UART_IF.WRD_RX_M WRD_IF,mailbox gen2rx_drv);
    this.gen2rx_drv=gen2rx_drv;
    this.WRD_IF=WRD_IF;
    $display("UART RX write Driver is Build");
 endfunction 
  
  virtual task drive();
    repeat(11)  begin
      
      @(WRD_IF.WRD_RX_CB)begin
     //$display("  befor Data is driveing  %b",trans.rx_reg[10]);
      WRD_IF.WRD_RX_CB.rx<=trans.rx_reg[10];
      trans.rx_reg=trans.rx_reg<<1;
     //$display($time,"  Data is driveing  %b",trans.rx_reg[10]);
     end   
    end
WRD_IF.WRD_RX_CB.rx<=1'b1;
  endtask
  
  virtual task start();
fork 
 	 forever   
  	 begin  
  	 gen2rx_drv.get(trans); 
       //$display("  Data is driveing  %h",trans.rx_reg);
       drive();
       #100;
  	 end
  join_none
 
  endtask
endclass;