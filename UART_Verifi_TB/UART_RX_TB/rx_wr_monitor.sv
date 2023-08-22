class rx_wr_monitor;
 transaction trans;
 virtual UART_IF.WRM_RX_M WRM_IF;
 mailbox wr_mon2rx_ref;

  function new(virtual UART_IF.WRM_RX_M WRM_IF,mailbox wr_mon2rx_ref);
   this.WRM_IF=WRM_IF;
   this.wr_mon2rx_ref=wr_mon2rx_ref; 
    $display("UART RX write monitor  is Build");
  endfunction 
  
 virtual task start();
   fork 
     forever
       begin
         trans=new;
         @(WRM_IF.WRM_RX_CB)begin
          trans.rx=WRM_IF.WRM_RX_CB.rx;
          wr_mon2rx_ref.put(trans);  
    end
       end
   join_none
  endtask
  
endclass