class rx_generator;
  transaction trans,data2send;
  mailbox gen2rx_drv;
  mailbox grn_2cov;
  function new(mailbox gen2rx_drv,mailbox grn_2cov);
  this.gen2rx_drv= gen2rx_drv;
  this.grn_2cov=grn_2cov;
  trans=new;
  $display("UART Rx Generator is Build");
  endfunction 
  
  virtual task start(); $display("UART RX Generator is Running");
   fork  begin 
   for(int i=0;i< rx_no_of_transaction;i++)  begin 
     if(!trans.randomize())
     begin  
     $display("Genetaror :Randomize is not set properly",$time);     
     end
  data2send=new trans;
  gen2rx_drv.put(data2send);       
  grn_2cov.put(data2send);
  end end
 join_none
 endtask
  
endclass
