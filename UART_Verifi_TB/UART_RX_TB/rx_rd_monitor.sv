class rx_rd_monitor;
  
  transaction trans;

  virtual UART_IF.RDM_RX_M RDM_IF;
  mailbox rdmon2rx_sb;
 
  function new(virtual UART_IF.RDM_RX_M RDM_IF, mailbox rdmon2rx_sb);
  this.RDM_IF=RDM_IF;
  this.rdmon2rx_sb=rdmon2rx_sb;
    $display("UART RX Read Monitor is Build");
  endfunction 
  
  virtual task start();
   fork 
   forever begin 
   trans=new;
   
   wait(RDM_IF.RDM_RX_CB.rd_en==1'b1);
   @(RDM_IF.RDM_RX_CB);
   trans.d_out=RDM_IF.RDM_RX_CB.d_out;
   rdmon2rx_sb.put(trans);
     
  //$display($time ,"Transcation get from rd montor %h",trans.d_out);          
   end  join_none endtask
endclass