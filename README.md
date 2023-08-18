# UART
UART Design and Verification - System Verilog 
-----------------------------------------------------
Designed UART does Tx and Rx at the baud clock of 9600 baud rate and 12 Mhz
Implemented FIFO to support different clock domain interface at the external interface of UART Tx and Rx.
The common FIFO has a depth of 16, each having 8-bit data storage

UART RTL architecture  
------------------------------------------------------
The complete RTL of UART comes with a bus interface(APB/AHB/WISHBONE), Register File, and UART core which does the transmission and reception part, but currently, only the UART Core and the supporting sv based testbench is implemented
The below diagram is an illustration of  a high-level block diagram of the UART core

![image](https://github.com/ASOKAN07/UART/assets/140265974/95cb33f2-2467-4e09-9651-aeb1dc11a9d6)


