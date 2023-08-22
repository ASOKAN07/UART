class rx_scoreboard;
  transaction data_rd_mon,data_ref;
  mailbox rdmon2rx_sb;
  mailbox ref2rx_sb;
  int cnt=0;
  function new(mailbox rdmon2rx_sb, mailbox ref2rx_sb);
  this.rdmon2rx_sb=rdmon2rx_sb;   
  this.ref2rx_sb=ref2rx_sb;
  $display("UART RX Scoreboard is Build");
  endfunction 

  virtual task start();
  fork forever begin 
   ref2rx_sb.get(data_ref);
   rx_no_of_write_trans=rx_no_of_write_trans+1; 
 end
  forever begin 
  rdmon2rx_sb.get(data_rd_mon);
  rx_no_of_read_trans=rx_no_of_read_trans+1;
  compare(); end
  join_none 
  endtask
 
virtual task compare();
  cnt=0;
  $display( "Transcation count =%0d \nUART Rx Transmitted  Data is =%b %b %b %b\nUART Rx received Data = %b\n----------------RESULT--------------------  ",rx_no_of_read_trans,data_ref.rx_d_ref[rx_no_of_read_trans-1][10],data_ref.rx_d_ref[rx_no_of_read_trans-1][9],data_ref.rx_d_ref[rx_no_of_read_trans-1][8:1],data_ref.rx_d_ref[rx_no_of_read_trans-1][0],data_rd_mon.d_out);
  if( data_ref.rx_d_ref[rx_no_of_read_trans-1][0]==1'b1 &&  data_ref.rx_d_ref[rx_no_of_read_trans-1][10]==1'b0) begin 
    $display("Transmited  data start bit and stop bits are correct"); cnt=cnt+1;  end 
  else
  $display("xxx----Transmited  data start bit and stop bits are Incorrect----xxx");
    
 if(^data_rd_mon.d_out==data_ref.rx_d_ref[rx_no_of_read_trans-1][9]) begin 
   $display("Received data of its Calculated parity is correct ");  cnt=cnt+1; end
 else 
   $display("xxx----Received data of its Calculated parity is Incorrect----xxx");
   
if(data_rd_mon.d_out==data_ref.rx_d_ref[rx_no_of_read_trans-1][8:1]) begin 
   $display("Received data of its Calculated parity is correct ");cnt=cnt+1; end
else 
  $display("xxx----Received data  Incorrect----xxx");

if(cnt==3)
  begin  
  $display("------------ScoreBoard Result Pass--------------");
  no_of_pass=no_of_pass+1;
  end
else begin 
  $display("------------ScoreBoard Result Fail--------------");
  no_of_fail=no_of_fail+1;
  end
$display("=======================================================");
endtask   
endclass
