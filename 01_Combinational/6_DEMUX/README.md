# 6_DEMUX1to2

## Overview

The **1-to-2 Demultiplexer (DEMUX 1:2)** is a fundamental combinational logic circuit in digital electronics. A Demultiplexer acts as a **data distributor**, routing a **single input signal** to one of multiple output lines based on the value of a **Select (S)** signal.

A 1-to-2 DEMUX has:

- **One Data Input:** `D`
- **One Select Input:** `S`
- **Two Outputs:** `Y0`, `Y1`

Depending on the Select signal:

- If `S = 0`, the input is routed to **Y0**.
- If `S = 1`, the input is routed to **Y1**.

The DEMUX is widely used in **data routing, communication systems, processor datapaths, memory systems, FPGA designs, ASICs, and digital control circuits**.

This project presents a synthesizable Verilog implementation of a **1-to-2 Demultiplexer** along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Pure combinational logic
- One input distributed to two outputs
- FPGA/ASIC compatible
- Beginner-friendly implementation
- Exhaustive verification
- GTKWave waveform generation

---

# Theory

A Demultiplexer performs the reverse operation of a Multiplexer.

It accepts:

```
Data Input

D

Select Line

S

Outputs

Y0
Y1
```

Selection rule

```
S = 0

Y0 = D

Y1 = 0
```

```
S = 1

Y0 = 0

Y1 = D
```

---

# Boolean Equations

The Boolean equations are

```
Y0 = D · S̅

Y1 = D · S
```

where

```
S̅ = NOT S
```

Equivalent Verilog implementation

```verilog
assign Y0 = (~S) ? D : 1'b0;

assign Y1 = (S) ? D : 1'b0;
```

---

# Block Diagram

```
                 +------------------+
D -------------->|                  |
                 |    1:2 DEMUX     |
S -------------->|                  |
                 +------------------+
                  |              |
                  |              |
                 Y0             Y1
```

---

# Logic Diagram

```
                  D -------------AND-------- Y0
                                 ^
                                 |
                              NOT S

                  D -------------AND-------- Y1
                                 ^
                                 |
                                 S
```

---

# Truth Table

| Select (S) | Data (D) | Y0 | Y1 |
|------------|----------|----|----|
|0|0|0|0|
|0|1|1|0|
|1|0|0|0|
|1|1|0|1|

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| D | 1 | Data Input |
| S | 1 | Select Line |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Y0 | 1 | Output 0 |
| Y1 | 1 | Output 1 |

---

# RTL Description

The RTL implementation uses conditional assignments.

```verilog
assign Y0 = (~S) ? D : 1'b0;

assign Y1 = (S) ? D : 1'b0;
```

Equivalent implementation using Boolean expressions

```verilog
assign Y0 = D & ~S;

assign Y1 = D & S;
```

Since the circuit is purely combinational:

- No clock
- No reset
- No FSM
- Zero clock latency

---

# Hardware Implementation

A 1-to-2 DEMUX can be implemented using:

- One NOT gate
- Two AND gates

```
                    D --------AND---------- Y0
                               ^
                               |
                            NOT S

                    D --------AND---------- Y1
                               ^
                               |
                               S
```

---

# Working Principle

### Case 1

```
S = 0

D = 1

Output

Y0 = 1

Y1 = 0
```

---

### Case 2

```
S = 1

D = 1

Output

Y0 = 0

Y1 = 1
```

---

### Case 3

```
D = 0

Regardless of Select

Outputs remain LOW
```

---

---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o demux1to2.out demux1to2.v demux1to2_tb.v
```

### Run

```bash
vvp demux1to2.out
```

### View Waveform

```bash
gtkwave demux1to2.vcd
```

---

# Expected Console Output

```
S D | Y0 Y1
-----------
0 0 | 0  0
0 1 | 1  0
1 0 | 0  0
1 1 | 0  1
```

---

# Expected Waveform

```
S
0011

D
0101

Y0
0100

Y1
0001
```

---

# Verification

The testbench verifies all possible input combinations.

| Test | S | D | Expected Y0 | Expected Y1 |
|------|---|---|-------------|-------------|
|1|0|0|0|0|
|2|0|1|1|0|
|3|1|0|0|0|
|4|1|1|0|1|

---

# Applications

1-to-2 Demultiplexers are widely used in:

- Data routing
- Bus switching
- Communication systems
- Memory address decoding
- FPGA routing
- ASIC datapaths
- Serial-to-parallel conversion
- Digital control systems
- Signal distribution
- Embedded systems

---

# Advantages

- Simple hardware implementation
- Fast switching
- Low propagation delay
- FPGA-friendly
- Easily scalable to larger DEMUX designs

---

# Limitations

- Can distribute data to only one of two outputs.
- Larger systems require cascading multiple DEMUX circuits.

---

# Multiplexer vs Demultiplexer

| Feature | Multiplexer | Demultiplexer |
|----------|-------------|---------------|
|Function|Selects one input|Routes one input|
|Inputs|Many|One|
|Outputs|One|Many|
|Select Lines|Choose input|Choose output|
|Application|Data Selection|Data Distribution|

---

# DEMUX Comparison

| DEMUX | Inputs | Outputs | Select Lines |
|--------|--------|----------|--------------|
|1:2|1|2|1|
|1:4|1|4|2|
|1:8|1|8|3|
|1:16|1|16|4|

---

# FPGA/ASIC Design Flow

```
Specification
      │
      ▼
RTL Design
      │
      ▼
Testbench Development
      │
      ▼
Simulation
      │
      ▼
Waveform Verification
      │
      ▼
Synthesis
      │
      ▼
Place & Route
      │
      ▼
FPGA Bitstream / ASIC GDSII
```

---

---

# Future Enhancements

- 1-to-4 Demultiplexer
- 1-to-8 Demultiplexer
- 1-to-16 Demultiplexer
- Parameterized N-to-1 Demultiplexer
- Multiplexer-Demultiplexer Communication System
- Memory Decoder
- Bus Arbitration Logic

---
