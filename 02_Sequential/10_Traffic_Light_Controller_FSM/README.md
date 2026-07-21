# 10_Traffic_Light_Controller_FSM

## Overview

The **Traffic Light Controller** is one of the most common **Finite State Machine (FSM)** applications in Digital Electronics, FPGA Design, ASIC Design, and Embedded Systems. It automatically controls traffic signals by changing the light sequence in a predefined order using clock-driven state transitions.

Unlike a combinational circuit, a Traffic Light Controller is a **sequential circuit** because the current output depends not only on the present inputs but also on the **current state** of the system.

This project implements a **Moore Finite State Machine (FSM)** in Verilog HDL that controls a **two-road traffic intersection**.

The controller cycles through the following traffic phases:

```
Road A : Green
Road B : Red

↓

Road A : Yellow
Road B : Red

↓

Road A : Red
Road B : Green

↓

Road A : Red
Road B : Yellow

↓

Repeat
```

Each state remains active for a predefined duration determined by an internal timer or clock counter.

This project is suitable for:

- FPGA Learning
- ASIC RTL Design
- Digital Electronics
- VLSI Interviews
- Embedded Systems
- Smart Traffic Systems

---

# Features

- Synthesizable Verilog RTL
- Moore FSM Architecture
- Four-State Traffic Controller
- Automatic State Transition
- Clock-driven Operation
- Reset Support
- Timer-Based State Changes
- FPGA Compatible
- ASIC Compatible
- Functional Verification
- GTKWave Waveform Generation

---

# Theory

Traffic lights regulate vehicle movement at road intersections.

A basic two-road junction contains:

```
Road A

Green
Yellow
Red
```

```
Road B

Green
Yellow
Red
```

To avoid accidents,

- Both roads must **never receive Green simultaneously**.
- Yellow acts as a transition state.
- Red indicates stop.

The controller continuously cycles through the traffic sequence.

---

# State Definitions

The FSM consists of four states.

| State | Road A | Road B |
|--------|--------|--------|
|S0|Green|Red|
|S1|Yellow|Red|
|S2|Red|Green|
|S3|Red|Yellow|

The sequence is

```
S0

↓

S1

↓

S2

↓

S3

↓

S0
```

---

# State Diagram

```
              +---------+
              |   S0    |
              | G   R   |
              +---------+
                   |
                   |
                   ▼
              +---------+
              |   S1    |
              | Y   R   |
              +---------+
                   |
                   ▼
              +---------+
              |   S2    |
              | R   G   |
              +---------+
                   |
                   ▼
              +---------+
              |   S3    |
              | R   Y   |
              +---------+
                   |
                   ▼
                  S0
```

---

# State Encoding

One possible state encoding is

| State | Binary |
|--------|--------|
|S0|00|
|S1|01|
|S2|10|
|S3|11|

The synthesis tool may choose a different encoding depending on optimization settings.

---

# Working Principle

Initially,

```
RST = 1
```

The controller enters

```
State S0

Road A = Green

Road B = Red
```

After the timer expires,

```
S0

↓

S1
```

Road A changes to Yellow.

After another timer interval,

```
S1

↓

S2
```

Road A becomes Red while Road B becomes Green.

Similarly,

```
S2

↓

S3
```

Finally,

```
S3

↓

S0
```

The cycle repeats indefinitely.

---

# Traffic Signal Timing

Example timing

| State | Duration |
|---------|---------|
|Green|10 Seconds|
|Yellow|3 Seconds|
|Red|Depends on opposite road|

In simulation, these delays are represented by **clock cycles** instead of real-time seconds.

---

# Truth Table

| State | Road A Green | Road A Yellow | Road A Red | Road B Green | Road B Yellow | Road B Red |
|--------|--------------|---------------|------------|--------------|---------------|------------|
|S0|1|0|0|0|0|1|
|S1|0|1|0|0|0|1|
|S2|0|0|1|1|0|0|
|S3|0|0|1|0|1|0|

---

# Block Diagram

```
                 +------------------------------+
 Clock --------->|                              |
 Reset --------->| Traffic Light Controller FSM |
                 |                              |
                 +------------------------------+
                    │      │
                    │      │
              Road A      Road B
           R Y G LEDs   R Y G LEDs
```

