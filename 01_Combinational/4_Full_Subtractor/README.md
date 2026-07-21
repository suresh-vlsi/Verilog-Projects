# 4_Full_Subtractor

## Overview

The **Full Subtractor** is a fundamental combinational logic circuit used in digital electronics to subtract **three single-bit binary inputs**:

- **Minuend (A)**
- **Subtrahend (B)**
- **Borrow-In (Bin)**

It produces two outputs:

- **Difference (D)**
- **Borrow-Out (Bout)**

Unlike the Half Subtractor, the Full Subtractor considers an incoming borrow from the previous stage, making it suitable for cascading multiple stages to perform **multi-bit binary subtraction**.

Full Subtractors are widely used in **Arithmetic Logic Units (ALUs)**, **processors**, **DSPs**, **microcontrollers**, **FPGA-based arithmetic units**, and **ASIC datapaths**.

This project implements a synthesizable Verilog Full Subtractor along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Pure combinational logic
- Three-input subtraction
- Difference and Borrow-Out generation
- Exhaustive testbench covering all input combinations
- GTKWave waveform generation
- FPGA/ASIC compatible
- Beginner-friendly implementation

---

# Theory

A Full Subtractor performs the subtraction:

```
A − B − Bin
```

where

- **A** = Minuend
- **B** = Subtrahend
- **Bin** = Borrow-In

Outputs

- **Difference**
- **Borrow-Out**

Unlike the Half Subtractor, it can be cascaded to construct multi-bit subtractors.

---

# Boolean Equations

### Difference

```
Difference = A ⊕ B ⊕ Bin
```

### Borrow-Out

```
Borrow = (~A & B) |
         (~A & Bin) |
         (B & Bin)
```

Equivalent expression

```
Borrow = (~A & (B | Bin)) | (B & Bin)
```

---

# Logic Representation

```
               A --------┐
                         XOR -------┐
               B --------┘          │
                                    XOR ------ Difference
              Bin ------------------┘



               A ----NOT----┐
                            AND --------┐
               B -----------┘           │
                                        │
               A ----NOT----┐           │
                            AND --------┤
             Bin -----------┘           │
                                        OR ------ Borrow
               B --------AND------------┘
                     |
                    Bin
```

---

# Truth Table

| A | B | Bin | Difference | Borrow |
|---|---|-----|------------|--------|
|0|0|0|0|0|
|0|0|1|1|1|
|0|1|0|1|1|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|0|
|1|1|0|0|0|
|1|1|1|1|1|

---

# Block Diagram

```
                +----------------------+
A ------------->|                      |
B ------------->|   Full Subtractor    |------ Difference
Bin ----------->|                      |
                +----------------------+
                           |
                           |
                        Borrow
```

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| A | 1 | Minuend |
| B | 1 | Subtrahend |
| Bin | 1 | Borrow-In |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Difference | 1 | Difference output |
| Borrow | 1 | Borrow-Out output |

---

# RTL Description

The Full Subtractor is implemented using continuous assignments.

```verilog
assign Difference = A ^ B ^ Bin;

assign Borrow = (~A & B) |
                (~A & Bin) |
                (B & Bin);
```

Since the circuit is purely combinational,

- No clock
- No reset
- No FSM
- Zero clock latency

---

# Hardware Implementation

The Full Subtractor can be implemented using:

- Two XOR gates
- Two NOT gates
- Three AND gates
- Two OR gates

or using

- Two Half Subtractors
- One OR gate

```
        Half Subtractor
     +------------------+
A --->|                  |
B --->|                  |---- D1
     +------------------+
            |
         Borrow1

        Half Subtractor
     +------------------+
D1 -->|                 |
Bin -->|                |---- Difference
     +------------------+
            |
         Borrow2

Borrow = Borrow1 OR Borrow2
```

---

# Working Principle

### Case 1

```
A = 0
B = 0
Bin = 0

Difference = 0
Borrow = 0
```

---

### Case 2

```
A = 0
B = 1
Bin = 0

0 - 1

Difference = 1
Borrow = 1
```

---

### Case 3

```
A = 1
B = 0
Bin = 1

1 - 0 - 1

Difference = 0
Borrow = 0
```

---

### Case 4

```
A = 1
B = 1
Bin = 1

1 - 1 - 1

Difference = 1
Borrow = 1
```

---

# Simulation

## Icarus Verilog

### Compile

```bash
iverilog -o full_subtractor.out full_subtractor.v full_subtractor_tb.v
```

### Run

```bash
vvp full_subtractor.out
```

### View Waveform

```bash
gtkwave full_subtractor.vcd
```

---

# Expected Console Output

```
A B Bin | Difference Borrow
---------------------------
0 0 0   |     0        0
0 0 1   |     1        1
0 1 0   |     1        1
0 1 1   |     0        1
1 0 0   |     1        0
1 0 1   |     0        0
1 1 0   |     0        0
1 1 1   |     1        1
```

---

# Expected Waveform

```
A
00001111

B
00110011

Bin
01010101

Difference
01101001

Borrow
01110001
```

---

# Verification

The testbench verifies all **8 possible input combinations**.

| Test | A | B | Bin | Difference | Borrow |
|------|---|---|-----|------------|--------|
|1|0|0|0|0|0|
|2|0|0|1|1|1|
|3|0|1|0|1|1|
|4|0|1|1|0|1|
|5|1|0|0|1|0|
|6|1|0|1|0|0|
|7|1|1|0|0|0|
|8|1|1|1|1|1|

---

# Applications

The Full Subtractor is widely used in:

- Binary subtraction circuits
- Ripple Borrow Subtractors
- Arithmetic Logic Units (ALUs)
- CPUs
- DSP processors
- FPGA arithmetic units
- ASIC datapaths
- Digital calculators
- Embedded processors
- Signal processing hardware

---

# Advantages

- Supports Borrow-In
- Can be cascaded for multi-bit subtraction
- Simple combinational implementation
- Easy FPGA synthesis
- Fundamental arithmetic building block

---

# Limitations

- Ripple Borrow implementation introduces propagation delay.
- High-speed arithmetic units require optimized subtractor architectures.

---

# Half Subtractor vs Full Subtractor

| Feature | Half Subtractor | Full Subtractor |
|----------|-----------------|-----------------|
| Inputs | 2 | 3 |
| Borrow-In | No | Yes |
| Borrow-Out | Yes | Yes |
| Multi-bit Subtraction | No | Yes |
| Hardware Complexity | Low | Medium |

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
Bitstream / GDSII
```

---

# Future Enhancements

- Ripple Borrow Subtractor
- 4-bit Binary Subtractor
- Adder-Subtractor Unit
- Arithmetic Logic Unit (ALU)
- Carry Lookahead Adder/Subtractor
- Two's Complement Arithmetic Unit
- Parameterized N-bit Subtractor

---
