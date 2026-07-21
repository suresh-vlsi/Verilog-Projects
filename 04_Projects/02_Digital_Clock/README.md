# 🕒 Digital Clock using Verilog HDL

A synthesizable **24-Hour Digital Clock** designed in **Verilog HDL** using a modular and hierarchical RTL architecture. The project demonstrates industry-standard FPGA/ASIC design practices, including parameterized modules, reusable counters, single-clock synchronous design, and clock-enable based counting.

---

# Project Overview

This project implements a **24-hour digital clock** capable of displaying:

- Hours (00–23)
- Minutes (00–59)
- Seconds (00–59)

The clock automatically updates every second and correctly performs rollovers:

- Seconds: 59 → 00
- Minutes: 59 → 00
- Hours: 23 → 00

The design uses a **single clock domain**, making it suitable for FPGA implementation and ASIC synthesis.

---

# Features

- 24-Hour Time Format
- Automatic Time Increment
- Modular RTL Design
- Hierarchical Architecture
- Parameterized Clock Divider
- Reusable Counter Modules
- Dedicated Hour Counter
- Single Clock Domain
- Clock Enable Based Design
- Synthesizable Verilog-2001
- FPGA Friendly
- ASIC Friendly

---

# Project Structure

```
02_Digital_Clock
│
├── rtl
│   ├── 1_clock_divider.v
│   ├── 2_bcd_counter.v
│   ├── 3_hour_counter.v
│   └── 4_digital_clock.v
│
├── tb
│   └── digital_clock_tb.v
│
├── waveform
│   └── digital_clock.vcd
│
├── docs
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
Clock ----------->|   Clock Divider      |
Reset ----------->|                      |
                  +----------+-----------+
                             |
                         1 Hz Tick
                             |
                             ▼
                  +----------------------+
                  | Seconds Counter      |
                  |       00–59          |
                  +----------+-----------+
                             |
                        Overflow
                             |
                             ▼
                  +----------------------+
                  | Minutes Counter      |
                  |       00–59          |
                  +----------+-----------+
                             |
                        Overflow
                             |
                             ▼
                  +----------------------+
                  | Hours Counter        |
                  |       00–23          |
                  +----------------------+
```

---

# RTL Hierarchy

```
digital_clock
│
├── clock_divider
│
├── bcd_counter
│
├── bcd_counter
│
└── hour_counter
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

### Used For

- Seconds
- Minutes

### Features

- Parameterized
- Clock Enable
- Overflow Pulse
- Synthesizable

---

## 3. Hour Counter

Counts from:

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

Generates an overflow pulse after 23.

---

## 4. Digital Clock

Top-level module integrating all submodules.

---

# Counter Flow

```
1 Hz Tick

↓

Seconds

↓

59 → 00

↓

Minute Overflow

↓

Minutes

↓

59 → 00

↓

Hour Overflow

↓

Hours

↓

23 → 00
```

---

# Time Sequence

```
00:00:00

↓

00:00:01

↓

00:00:02

↓

...

↓

00:00:59

↓

00:01:00

↓

...

↓

00:59:59

↓

01:00:00

↓

...

↓

23:59:59

↓

00:00:00
```

---

# Input Signals

| Signal | Description |
|---------|-------------|
| clk | System Clock |
| rst | Asynchronous Active-High Reset |

---

# Output Signals

| Signal | Description |
|---------|-------------|
| hours | Hours (00–23) |
| minutes | Minutes (00–59) |
| seconds | Seconds (00–59) |

---

# Design Methodology

The design follows a **single synchronous clock** methodology.

Instead of generating derived clocks, it uses:

- Clock Enable
- Tick Pulse
- Overflow Pulse

Benefits include:

- No clock gating
- Easier timing closure
- Reduced clock skew
- Better FPGA implementation
- ASIC friendly

---

# Clock Rollover

## Seconds

```
58

↓

59

↓

00
```

---

## Minutes

```
58

↓

59

↓

00
```

---

## Hours

```
22

↓

23

↓

00
```

---

# Simulation

## Compile

### Windows (PowerShell)

```powershell
iverilog -o digital_clock_sim rtl/1_clock_divider.v rtl/2_bcd_counter.v rtl/3_hour_counter.v rtl/4_digital_clock.v tb/digital_clock_tb.v
```

## Run

```bash
vvp digital_clock_sim
```

---

## View Waveform

```bash
gtkwave digital_clock.vcd
```

---

# Expected Console Output

```
--------------------------------------------
        DIGITAL CLOCK SIMULATION
--------------------------------------------

00:00:00

00:00:01

00:00:02

...

00:00:59

00:01:00

...

00:59:59

01:00:00

...

23:59:59

00:00:00

Simulation Completed Successfully
```

---

# Expected Waveform

Verify:

- Reset
- Tick Generation
- Seconds Increment
- Minute Increment
- Hour Increment
- Seconds Overflow
- Minutes Overflow
- 24-Hour Rollover

---

# Verification Checklist

- Reset functionality
- Seconds counting
- Minute counting
- Hour counting
- Seconds rollover
- Minutes rollover
- Hours rollover
- 23:59:59 → 00:00:00
- Waveform generation
- Console output

---

# Applications

- Digital Wall Clocks
- Digital Wrist Watches
- FPGA Development Boards
- Embedded Systems
- Timekeeping Systems
- Industrial Automation
- Digital Timers
- Real-Time Clock Controllers

---

# Advantages

- Modular RTL
- Hierarchical Design
- Reusable Modules
- Parameterized Components
- Single Clock Domain
- Easy Verification
- Easy Maintenance
- FPGA Compatible
- ASIC Compatible
- Interview Ready

---

# Limitations

- No time-setting interface
- No AM/PM mode
- No alarm feature
- No display driver
- No RTC synchronization
- No leap second support

---

# Future Enhancements

- 12-Hour Mode (AM/PM)
- Alarm Clock
- Stopwatch Mode
- Countdown Timer
- Seven-Segment Display Driver
- LCD Interface
- UART Time Transmission
- SPI Display Interface
- Push Button Debouncer
- Time Setting Buttons
- Real-Time Clock (RTC) Interface
- Calendar (Day/Month/Year)

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
