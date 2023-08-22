int rx_no_of_transaction =30;
int rx_no_of_read_trans=0;
int rx_no_of_write_trans=0;

`define ODD_PARITY
`define EVEN_PARITY
`include "environment.sv"

program  test_rx(UART_IF DUT_IF,input clk);  
 
class my_trans extends transaction; 
   
  bit [1:0] count;
  
  function void pre_randomize();
      
      bad_parity_bit.constraint_mode(0);
    count_odd.constraint_mode(0);
      count_even.constraint_mode(0);
      good_parity_bit.constraint_mode(1);
    endfunction
    
  endclass
  
  
environment env_h;
my_trans my_tr;
  
initial begin 
  reset_dut();  
  env_h=new(DUT_IF,DUT_IF,DUT_IF,DUT_IF);
  env_h.build();
  my_tr=new();
  $display("-------------Random Parity Data Generating---------------");
  env_h.rx_gen_h.trans =my_tr;
  env_h.run();
end 
  
 task reset_dut();
   @(posedge clk) DUT_IF.reset=1'b1;
   repeat(5)   @(posedge clk);
  DUT_IF.reset=1'b0;
   DUT_IF.rx=1'b1;
  $display("Restting DUT----------- ");
  endtask
endprogram 
