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

The complete RTL of the UART core path is mentioned below.
UART_Design/*.sv

UART Verification  architecture  
------------------------------------------------------
There are 2 parts in the UART core, which is the transmitter and receiver path. These 2 Blocks work independently so separate test benches are implemented for each

![image](https://github.com/ASOKAN07/UART/assets/140265974/28e00314-6649-4ddd-8db3-988b3586a23d)




UART_Rx Verification  architecture  
------------------------------------------------------

![image](https://github.com/ASOKAN07/UART/assets/140265974/505154bb-0200-4d62-9819-c4ce240025ff)

Rx Environment: This is the component that contains the handles of testbench components such as UART_Rx Generator, Rx rd mon, Rx_wr_mon, UART_Rx_wr_drv, Rx Reference Model, scoreboard, and UART_Rx rd_drv. And the components are communicated via mailbox communication.

**Rx Generator**: This is the component that generates the UART_Rx signals. It can be configured to generate a variety of data and dives the data to the DUT_UART_Rx through UART_Rx_wr_Driver.

**Transaction**: This is the component that has the variable to generate constraint-based random data to generate possible values to drive.

**Scoreboard:** This is a Comparator that compares the data which is received by the dut with the data sent by the UART_Rx Testbench

**Rx Reference Model**: This is a component to store the Reference data of the UART_Rx DUT. It is used to verify that the UART_Rx signals received by the UART_Rx rd monitor are correct.

**Rx wr dev**: This is the device that writes the UART_Rx signals to the UART_Rx DUT.

**Rx_wr_mon:** This is the monitor that verifies that the UART_Rx signals are written correctly to the UART_Rx DUT.

**Rx_rd_mon:** This is the monitor that verifies that the UART_Rx signals are read  from the UART_Rx DUT.

**Rx_rd_drv:** This is the device that reads and enables signals to the UART_UART_Rx DUT.

**Interface:** This is the interface between the UART_Rx DUT and the UART_Rx testbench. It is responsible for transferring the UART_UART_Rx signals between the two modules DUT and Testbech.

**Coverage module:** This Finds which functionalities/features of the design have been exercised by the tests. This is useful in constrained random verification (CRV) to know what features have been covered by a set of tests in a regression

**Path:** UART/UART_Verifi_TB/UART_RX_TB/


