int rx_no_of_transaction = 100;
int rx_no_of_read_trans=0;
int rx_no_of_write_trans=0;

//`define ODD_PARITY
`define EVEN_PARITY
`include "environment.sv"
program  test_rx(UART_IF DUT_IF,input clk);  
  

 class my_trans extends transaction;
    bit [1:0] count;
    function void pre_randomize();
      bad_parity_bit.constraint_mode(0);
      count_odd.constraint_mode(0);
      count_even.constraint_mode(1);
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
  $display("-------------Even Parity Data Generating---------------");
  env_h.rx_gen_h.trans =my_tr;
  //env_h.rx_covgrp_h.RX_coverage.DATA.option.weight=0;
  //env_h.rx_covgrp_h.RX_coverage.DATA.option.weight=1'b0;
  //env_h.rx_covgrp_h.RX_coverage.PARITY_RX_0.option.weight=0;
  //env_h.rx_covgrp_h.RX_coverage.START_RX.option.weight=0;
  //env_h.rx_covgrp_h.RX_coverage.STOP_RX.option.weight=0;
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

/*
class test;
  virtual UART_IF.WRD_RX_M WRD_IF;
  virtual UART_IF.WRM_RX_M WRM_IF;
  virtual UART_IF.RDM_RX_M RDM_IF;
  virtual UART_IF.RDD_RX_M RDD_IF;
  environment env_h;
  function new(virtual UART_IF.WRD_RX_M WRD_IF,
  virtual UART_IF.WRM_RX_M WRM_IF,
  virtual UART_IF.RDM_RX_M RDM_IF,  virtual UART_IF.RDD_RX_M RDD_IF);
 
    this.WRD_IF=WRD_IF;
    this.WRM_IF=WRM_IF;
    this.RDM_IF=RDM_IF;
    this.RDD_IF=RDD_IF;
    env_h=new(WRD_IF,WRM_IF,RDM_IF,RDD_IF);
  endfunction 
  
  task build_and_run;
  env_h.build();
  env_h.run();
  endtask 
  
endclass*/
