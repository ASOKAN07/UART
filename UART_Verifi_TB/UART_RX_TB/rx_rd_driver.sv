class rx_rd_driver;
  
  transaction trans;
  
  virtual UART_IF.RDD_RX_M RDD_IF;
  function new(virtual UART_IF.RDD_RX_M RDD_IF);
  this.RDD_IF= RDD_IF; 
    $display("UART RX Read Driver is Build");
  endfunction 
  
  virtual task drive_read_enable();
    wait(RDD_IF.RDD_RX_CB.rx_empty==1'b1)   
    RDD_IF.RDD_RX_CB.rd_en<=1'b1;
     @(RDD_IF.RDD_RX_CB);
    RDD_IF.RDD_RX_CB.rd_en<=1'b0;
    wait(RDD_IF.RDD_RX_CB.rx_empty==1'b0);
  endtask
  
  virtual task start();
  fork begin 
  forever begin
  RDD_IF.RDD_RX_CB.rd_en<=1'b0;
  drive_read_enable();
  end end
  join_none
  endtask
endclass