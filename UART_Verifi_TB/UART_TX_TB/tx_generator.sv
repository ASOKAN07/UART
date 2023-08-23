
class tx_generator;
  transaction trans;
  mailbox drv_2gen;
  transaction data2send;
  mailbox gen2tx_drv;
  function new(mailbox gen2tx_drv);
  this.gen2tx_drv=gen2tx_drv;
  this.drv_2gen=drv_2gen;
  trans=new;
  endfunction 
  
virtual task start();
  $display("----Genetaror start ");
   fork
     for(int i=0;i<no_of_trans;i++)
      begin
      
      if(!(trans.randomize())) begin  
$display("Genetaror :Randomize is not set properly",$time);
           $stop;
        end
        data2send=new trans;
        gen2tx_drv.put(data2send);
      end
    join_none
  endtask
endclass