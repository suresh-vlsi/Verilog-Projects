# 9_Sequence_Detector_FSM

## Overview

The **Sequence Detector** is a sequential digital circuit designed to detect a predefined sequence of bits from a serial input stream. Unlike combinational circuits, a Sequence Detector remembers previous inputs using a **Finite State Machine (FSM)**, allowing it to recognize patterns over time.

Sequence detectors are among the most common interview questions for **RTL Design**, **FPGA**, and **ASIC** roles because they combine several important digital design concepts:

- Finite State Machines (FSM)
- Sequential Logic
- State Encoding
- Clocked Logic
- Pattern Recognition
- Verilog RTL Coding

This project implements a synthesizable **Moore FSM Sequence Detector** in Verilog to detect the binary sequence:

```
1011
```

When the sequence **1011** is detected, the output **detect** becomes HIGH for one clock cycle.

The design also supports **overlapping sequence detection**, allowing consecutive occurrences of the target sequence to be detected without resetting the FSM.

Example

```
Input

1011011

Detected

1011
   1011
```

Both occurrences are detected.

---

# Features

- Synthesizable Verilog RTL
- Moore Finite State Machine
- Detects sequence **1011**
- Supports overlapping detection
- Positive-edge triggered
- Synchronous operation
- FPGA/ASIC compatible
- Complete testbench
- GTKWave waveform generation
- Industry-standard RTL coding style

---

# Theory

A Sequence Detector continuously monitors a serial input stream.

Example input

```
1 0 1 1 0 1 1
```

Desired sequence

```
1011
```

Whenever the sequence appears,

```
detect = 1
```

Otherwise,

```
detect = 0
```

The FSM stores the history of previously received bits.

---

# Moore vs Mealy FSM

Two types of FSMs are commonly used.

### Moore FSM

```
Output depends only on

Current State
```

Advantages

- Stable outputs
- Glitch-free
- Easier timing analysis
- Preferred in FPGA/ASIC designs

---

### Mealy FSM

```
Output depends on

Current State

+

Current Input
```

Advantages

- Fewer states
- Faster response

Disadvantages

- Possible glitches
- More difficult timing analysis

This project uses a **Moore FSM**.

---

# Target Sequence

```
1011
```

---

# State Diagram

```
                 1
          +--------------+
          |              |
          ▼              |
      +-------+          |
      | S0    |<---------+
      | Idle  |
      +-------+
       |0
       |
       |1
       ▼
    +-------+
    | S1    |
    | 1      |
    +-------+
      |0
      ▼
    +-------+
    | S2    |
    | 10     |
    +-------+
      |1
      ▼
    +-------+
    | S3    |
    | 101    |
    +-------+
      |1
      ▼
    +-------+
    | S4    |
    |Detected|
    +-------+
```

The FSM transitions through intermediate states as matching bits are received.

---

# State Transition Table

| Current State | Input = 0 | Input = 1 |
|---------------|-----------|-----------|
| S0 | S0 | S1 |
| S1 | S2 | S1 |
| S2 | S0 | S3 |
| S3 | S2 | S4 |
| S4 | S2 | S1 |

---

# State Encoding

One possible encoding is

| State | Binary |
|--------|--------|
|S0|000|
|S1|001|
|S2|010|
|S3|011|
|S4|100|

The actual encoding may vary depending on the synthesis tool.

---

# Working Principle

Initially

```
State = S0
```

Suppose the serial input is

```
1
```

FSM

```
S0

↓

S1
```

Next bit

```
0
```

FSM

```
S1

↓

S2
```

Next bit

```
1
```

FSM

```
S2

↓

S3
```

Next bit

```
1
```

FSM

```
S3

↓

S4

↓

detect = 1
```

The desired sequence has now been detected.

---

# Overlapping Detection

Suppose the input is

```
1011011
```

Detected sequences

```
1011
   1011
```

Instead of returning to the idle state after detection, the FSM transitions to a state that preserves the longest valid suffix of the detected sequence. This enables overlapping detection without restarting the search.

---

# Block Diagram

```
                  +---------------------------+
 Serial Input --->|                           |
                  |   Sequence Detector FSM   |
 Clock ---------->|                           |
 Reset ---------->|                           |
                  +---------------------------+
                             |
                             |
                          Detect
```

