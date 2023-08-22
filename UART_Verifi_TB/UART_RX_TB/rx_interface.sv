interface UART_IF(input bit clk,baud_clk_tx);
  logic reset;
  logic rd_en;
  logic rx;
  logic rx_empty;
  logic [7:0]d_out;
  
  clocking WRD_RX_CB@(posedge baud_clk_tx);
  default input #1 output #1;
     output rx;
  endclocking 
  
  clocking WRM_RX_CB@(negedge baud_clk_tx);
  default input #1 output #1;
    input rx;
  endclocking 

  clocking RDM_RX_CB@(posedge clk);
  default input #1 output #1;
    input d_out;
    input rd_en;
  endclocking
  
  clocking RDD_RX_CB@(posedge clk);
  default input #1 output #1;
    input rx_empty;
    output rd_en;
  endclocking
  
  modport WRD_RX_M(clocking WRD_RX_CB);
  modport WRM_RX_M(clocking WRM_RX_CB);
  modport RDM_RX_M(clocking RDM_RX_CB);
  modport RDD_RX_M(clocking RDD_RX_CB);   
     
endinterface 
