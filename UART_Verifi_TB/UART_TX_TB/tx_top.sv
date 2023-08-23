`include "tx_interface.sv"

//Particular testcase can be run by uncommenting, and commenting the rest

//`include "tx_even_parity_0_test.sv"
//`include "tx_even_parity_1_test.sv"
`include "tx_random_test.sv"

module UART_TX_TB();
parameter time_period=10;
bit clk;
always #(time_period/2) clk=~clk; 

UART_IF DUT_IF(clk);
uart_top dut(clk,DUT_IF.reset,DUT_IF.wr_en,DUT_IF.d_in,DUT_IF.tx_full,DUT_IF.tx);
test_tx t1(DUT_IF);
 
initial begin
  $dumpfile("dump.vcd"); $dumpvars;
end 
endmodule
