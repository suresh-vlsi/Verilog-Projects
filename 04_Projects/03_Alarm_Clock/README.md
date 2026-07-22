# ⏰ Alarm Clock using Verilog HDL

A synthesizable **24-Hour Programmable Alarm Clock** implemented in **Verilog HDL** using a modular, hierarchical RTL architecture. This project extends the Digital Clock by adding programmable alarm registers, comparison logic, and an alarm output, demonstrating industry-standard FPGA/ASIC design practices.

---

# Project Overview

The Alarm Clock keeps track of:

- Hours (00–23)
- Minutes (00–59)
- Seconds (00–59)

In addition, the user can program an alarm time. When the current time matches the stored alarm time, the design generates a **one-second alarm pulse**, which can be connected to a buzzer, interrupt controller, or other notification logic.

---

# Features

- 24-Hour Digital Clock
- Programmable Alarm Time
- Alarm Enable/Disable
- One-Second Alarm Pulse
- Modular RTL Design
- Hierarchical Architecture
- Reusable Counter Modules
- Single Clock Domain
- Parameterized Clock Divider
- Synthesizable Verilog-2001
- FPGA Compatible
- ASIC Compatible

---

# Folder Structure

```
03_Alarm_Clock
│
├── rtl
│   ├── 1_clock_divider.v
│   ├── 2_bcd_counter.v
│   ├── 3_hour_counter.v
│   ├── 4_alarm_register.v
│   ├── 5_alarm_comparator.v
│   └── 6_alarm_clock.v
│
├── tb
│   └── alarm_clock_tb.v
│
├── docs
│
├── waveform
│   └── alarm_clock.vcd
│
├── sim
│
└── README.md
```

---

# Block Diagram

```
                     +----------------------+
                     |                      |
Clock -------------> | Clock Divider        |
Reset -------------> |                      |
                     +----------+-----------+
                                |
                             1 Hz Tick
                                |
              +-----------------+-----------------+
              |                                   |
              ▼                                   ▼
      Seconds Counter                     Alarm Register
              |                                   |
              ▼                                   ▼
      Minutes Counter                  Alarm Hour / Minute
              |                                   |
              ▼                                   |
       Hours Counter                              |
              |                                   |
              +-----------------+-----------------+
                                |
                                ▼
                      Alarm Comparator
                                |
                                ▼
                           Alarm Output
```

---

# RTL Hierarchy

```
alarm_clock
│
├── clock_divider
│
├── bcd_counter
│
├── bcd_counter
│
├── hour_counter
│
├── alarm_register
│
└── alarm_comparator
```

---

# Module Description

## 1. Clock Divider

Generates a one-clock-cycle pulse every second.

### Inputs

- clk
- rst

### Output

- tick_1hz

---

## 2. BCD Counter

Reusable synchronous counter.

Used for:

- Seconds
- Minutes

Features:

- Parameterized
- Overflow Pulse
- Clock Enable
- Synthesizable

---

## 3. Hour Counter

Counts:

```
00

↓

01

↓

...

↓

22

↓

23

↓

00
```

---

## 4. Alarm Register

Stores:

- Alarm Hour
- Alarm Minute

Updates only when:

```
set_alarm = 1
```

Otherwise, it retains the programmed alarm time.

---

## 5. Alarm Comparator

Compares:

Current Time

```
Hours

Minutes

Seconds
```

with

Stored Alarm

```
Alarm Hour

Alarm Minute
```

Alarm condition:

```
Hour    == Alarm Hour

Minute  == Alarm Minute

Second  == 00

Alarm Enable == 1
```

---

## 6. Alarm Clock

Top-level module integrating:

- Clock Divider
- Seconds Counter
- Minutes Counter
- Hour Counter
- Alarm Register
- Alarm Comparator

---

# Functional Flow

```
Power On

↓

Reset

↓

Clock Starts

↓

Program Alarm

↓

Alarm Register Stores Time

↓

Current Time Runs

↓

Current Time = Alarm Time

↓

Alarm Output High

↓

One Second Later

↓

Alarm Output Low
```

---

# Example Operation

Program Alarm:

```
07:30
```

Clock Operation:

```
07:29:58

↓

07:29:59

↓

07:30:00

↓

Alarm = 1

↓

07:30:01

↓

Alarm = 0
```

---

# Input Signals

| Signal | Description |
|----------|-------------|
| clk | System Clock |
| rst | Asynchronous Reset |
| set_alarm | Load Alarm Register |
| alarm_enable | Enable Alarm |
| alarm_hour_in | Alarm Hour |
| alarm_min_in | Alarm Minute |

---

# Output Signals

| Signal | Description |
|----------|-------------|
| hours | Current Hour |
| minutes | Current Minute |
| seconds | Current Second |
| alarm_hour | Stored Alarm Hour |
| alarm_min | Stored Alarm Minute |
| alarm | Alarm Pulse |

---

# Design Methodology

The design follows **industry-standard synchronous RTL principles**.

Key characteristics:

- Single Clock Domain
- Clock Enable Based Counting
- No Gated Clocks
- Modular Design
- Parameterized Components
- Hierarchical RTL

---

# Alarm Logic

```
Current Time

↓

Comparator

↓

Hour Match

↓

Minute Match

↓

Second = 00

↓

Alarm Enable

↓

Alarm Pulse
```

---

# Simulation

## Compile

### Windows (PowerShell)

```powershell
iverilog -o alarm_clock_sim rtl/1_clock_divider.v rtl/2_bcd_counter.v rtl/3_hour_counter.v rtl/4_alarm_register.v rtl/5_alarm_comparator.v rtl/6_alarm_clock.v tb/alarm_clock_tb.v
```

---

## Run

```bash
vvp alarm_clock_sim
```

---

## View Waveform

```bash
gtkwave alarm_clock.vcd
```

---

# Expected Console Output

```
00:00:00

Program Alarm = 00:01

↓

Clock Running

↓

00:00:59

↓

00:01:00

Alarm = 1

↓

00:01:01

Alarm = 0

Simulation Completed Successfully
```

---

# Verification Checklist

- Reset functionality
- Seconds counting
- Minutes counting
- Hours counting
- Alarm programming
- Alarm enable
- Alarm disable
- Alarm comparison
- One-second alarm pulse
- Waveform generation

---

# Applications

- Digital Alarm Clocks
- FPGA Development Boards
- Embedded Systems
- Home Automation
- Industrial Controllers
- Time-Based Event Triggering
- Educational RTL Projects

---

# Advantages

- Modular RTL
- Hierarchical Design
- Reusable Components
- Easy Verification
- Synthesizable
- FPGA Friendly
- ASIC Friendly
- Interview Ready

---

# Limitations

- Single Alarm Only
- No Snooze Function
- No Time Setting Interface
- No Display Driver
- No Alarm Duration Control
- No RTC Synchronization

---

# Future Enhancements

- Multiple Alarms
- Snooze Button
- Alarm Acknowledge
- Alarm Duration Timer
- Push Button Debouncer
- Seven-Segment Display Driver
- LCD Interface
- UART Time Programming
- RTC Interface (DS1307/DS3231)
- Calendar Support
- Day-of-Week Alarm
- 12-Hour (AM/PM) Mode

---

# FPGA Design Flow

```
RTL Design

↓

Functional Simulation

↓

Synthesis

↓

Implementation

↓

Static Timing Analysis

↓

Bitstream Generation

↓

FPGA Programming
```

---
