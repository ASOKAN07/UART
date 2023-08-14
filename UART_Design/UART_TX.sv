module uart_tx(clk,rst,wr_en,baud_trig,d_in,done,tx);
input logic clk,rst,wr_en;
input logic [7:0] d_in;
output logic tx,done;
input logic baud_trig;
logic wr_en_reg;
logic parity;
logic [9:0] d_reg;
logic tx_reg,done_reg;
localparam start_bit=1'b0, stop_bit=1'b1;
typedef enum {idel_state,start,data_f_state,stop}state;
state pr_st,nx_st;
logic [3:0]count;
assign parity=^d_in;   
always_ff @(posedge clk, posedge rst)
begin 
if(rst==1'b1)
pr_st<=idel_state;
else 
pr_st<=nx_st;
end

assign tx=tx_reg;
assign done=done_reg;

always_latch 
begin 
case(pr_st)
idel_state: 
begin 
tx_reg=1'b1;
done_reg=1'b0;
d_reg=8'd0;
count=4'd0;
nx_st=stop; 
end

stop: 
begin 
	tx_reg=1'b1;
  	done_reg=1'b0;
    if(wr_en_reg==1'b1)
	begin
    d_reg={parity,d_in,1'b1};
    $display("%b",d_reg);
    nx_st=start;
	end
else if(wr_en_reg==1'b0)
nx_st=stop;
end

start: 
begin
if(baud_trig==1'b1) begin
	tx_reg=1'b0;
	nx_st=data_f_state;
end
end
data_f_state:
begin
	if(baud_trig==1'b1)
	begin  
        	tx_reg=d_reg[9];
			d_reg=d_reg<<1;
			count=count+1;
    	if( count==4'd11)
			begin 
			count=4'd0;
          	done_reg=1'b1; 
            tx_reg=1'b1;
            nx_st=stop;
	     	end
	end
	else 
	nx_st=data_f_state;
end
endcase 
 end 
      
  always_ff@(posedge clk)
    begin 
      if(rst==1'b1) 
      wr_en_reg<=1'b0;  
      else 
      wr_en_reg<=wr_en;
       end
endmodule
