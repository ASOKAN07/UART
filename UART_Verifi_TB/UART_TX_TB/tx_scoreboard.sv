class scoreboard;

 mailbox ref2sb;
 mailbox rd_mob2sb;
 int count=0;

transaction ref_trans,data2send;
mailbox sb2tx_cov;
  
 transaction trans_actual;
function new(mailbox ref2sb,mailbox rd_mob2sb,mailbox    sb2tx_cov);
  this.ref2sb=ref2sb;
  this.rd_mob2sb=rd_mob2sb;
  this.sb2tx_cov=sb2tx_cov;
endfunction 
  
  virtual task start();
    begin 
  fork
   forever begin 
     ref2sb.get(ref_trans);
     drive_cnt=drive_cnt+1;
   end
   forever begin 
     rd_mob2sb.get(trans_actual);
     //data2send=new trans_actual;
     
     mon_cnt=mon_cnt+1;
    if(mon_cnt>0) begin 
    compare();
   sb2tx_cov.put( trans_actual);
   end
end
  join_none
    end 
  endtask 
  
  virtual task compare();
   
    count =0;
    $display("UART TX Trascation count    =   %0d\n UART_TX Transmited Data =     %b\nUART_TX Received Data    = %b %b %b %b\n-------------Result-----------",mon_cnt,ref_trans.ref_arry_with_parity[mon_cnt-1][7:0],trans_actual.d_rcv[10],trans_actual.d_rcv[9],trans_actual.d_rcv[8:1],trans_actual.d_rcv[0]);
    if(trans_actual.d_rcv[10]==1'b0 && trans_actual.d_rcv[0]==1'b1)  begin 
      $display("Received Data stop and start bit are correct"); count=count+1;
    end
else $display("\n---xxx Received Data stop and start bit are correct---xxx");
    
    if(trans_actual.d_rcv[9]==ref_trans.ref_arry_with_parity[mon_cnt-1][8]) begin 
      $display("Received Data Parity bit is correct"); count=count+1; end
else $display("---xxx Received parity bit  Incorrect xxx---");               
    
    if(trans_actual.d_rcv[8:1]==ref_trans.ref_arry_with_parity[mon_cnt-1][7:0]) begin
      $display("Received Data is correct and it is match with reference model"); count=count+1; end
else  $display("xxx---Received Data bit are Incorrect---xxx");
    
    if(count==3) begin 
      $display("-------Scoreboard Result Pass-------");
      success_count= success_count+1;
    end
    else begin 
      $display("XXX----Scoreboard Result Fail-----XXX");
     error_count=error_count+1;
    end $display("============================================================");
  endtask
endclass
