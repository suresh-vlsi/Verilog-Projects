# 2_Full_Adder

## Overview

The **Full Adder** is one of the most fundamental arithmetic circuits in digital electronics. It performs the addition of **three single-bit binary inputs**:

- **Input A**
- **Input B**
- **Carry-In (Cin)**

and produces two outputs:

- **Sum (S)**
- **Carry-Out (Cout)**

Unlike the Half Adder, the Full Adder can add an incoming carry bit, making it suitable for cascading multiple stages to build **N-bit binary adders**. Full Adders are essential components in **Arithmetic Logic Units (ALUs)**, **microprocessors**, **DSPs**, **CPUs**, **GPUs**, **FPGAs**, and **ASICs**.

This project implements a synthesizable Verilog Full Adder along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Pure combinational logic
- Three input addition
- Sum and Carry generation
- Exhaustive testbench
- Complete waveform verification
- FPGA/ASIC ready
- Beginner-friendly RTL implementation

---

# Theory

A Full Adder performs binary addition of three one-bit inputs.

```
          A
          │
          │
          ▼
     +-----------+
     |           |
B --->| Full      |-----> Sum
     |  Adder    |
Cin->|           |-----> Carry
     +-----------+
```

The Full Adder is commonly constructed using:

- Two Half Adders
- One OR gate

---

# Boolean Equations

```
Sum = A ⊕ B ⊕ Cin

Carry = (A · B) + (Cin · (A ⊕ B))
```

Alternative Carry equation

```
Carry = (A&B) | (B&Cin) | (A&Cin)
```

---

# Logic Representation

```
               A --------┐
                         XOR -------┐
               B --------┘          │
                                    XOR ------ Sum
              Cin ------------------┘


               A --------AND-----┐
                                 │
               B ----------------┘
                                     OR -------- Carry
               Cin ----AND-----┐
                               │
         (A XOR B)-------------┘
```

---

# Truth Table


::contentReference[oaicite:0]{index=0}


| A | B | Cin | Sum | Carry |
|---|---|-----|-----|--------|
|0|0|0|0|0|
|0|0|1|1|0|
|0|1|0|1|0|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|1|
|1|1|0|0|1|
|1|1|1|1|1|

---

# Block Diagram

```
             +------------------+
A ---------->|                  |
B ---------->|    Full Adder    |------ Sum
Cin -------->|                  |
             +------------------+
                      |
                      |
                    Carry
```

---

# Inputs

| Signal | Width | Description |
|----------|------|-------------|
| A | 1 | First operand |
| B | 1 | Second operand |
| Cin | 1 | Carry input |

---

# Outputs

| Signal | Width | Description |
|----------|------|-------------|
| Sum | 1 | Sum output |
| Carry | 1 | Carry output |

---

# RTL Description

The RTL uses continuous assignments.

```
assign Sum   = A ^ B ^ Cin;

assign Carry = (A & B) |
               (A & Cin) |
               (B & Cin);
```

Since the circuit is purely combinational,

- No clock
- No reset
- No FSM
- No sequential logic
- Zero latency (except propagation delay)

---

# Hardware Implementation

The Full Adder can be implemented using:

- 2 XOR Gates
- 2 AND Gates
- 1 OR Gate

or

- Two Half Adders
- One OR Gate

```
         Half Adder
      +--------------+
A ---->|              |
B ---->|              |---- S1
      +--------------+
               |
             Carry1

         Half Adder
      +--------------+
S1 --->|             |
Cin -->|             |---- Sum
      +--------------+
               |
             Carry2

Carry = Carry1 OR Carry2
```

---

# Simulation

## Icarus Verilog

### Compile

```bash
iverilog -o full_adder.out full_adder.v full_adder_tb.v
```

### Run

```bash
vvp full_adder.out
```

### View Waveform

```bash
gtkwave full_adder.vcd
```

---

# Expected Console Output

```
A B Cin | Sum Carry
--------------------
0 0 0   | 0    0
0 0 1   | 1    0
0 1 0   | 1    0
0 1 1   | 0    1
1 0 0   | 1    0
1 0 1   | 0    1
1 1 0   | 0    1
1 1 1   | 1    1
```

---

# Expected Waveform

```
A
00001111

B
00110011

Cin
01010101

Sum
01101001

Carry
00010111
```

---

# Verification

The testbench verifies all **8 possible input combinations**.

| Test | A | B | Cin | Expected Sum | Expected Carry |
|------|---|---|-----|--------------|----------------|
|1|0|0|0|0|0|
|2|0|0|1|1|0|
|3|0|1|0|1|0|
|4|0|1|1|0|1|
|5|1|0|0|1|0|
|6|1|0|1|0|1|
|7|1|1|0|0|1|
|8|1|1|1|1|1|

---

# Applications

The Full Adder is used in:

- Ripple Carry Adders
- Carry Lookahead Adders
- Carry Save Adders
- Arithmetic Logic Units (ALUs)
- CPUs
- GPUs
- DSP Processors
- Multipliers
- Accumulators
- FPGA Arithmetic Blocks
- ASIC Datapaths

---

# Advantages

- Supports Carry-In
- Easy to cascade
- Low hardware complexity
- Fundamental arithmetic building block
- Synthesizable on FPGA and ASIC

---

# Limitations

- Ripple Carry implementations introduce propagation delay.
- Large adders require optimized architectures such as Carry Lookahead or Carry Select Adders.

---

# Half Adder vs Full Adder

| Feature | Half Adder | Full Adder |
|----------|------------|------------|
| Inputs | 2 | 3 |
| Carry-In | No | Yes |
| Carry-Out | Yes | Yes |
| Multi-bit Addition | No | Yes |
| Used in Processors | Limited | Yes |

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
Implementation
      │
      ▼
FPGA Bitstream / ASIC GDSII
```

---

# Future Enhancements

- Ripple Carry Adder
- Carry Lookahead Adder
- Carry Select Adder
- Carry Save Adder
- 8-bit ALU
- Binary Multiplier
- Booth Multiplier
- Wallace Tree Multiplier

---
