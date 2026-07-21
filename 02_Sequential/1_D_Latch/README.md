# 1_D_Latch

## Overview

The **D (Data) Latch** is one of the most fundamental sequential logic circuits in digital electronics. Unlike combinational circuits, a D Latch can **store one bit of data**, making it a basic memory element used in digital systems.

A D Latch has:

- **One Data Input (D)**
- **One Enable Input (EN)**
- **One Output (Q)**

When the **Enable (EN)** signal is HIGH, the latch is **transparent**, meaning the output follows the input.

When the **Enable (EN)** signal is LOW, the latch **holds** (stores) its previous value.

D Latches are widely used in **registers, memory elements, state machines, digital controllers, CPUs, DSPs, FPGA designs, and ASIC implementations**.

This project presents a synthesizable Verilog implementation of a **Level-Sensitive D Latch** along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Level-sensitive storage element
- Transparent mode operation
- Data holding capability
- FPGA/ASIC compatible
- Beginner-friendly implementation
- Complete functional verification
- GTKWave waveform generation

---

# Theory

Unlike combinational circuits, a D Latch has memory.

Inputs

```
D
EN
```

Output

```
Q
```

Operation

```
EN = 1

Q follows D
```

```
EN = 0

Q stores previous value
```

Hence the D Latch is called a **Transparent Latch**.

---

# Symbol

```
          +-------------+
D -------->|             |
           |             |
EN ------->|   D Latch   |------ Q
           |             |
          +-------------+
```

---

# Working Principle

### Transparent Mode

```
EN = 1

Q = D
```

Any change in D immediately appears at the output.

---

### Hold Mode

```
EN = 0

Q retains previous value.
```

Changes in D have no effect.

---

# Truth Table

| EN | D | Q(next) |
|----|---|----------|
|0|X|Hold Previous Value|
|1|0|0|
|1|1|1|

Where

```
X = Don't Care
```

---

# RTL Description

Typical Verilog implementation

```verilog
module d_latch(
    input D,
    input EN,
    output reg Q
);

always @(*)
begin
    if (EN)
        Q = D;
end

endmodule
```

When **EN = 0**, there is **no assignment**, causing synthesis tools to infer a latch.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| D | 1 | Data Input |
| EN | 1 | Enable Signal |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Q | 1 | Stored Output |

---

# Internal Operation

```
          EN = 1

D ---------------------> Q


          EN = 0

Previous Q -----------> Q
```

---

# Timing Diagram

```
EN
____████████________██████____

D
___██____████____██___________

Q
___██____██████████___________
```

Notice

- During Enable HIGH → Q follows D
- During Enable LOW → Q holds previous value

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o d_latch.out d_latch.v d_latch_tb.v
```

### Run

```bash
vvp d_latch.out
```

### View Waveform

```bash
gtkwave d_latch.vcd
```

---

# Expected Console Output

```
Time EN D | Q
----------------
0    0  0 | X
10   1  0 | 0
20   1  1 | 1
30   0  0 | 1
40   0  1 | 1
50   1  0 | 0
60   1  1 | 1
```

---

# Expected Waveform

```
EN
001111000111

D
010110100101

Q
011111111101
```

Explanation

- While EN is HIGH, Q follows D.
- While EN is LOW, Q retains the previously stored value.

---

# Verification

The testbench verifies the following scenarios:

| Test | EN | D | Expected Q |
|------|----|---|------------|
|1|0|0|Hold Previous|
|2|1|0|0|
|3|1|1|1|
|4|0|0|Hold Previous|
|5|0|1|Hold Previous|
|6|1|0|0|
|7|1|1|1|

---

# Applications

D Latches are widely used in:

- Temporary data storage
- Register design
- Memory elements
- Pipeline stages
- State machines
- Digital controllers
- FPGA logic
- ASIC datapaths
- Synchronization circuits
- Low-power digital systems

---

# Advantages

- Very simple hardware
- Low propagation delay
- Stores one bit of information
- Easy FPGA implementation
- Foundation for sequential logic

---

# Limitations

- Level-sensitive operation may introduce transparency issues.
- Can lead to race conditions if used incorrectly.
- Most synchronous systems prefer edge-triggered flip-flops.

---

# D Latch vs D Flip-Flop

| Feature | D Latch | D Flip-Flop |
|----------|----------|-------------|
|Trigger|Level Sensitive|Edge Triggered|
|Clock|Enable Signal|Clock Edge|
|Transparent|Yes|No|
|Storage|Yes|Yes|
|Common Usage|Simple storage|Synchronous systems|

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

# Common Design Pitfalls

- Incomplete assignments inside combinational `always` blocks unintentionally infer latches.
- Using latches in fully synchronous designs can create timing analysis challenges.
- Failing to control enable signals properly may result in race-through behavior.
- Always verify latch behavior through simulation before synthesis.

---

# Future Enhancements

- Gated D Latch
- SR Latch
- JK Latch
- D Flip-Flop
- JK Flip-Flop
- T Flip-Flop
- Register Design
- Shift Register
- Finite State Machine (FSM)
- Memory Array

---
