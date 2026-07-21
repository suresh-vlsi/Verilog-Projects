# 8_DECODER2to4

## Overview

The **2-to-4 Decoder** is a fundamental combinational logic circuit in digital electronics that converts a **2-bit binary input** into **one of four unique output lines**. A decoder performs the opposite function of an encoder by expanding a binary code into multiple output signals.

A 2-to-4 Decoder has:

- **Two Inputs:** `A1`, `A0`
- **One Enable Input (EN)** *(optional but commonly used)*
- **Four Outputs:** `Y0`, `Y1`, `Y2`, `Y3`

Only **one output is HIGH** for each valid input combination when the decoder is enabled. This is known as **one-hot output**.

Decoders are extensively used in **memory address decoding, processor control units, chip-select generation, instruction decoding, FPGA routing, ASIC designs, and digital communication systems**.

This project implements a synthesizable Verilog **2-to-4 Decoder** with an Enable input along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Pure combinational logic
- One-hot output generation
- Enable control input
- FPGA/ASIC compatible
- Beginner-friendly implementation
- Exhaustive verification
- GTKWave waveform generation

---

# Theory

A decoder activates exactly one output corresponding to the binary value present on its input lines.

```
Inputs

EN
A1
A0

Outputs

Y0
Y1
Y2
Y3
```

When **EN = 1**

```
A1 A0 = 00 → Y0

A1 A0 = 01 → Y1

A1 A0 = 10 → Y2

A1 A0 = 11 → Y3
```

When

```
EN = 0
```

All outputs remain LOW.

---

# Boolean Equations

```
Y0 = EN · A1̅ · A0̅

Y1 = EN · A1̅ · A0

Y2 = EN · A1 · A0̅

Y3 = EN · A1 · A0
```

Equivalent Verilog implementation

```verilog
assign Y0 = EN & ~A1 & ~A0;
assign Y1 = EN & ~A1 &  A0;
assign Y2 = EN &  A1 & ~A0;
assign Y3 = EN &  A1 &  A0;
```

---

# Block Diagram

```
              +----------------------+
EN ---------->|                      |
A1 ---------->|                      |
A0 ---------->|    2-to-4 Decoder    |
              |                      |
              +----------------------+
                 │   │   │   │
                Y0  Y1  Y2  Y3
```

---

# Logic Diagram

```
                 EN
                  │
        ---------------------
        │    │    │    │
      AND  AND  AND  AND
       │    │    │    │
      Y0   Y1   Y2   Y3

Each AND gate receives EN along with the
appropriate combination of A1, A0 and their complements.
```

---

# Truth Table

| EN | A1 | A0 | Y0 | Y1 | Y2 | Y3 |
|----|----|----|----|----|----|----|
|0|X|X|0|0|0|0|
|1|0|0|1|0|0|0|
|1|0|1|0|1|0|0|
|1|1|0|0|0|1|0|
|1|1|1|0|0|0|1|

**Note:** `X` represents a "don't care" condition because when `EN = 0`, all outputs remain LOW regardless of the input values.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| EN | 1 | Enable input |
| A1 | 1 | Most Significant Input Bit |
| A0 | 1 | Least Significant Input Bit |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Y0 | 1 | Output corresponding to 00 |
| Y1 | 1 | Output corresponding to 01 |
| Y2 | 1 | Output corresponding to 10 |
| Y3 | 1 | Output corresponding to 11 |

---

# RTL Description

The decoder is implemented using continuous assignments.

```verilog
assign Y0 = EN & ~A1 & ~A0;
assign Y1 = EN & ~A1 &  A0;
assign Y2 = EN &  A1 & ~A0;
assign Y3 = EN &  A1 &  A0;
```

The design is purely combinational.

- No clock
- No reset
- No FSM
- Zero clock latency

---

# Hardware Implementation

The circuit requires

- 2 NOT Gates
- 4 AND Gates

```
          EN
           │
     ----------------
     │  │  │  │
    AND AND AND AND
     │  │  │  │
    Y0 Y1 Y2 Y3
```

---

# Working Principle

### Case 1

```
EN = 0

Outputs

Y0 = 0

Y1 = 0

Y2 = 0

Y3 = 0
```

---

### Case 2

```
EN = 1

A1A0 = 00

Output

Y0 = 1
```

---

### Case 3

```
EN = 1

A1A0 = 01

Output

Y1 = 1
```

---

### Case 4

```
EN = 1

A1A0 = 10

Output

Y2 = 1
```

---

### Case 5

```
EN = 1

A1A0 = 11

Output

Y3 = 1
```

---

---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o decoder2to4.out decoder2to4.v decoder2to4_tb.v
```

### Run

```bash
vvp decoder2to4.out
```

### View Waveform

```bash
gtkwave decoder2to4.vcd
```

---

# Expected Console Output

```
EN A1 A0 | Y0 Y1 Y2 Y3
----------------------
0  X  X  | 0  0  0  0
1  0  0  | 1  0  0  0
1  0  1  | 0  1  0  0
1  1  0  | 0  0  1  0
1  1  1  | 0  0  0  1
```

---

# Expected Waveform

```
EN
01111

A1
00111

A0
01010

Y0
01000

Y1
00100

Y2
00010

Y3
00001
```

---

# Verification

The testbench verifies the disabled condition and all valid input combinations.

| Test | EN | A1 | A0 | Expected Output |
|------|----|----|----|-----------------|
|1|0|X|X|0000|
|2|1|0|0|1000|
|3|1|0|1|0100|
|4|1|1|0|0010|
|5|1|1|1|0001|

---

# Applications

2-to-4 Decoders are widely used in:

- Memory address decoding
- Chip-select generation
- Processor instruction decoding
- Register selection
- FPGA routing resources
- ASIC control logic
- Digital communication systems
- Display drivers
- Embedded systems
- Industrial control systems

---

# Advantages

- Simple hardware implementation
- Generates one-hot outputs
- Low propagation delay
- Easy FPGA implementation
- Widely used in digital control systems

---

# Limitations

- Supports only four output lines.
- Larger systems require cascading multiple decoders.
- Standard decoder activates only one output at a time.

---

# Encoder vs Decoder

| Feature | Encoder | Decoder |
|----------|---------|---------|
|Function|Compresses inputs|Expands binary inputs|
|Inputs|2ⁿ|n|
|Outputs|n|2ⁿ|
|Example|4-to-2|2-to-4|

---

# Decoder Comparison

| Decoder | Inputs | Outputs |
|----------|--------|----------|
|2-to-4|2|4|
|3-to-8|3|8|
|4-to-16|4|16|
|5-to-32|5|32|

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

- 3-to-8 Decoder
- 4-to-16 Decoder
- Priority Decoder
- Memory Address Decoder
- Seven-Segment Display Decoder
- Parameterized N-to-2ᴺ Decoder
- Instruction Decoder

---

