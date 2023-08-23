module fifo(clk,reset,wr_en,rd_en,d_in,d_out,fifo_empty,fifo_full);
input clk,reset,wr_en,rd_en;
input [7:0]d_in;
output logic [7:0]d_out;
output logic fifo_empty,fifo_full;
  //logic fifo_empty_reg;
integer i;

logic [4:0] wr_ptr,rd_ptr;
reg [7:0] fifo_reg [0:15];
always @(posedge clk) 
begin 
if (reset==1'b1) begin
  for (i=0;i<16;i=i+1) begin 
    fifo_reg[i][7:0]=8'b0;
	end
	wr_ptr=5'd0;
	end
else
begin 
  if(wr_en==1'b1 && fifo_full==1'b0)   
        begin 
       fifo_reg[wr_ptr][7:0]=d_in[7:0];
		wr_ptr=wr_ptr+1'b1;
		if(wr_ptr>5'd15)
			wr_ptr=5'd0;
        end
end
end

always@(posedge clk)
begin
if(reset==1'b1) begin
rd_ptr=5'd0;
d_out=8'b00000000; 
end

else
begin
  if(rd_en==1'b1 && fifo_empty==1) 
	begin
		
	d_out=fifo_reg[rd_ptr];
    rd_ptr=rd_ptr+1'b1;
      if(rd_ptr>5'd15)
          rd_ptr=5'd0;
    end

end
end
 
assign fifo_empty=(rd_ptr==wr_ptr)?1'b0:1'b1;
assign fifo_full=(rd_ptr>wr_ptr)?(((rd_ptr-wr_ptr)==1)?1'b1:1'b0):(((wr_ptr-rd_ptr)>=5'd15)?1'b1:1'b0);

  
endmodule
