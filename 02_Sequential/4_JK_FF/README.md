# 4_JK_Flip_Flop

## Overview

The **JK Flip-Flop** is one of the most versatile and widely used sequential logic circuits in digital electronics. It is an improved version of the **SR Flip-Flop**, designed to eliminate the invalid state that occurs when both inputs are HIGH.

A JK Flip-Flop has:

- **J (Set) Input**
- **K (Reset) Input**
- **Clock (CLK) Input**
- **Output (Q)**
- **Complement Output (Q̅)** *(optional)*

Unlike the SR Flip-Flop, when both **J = 1** and **K = 1**, the JK Flip-Flop **toggles** its output on the active clock edge instead of entering an invalid state.

JK Flip-Flops are extensively used in:

- Binary Counters
- Frequency Dividers
- Shift Registers
- Control Logic
- State Machines
- Digital Clocks
- FPGA Designs
- ASIC Implementations
- Sequential Controllers
- Embedded Systems

This project presents a synthesizable Verilog implementation of a **Positive Edge Triggered JK Flip-Flop** along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Positive-edge triggered operation
- Set, Reset, Hold, and Toggle modes
- No invalid input condition
- FPGA/ASIC compatible
- Functional verification
- GTKWave waveform generation
- Industry-standard RTL coding style

---

# Theory

The JK Flip-Flop is a clocked memory element that stores one bit of information.

Inputs

```
J
K
CLK
```

Outputs

```
Q
Q̅
```

The output changes only on the active edge of the clock.

Possible operations:

```
J = 0
K = 0

Hold Previous State
```

```
J = 0
K = 1

Reset
```

```
J = 1
K = 0

Set
```

```
J = 1
K = 1

Toggle Output
```

---

# Symbol

```
               +-----------------+
J ------------>|                 |
K ------------>|                 |
CLK ---------->|>  JK Flip-Flop  |------ Q
               |                 |------ Q̅
               +-----------------+
```

The triangle (`>`) indicates an **edge-triggered clock**.

---

# Truth Table

| Clock | J | K | Q(next) | Operation |
|-------|---|---|----------|-----------|
| ↑ |0|0|Q|Hold|
| ↑ |0|1|0|Reset|
| ↑ |1|0|1|Set|
| ↑ |1|1|Q̅|Toggle|
| No Edge |X|X|Hold|No Change|

---

# State Transition Table

| Current Q | J | K | Next Q |
|-----------|---|---|--------|
|0|0|0|0|
|1|0|0|1|
|0|0|1|0|
|1|0|1|0|
|0|1|0|1|
|1|1|0|1|
|0|1|1|1|
|1|1|1|0|

---

# Characteristic Equation

The characteristic equation of a JK Flip-Flop is

```
Q(next) = J·Q̅ + K̅·Q
```

where

```
Q̅ = Complement of Q
```

This equation describes how the next state depends on the current state and the inputs.

---

# Timing Diagram

```
CLK
___/‾‾\___/‾‾\___/‾‾\___/‾‾\___

J
____‾‾______________‾‾________

K
___________‾‾____________‾‾___

Q
____‾‾‾‾___________‾‾_________
```

Notice that **Q changes only on the rising edge of the clock**.

---

# RTL Description

Typical Verilog implementation

```verilog
module jk_ff(
    input clk,
    input J,
    input K,
    output reg Q
);

always @(posedge clk)
begin
    case ({J,K})

        2'b00 : Q <= Q;

        2'b01 : Q <= 1'b0;

        2'b10 : Q <= 1'b1;

        2'b11 : Q <= ~Q;

    endcase
end

endmodule
```

The design uses **non-blocking assignments (`<=`)**, which are recommended for sequential logic.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| CLK | 1 | Clock Input |
| J | 1 | Set Input |
| K | 1 | Reset Input |

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| Q | 1 | Stored Output |
| Q̅ | 1 | Complement Output (optional) |

---

# Internal Operation

### Hold

