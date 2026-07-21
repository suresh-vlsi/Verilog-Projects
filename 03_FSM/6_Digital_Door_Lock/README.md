# 6_Digital_Door_Lock

## Overview

This project implements a **Digital Door Lock System** using Verilog HDL. The system compares an entered 4-bit password with a predefined password. If the password matches, the door unlocks. Otherwise, an alarm signal is activated. The design uses a Finite State Machine (FSM) for password verification and access control.

---

## Features

- FSM-based design
- Parameterized password
- Unlock on correct password
- Alarm on incorrect password
- Asynchronous reset
- Synthesizable RTL
- Comprehensive testbench
- Waveform generation for verification

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk | 1 | System clock |
| rst | 1 | Asynchronous reset |
| enter | 1 | Password entry trigger |
| password | 4 | Entered password |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| unlock | 1 | High when password is correct |
| alarm | 1 | High when password is incorrect |

---

## Default Password

```
1010
```

---

## State Diagram

```text
            +------+
            | IDLE |
            +------+
                |
            enter = 1
                |
                V
          +-----------+
          |   CHECK   |
          +-----------+
          /           \
 Correct /             \ Incorrect
        V               V
 +------------+    +------------+
 |  UNLOCK    |    |  LOCKED    |
 +------------+    +------------+
        |               |
    enter=0         enter=0
        \______________/
               |
             IDLE
```

---
---

## Simulation

### Icarus Verilog

Compile

```bash
iverilog -o door_lock.out digital_door_lock.v digital_door_lock_tb.v
```

Run

```bash
vvp door_lock.out
```

Waveform

```bash
gtkwave digital_door_lock.vcd
```

---

### ModelSim / QuestaSim

```tcl
vlib work
vlog digital_door_lock.v
vlog digital_door_lock_tb.v
vsim digital_door_lock_tb
add wave *
run -all
```

---

## Expected Behavior

| Password | Unlock | Alarm |
|-----------|:------:|:-----:|
| 1010 | 1 | 0 |
| Any other value | 0 | 1 |

---

## Applications

- Electronic door access systems
- Smart home security
- Office access control
- Digital lockers
- Hotel room locking systems
- FPGA-based security projects

---

## Future Improvements

- Configurable password length
- Multiple users
- Three-attempt lockout
- Keypad interface
- Password update mode
- LCD/OLED display interface
- RFID authentication
- Fingerprint authentication
- OTP-based access
- UART logging of access events

---

## Learning Outcomes

- FSM design
- Password comparison logic
- Register operations
- Sequential logic
- RTL coding
- Testbench development
- Waveform analysis
- Digital access control systems

---
