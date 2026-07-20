# 7_Washing_Machine_Controller

## Overview

This project implements a **Washing Machine Controller** using Verilog HDL. The controller is designed as a Finite State Machine (FSM) that sequences through the stages of a washing cycle: **Fill**, **Wash**, **Rinse**, **Spin**, and **Done**. Each stage remains active for a predefined number of clock cycles before transitioning to the next stage.

---

## Features

- FSM-based controller
- Automatic washing cycle sequencing
- Timer-controlled state transitions
- Separate outputs for each washing stage
- Asynchronous reset
- Synthesizable RTL
- Comprehensive Verilog testbench
- Waveform generation for verification

---

## Washing Cycle

| Stage | Duration |
|--------|---------:|
| Fill Water | 3 Clock Cycles |
| Wash | 5 Clock Cycles |
| Rinse | 3 Clock Cycles |
| Spin | 4 Clock Cycles |
| Done | 1 Clock Cycle |

---

## State Diagram

```text
             +------+
             | IDLE |
             +------+
                 |
             start = 1
                 |
                 V
            +---------+
            |  FILL   |
            +---------+
                 |
                 V
            +---------+
            |  WASH   |
            +---------+
                 |
                 V
            +---------+
            | RINSE   |
            +---------+
                 |
                 V
            +---------+
            |  SPIN   |
            +---------+
                 |
                 V
            +---------+
            |  DONE   |
            +---------+
                 |
                 +-----------> IDLE
```

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk | 1 | System clock |
| rst | 1 | Asynchronous reset |
| start | 1 | Starts the washing cycle |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| fill_water | 1 | Water inlet valve control |
| wash | 1 | Wash motor control |
| rinse | 1 | Rinse operation |
| spin | 1 | Spin motor control |
| done | 1 | Cycle complete indicator |

---

## Directory Structure

```text
7_Washing_Machine_Controller/
│
├── rtl/
│   └── washing_machine_controller.v
│
├── tb/
│   └── washing_machine_controller_tb.v
│
├── sim/
├── waveform/
├── README.md
└── .gitignore
```

---

## Simulation

### Icarus Verilog

Compile

```bash
iverilog -o washing_machine.out rtl/washing_machine_controller.v tb/washing_machine_controller_tb.v
```

Run

```bash
vvp washing_machine.out
```

Open Waveform

```bash
gtkwave washing_machine_controller.vcd
```

---

### ModelSim / QuestaSim

```tcl
vlib work
vlog rtl/washing_machine_controller.v
vlog tb/washing_machine_controller_tb.v
vsim washing_machine_controller_tb
add wave *
run -all
```

---

## Expected Sequence

```text
Start
  │
  ▼
Fill Water (3 cycles)
  │
  ▼
Wash (5 cycles)
  │
  ▼
Rinse (3 cycles)
  │
  ▼
Spin (4 cycles)
  │
  ▼
Done
  │
  ▼
Idle
```

---

## Applications

- Automatic washing machines
- Home appliance controllers
- Industrial automation
- Embedded control systems
- FPGA-based appliance prototypes
- FSM learning projects

---

## Future Improvements

- Water level sensor input
- Door lock detection
- Temperature control
- Multiple wash modes (Quick, Normal, Heavy)
- Pause and resume functionality
- Error detection (low water, door open)
- Remaining time display
- Buzzer notification on completion

---

## Learning Outcomes

- FSM design using Verilog
- Sequential control systems
- Counter-based timing
- State transitions
- RTL coding practices
- Testbench development
- Waveform verification
- Appliance controller design

---
