# UART
UART Design and Verification - System Verilog 
-----------------------------------------------------
Designed UART does Tx and Rx at the baud clock of 9600 baud rate and 12 Mhz
Implemented FIFO to support different clock domain interface at the external interface of UART Tx and Rx.
The common FIFO has a depth of 16, each having 8-bit data storage

UART RTL architecture  
------------------------------------------------------
![image](https://github.com/ASOKAN07/UART/assets/140265974/ae06ec00-683a-4916-ae4a-6669fe80dbb5)
