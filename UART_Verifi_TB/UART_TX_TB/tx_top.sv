`include "interface.sv"

//Particular test case can be run by uncommenting and commenting on the rest

 `include "odd_parity_test.sv"
//  `include "even_parity_test.sv"
//  `include "random_test.sv"
//  `include "toggle_data_test.sv"
//  `include "range_def_test.sv"

module UART_TX_TB(); 

 parameter time_period=10;
 bit clk;
 always #(time_period/2) clk=~clk; 

 UART_IF DUT_IF(clk);
 uart_top dut(clk,DUT_IF.reset,DUT_IF.wr_en,DUT_IF.d_in,DUT_IF.tx_full,DUT_IF.tx);
 test_tx t1(DUT_IF);
 
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
 end
endmodule

