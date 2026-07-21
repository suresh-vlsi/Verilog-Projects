# ⏱️ Digital Stopwatch using Verilog HDL

A synthesizable **Digital Stopwatch** designed in **Verilog HDL** using a **modular and hierarchical RTL architecture**. The design demonstrates industry-standard FPGA/ASIC design practices including parameterized modules, finite state machine (FSM) control, reusable counters, and a single-clock synchronous design.

---

# Project Overview

This project implements a digital stopwatch capable of counting **minutes and seconds (00:00 to 59:59)**.

The stopwatch supports:

- ▶️ Start
- ⏸️ Pause/Stop
- ▶️ Resume
- 🔄 Reset
- Automatic minute increment after every 60 seconds

The design follows a **single clock domain** methodology, making it suitable for FPGA implementation and ASIC synthesis.

---

# Features

- Modular RTL Design
- Hierarchical Architecture
- Parameterized Clock Divider
- Moore FSM Controller
- Reusable Counter Module
- Single Clock Domain
- Clock Enable Based Design
- Synthesizable Verilog-2001
- FPGA Friendly
- ASIC Friendly

---

# Project Structure

```
01_Digital_Stopwatch
│
├── rtl
│   ├── 1_clock_divider.v
│   ├── 2_control_fsm.v
│   ├── 3_bcd_counter.v
│   └── 4_digital_stopwatch.v
│
├── tb
│   └── digital_stopwatch_tb.v
│
├── waveform
│   └── digital_stopwatch.vcd
│
├── docs
│
└── README.md
```

---

# Block Diagram

```
                +----------------------+
                |                      |
Clock --------->|   Clock Divider      |
Reset --------->|                      |
                +----------+-----------+
                           |
                       1 Hz Tick
                           |
                           v
                +----------------------+
Start --------->|                      |
Stop ---------->|    Control FSM       |
Reset --------->|                      |
                +----------+-----------+
                           |
                        Enable
                           |
          +----------------+----------------+
          |                                 |
          v                                 v
 +-------------------+             +-------------------+
 | Seconds Counter   |------------>| Minutes Counter   |
 |      0–59         | Overflow    |      0–59         |
 +-------------------+             +-------------------+
```

---

# RTL Hierarchy

```
digital_stopwatch
│
├── clock_divider
│
├── control_fsm
│
├── bcd_counter
│
└── bcd_counter
```

---

# Modules Description

## 1. Clock Divider

Converts the high-frequency system clock into a **1 Hz tick**.

### Inputs

- clk
- rst

### Output

- tick_1hz

---

## 2. Control FSM

Controls stopwatch operation.

### States

```
IDLE

↓

RUNNING

↓

PAUSED
```

### Inputs

- start
- stop
- rst

### Output

- enable

---

## 3. BCD Counter

Counts from **0 to 59**.

### Features

- Parameterized
- Overflow Generation
- Clock Enable
- Synchronous Design

---

## 4. Digital Stopwatch

Top module that integrates all submodules.

---

# State Diagram

```
                +---------+
                | IDLE    |
                +---------+
                     |
                 Start
                     |
                     v
                +---------+
                |RUNNING  |
                +---------+
                 |      |
             Stop|      |Reset
                 |      |
                 v      |
              +---------+
              | PAUSED  |
              +---------+
                  |
                Start
                  |
                  v
              RUNNING
```

---

# Functional Flow

```
Power ON

↓

Reset

↓

00:00

↓

Start

↓

Counting Begins

↓

00:59

↓

01:00

↓

Pause

↓

Hold Value

↓

Resume

↓

Continue Counting
```

---

# Timing Example

```
Start

_____|‾‾‾|____________________

Running

0_____|‾‾‾‾‾‾‾‾‾‾_____________

Seconds

00
↓

01
↓

02
↓

...
↓

59
↓

00

Minutes

00

↓

01
```

---

# Input Signals

| Signal | Description |
|---------|-------------|
| clk | System Clock |
| rst | Asynchronous Reset |
| start | Start/Resume |
| stop | Pause |

