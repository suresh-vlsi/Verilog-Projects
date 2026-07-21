# 5_Traffic_Light_With_Timer

## Overview

This project implements a **Traffic Light Controller with Timer** using Verilog HDL. The controller operates as a Finite State Machine (FSM), cycling through **Green**, **Yellow**, and **Red** states with predefined time durations. The design demonstrates sequential logic, counters, and FSM implementation, making it a fundamental digital design project for FPGA and ASIC development.

---

## Features

- Moore FSM architecture
- Three traffic light states
- Timer-based state transitions
- Parameterized state durations (can be easily modified)
- Synthesizable RTL
- Comprehensive Verilog testbench
- Waveform generation for verification

---

## Traffic Light Timing

| Light | Duration |
|--------|---------:|
| Green | 10 Clock Cycles |
| Yellow | 3 Clock Cycles |
| Red | 10 Clock Cycles |

> **Note:** The testbench uses a simple clock where one clock cycle represents one second for easy simulation.

---

## State Diagram

```text
             +---------+
             | GREEN   |
             +---------+
                  |
            After 10 Cycles
                  |
                  V
             +---------+
             | YELLOW  |
             +---------+
                  |
             After 3 Cycles
                  |
                  V
             +---------+
             |  RED    |
             +---------+
                  |
            After 10 Cycles
                  |
                  +------------------+
                                     |
                                     V
                                 GREEN
```

---

## FSM Description

| State | Active Light | Next State |
|--------|--------------|------------|
| GREEN | Green ON | Yellow |
| YELLOW | Yellow ON | Red |
| RED | Red ON | Green |

---
---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk | 1 | System clock |
| rst | 1 | Asynchronous reset |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| green | 1 | Green light output |
| yellow | 1 | Yellow light output |
| red | 1 | Red light output |

---

## State Encoding

| State | Encoding |
|--------|---------:|
| GREEN | 2'b00 |
| YELLOW | 2'b01 |
| RED | 2'b10 |

---

## Design Flow

```text
             Reset
               │
               ▼
         GREEN State
               │
      Timer = 10 Cycles
               │
               ▼
        YELLOW State
               │
      Timer = 3 Cycles
               │
               ▼
          RED State
               │
      Timer = 10 Cycles
               │
               └──────────────► GREEN
```

---

## Simulation

### Icarus Verilog

Compile

```bash
iverilog -o traffic.out traffic_light_timer.v traffic_light_timer_tb.v
```

Run

```bash
vvp traffic.out
```

Open Waveform

```bash
gtkwave traffic_light_timer.vcd
```

---

### ModelSim / QuestaSim

```tcl
vlib work
vlog traffic_light_timer.v
vlog traffic_light_timer_tb.v
vsim traffic_light_timer_tb
add wave *
run -all
```

---

## Expected Output

```text
Time    Green Yellow Red

0        1      0      0

...

After 10 cycles

0        1      0

...

After 3 cycles

0        0      1

...

After 10 cycles

1        0      0

Repeat...
```

---

## Waveform Behavior

```text
Clock
_|‾|_|‾|_|‾|_|‾|_|‾|_

Green
‾‾‾‾‾‾‾‾‾___________

Yellow
__________‾‾‾_______

Red
_____________‾‾‾‾‾‾‾‾

Sequence:

GREEN → YELLOW → RED → GREEN
```

---

## Applications

- Road traffic signal control
- Smart city infrastructure
- FPGA learning projects
- FSM-based digital controllers
- Embedded traffic management systems
- Digital logic laboratory experiments

---

## Future Improvements

- Configurable timer values using parameters
- Pedestrian crossing button
- Emergency vehicle priority
- Countdown timer display
- Four-way traffic intersection
- Night blinking mode
- Vehicle density sensor integration
- Multiple synchronized intersections

---

## Learning Outcomes

After completing this project, you will understand:

- Finite State Machine (FSM) design
- Moore state machines
- Sequential logic
- Counter/timer implementation
- State transitions
- Verilog RTL coding
- Testbench development
- Waveform analysis
- FPGA implementation basics

---
