# 2_SR_Latch

## Overview

The **SR (Set-Reset) Latch** is one of the simplest and most fundamental **sequential logic circuits** used in digital electronics. Unlike combinational circuits, an SR Latch can **store one bit of information**, making it a basic memory element.

The SR Latch has:

- **Set (S) Input**
- **Reset (R) Input**
- **Output (Q)**
- **Complement Output (Q̅)** *(optional)*

The latch changes its output depending on the values of the **Set** and **Reset** inputs.

SR Latches form the foundation for more advanced memory elements such as:

- D Latches
- JK Flip-Flops
- D Flip-Flops
- T Flip-Flops
- Registers
- Memory Cells

This project implements a synthesizable **SR Latch** in Verilog along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Sequential logic circuit
- One-bit memory element
- Set and Reset functionality
- FPGA/ASIC compatible
- Functional verification
- GTKWave waveform generation
- Beginner-friendly implementation

---

# Theory

Unlike combinational circuits, an SR Latch stores information.

Inputs

```
S (Set)

R (Reset)
```

Outputs

```
Q

Q̅
```

Operation

```
S = 1

Stores Logic 1
```

```
R = 1

Stores Logic 0
```

```
S = 0
R = 0

Hold Previous State
```

```
S = 1
R = 1

Invalid Condition
```

---

# Symbol

```
             +-------------+
S ---------->|             |
             |             |
R ---------->|  SR Latch   |------ Q
             |             |------ Q̅
             +-------------+
```

---

# Working Principle

### Hold Condition

```
S = 0

R = 0

Q remains unchanged
```

---

### Set Condition

```
S = 1

R = 0

Q = 1
```

---

### Reset Condition

```
S = 0

R = 1

Q = 0
```

---

### Invalid Condition

```
S = 1

R = 1
```

This condition is **not allowed** in a NOR-based SR Latch because both outputs become LOW simultaneously, violating the complementary relationship between `Q` and `Q̅`.

---

# Truth Table (NOR-based SR Latch)

| S | R | Q(next) | Q̅(next) | Operation |
|---|---|----------|-----------|-----------|
|0|0|Hold|Hold|Memory|
|0|1|0|1|Reset|
|1|0|1|0|Set|
|1|1|Invalid|Invalid|Forbidden|

---

# RTL Description

Example Verilog implementation

```verilog
module sr_latch(
    input S,
    input R,
    output reg Q
);

always @(*)
begin
    if (S && !R)
        Q = 1'b1;
    else if (!S && R)
        Q = 1'b0;
    else if (!S && !R)
        Q = Q;   // Hold previous state
    else
        Q = 1'bx; // Invalid condition
end

endmodule
```

> **Note:** In synthesizable RTL, assigning `Q = Q;` or `Q = 1'bx;` is generally not recommended. For practical FPGA/ASIC designs, an SR latch is typically described using cross-coupled gates or inferred through latch behavior.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| S | 1 | Set Input |
| R | 1 | Reset Input |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Q | 1 | Stored Output |
| Q̅ | 1 | Complement Output (optional) |

---

# Internal Operation

```
          S = 1

Q = 1



          R = 1

Q = 0



S = 0

R = 0

Q remains unchanged
```

---

# Gate-Level Implementation

### NOR Gate SR Latch

```
                 +---------+
      S -------->|         |
                 |   NOR   |------ Q
         +------>|         |
         |       +---------+
         |
         |       +---------+
         +-------|         |
      R -------->|   NOR   |------ Q̅
                 |         |
                 +---------+
```

The outputs are cross-coupled to create a feedback loop, enabling the latch to store one bit of information.

---

# Timing Diagram

```
S
____████______________

R
____________████______

Q
____████████__________
```

Explanation

- When **S** goes HIGH, Q becomes HIGH.
- When **R** goes HIGH, Q becomes LOW.
- When both inputs are LOW, Q retains its previous state.

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o sr_latch.out sr_latch.v sr_latch_tb.v
```

### Run

```bash
vvp sr_latch.out
```

### View Waveform

```bash
gtkwave sr_latch.vcd
```

---

# Expected Console Output

```
Time  S R | Q
----------------
0     0 0 | X
10    1 0 | 1
20    0 0 | 1
30    0 1 | 0
40    0 0 | 0
50    1 1 | X
60    0 0 | X (or previous state, depending on implementation)
```

---

# Expected Waveform

```
S
0011001100

R
0000110011

Q
011110000X
```

The exact waveform after the invalid condition depends on the implementation and simulator.

---

# Verification

The testbench verifies the following scenarios:

| Test | S | R | Expected Result |
|------|---|---|-----------------|
|1|0|0|Hold Previous State|
|2|1|0|Set (Q = 1)|
|3|0|0|Hold|
|4|0|1|Reset (Q = 0)|
|5|0|0|Hold|
|6|1|1|Invalid Condition|

---

# Applications

SR Latches are widely used in:

- Basic memory cells
- Digital storage elements
- Debouncing mechanical switches
- Control circuits
- Register design
- State machines
- Flip-Flop construction
- FPGA sequential logic
- ASIC control logic
- Digital timing circuits

---

# Advantages

- Simple hardware implementation
- Stores one bit of information
- Very low hardware cost
- Foundation of sequential logic
- Fast operation

---

# Limitations

- Invalid condition when both Set and Reset are asserted simultaneously.
- Level-sensitive operation may introduce timing issues.
- Rarely used directly in modern synchronous digital systems.
- Edge-triggered flip-flops are generally preferred for clocked designs.

---

# SR Latch vs D Latch vs D Flip-Flop

| Feature | SR Latch | D Latch | D Flip-Flop |
|----------|----------|----------|-------------|
|Inputs|2|2 (D, EN)|2 (D, CLK)|
|Trigger|Level|Level|Clock Edge|
|Memory|Yes|Yes|Yes|
|Invalid State|Yes|No|No|
|Common Usage|Basic storage|Temporary storage|Synchronous systems|

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

- Avoid asserting both **S** and **R** simultaneously in a NOR-based SR Latch.
- Unintended latch inference in RTL can cause timing issues.
- Ensure the latch behavior matches the intended design during simulation.
- Prefer edge-triggered flip-flops for clocked synchronous systems unless a latch is specifically required.

---

# Future Enhancements

- Gated SR Latch
- D Latch
- JK Latch
- D Flip-Flop
- JK Flip-Flop
- T Flip-Flop
- Master-Slave Flip-Flop
- Shift Register
- Register File
- Finite State Machine (FSM)

---
