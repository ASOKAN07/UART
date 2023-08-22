class rx_referece;
  mailbox wr_mon2rx_ref; 
  mailbox ref2rx_sb;
  transaction trans,data2send;
  int i;
  
function new(mailbox wr_mon2rx_ref,mailbox ref2rx_sb);
   this.wr_mon2rx_ref=wr_mon2rx_ref;
   this.ref2rx_sb=ref2rx_sb;
   $display("UART RX Reference Model is Build");
endfunction

virtual task start();
  data2send=new;
  data2send.rx_d_ref=new[rx_no_of_transaction];
  i=0;
  fork forever 
  begin 
  wr_mon2rx_ref.get(trans);
   if(trans.rx==0) begin
    data2send.rx_d_ref[i][0]=trans.rx; 
    repeat(10)  begin 
    wr_mon2rx_ref.get(trans);
    data2send.rx_d_ref[i]=data2send.rx_d_ref[i]<<1;
    data2send.rx_d_ref[i][0]= trans.rx;
    end
  ref2rx_sb.put(data2send);
  i=i+1;
 end end
join_none
endtask
endclass
