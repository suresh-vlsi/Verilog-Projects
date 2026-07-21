# 9_SPI_Master

## Overview

This project implements an **SPI (Serial Peripheral Interface) Master** in Verilog HDL. The SPI Master transmits 8-bit data to an SPI slave using the MOSI line while generating the serial clock (`SCLK`) and chip select (`CS`). The design uses a Finite State Machine (FSM) and a shift register to serialize data.

---

## Features

- SPI Master implementation
- FSM-based control
- 8-bit serial transmission
- Shift register based serializer
- Chip Select (CS) generation
- Busy and Done status signals
- Synthesizable RTL
- Verilog testbench
- Waveform generation

---

## SPI Signals

| Signal | Direction | Description |
|--------|-----------|-------------|
| MOSI | Master → Slave | Master Out Slave In |
| MISO | Slave → Master | Master In Slave Out *(not implemented)* |
| SCLK | Master → Slave | Serial Clock |
| CS | Master → Slave | Chip Select (Active Low) |

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk | 1 | System clock |
| rst | 1 | Asynchronous reset |
| start | 1 | Starts SPI transmission |
| tx_data | 8 | Parallel data to transmit |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| sclk | 1 | SPI serial clock |
| mosi | 1 | SPI data output |
| cs | 1 | Chip select (active low) |
| busy | 1 | Transmission in progress |
| done | 1 | One-clock pulse after transmission |

---

## FSM States

| State | Description |
|--------|-------------|
| IDLE | Wait for start |
| LOAD | Load transmit data |
| SHIFT | Shift out 8 bits |
| DONE | Finish transmission |

---

## State Diagram

```text
          +------+
          | IDLE |
          +------+
              |
           start
              |
              V
         +---------+
         |  LOAD   |
         +---------+
              |
              V
         +---------+
         | SHIFT   |
         +---------+
              |
         8 Bits Sent
              |
              V
         +---------+
         | DONE    |
         +---------+
              |
              +-------> IDLE
```

---

## Directory Structure

```text
9_SPI_Master/
│
├── rtl/
│   └── spi_master.v
│
├── tb/
│   └── spi_master_tb.v
│
├── sim/
├── waveform/
├── README.md
└── .gitignore
```

---

## Simulation

### Icarus Verilog

If using folders:

```bash
iverilog -o spi_master.out rtl/spi_master.v tb/spi_master_tb.v
```

If both files are in the same directory:

```bash
iverilog -o spi_master.out spi_master.v spi_master_tb.v
```

Run:

```bash
vvp spi_master.out
```

View waveform:

```bash
gtkwave spi_master.vcd
```

---

## Example Transmission

```
tx_data = 8'hA5

Binary:
10100101

MOSI Sequence (MSB First):
1 → 0 → 1 → 0 → 0 → 1 → 0 → 1
```

---

## Applications

- FPGA-to-sensor communication
- EEPROM/Flash memory interface
- ADC/DAC communication
- Display controllers
- Embedded systems
- Industrial automation

---

## Future Improvements

- Full-duplex communication (MISO support)
- Configurable clock divider
- Support for SPI Modes 0–3
- Variable data width
- FIFO buffering
- Multi-slave support
- Configurable bit order (MSB/LSB first)
- CRC/error detection

---

## Learning Outcomes

- SPI protocol basics
- FSM implementation
- Shift register design
- Serial communication
- Clock generation
- RTL development
- Testbench creation
- Waveform verification

---
