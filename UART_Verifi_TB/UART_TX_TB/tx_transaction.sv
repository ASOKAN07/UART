class transaction;
  rand bit [7:0]data;
  bit wr_en;
  logic tx;
  logic tx_full;
  logic [10:0]d_rcv;
  bit[7:0]wr_data;
  bit ref_parity;
  bit [8:0] ref_arry_with_parity[];
  
constraint data_same{unique {data};} 
constraint count_odd{($countones(data))%2==1'b0;};
constraint count_even{($countones(data))%2==1'b1;}  
constraint range_data{data  dist {[0:7]:/5,[8:15]:/5,[16:31]:/5,[32:63]:/5,[64:127]:/5,[128:255]:/5};} 
  
function void post_randomize();
  $display("Randomize data =%d ",data);
  endfunction     
  
endclass
