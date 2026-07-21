# 1_Half_Adder

## Overview

The **Half Adder** is one of the most fundamental combinational logic circuits in digital electronics. It performs the addition of **two single-bit binary inputs** and generates two outputs:

- **Sum (S)** – Least Significant Bit (LSB) of the addition.
- **Carry (C)** – Most Significant Bit (MSB) of the addition.

A Half Adder forms the basic building block for designing **Full Adders**, **Ripple Carry Adders**, **Arithmetic Logic Units (ALUs)**, and many other arithmetic circuits used in processors, microcontrollers, DSPs, and FPGA/ASIC designs.

This project presents a synthesizable Verilog implementation of a Half Adder along with a comprehensive testbench for functional verification.

---

## Features

- Combinational logic design
- Synthesizable Verilog RTL
- No clock required
- No reset required
- Simple gate-level implementation
- Self-contained testbench
- Exhaustive verification of all input combinations
- Waveform generation using GTKWave
- Suitable for FPGA and ASIC design flow

---

## Theory

A Half Adder adds two binary digits.

```
        A
        │
        │
        ├─────┐
        │     │
        ▼     ▼
      XOR     AND
        │      │
        │      │
      Sum    Carry
```

### Mathematical Representation

```
Sum   = A ⊕ B

Carry = A · B
```

Where

- ⊕ = XOR operation
- · = AND operation

---

## Logic Equations

```
Sum = A ^ B

Carry = A & B
```

---

## Truth Table


::contentReference[oaicite:0]{index=0}


| A | B | Sum | Carry |
|---|---|-----|--------|
| 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 1 |

---

## Block Diagram

```
        +----------------+
A ------|                |
        |   Half Adder   |------ Sum
B ------|                |
        +----------------+
                |
                |
              Carry
```

---

## Logic Circuit

```
              A -----------┐
                            XOR -------- Sum
              B -----------┘

              A -----------┐
                            AND -------- Carry
              B -----------┘
```

---

## Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| A | 1 | First input bit |
| B | 1 | Second input bit |

---

## Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Sum | 1 | Sum output |
| Carry | 1 | Carry output |

---

## RTL Description

The RTL is purely combinational and consists of two continuous assignments.

```
Sum   = A XOR B

Carry = A AND B
```

Since there is no sequential logic:

- No clock
- No reset
- No FSM
- Zero latency
---

## Simulation

### Using Icarus Verilog

### Compile

```bash
iverilog -o half_adder.out half_adder.v half_adder_tb.v
```

### Run

```bash
vvp half_adder.out
```

### Generate Waveform

```bash
gtkwave half_adder.vcd
```

---

## Expected Console Output

```
A B | Sum Carry
----------------
0 0 |  0    0
0 1 |  1    0
1 0 |  1    0
1 1 |  0    1
```

---

## Expected Waveform

```
A
0____1111____

B
0011__0011___

Sum
0110__0110___

Carry
0001__0001___
```

---

## Verification

The testbench verifies every possible input combination.

| Test Case | A | B | Expected Sum | Expected Carry |
|-----------|---|---|--------------|----------------|
| 1 | 0 | 0 | 0 | 0 |
| 2 | 0 | 1 | 1 | 0 |
| 3 | 1 | 0 | 1 | 0 |
| 4 | 1 | 1 | 0 | 1 |

---

## Applications

Half Adders are widely used in:

- Binary addition circuits
- Full Adder design
- Ripple Carry Adders
- Carry Lookahead Adders
- Arithmetic Logic Units (ALUs)
- Digital Signal Processors (DSPs)
- FPGA arithmetic blocks
- ASIC datapaths
- Multipliers
- Accumulators

---

## Advantages

- Simple combinational circuit
- Low hardware complexity
- Minimal propagation delay
- Easy to synthesize
- Fundamental building block for arithmetic circuits

---

## Limitations

- Cannot accept a Carry-In input.
- Suitable only for adding two single-bit numbers.
- Practical multi-bit addition requires Full Adders.

---

## Comparison: Half Adder vs Full Adder

| Feature | Half Adder | Full Adder |
|----------|------------|------------|
| Inputs | 2 | 3 |
| Outputs | 2 | 2 |
| Carry-In | No | Yes |
| Carry-Out | Yes | Yes |
| Used Alone | Limited | Yes |
| Used in Multi-bit Addition | No | Yes |

---

## FPGA/ASIC Design Flow

```
Specification
      │
      ▼
RTL Design (Verilog)
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

## Future Enhancements

- Full Adder
- 4-bit Ripple Carry Adder
- Carry Lookahead Adder
- Carry Save Adder
- Binary Multiplier
- ALU Design
- Parameterized N-bit Adder

---
