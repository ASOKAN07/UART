int no_of_pass=0;
int no_of_fail=0;

`include "transaction.sv"
`include "rx_reference.sv"
`include "rx_scoreboard.sv"
`include "rx_rd_monitor.sv"
`include "rx_rd_driver.sv"
`include "rx_wr_driver.sv"
`include "rx_wr_monitor.sv"
`include "uart_coverage.sv"
`include "generator.sv"

class environment;

  virtual UART_IF.WRD_RX_M WRD_IF;
  virtual UART_IF.WRM_RX_M WRM_IF;
  virtual UART_IF.RDM_RX_M RDM_IF;
  virtual UART_IF.RDD_RX_M RDD_IF;

  mailbox gen2rx_drv=new;
  mailbox wr_mon2rx_ref=new; 
  mailbox rdmon2rx_sb=new;
  mailbox ref2rx_sb=new;
  mailbox grn_2cov=new;
  
  rx_wr_driver  rx_w_drv_h;
  rx_wr_monitor rx_w_mon_h;
  rx_rd_monitor rx_r_mon_h;
  rx_rd_driver  rx_r_drv_h;
  rx_scoreboard rx_sb_h;
  rx_generator  rx_gen_h;
  rx_referece   rx_ref_h;
  uart_coverage rx_covgrp_h;

function new(virtual UART_IF.WRD_RX_M WRD_IF,virtual UART_IF.WRM_RX_M WRM_IF,virtual UART_IF.RDM_RX_M RDM_IF,virtual UART_IF.RDD_RX_M RDD_IF);
    this.WRD_IF=WRD_IF;
    this.WRM_IF=WRM_IF;
    this.RDM_IF=RDM_IF;
    this.RDD_IF=RDD_IF;

endfunction 
  
task build();
  $display("UART RX Environment is Build");
  rx_gen_h=new(gen2rx_drv,grn_2cov);
  rx_w_drv_h=new(WRD_IF,gen2rx_drv);     
  rx_w_mon_h=new(WRM_IF,wr_mon2rx_ref);
  rx_r_drv_h=new(RDD_IF);
  rx_ref_h=new(wr_mon2rx_ref,ref2rx_sb);
  rx_r_mon_h=new(RDM_IF,rdmon2rx_sb);
  rx_sb_h=new(rdmon2rx_sb,ref2rx_sb); 
  rx_covgrp_h=new(grn_2cov);
endtask

virtual task  start_dut;
 fork 
   $display("Start metode-----");
  rx_gen_h.start();
  rx_w_drv_h.start();
  rx_r_drv_h.start();
  rx_r_mon_h.start();
  rx_w_mon_h.start();
  rx_sb_h.start();
  rx_ref_h.start();
  rx_covgrp_h.start();
 join_any
endtask
  
  virtual task stop_dut();
wait ( rx_no_of_write_trans==rx_no_of_transaction && rx_no_of_read_trans==rx_no_of_write_trans);
    $display("Total number of trans =%d\n Number of pass transaction =%d\n Number of fail transaction= %d",rx_no_of_transaction,no_of_pass,no_of_fail);
    $display("coverage =%0.2f %%",rx_covgrp_h. RX_coverage.get_inst_coverage());
    
 #10 $finish;
  endtask

task run();
  start_dut(); 
  stop_dut();
  
endtask
endclass