---

# FSM Architecture

The controller consists of three logical blocks.

```
          +----------------------+
          | State Register       |
          +----------------------+
                     │
                     ▼
          +----------------------+
          | Next-State Logic     |
          +----------------------+
                     │
                     ▼
          +----------------------+
          | Output Logic         |
          +----------------------+
                     │
          Road A & Road B Lights
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

    S0 : next_state = S1;

    S1 : next_state = S2;

    S2 : next_state = S3;

    S3 : next_state = S0;

    endcase
end

// Output Logic
always @(*)
begin
    case(state)

    S0:
    begin
        roadA = GREEN;
        roadB = RED;
    end

    ...

    endcase
end
```

The FSM follows the **three-process coding style**, which separates state updates, next-state logic, and output logic for better readability and synthesis.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
|CLK|1|System Clock|
|RST|1|Reset|

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
|RoadA_G|1|Road A Green|
|RoadA_Y|1|Road A Yellow|
|RoadA_R|1|Road A Red|
|RoadB_G|1|Road B Green|
|RoadB_Y|1|Road B Yellow|
|RoadB_R|1|Road B Red|

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o traffic_light.out traffic_light_controller.v traffic_light_controller_tb.v
```

### Run

```bash
vvp traffic_light.out
```

### View Waveform

```bash
gtkwave traffic_light_controller.vcd
```

---

# Expected Console Output

```
Time   State   Road A    Road B
-----------------------------------------
0      S0      Green     Red
100    S1      Yellow    Red
130    S2      Red       Green
230    S3      Red       Yellow
260    S0      Green     Red
```

---

# Expected Waveform

```
CLK
_|‾|_|‾|_|‾|_|‾|_|‾|_

State

S0  S1  S2  S3  S0

Road A

Green
Yellow
Red
Red
Green

Road B

Red
Red
Green
Yellow
Red
```

---

# Verification

The testbench verifies the following scenarios:

| Test | Expected Result |
|------|-----------------|
|Reset|Controller starts in S0|
|S0 → S1|Road A changes Green → Yellow|
|S1 → S2|Road A becomes Red, Road B becomes Green|
|S2 → S3|Road B changes Green → Yellow|
|S3 → S0|Road A becomes Green again|
|Continuous Operation|Repeats correctly|

---

# Applications

Traffic Light Controllers are widely used in:

- Smart Traffic Management Systems
- Intelligent Transportation Systems (ITS)
- FPGA Development Boards
- ASIC Traffic Controllers
- Railway Signaling
- Factory Automation
- Industrial Process Sequencing
- Parking Gate Controllers
- Airport Runway Signal Systems
- Educational FSM Projects

---

# Advantages

- Simple FSM implementation
- Deterministic operation
- Easy to verify
- Modular design
- Safe traffic sequencing
- FPGA-friendly architecture
- Easily scalable for more intersections

---

# Limitations

- Fixed timing unless additional control logic is added.
- Does not account for real-time traffic density.
- Cannot prioritize emergency vehicles without extra inputs.
- Limited to a simple two-road intersection.

---

# Traffic Light Controller vs Real-Time Smart Controller

| Feature | Basic FSM Controller | Smart Controller |
|----------|----------------------|------------------|
|Fixed Timing|Yes|No|
|Vehicle Sensors|No|Yes|
|Emergency Vehicle Detection|No|Yes|
|Traffic Density Adaptation|No|Yes|
|Hardware Complexity|Low|High|
|Cost|Low|Higher|

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

- Allowing conflicting Green signals for both roads.
- Omitting default assignments in combinational logic, leading to latch inference.
- Mixing combinational and sequential logic in the same `always` block.
- Using blocking (`=`) assignments for state registers instead of non-blocking (`<=`).
- Hardcoding timing values instead of using parameters, reducing design flexibility.

---

# Future Enhancements

- Traffic Density-Based Controller
- Emergency Vehicle Priority
- Pedestrian Crossing Support
- Countdown Timer Display
- Four-Way Intersection Controller
- Sensor-Based Adaptive Timing
- Night Mode Flashing Signals
- Parameterized Green/Yellow Durations
- Multi-Junction Traffic Coordination
- Smart IoT-Based Traffic Management System

---