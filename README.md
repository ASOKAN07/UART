# UART
UART Design and Verification - System Verilog 
-----------------------------------------------------
Designed UART does Tx and Rx at the baud clock of 9600 baud rate and 12 Mhz
Implemented FIFO to support different clock domain interface at the external interface of UART Tx and Rx.
The common FIFO has a depth of 16, each having 8-bit data storage
The current design is based on an even parity data frame.

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


UART_Tx Verification  architecture  
------------------------------------------------------

![image](https://github.com/ASOKAN07/UART/assets/140265974/28e00314-6649-4ddd-8db3-988b3586a23d)


**Tx Environment**: This is the component that contains the handles of testbench components such as UART_Tx Generator, Tx rd mon, Tx_wr_mon, UART_Tx_wr_drv, Tx Reference Model, and, scoreboard. And the components are communicated via mailbox communication.

**Tx Generator**: This is the component that generates the UART_Tx signals. It can be configured to generate a variety of data and dives the data to the DUT_UART_Tx through UART_Tx_wr_Driver.

**Transaction**: This is the component that has the variable to generate constraint-based random data to generate possible values to drive.

**Scoreboard:** This is a Comparator that compares the data which is received by the dut with the data sent by the UART_Tx Testbench

**Tx Reference Model**: This is a component to store the Reference data of the UART_Tx DUT. It is used to verify that the UART_Tx signals received by the UART_Tx rd monitor are correct.

**Tx wr dev**: This is the device that writes the UART_Tx signals to the UART_Tx DUT.

**Tx_wr_mon:** This is the monitor that verifies that the UART_Tx signals are written correctly to the UART_Tx DUT.

**Tx_rd_mon:** This is the monitor that verifies that the UART_Tx signals are read  from the UART_Tx DUT.

**Interface:** This is the interface between the UART_Tx DUT and the UART_Tx testbench. It is responsible for transferring the UART_UART_Tx signals between the two modules DUT and Testbech.

**Coverage module:** This Finds which functionalities/features of the design have been exercised by the tests. This is useful in constrained random verification (CRV) to know what features have been covered by a set of tests in a regression

**Path:** UART/UART_Verifi_TB/UART_TX_TB


UART_Rx Verification  architecture  
------------------------------------------------------
![image](https://github.com/ASOKAN07/UART/assets/140265974/19b66bb9-bc8e-4737-8414-a7a1d8fa3b0f)


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


Simulated verification output for Designed UART
--------------------------------------------------------
Verified the current design using various test cases with a designed verification environment as mentioned in the verification architecture of respective UART_Tx and UART_Rx.
These various test cases are written to cover even parity combinations initially (also cover's all its respective boundary conditions) and cover all other possible DATA input combinations using Random constrain based test cases. 

The current UART was simulated in EDA playground and its respective generated output waveform are

**The Output waveform for UART_Tx for random test cases**


<img width="943" alt="TX_random_wafeform" src="https://github.com/ASOKAN07/UART/assets/140265974/120b85a3-4de2-4ca5-bdbb-93d15b32fb72">


**The Output waveform for UART_Rx for random test cases**


<img width="943" alt="RX_random_waveform" src="https://github.com/ASOKAN07/UART/assets/140265974/b02d2ae6-060f-4a7b-95d6-24cb36e47fef">

Functional Coverage 
-------------------

The verification is complete with the coverage model having 100% coverage of functional aspects.
The current design also covers all its functionality through the written random tests resulting in 100% functional coverage, with the help of the Questasim tool.
**The Output Coverage report for UART_Tx for random test cases**


![image](https://github.com/ASOKAN07/UART/assets/140265974/de86e532-ebcc-464e-af73-df18a3b03c98)


**The Output Coverage report for UART_Rx for random test cases**


![Uploading image.png…]()

  
Initially, the coverage was reported as 76% which was improved with the addition and updation of various other cover bins, thus singing the coverage by 100%.