---

# Output Signals

| Signal | Description |
|---------|-------------|
| running | Stopwatch Running Status |
| seconds | Seconds Counter |
| minutes | Minutes Counter |

---

# Counter Operation

```
00

↓

01

↓

02

↓

...

↓

58

↓

59

↓

00

↓

Overflow

↓

Minute Increment
```

---

# Design Methodology

The stopwatch uses a **single synchronous clock**.

Instead of generating new clocks, the design uses:

- Clock Enable
- Tick Pulse
- Overflow Pulse

This is the recommended FPGA/ASIC methodology because it:

- avoids multiple clock domains
- simplifies timing analysis
- improves reliability
- reduces clock skew

---

# Simulation

## Compile

### Windows (PowerShell)

```powershell
iverilog -o stopwatch_sim rtl/1_clock_divider.v rtl/2_control_fsm.v rtl/3_bcd_counter.v rtl/4_digital_stopwatch.v tb/digital_stopwatch_tb.v
```

### Linux/macOS

```bash
iverilog -o stopwatch_sim \
rtl/1_clock_divider.v \
rtl/2_control_fsm.v \
rtl/3_bcd_counter.v \
rtl/4_digital_stopwatch.v \
tb/digital_stopwatch_tb.v
```

---

## Run

```bash
vvp stopwatch_sim
```

---

## View Waveform

```bash
gtkwave digital_stopwatch.vcd
```

---

# Expected Console Output

```
RUN=0 MIN=00 SEC=00

RUN=1 MIN=00 SEC=01

RUN=1 MIN=00 SEC=02

...

RUN=1 MIN=00 SEC=59

RUN=1 MIN=01 SEC=00

Simulation Completed Successfully
```

---

# Expected Waveform

Observe:

- Reset
- Start Pulse
- Stop Pulse
- Running Signal
- Tick Pulse
- Seconds Counter
- Minutes Counter

---

# Verification Checklist

- Reset functionality
- Start operation
- Pause operation
- Resume operation
- Seconds increment
- Minute rollover
- Counter hold during pause
- Counter resume after pause
- Overflow generation

---

# Applications

- Digital Wrist Watches
- Industrial Timers
- Sports Timers
- Embedded Systems
- FPGA Learning
- Digital Clocks
- Laboratory Instruments

---

# Advantages

- Modular Design
- Reusable Modules
- Parameterized RTL
- Easy to Maintain
- Easy to Extend
- FPGA Compatible
- ASIC Compatible
- Interview Ready

---

# Limitations

- Counts only up to 59 minutes
- No lap function
- No countdown mode
- No display driver
- No button debouncing

---

# Future Enhancements

- Hours Counter
- Seven Segment Display Driver
- LCD Interface
- Lap Timer
- Countdown Timer
- Alarm Feature
- UART Time Logging
- SPI Display Interface
- Push Button Debouncer
- Edge Detector
- Clock Synchronizer

---

# FPGA Design Flow

```
RTL Design

↓

Simulation

↓

Synthesis

↓

Implementation

↓

Timing Analysis

↓

Bitstream Generation

↓

FPGA Programming
```

---

# Learning Outcomes

After completing this project, you will understand:

- Hierarchical RTL Design
- Modular Verilog Coding
- Clock Division
- Clock Enable Technique
- FSM Design
- Counter Design
- Parameterized Modules
- Top-Level Integration
- Testbench Development
- Waveform Analysis

---

# Common Interview Questions

1. Why is a single clock domain preferred?
2. What is a clock enable?
3. Why should derived clocks be avoided?
4. Explain the Moore FSM used.
5. How does the overflow pulse work?
6. Why use parameterized modules?
7. How would you implement a 24-hour stopwatch?
8. How would you debounce push buttons?
9. What is metastability?
10. How would you verify this design?

---

# License

This project is released under the **MIT License**.

---

# Author

**Suresh Kumar**

GitHub: *Add your GitHub profile link here*

LinkedIn: *Add your LinkedIn profile link here*