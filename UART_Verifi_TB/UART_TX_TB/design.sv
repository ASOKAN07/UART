
//module uart_top(clk,reset,rd_en,wr_en,d_in,d_out,tx_full,rx_empty,tx,rx);
module uart_top(clk,reset,wr_en,d_in,tx_full,tx);
input clk,reset,wr_en;
//input rd_en,rx;  
input [7:0]d_in;
output tx;
//output logic [7:0]d_out;
//output logic rx_empty;
output logic tx_full;
  logic empty_reg;
  logic [10:0]dvsr;
assign dvsr=11'd7;
logic  [7:0]ff_dout,d_out_rx;
logic tx_done,empty,done_rx;
logic baud_trig_rx,baud_trig_tx;
b_clk   b_c(clk,reset,dvsr,baud_trig_tx,baud_trig_rx);
uart_tx  tx1(clk,reset,empty_reg,baud_trig_tx,ff_dout,tx_done,tx);  

fifo  tx_ff(clk,reset,wr_en,tx_done,d_in,ff_dout,empty,tx_full);

always@(posedge clk)
begin 
if(reset==1'b1)
empty_reg=1'b0;
else
empty_reg=empty;
end

endmodule
