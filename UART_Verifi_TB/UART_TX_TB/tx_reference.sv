class  reference;
  
  mailbox ref2sb;
  mailbox wr_mon2ref;
  transaction trans,tr;
  int i;
  function new(mailbox wr_mon2ref,mailbox ref2sb);
  	this.wr_mon2ref=wr_mon2ref;
  	this.ref2sb=ref2sb;
  endfunction 
  virtual task start();
    trans=new;
    trans.ref_arry_with_parity=new[no_of_trans];
    fork       
        forever begin   
          wr_mon2ref.get(tr);
          if(tr.wr_en==1) begin
 trans.ref_arry_with_parity[i]={(^tr.wr_data),tr.wr_data};
         	i=i+1;
            ref2sb.put(trans);
            
          end
        end
       
    join_none
  endtask
 
endclass