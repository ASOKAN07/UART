int no_of_trans=30;
static int drive_cnt=0;
static int mon_cnt=-1;
`define EVEN_PARITY_1

`include "tx_environment.sv"
program test_tx(UART_IF DUT_IF);

  class my_trns extends transaction;
    
    function void pre_randomize();
    count_odd.constraint_mode(0);
    count_even.constraint_mode(1);
    endfunction 
  
  endclass
environment env_h;  
  
   my_trns tr;
  initial 
    begin 
  env_h=new(DUT_IF,DUT_IF,DUT_IF);
  tr=new;
  env_h.build();  
  env_h.tx_gen_h.trans=tr;
      $display("-------------EVEN Parity 1 Data Generating---------------");
  env_h.run();
    end 
endprogram
