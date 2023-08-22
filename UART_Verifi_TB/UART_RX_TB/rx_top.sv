//----------------------------------------------------------------------------------------
//`include "interface.sv"

//Particular testcase can be run by uncommenting, and commenting the rest
//`include "rx_erroy_parity_test.sv"
`include "rx_odd_parity_test.sv"
//`include "rx_even_parity_test.sv"
//`include "rx_random_test.sv"

module uart_tb;
  
  parameter time_period=10;
  bit clk;
  bit  b_clk_tx; 
  UART_IF DUT_IF(clk,b_clk_tx);
  uart_top 	DUT(clk,DUT_IF.reset,DUT_IF.rd_en,DUT_IF.d_out,DUT_IF.rx,DUT_IF.rx_empty);
 
  always #(time_period/2) clk=~clk; 
  test_rx t1(DUT_IF,clk);

  initial begin 
   $dumpfile("dump.vcd"); 
   $dumpvars;
  end
  
  always 
  begin 
    if(DUT_IF.reset==1'b1)
    b_clk_tx=1'b0;  

    for (int i=0;i<7;i++)begin 
    @(posedge clk) begin 
    if(i=='d6)
      b_clk_tx=1'b1;
    else 
     b_clk_tx=1'b0;
    end end end
  
endmodule 
