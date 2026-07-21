# 3_Half_Subtractor

## Overview

The **Half Subtractor** is a fundamental combinational logic circuit used in digital electronics to perform the subtraction of **two single-bit binary numbers**. It subtracts one binary digit (**B**) from another (**A**) and generates two outputs:

- **Difference (D)** – Result of the subtraction.
- **Borrow (Bout)** – Indicates whether a borrow is required from the next higher bit.

The Half Subtractor is one of the basic arithmetic building blocks used in designing **Full Subtractors**, **Binary Subtractors**, **Arithmetic Logic Units (ALUs)**, and various digital signal processing systems.

This project presents a synthesizable Verilog implementation of a Half Subtractor along with a comprehensive testbench for functional verification.

---

# Features

- Pure combinational logic
- Synthesizable Verilog RTL
- No clock required
- No reset required
- Exhaustive verification of all input combinations
- Simple gate-level implementation
- FPGA/ASIC compatible
- GTKWave waveform generation

---

# Theory

A Half Subtractor subtracts one binary digit from another.

```
          A
          │
          │
          ▼
      +-----------+
B ---->|           |------ Difference
      | Half      |
      |Subtractor |
      |           |------ Borrow
      +-----------+
```

Unlike a Full Subtractor, a Half Subtractor **does not consider a Borrow-In input**.

---

# Boolean Equations

The outputs are defined as:

```
Difference = A ⊕ B

Borrow = A̅ · B
```

where

- ⊕ = XOR operation
- A̅ = NOT A
- · = AND operation

---

# Logic Representation

```
              A -----------┐
                            XOR -------- Difference
              B -----------┘


              A ----NOT-----┐
                             AND -------- Borrow
              B ------------┘
```

---

# Truth Table

| A | B | Difference | Borrow |
|---|---|------------|--------|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 |

---

# Block Diagram

```
            +---------------------+
A --------->|                     |
B --------->|   Half Subtractor   |------ Difference
            |                     |
            +---------------------+
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

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Difference | 1 | Difference output |
| Borrow | 1 | Borrow output |

---

# RTL Description

The RTL implementation consists of two continuous assignments.

```verilog
assign Difference = A ^ B;

assign Borrow = (~A) & B;
```

Since the circuit is purely combinational:

- No clock
- No reset
- No sequential logic
- Zero clock latency

---

# Hardware Implementation

A Half Subtractor can be implemented using:

- One XOR Gate
- One NOT Gate
- One AND Gate

```
              A --------┐
                        XOR -------- Difference
              B --------┘


              A --NOT---┐
                         AND ------- Borrow
              B --------┘
```

---

# Working Principle

### Case 1

```
A = 0
B = 0

Difference = 0
Borrow = 0
```

---

### Case 2

```
A = 0
B = 1

0 - 1

Difference = 1

Borrow = 1
```

A borrow is generated because the minuend is smaller than the subtrahend.

---

### Case 3

```
A = 1
B = 0

Difference = 1

Borrow = 0
```

---

### Case 4

```
A = 1
B = 1

Difference = 0

Borrow = 0
```

---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o half_subtractor.out half_subtractor.v half_subtractor_tb.v
```

### Run

```bash
vvp half_subtractor.out
```

### View Waveform

```bash
gtkwave half_subtractor.vcd
```

---

# Expected Console Output

```
A B | Difference Borrow
-----------------------
0 0 |     0         0
0 1 |     1         1
1 0 |     1         0
1 1 |     0         0
```

---

# Expected Waveform

```
A
0011

B
0101

Difference
0110

Borrow
0100
```

---

# Verification

The testbench verifies every possible input combination.

| Test | A | B | Difference | Borrow |
|------|---|---|------------|--------|
|1|0|0|0|0|
|2|0|1|1|1|
|3|1|0|1|0|
|4|1|1|0|0|

---

# Applications

Half Subtractors are widely used in:

- Binary subtraction circuits
- Full Subtractor design
- Arithmetic Logic Units (ALUs)
- Digital calculators
- FPGA arithmetic blocks
- ASIC arithmetic units
- Digital signal processing
- Embedded systems

---

# Advantages

- Simple combinational circuit
- Low hardware complexity
- Easy to implement
- Low propagation delay
- Basic arithmetic building block

---

# Limitations

- Cannot accept a Borrow-In input.
- Not suitable for multi-bit subtraction.
- Must be combined with Full Subtractors for practical binary subtractors.

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

- Full Subtractor
- 4-bit Binary Subtractor
- Ripple Borrow Subtractor
- Adder-Subtractor Unit
- Arithmetic Logic Unit (ALU)
- Two's Complement Arithmetic Unit
- Parameterized N-bit Subtractor

---