---

# RTL Architecture

The FSM consists of three logical blocks.

```
            +----------------------+
            | Present State Register|
            +----------------------+
                      |
                      ▼
            +----------------------+
            | Next-State Logic     |
            +----------------------+
                      |
                      ▼
            +----------------------+
            | Output Logic         |
            +----------------------+
                      |
                    Detect
```

---

# RTL Description

Typical Verilog structure

```verilog
// State Register
always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

// Next-State Logic
always @(*)
begin
    case(state)
        ...
    endcase
end

// Output Logic
always @(*)
begin
    detect = (state == S4);
end
```

The design follows the standard **three-process FSM coding style**, commonly used in industry.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
| CLK |1|System Clock|
| RST |1|Reset|
| DIN |1|Serial Input|

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
| DETECT |1|Sequence Detected|

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o sequence_detector.out sequence_detector.v sequence_detector_tb.v
```

### Run

```bash
vvp sequence_detector.out
```

### View Waveform

```bash
gtkwave sequence_detector.vcd
```

---

# Expected Console Output

```
Time  DIN  State  Detect
-------------------------
0      0    S0      0
10     1    S1      0
20     0    S2      0
30     1    S3      0
40     1    S4      1
50     0    S2      0
60     1    S3      0
70     1    S4      1
```

---

# Expected Waveform

```
CLK
_|‾|_|‾|_|‾|_|‾|_|‾|_

DIN
1 0 1 1 0 1 1

State
S0 S1 S2 S3 S4 S2 S3 S4

Detect
0  0  0  0  1  0  0  1
```

---

# Verification

The testbench verifies:

| Test | Input Stream | Expected Result |
|------|--------------|-----------------|
|1|1011|Detect once|
|2|1011011|Detect twice (overlapping)|
|3|111111|No detection|
|4|000000|No detection|
|5|101011|No detection|
|6|Reset operation|FSM returns to S0|

---

# Applications

Sequence Detectors are widely used in:

- Serial communication receivers
- UART protocol detection
- SPI protocol monitoring
- Packet synchronization
- Digital communication systems
- Error detection circuits
- Pattern recognition
- Embedded controllers
- FPGA protocol analyzers
- ASIC communication interfaces
- Network packet processing
- Industrial automation systems

---

# Advantages

- Efficient pattern recognition
- Supports overlapping detection
- Glitch-free Moore FSM output
- Modular and scalable design
- FPGA/ASIC friendly
- Easy to extend for longer sequences

---

# Limitations

- Longer sequences require more FSM states.
- Moore FSMs generally use more states than equivalent Mealy FSMs.
- Detects only predefined patterns unless redesigned.

---

# Moore FSM vs Mealy FSM

| Feature | Moore FSM | Mealy FSM |
|----------|-----------|-----------|
|Output Depends On|State Only|State + Input|
|Output Stability|High|Can Glitch|
|Response Time|One Clock Later|Immediate|
|Number of States|Usually More|Usually Fewer|
|Preferred For|FPGA/ASIC RTL|Protocol Interfaces|

---

# FPGA/ASIC Design Flow

```
Specification
      │
      ▼
FSM Design
      │
      ▼
State Diagram
      │
      ▼
RTL Coding
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
RTL Synthesis
      │
      ▼
Static Timing Analysis (STA)
      │
      ▼
Place & Route
      │
      ▼
Bitstream / GDSII Generation
```

---
---

# Common Design Pitfalls

- Incorrect state transitions causing missed or false detections.
- Failing to support overlapping sequences when required.
- Mixing combinational and sequential logic in the same `always` block.
- Using blocking (`=`) assignments for state registers instead of non-blocking (`<=`).
- Not assigning default values in combinational logic, leading to unintended latch inference.

---

# Future Enhancements

- Mealy FSM Sequence Detector
- Parameterized Sequence Detector
- Configurable Pattern Length
- Multi-Pattern Sequence Detector
- UART Frame Detector
- SPI Protocol Detector
- Ethernet Preamble Detector
- Pattern Matching Accelerator
- Traffic Light Controller FSM
- Elevator Controller FSM

---
