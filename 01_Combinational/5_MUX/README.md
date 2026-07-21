# 5_MUX2to1

## Overview

The **2-to-1 Multiplexer (MUX 2:1)** is one of the most fundamental combinational logic circuits in digital electronics. A multiplexer acts as a **digital data selector**, choosing one of several input signals and forwarding the selected input to a single output based on the value of a **selection (Select) signal**.

A 2-to-1 Multiplexer has:

- **Two Data Inputs:** `I0`, `I1`
- **One Select Input:** `S`
- **One Output:** `Y`

When `S = 0`, the output follows `I0`.

When `S = 1`, the output follows `I1`.

Multiplexers are widely used in **CPUs, ALUs, FPGAs, ASICs, communication systems, datapaths, memory systems, and digital control circuits**.

This project provides a synthesizable Verilog implementation of a **2-to-1 Multiplexer** along with a comprehensive testbench for functional verification.

---

# Features

- Pure combinational logic
- Synthesizable Verilog RTL
- Simple data selector
- One-bit input selection
- FPGA/ASIC compatible
- Exhaustive verification
- GTKWave waveform generation
- Beginner-friendly design

---

# Theory

A Multiplexer (MUX) selects one input from multiple inputs.

For a 2-to-1 Multiplexer,

```
Inputs

I0
I1

Select

S

Output

Y
```

Selection rule

```
S = 0  →  Y = I0

S = 1  →  Y = I1
```

---

# Boolean Equation

The Boolean expression for a 2:1 Multiplexer is

```
Y = S̅·I0 + S·I1
```

where

```
S̅ = NOT S
```

Equivalent Verilog expression

```verilog
assign Y = (S) ? I1 : I0;
```

---

# Block Diagram

```
                +------------------+
I0 ------------>|                  |
                |                  |
I1 ------------>|     2:1 MUX      |------ Y
                |                  |
S ------------->|                  |
                +------------------+
```

---

# Logic Diagram

```
              S -----NOT------┐
                              AND -----┐
I0 ---------------------------┘        │
                                       OR ------ Y
S -----------------------AND-----------┘
                         │
I1 ----------------------┘
```

---

# Truth Table

| Select (S) | I0 | I1 | Output (Y) |
|------------|----|----|------------|
| 0 | 0 | X | 0 |
| 0 | 1 | X | 1 |
| 1 | X | 0 | 0 |
| 1 | X | 1 | 1 |

**Note:** `X` denotes a "don't care" condition because the unselected input does not affect the output.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| I0 | 1 | Data Input 0 |
| I1 | 1 | Data Input 1 |
| S | 1 | Select Line |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Y | 1 | Selected Output |

---

# RTL Description

The RTL implementation uses a conditional operator.

```verilog
assign Y = (S) ? I1 : I0;
```

Equivalent implementation using Boolean logic

```verilog
assign Y = (~S & I0) | (S & I1);
```

The design is purely combinational.

- No clock
- No reset
- No FSM
- Zero clock latency

---

# Hardware Implementation

A 2-to-1 Multiplexer can be implemented using:

- 1 NOT Gate
- 2 AND Gates
- 1 OR Gate

or directly using FPGA LUTs.

```
          I0 --------AND------\
                   ^           \
                   |            \
                NOT S            OR ------ Y
                   |            /
                   |           /
          I1 -------AND-------/
                    ^
                    |
                    S
```

---

# Working Principle

### Case 1

```
S = 0

Output = I0
```

Example

```
I0 = 1

I1 = 0

Y = 1
```

---

### Case 2

```
S = 1

Output = I1
```

Example

```
I0 = 0

I1 = 1

Y = 1
```

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o mux2to1.out mux2to1.v mux2to1_tb.v
```

### Run

```bash
vvp mux2to1.out
```

### View Waveform

```bash
gtkwave mux2to1.vcd
```

---

# Expected Console Output

```
S I0 I1 | Y
---------
0  0  0 | 0
0  0  1 | 0
0  1  0 | 1
0  1  1 | 1
1  0  0 | 0
1  0  1 | 1
1  1  0 | 0
1  1  1 | 1
```

---

# Expected Waveform

```
S
00001111

I0
00110011

I1
01010101

Y
00110101
```

---

# Verification

The testbench verifies all **8 possible combinations** of the select line and input values.

| Test | S | I0 | I1 | Expected Y |
|------|---|----|----|------------|
|1|0|0|0|0|
|2|0|0|1|0|
|3|0|1|0|1|
|4|0|1|1|1|
|5|1|0|0|0|
|6|1|0|1|1|
|7|1|1|0|0|
|8|1|1|1|1|

---

# Applications

2-to-1 Multiplexers are widely used in:

- Arithmetic Logic Units (ALUs)
- CPU datapaths
- Register selection
- Bus multiplexing
- Memory address selection
- FPGA routing
- ASIC datapaths
- Digital communication systems
- Signal routing
- Embedded systems

---

# Advantages

- Simple hardware
- Fast operation
- Low power consumption
- Easy FPGA implementation
- Scalable to larger multiplexers

---

# Limitations

- Can select only one of two inputs.
- Larger systems require cascading multiple multiplexers.

---

# Multiplexer Comparison

| Multiplexer | Inputs | Select Lines | Outputs |
|-------------|--------|--------------|---------|
|2:1|2|1|1|
|4:1|4|2|1|
|8:1|8|3|1|
|16:1|16|4|1|

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

# Future Enhancements

- 4-to-1 Multiplexer
- 8-to-1 Multiplexer
- 16-to-1 Multiplexer
- Parameterized N-to-1 Multiplexer
- Demultiplexer (1:2, 1:4, 1:8)
- ALU Operand Selector
- Bus Arbitration Logic

---
