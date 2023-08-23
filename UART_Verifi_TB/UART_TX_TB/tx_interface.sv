interface UART_IF(input bit clk);
 
 logic [7:0] d_in;
 logic wr_en ;
 logic tx_full;
 logic tx;
 logic reset;
    
 clocking WRD_TX_CB@(negedge clk);
   default input #1  output #4  ;
  output d_in;
  output wr_en;
  output reset;
  input tx_full; 
 endclocking 

 clocking WRM_TX_CB@(posedge clk);
    default input #1 output #1  ;
  input d_in;
  input wr_en;
  input tx_full;
 endclocking 
  
 clocking RDM_TX_CB@(negedge clk);
   default input #1 output #0;
  input tx;
   
endclocking 
  
  modport WRD_TX_M(clocking WRD_TX_CB);
  modport WRM_TX_M(clocking WRM_TX_CB);
  modport RDM_TX_M(clocking RDM_TX_CB);
 
endinterface   
