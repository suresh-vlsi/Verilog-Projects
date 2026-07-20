# 4_UART_Receiver

## Overview

This project implements a **UART (Universal Asynchronous Receiver Transmitter) Receiver** in Verilog HDL. The receiver converts serial UART data into an 8-bit parallel output using a finite state machine (FSM). It samples the incoming data at the center of each bit period to improve reliability.

---

## Features

- Parameterized clock frequency
- Parameterized baud rate
- 8-bit UART reception
- Start-bit validation
- Stop-bit verification
- LSB-first data reception
- `rx_done` pulse after successful reception
- FSM-based architecture
- Synthesizable RTL
- Comprehensive Verilog testbench

---

## UART Frame Format

```
Idle | Start | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop
  1      0      LSB -----------------------------> MSB     1
```

---

## State Machine

| State | Description |
|--------|-------------|
| IDLE | Waits for a low start bit |
| START | Confirms the start bit by sampling mid-bit |
| DATA | Receives 8 data bits (LSB first) |
| STOP | Verifies stop bit and asserts `rx_done` |

```
          +--------+
          | IDLE   |
          +--------+
               |
         rx == 0
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
4_UART_Receiver/
│
├── rtl/
│   └── uart_rx.v
│
├── tb/
│   └── uart_rx_tb.v
│
├── sim/
├── waveform/
└── README.md
```

---

## Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `CLK_FREQ` | System clock frequency | 50 MHz |
| `BAUD_RATE` | UART baud rate | 9600 bps |

```
CLKS_PER_BIT = CLK_FREQ / BAUD_RATE

50,000,000 / 9600 ≈ 5208
```

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| `clk` | 1 | System clock |
| `rst` | 1 | Asynchronous reset |
| `rx` | 1 | UART serial input |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| `rx_data` | 8 | Received parallel data |
| `rx_done` | 1 | One-clock pulse indicating valid reception |

---

## Simulation

### Icarus Verilog

```bash
iverilog -o uart_rx.out rtl/uart_rx.v tb/uart_rx_tb.v
vvp uart_rx.out
gtkwave uart_rx.vcd
```

### ModelSim / QuestaSim

```tcl
vlib work
vlog rtl/uart_rx.v
vlog tb/uart_rx_tb.v
vsim uart_rx_tb
add wave *
run -all
```

---

## Sample Reception

Input frame for `8'hA3`:

```
Start  Data Bits (LSB First)        Stop
 0      1 1 0 0 0 1 0 1             1
```

Output:

```
rx_data = 8'hA3
rx_done = 1
```

---

## Applications

- FPGA serial communication
- UART terminal interface
- Embedded systems
- Sensor communication
- FPGA-to-PC communication
- Microcontroller peripherals

---

## Future Improvements

- Parity-bit support
- Configurable stop bits
- Framing error detection
- Overrun error detection
- Noise filtering
- Receive FIFO
- Configurable data widths (5–9 bits)
- Interrupt generation

---

## Learning Outcomes

- UART receive protocol
- Mid-bit sampling
- Finite State Machine (FSM) design
- Serial-to-parallel conversion
- Verilog RTL development
- Testbench creation
- Timing and waveform analysis

---
