
module uart_rx(clk,rst,rx,done,d_out,baud_trig);
input logic clk,rst;
input logic  rx;
output logic [7:0]d_out;
output  logic done;
input logic baud_trig;
logic in_parity;
logic [10:0] d_reg;
logic done_reg;
localparam start_bit=1'b0, stop_bit=1'b1;
typedef enum {idel_state,start,data_f_state}state;
state pr_st,nx_st;
logic [3:0]count,count_reg;

always_ff @(posedge clk, posedge rst)
begin 
if(rst==1'b1)
pr_st<=idel_state;
else 
pr_st<=nx_st;
end
  
assign d_out=(done==1'b1)?d_reg[8:1]:8'hff;
assign done=(done_reg==1'b1); 

always_comb  begin 
case(pr_st)
idel_state: 
begin
nx_st=start;
end  
start:  begin
if(rx==1'b0)  nx_st=data_f_state;	
else 	
nx_st=start;
end
data_f_state:
begin
if(done_reg==1'b1)
nx_st=start;
else
nx_st=data_f_state;
end 
endcase end

always@(posedge clk) begin
case(pr_st)
idel_state :begin 
d_reg=11'b11111111111;
count<=4'd0;
end
  
start: begin  
d_reg=11'b11111111111;
count<=4'd0; 
d_reg[0]=rx;
end

data_f_state: begin
if(baud_trig==1'b1)
begin 
d_reg=d_reg<<1;
d_reg[0]=rx;
count<=count_reg;    
end end
endcase end 
  
assign count_reg=(count==4'd11||pr_st==2'd1)?4'd0:count+1'b1; 
assign done_reg=(count_reg==4'd11);  
assign in_parity=^d_reg[8:1];
 
endmodule