//`include "b_clk.sv"
//`include "uart_tx.sv"
//`include "uart_rx.sv"
//`include "fifo.sv"

module uart_top(clk,reset,rd_en,d_out,rx,rx_empty);
input logic clk,reset;
input logic rd_en;
input logic rx;  
output logic [7:0]d_out;
output logic rx_empty;
  
logic [10:0]dvsr;
assign dvsr=11'd7;
logic  [7:0]ff_dout,d_out_rx;
logic done_rx;
logic baud_trig_rx,baud_trig_tx;

b_clk b_c(clk,reset,dvsr,baud_trig_tx,baud_trig_rx);
uart_rx rx1(clk,reset,rx,done_rx,d_out_rx,baud_trig_rx);
fifo rx_ff(clk,reset,done_rx,rd_en,d_out_rx,d_out,rx_empty,fifo_full);

endmodule
