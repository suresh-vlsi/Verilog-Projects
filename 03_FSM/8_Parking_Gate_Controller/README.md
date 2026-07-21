# 8_Park_Gate_Controller

## Overview

This project implements an **Automatic Parking Gate Controller** using Verilog HDL. The controller opens a parking gate when a vehicle is detected, waits until the vehicle passes through, and then closes the gate. The design uses a Finite State Machine (FSM) with timer-based control for gate movement.

---

## Features

- Moore FSM architecture
- Vehicle detection input
- Vehicle passed sensor input
- Automatic gate opening
- Automatic gate closing
- Timer-controlled gate movement
- Synthesizable RTL
- Verilog testbench
- Waveform generation

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk | 1 | System clock |
| rst | 1 | Asynchronous reset |
| vehicle_detect | 1 | Vehicle arrival sensor |
| vehicle_passed | 1 | Exit sensor |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| gate_open | 1 | Opens gate motor |
| gate_close | 1 | Closes gate motor |

---

## FSM States

| State | Description |
|--------|-------------|
| IDLE | Wait for vehicle |
| OPEN_GATE | Open barrier |
| WAIT_PASS | Wait until vehicle passes |
| CLOSE_GATE | Close barrier |

---

## State Diagram

```text
                +------+
                | IDLE |
                +------+
                    |
          vehicle_detect
                    |
                    V
            +---------------+
            |  OPEN_GATE    |
            +---------------+
                    |
            Gate Open Timer
                    |
                    V
            +---------------+
            |  WAIT_PASS    |
            +---------------+
                    |
          vehicle_passed
                    |
                    V
            +---------------+
            | CLOSE_GATE    |
            +---------------+
                    |
           Gate Close Timer
                    |
                    +-----------> IDLE
```

---
---

## Simulation

### Icarus Verilog

Compile

```bash
iverilog -o park_gate.out park_gate_controller.v park_gate_controller_tb.v
```

Run

```bash
vvp park_gate.out
```

Waveform

```bash
gtkwave park_gate_controller.vcd
```

---

## Expected Operation

```text
Vehicle Detected
       │
       ▼
Gate Opens
       │
       ▼
Vehicle Passes
       │
       ▼
Gate Closes
       │
       ▼
Idle
```

---

## Applications

- Parking lot automation
- Toll booth systems
- Smart city infrastructure
- Industrial access control
- Residential gated communities
- FPGA automation projects

---

## Future Improvements

- Entry and exit vehicle counters
- RFID-based authentication
- Number plate recognition interface
- Safety sensor to prevent gate closing on vehicles
- Emergency manual override
- LCD display for parking status
- UART logging of vehicle entries
- Parking space availability display

---

## Learning Outcomes

- FSM design
- Sensor interfacing
- Sequential logic
- Counter-based timing
- RTL development
- Testbench creation
- Waveform verification
- Embedded controller design

---
