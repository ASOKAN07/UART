module uart_top(clk,reset,rd_en,wr_en,d_in,d_out,tx_full,rx_empty,tx,rx);
input clk,reset,wr_en;
input rd_en,rx;  
input [7:0]d_in;
output tx;
output logic [7:0]d_out;
output logic rx_empty;
output logic tx_full;
logic [10:0]dvsr;
assign dvsr=11'd7;
logic  [7:0]ff_dout,d_out_rx;
logic tx_done,empty,done_rx;
logic baud_trig_rx,baud_trig_tx;
b_clk   b_c(clk,reset,dvsr,baud_trig_tx,baud_trig_rx);
uart_tx  tx1(clk,reset,empty,baud_trig_tx,ff_dout,tx_done,tx); 
uart_rx rx1(clk,reset,rx,done_rx,d_out_rx,baud_trig_rx);
fifo rx_ff(clk,reset,done_rx,rd_en,d_out_rx,d_out,rx_empty,fifo_full);
fifo  tx_ff(clk,reset,wr_en,tx_done,d_in,ff_dout,empty,tx_full);
endmodule
