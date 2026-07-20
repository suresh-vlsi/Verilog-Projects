# 3_UART_Transmitter

## Overview

This project implements a **UART (Universal Asynchronous Receiver Transmitter) Transmitter** in Verilog HDL. The transmitter converts an 8-bit parallel input into a serial data stream following the standard UART protocol. It is designed using a Finite State Machine (FSM) and is fully verified using a self-checking testbench.

---

## Features

- Parameterized clock frequency
- Parameterized baud rate
- 8-bit data transmission
- One start bit
- One stop bit
- LSB-first transmission
- Busy flag during transmission
- FSM-based implementation
- Synthesizable RTL
- Testbench with multiple transmission cases

---

## UART Frame Format

```
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
  1      0      LSB -----------------------------> MSB     1
```

Example for transmitting **8'h55**

```
Data = 8'h55

Binary:
01010101

UART Transmission (LSB First)

Start
  |
  V

0 1 0 1 0 1 0 1 0 1

^               ^
Start         Stop
```

---

## State Machine

The transmitter operates using four states.

| State | Description |
|--------|-------------|
| IDLE | Waits for `tx_start` signal |
| START | Sends the start bit (`0`) |
| DATA | Sends 8 data bits (LSB first) |
| STOP | Sends the stop bit (`1`) and returns to IDLE |

State Diagram

```
           +--------+
           | IDLE   |
           +--------+
                |
           tx_start
                |
                V
           +--------+
           | START  |
           +--------+
                |
                V
           +--------+
           | DATA   |
           +--------+
                |
                V
           +--------+
           | STOP   |
           +--------+
                |
                +-----------> IDLE
```

---

## Directory Structure

```
3_UART_Transmitter/
│
├── rtl/
│   └── uart_tx.v
│
├── tb/
│   └── uart_tx_tb.v
│
├── sim/
│
├── waveform/
│
└── README.md
```

---

## Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| CLK_FREQ | Input clock frequency | 50 MHz |
| BAUD_RATE | UART baud rate | 9600 bps |

Clock cycles per bit

```
CLKS_PER_BIT = CLK_FREQ / BAUD_RATE

For 50 MHz and 9600 baud

CLKS_PER_BIT = 50,000,000 / 9600
             = 5208 clock cycles
```

---

## Inputs

| Signal | Width | Description |
|----------|------|-------------|
| clk | 1 | System clock |
| rst | 1 | Asynchronous reset |
| tx_start | 1 | Starts transmission |
| tx_data | 8 | Parallel input data |

---

## Outputs

| Signal | Width | Description |
|----------|------|-------------|
| tx | 1 | UART serial output |
| tx_busy | 1 | Indicates transmitter is busy |

---

## Simulation

### Icarus Verilog

Compile

```bash
iverilog -o uart_tx.out rtl/uart_tx.v tb/uart_tx_tb.v
```

Run

```bash
vvp uart_tx.out
```

View Waveform

```bash
gtkwave uart_tx.vcd
```

---

### ModelSim / QuestaSim

```tcl
vlib work
vlog rtl/uart_tx.v
vlog tb/uart_tx_tb.v
vsim uart_tx_tb
add wave *
run -all
```

---

## Expected Timing

```
Idle

tx = 1

          Start

            |
            V

1 1 1 1 0 D0 D1 D2 D3 D4 D5 D6 D7 1 1 1

          <---- One UART Frame ---->
```

---

## Sample Transmission

Input

```
tx_data = 8'hA3
```

Binary

```
10100011
```

LSB-first transmission

```
Start

0

1

1

0

0

0

1

0

1

Stop

1
```

---

## Applications

- FPGA communication
- Embedded systems
- Microcontroller interfacing
- Serial communication
- Debug UART
- Sensor communication
- FPGA-to-PC communication

---

## Future Improvements

- Configurable parity bit
- Multiple stop bits
- Variable data length (5–9 bits)
- Baud rate generator
- FIFO buffering
- Flow control (RTS/CTS)
- Break signal support
- AXI/APB interface

---

## Learning Outcomes

After completing this project, you will understand:

- UART communication protocol
- Finite State Machine (FSM) design
- Serial data transmission
- Parameterized Verilog modules
- Clock-based timing control
- Testbench development
- Waveform analysis
- FPGA implementation concepts

---

## Author

**Suresh Kumar**

Aspiring VLSI Design Engineer

GitHub: *Add your GitHub profile link here*

LinkedIn: *Add your LinkedIn profile link here*

---

## License

This project is released under the MIT License.