# 7_ENCODER4to2

## Overview

The **4-to-2 Encoder** is a fundamental combinational logic circuit in digital electronics that converts **one active input out of four input lines** into a **2-bit binary code**. An encoder performs the reverse operation of a decoder by reducing the number of signal lines required to represent active input information.

A 4-to-2 Encoder has:

- **Four Inputs:** `D0`, `D1`, `D2`, `D3`
- **Two Outputs:** `Y1`, `Y0`

The encoder assumes that **only one input is HIGH (logic 1) at any given time**. If multiple inputs are HIGH simultaneously, the output becomes undefined unless a **Priority Encoder** is used.

Encoders are widely used in **keyboard interfaces, interrupt controllers, digital communication systems, memory addressing, processors, FPGA designs, ASICs, and embedded systems**.

This project provides a synthesizable Verilog implementation of a **4-to-2 Encoder** along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Pure combinational logic
- Binary encoding
- Compact hardware implementation
- FPGA/ASIC compatible
- Beginner-friendly design
- Complete functional verification
- GTKWave waveform generation

---

# Theory

A 4-to-2 Encoder converts one of four active inputs into a 2-bit binary number.

```
Inputs

D0
D1
D2
D3

Outputs

Y1
Y0
```

Encoding

```
D0 → 00

D1 → 01

D2 → 10

D3 → 11
```

Only **one input should be active** at any instant.

---

# Boolean Equations

```
Y1 = D2 + D3

Y0 = D1 + D3
```

where

```
+ = OR operation
```

Equivalent Verilog

```verilog
assign Y1 = D2 | D3;

assign Y0 = D1 | D3;
```

---

# Block Diagram

```
            +----------------------+
D0 -------->|                      |
D1 -------->|                      |
D2 -------->|   4-to-2 Encoder     |------ Y1
D3 -------->|                      |------ Y0
            +----------------------+
```

---

# Logic Diagram

```
             D2 -------\
                         OR -------- Y1
             D3 -------/


             D1 -------\
                         OR -------- Y0
             D3 -------/
```

---

# Truth Table

| D3 | D2 | D1 | D0 | Y1 | Y0 |
|----|----|----|----|----|----|
|0|0|0|1|0|0|
|0|0|1|0|0|1|
|0|1|0|0|1|0|
|1|0|0|0|1|1|

> **Note:** This encoder assumes a **one-hot input**, meaning exactly one input should be HIGH at a time. If multiple inputs are HIGH simultaneously, the output is undefined. A **Priority Encoder** is used in such cases.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| D0 | 1 | Input Line 0 |
| D1 | 1 | Input Line 1 |
| D2 | 1 | Input Line 2 |
| D3 | 1 | Input Line 3 |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Y1 | 1 | Most Significant Bit (MSB) |
| Y0 | 1 | Least Significant Bit (LSB) |

---

# RTL Description

The RTL implementation uses continuous assignments.

```verilog
assign Y1 = D2 | D3;

assign Y0 = D1 | D3;
```

Since the design is purely combinational,

- No clock
- No reset
- No FSM
- Zero clock latency

---

# Hardware Implementation

The encoder requires only **two OR gates**.

```
          D2 -------\
                     OR -------- Y1
          D3 -------/


          D1 -------\
                     OR -------- Y0
          D3 -------/
```

---

# Working Principle

### Case 1

```
D0 = 1

Output

Y1 = 0

Y0 = 0
```

---

### Case 2

```
D1 = 1

Output

01
```

---

### Case 3

```
D2 = 1

Output

10
```

---

### Case 4

```
D3 = 1

Output

11
```

---

---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o encoder4to2.out encoder4to2.v encoder4to2_tb.v
```

### Run

```bash
vvp encoder4to2.out
```

### View Waveform

```bash
gtkwave encoder4to2.vcd
```

---

# Expected Console Output

```
D3 D2 D1 D0 | Y1 Y0
-------------------
0  0  0  1  | 0  0
0  0  1  0  | 0  1
0  1  0  0  | 1  0
1  0  0  0  | 1  1
```

---

# Expected Waveform

```
D0
1000

D1
0100

D2
0010

D3
0001

Y1
0011

Y0
0101
```

---

# Verification

The testbench verifies all valid one-hot input combinations.

| Test | D3 | D2 | D1 | D0 | Expected Output |
|------|----|----|----|----|-----------------|
|1|0|0|0|1|00|
|2|0|0|1|0|01|
|3|0|1|0|0|10|
|4|1|0|0|0|11|

---

# Applications

4-to-2 Encoders are widely used in:

- Keyboard encoding
- Interrupt controllers
- Processor input interfaces
- Memory address generation
- Digital communication systems
- FPGA datapaths
- ASIC control logic
- Embedded systems
- Sensor input encoding
- Industrial automation

---

# Advantages

- Reduces the number of signal lines
- Simple hardware implementation
- Fast combinational operation
- FPGA-friendly
- Low hardware complexity

---

# Limitations

- Requires one-hot input.
- Cannot resolve multiple active inputs.
- Does not indicate invalid input conditions.
- Priority Encoder is preferred when multiple inputs may become active simultaneously.

---

# Encoder vs Decoder

| Feature | Encoder | Decoder |
|----------|---------|---------|
|Function|Compresses inputs|Expands binary input|
|Inputs|2ⁿ|n|
|Outputs|n|2ⁿ|
|Example|4-to-2|2-to-4|

---

# Encoder Comparison

| Encoder | Inputs | Outputs |
|----------|--------|----------|
|2-to-1|2|1|
|4-to-2|4|2|
|8-to-3|8|3|
|16-to-4|16|4|

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

- Priority Encoder (4-to-2)
- 8-to-3 Encoder
- 16-to-4 Encoder
- Keyboard Encoder
- Interrupt Controller
- Decoder (2-to-4)
- Parameterized N-to-log₂(N) Encoder

---
