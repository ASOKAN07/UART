module b_clk(clk,rst,dvsr,baud_trig_tx,baud_trig_rx);
input clk,rst;
input logic [10:0]dvsr;
output logic baud_trig_tx,baud_trig_rx;
reg [10:0]b_reg_tx,b_next_tx;
reg [10:0]b_reg_rx,b_next_rx;

always_ff@(posedge clk, posedge rst) begin 
if(rst==1'b1)
b_reg_tx<=1'b0;
else
b_reg_tx<=b_next_tx;
end