```
J = 0

K = 0

Q remains unchanged
```

---

### Reset

```
J = 0

K = 1

Q = 0
```

---

### Set

```
J = 1

K = 0

Q = 1
```

---

### Toggle

```
J = 1

K = 1

Q = NOT(Q)
```

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o jk_ff.out jk_ff.v jk_ff_tb.v
```

### Run

```bash
vvp jk_ff.out
```

### View Waveform

```bash
gtkwave jk_ff.vcd
```

---

# Expected Console Output

```
Time CLK J K | Q
-------------------
0    0   0 0 | X
10   ↑   1 0 | 1
20   ↑   0 0 | 1
30   ↑   0 1 | 0
40   ↑   1 1 | 1
50   ↑   1 1 | 0
60   ↑   1 0 | 1
70   ↑   0 1 | 0
```

---

# Expected Waveform

```
CLK
010101010101

J
001100111100

K
000011001111

Q
001111001010
```

The waveform demonstrates all four operating modes:

- Hold
- Set
- Reset
- Toggle

---

# Verification

The testbench verifies all operating conditions.

| Test | J | K | Clock Edge | Expected Output |
|------|---|---|------------|-----------------|
|1|0|0|↑|Hold|
|2|1|0|↑|Set|
|3|0|1|↑|Reset|
|4|1|1|↑|Toggle|
|5|1|1|↑|Toggle Again|
|6|0|0|↑|Hold|

---

# Applications

JK Flip-Flops are widely used in:

- Binary Counters
- Ripple Counters
- Synchronous Counters
- Frequency Dividers
- Shift Registers
- Register Files
- Finite State Machines
- Digital Controllers
- FPGA Sequential Logic
- ASIC Sequential Circuits
- Timing Circuits
- Embedded Systems

---

# Advantages

- Eliminates the invalid state of the SR Flip-Flop
- Supports toggle operation
- Edge-triggered operation
- Reliable synchronous behavior
- Easy FPGA implementation
- Widely used in sequential logic

---

# Limitations

- Slightly more complex than a D Flip-Flop.
- Requires additional logic for toggle operation.
- Modern FPGA designs typically infer D Flip-Flops, making JK Flip-Flops less common in RTL coding.

---

# JK Flip-Flop vs Other Flip-Flops

| Feature | SR FF | D FF | JK FF | T FF |
|----------|-------|------|-------|------|
|Inputs|S,R|D|J,K|T|
|Hold|Yes|Yes|Yes|Yes|
|Set|Yes|Yes|Yes|No|
|Reset|Yes|Yes|Yes|No|
|Toggle|No|No|Yes|Yes|
|Invalid State|Yes|No|No|No|

---

# Excitation Table

The excitation table is useful in sequential circuit and FSM design.

| Current Q | Next Q | J | K |
|-----------|--------|---|---|
|0|0|0|X|
|0|1|1|X|
|1|0|X|1|
|1|1|X|0|

---

# Setup and Hold Time

For reliable operation:

### Setup Time

The inputs **J** and **K** must remain stable for a minimum time before the active clock edge.

### Hold Time

The inputs **J** and **K** must remain stable for a minimum time after the active clock edge.

Violating these timing requirements can cause **metastability**.

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
Static Timing Analysis (STA)
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

- Using blocking (`=`) instead of non-blocking (`<=`) assignments in sequential logic.
- Changing inputs too close to the active clock edge, causing setup/hold violations.
- Confusing level-sensitive latches with edge-triggered flip-flops.
- Forgetting that FPGA synthesis tools generally implement JK behavior using D Flip-Flops and combinational logic.

---

# Future Enhancements

- JK Flip-Flop with Asynchronous Reset
- JK Flip-Flop with Synchronous Reset
- JK Flip-Flop with Enable
- T Flip-Flop
- D Flip-Flop
- Universal Shift Register
- Ring Counter
- Johnson Counter
- Finite State Machine (FSM)
- Parameterized Register File

---
