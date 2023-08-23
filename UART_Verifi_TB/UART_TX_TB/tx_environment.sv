  int error_count=0;
  int success_count=0;

`include "tx_transaction.sv"
`include "tx_coverage.sv"
`include "tx_w_driver.sv"
`include "tx_w_monitor.sv"
`include "tx_r_monitor.sv"
`include "tx_generator.sv"
`include "tx_reference.sv"
`include "tx_scoreboard.sv"

class environment;
  
  mailbox gen2tx_drv=new();
  mailbox wr_mon2ref =new();
  mailbox rd_mon2ref=new();
  mailbox ref2sb=new();
  mailbox rd_mon2sb=new();
  mailbox sb2tx_cov=new();
  
tx_generator tx_gen_h;
tx_w_driver tx_w_drv;
tx_w_monitor tx_w_mon;
tx_r_monitor tx_r_mon;
tx_coverage tx_covgrp_h;  
reference tx_ref_h; 
scoreboard tx_sb_h;  


virtual UART_IF.WRD_TX_M WRD_IF;
virtual UART_IF.WRM_TX_M WRM_IF;
virtual UART_IF.RDM_TX_M RDM_IF;

function new( virtual UART_IF.WRD_TX_M WRD_IF, virtual UART_IF.WRM_TX_M WRM_IF, virtual UART_IF.RDM_TX_M RDM_IF);
  this.WRD_IF=WRD_IF;
  this.WRM_IF=WRM_IF;
  this.RDM_IF=RDM_IF;
endfunction 
  
task build();  
  $display("----Environment Build ");
  tx_gen_h=new(gen2tx_drv);
  tx_w_drv=new(WRD_IF,gen2tx_drv);
  tx_w_mon=new(WRM_IF,wr_mon2ref);
  tx_r_mon=new(RDM_IF,rd_mon2sb);
  tx_ref_h=new(wr_mon2ref,ref2sb);
  tx_sb_h=new(ref2sb,rd_mon2sb,sb2tx_cov);
  tx_covgrp_h=new(sb2tx_cov);
endtask
  
virtual task reset_dut();
  $display("---Reset DUT from ENv---");
  @(WRD_IF.WRD_TX_CB);
  WRD_IF.WRD_TX_CB.reset<=1'b1;
  WRD_IF.WRD_TX_CB.d_in<=8'dx;
  WRD_IF.WRD_TX_CB.wr_en<=1'b0;
  repeat(5) @(WRD_IF.WRD_TX_CB);
  WRD_IF.WRD_TX_CB.reset<=1'b0;
endtask
  
 virtual task stop_dut;
 wait(mon_cnt==no_of_trans && mon_cnt==drive_cnt);

endtask
  
  virtual task start_dut();
   $display("----Environment Start ");
   fork  
   tx_gen_h.start();
   tx_w_drv.start();
   tx_r_mon.start();
   tx_w_mon.start();
   tx_ref_h.start();
   tx_sb_h.start();
   tx_covgrp_h.start();
   join_any
 endtask
 
task run();  
 reset_dut(); 
 start_dut();
 stop_dut();
reset_dut(); 
report_tx();
endtask
  
task report_tx;
  $display("coverage     =%0.2f %%\n Number of test case generate =%d\n Number of test case pass     =%d\n Number of testcase fail        =%d",tx_covgrp_h.Tx_coverage.get_inst_coverage(),
  no_of_trans,success_count, error_count);
 $finish;
endtask
  
endclass
