# 5_T_Flip_Flop

## Overview

The **T (Toggle) Flip-Flop** is a fundamental sequential logic circuit that stores **one bit of information** and toggles its output whenever the **Toggle input (T)** is HIGH during the active edge of the clock.

The T Flip-Flop is derived from the **JK Flip-Flop** by connecting both J and K inputs together.

```
J = K = T
```

Whenever:

```
T = 0
```

the output remains unchanged.

Whenever:

```
T = 1
```

the output toggles (changes from 0→1 or 1→0) on every active clock edge.

Because of its toggling capability, the T Flip-Flop is extensively used in:

- Binary Counters
- Frequency Dividers
- Digital Clocks
- Event Counters
- State Machines
- Timing Circuits
- FPGA Designs
- ASIC Designs
- Clock Division Networks
- Embedded Systems

This project presents a synthesizable Verilog implementation of a **Positive Edge Triggered T Flip-Flop** along with a comprehensive testbench for functional verification.

---

# Features

- Synthesizable Verilog RTL
- Positive-edge triggered
- Toggle functionality
- One-bit storage element
- FPGA/ASIC compatible
- Functional verification
- GTKWave waveform generation
- Industry-standard coding style

---

# Theory

The T Flip-Flop stores one bit of data.

Inputs

```
T

CLK
```

Outputs

```
Q

Q̅
```

Operation

```
Clock Rising Edge

T = 0

Q remains unchanged
```

```
Clock Rising Edge

T = 1

Q toggles
```

No output changes occur between clock edges.

---

# Symbol

```
               +----------------+
T ------------>|                |
CLK ---------->|>  T Flip-Flop  |------ Q
               |                |------ Q̅
               +----------------+
```

The triangle (`>`) indicates an edge-triggered clock.

---

# Truth Table

| Clock | T | Q(Current) | Q(Next) | Operation |
|-------|---|------------|----------|-----------|
| ↑ |0|0|0|Hold|
| ↑ |0|1|1|Hold|
| ↑ |1|0|1|Toggle|
| ↑ |1|1|0|Toggle|
| No Edge |X|Q|Q|Hold|

---

# State Transition Table

| Current Q | T | Next Q |
|-----------|---|--------|
|0|0|0|
|1|0|1|
|0|1|1|
|1|1|0|

---

# Characteristic Equation

The characteristic equation of a T Flip-Flop is

```
Q(next) = T ⊕ Q
```

where

```
⊕ = XOR Operation
```

This equation indicates:

- If **T = 0**, the output remains unchanged.
- If **T = 1**, the output toggles.

---

# Timing Diagram

```
CLK
___/‾‾\___/‾‾\___/‾‾\___/‾‾\___

T
____‾‾‾‾___________‾‾‾‾_______

Q
______‾‾______‾‾______________
```

Notice that **Q changes only on the rising edge of CLK when T = 1**.

---

# RTL Description

Typical Verilog implementation

```verilog
module t_ff(
    input clk,
    input T,
    output reg Q
);

always @(posedge clk)
begin
    if (T)
        Q <= ~Q;
    else
        Q <= Q;
end

endmodule
```

The design uses **non-blocking assignments (`<=`)**, which are recommended for sequential logic.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| CLK | 1 | Clock Input |
| T | 1 | Toggle Input |

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
T = 0

Q remains unchanged
```

---

### Toggle

```
T = 1

Q becomes

NOT(Q)
```

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o t_ff.out t_ff.v t_ff_tb.v
```

### Run

```bash
vvp t_ff.out
```

### View Waveform

```bash
gtkwave t_ff.vcd
```

---

# Expected Console Output

```
Time CLK T | Q
-----------------
0    0   0 | X
10   ↑   0 | X
20   ↑   1 | 1
30   ↑   1 | 0
40   ↑   1 | 1
50   ↑   0 | 1
60   ↑   1 | 0
70   ↑   0 | 0
80   ↑   1 | 1
```

---

# Expected Waveform

```
CLK
01010101010101

T
00111100110011

Q
00010111001010
```

The waveform demonstrates:

- Hold operation when **T = 0**
- Toggle operation when **T = 1**

---

# Verification

The testbench verifies all operating modes.

| Test | T | Clock Edge | Expected Output |
|------|---|------------|-----------------|
|1|0|↑|Hold|
|2|1|↑|Toggle|
|3|1|↑|Toggle|
|4|1|↑|Toggle|
|5|0|↑|Hold|
|6|1|↑|Toggle|
|7|0|↑|Hold|
|8|1|↑|Toggle|

---

# Applications

T Flip-Flops are widely used in:

- Binary Counters
- Ripple Counters
- Synchronous Counters
- Frequency Dividers
- Digital Clocks
- Clock Division Circuits
- Event Counters
- Timing Controllers
- FPGA Sequential Logic
- ASIC Sequential Logic
- Embedded Controllers
- Finite State Machines

---

# Advantages

- Simple hardware implementation
- Ideal for counter design
- Efficient frequency division
- Edge-triggered operation
- Reliable synchronous behavior
- FPGA-friendly implementation

---

# Limitations

- Performs only hold and toggle operations.
- Less flexible than JK Flip-Flops.
- Requires a stable clock for reliable operation.
- Typically implemented internally using D Flip-Flops in FPGA architectures.

---

# T Flip-Flop vs Other Flip-Flops

| Feature | SR FF | D FF | JK FF | T FF |
|----------|-------|------|-------|------|
|Inputs|S,R|D|J,K|T|
|Hold|Yes|Yes|Yes|Yes|
|Set|Yes|Yes|Yes|No|
|Reset|Yes|Yes|Yes|No|
|Toggle|No|No|Yes|Yes|
|Invalid State|Yes|No|No|No|
|Primary Application|Memory|Registers|Counters & FSMs|Counters & Frequency Division|

---

# Excitation Table

The excitation table is useful in sequential circuit design.

| Current Q | Next Q | T |
|-----------|--------|---|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

---

# Frequency Division

A T Flip-Flop naturally divides the input clock frequency by **2** when the toggle input remains HIGH.

```
T = 1

Clock Frequency = f

↓

Output Frequency = f / 2
```

Example

```
Clock = 100 MHz

↓

Q = 50 MHz
```

By cascading multiple T Flip-Flops, frequencies can be divided by powers of two:

| Number of T Flip-Flops | Output Frequency |
|-------------------------|------------------|
|1|f/2|
|2|f/4|
|3|f/8|
|4|f/16|
|5|f/32|

This property makes T Flip-Flops ideal for digital counters and clock dividers.

---

# Setup and Hold Time

For reliable operation:

### Setup Time

The **T** input must remain stable for a minimum time before the rising edge of the clock.

### Hold Time

The **T** input must remain stable for a minimum time after the rising edge.

Violating these timing requirements can lead to **metastability**, causing unpredictable behavior.

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

- Using blocking (`=`) assignments instead of non-blocking (`<=`) assignments in sequential logic.
- Violating setup and hold time requirements.
- Assuming output changes immediately with T; changes occur only on the active clock edge.
- Forgetting that most FPGA devices implement T Flip-Flops by mapping the logic to D Flip-Flops.

---

# Future Enhancements

- T Flip-Flop with Asynchronous Reset
- T Flip-Flop with Synchronous Reset
- T Flip-Flop with Enable
- Binary Ripple Counter
- Synchronous Binary Counter
- Johnson Counter
- Ring Counter
- Clock Divider
- Universal Shift Register
- Finite State Machine (FSM)

---