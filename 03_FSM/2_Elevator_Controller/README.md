# 2_Elevator_Controller_Moore_FSM

## Overview

The **Elevator Controller** is one of the most widely used applications of a **Finite State Machine (FSM)** in Digital Electronics, Embedded Systems, FPGA Design, and ASIC Design. It controls the movement of an elevator between floors based on user requests while ensuring safe and predictable operation.

Unlike combinational circuits, an elevator controller must remember its **current floor**, **direction of movement**, and **door status**, making it a **Sequential Logic** system.

This project implements a **Moore Finite State Machine (FSM)** in Verilog HDL for a **4-floor elevator system**.

The controller supports:

- Moving Up
- Moving Down
- Door Opening
- Door Closing
- Idle State
- Reset Operation

Since this is a **Moore FSM**, the outputs depend **only on the current state**, ensuring stable and glitch-free outputs suitable for FPGA and ASIC implementations.

---

# Features

- Synthesizable Verilog RTL
- Moore FSM Architecture
- 4-Floor Elevator
- Up Movement
- Down Movement
- Door Open State
- Door Close State
- Idle State
- Reset Support
- FPGA Compatible
- ASIC Compatible
- Functional Verification
- GTKWave Waveform Generation

---

# Theory

An elevator controller continuously monitors floor requests and determines the appropriate movement.

Typical operations include:

- Waiting for a request
- Moving upward
- Moving downward
- Stopping at the requested floor
- Opening doors
- Closing doors
- Returning to Idle

Unlike combinational logic,

```
Current Output

depends on

Current State
```

Therefore,

```
Finite State Machine

↓

Sequential Logic
```

is the ideal implementation.

---

# Elevator Specifications

Number of Floors

```
4

Floor 0

Floor 1

Floor 2

Floor 3
```

Movement

```
Up

↓

Down
```

Door

```
Open

↓

Close
```

---

# FSM States

| State | Description |
|---------|------------|
|IDLE|Waiting for Request|
|MOVE_UP|Moving Up|
|MOVE_DOWN|Moving Down|
|DOOR_OPEN|Door Open|
|DOOR_CLOSE|Door Closing|

---

# State Diagram

```
                     +---------------+
                     |     IDLE      |
                     +---------------+
                      ^            |
          No Request  |            | Request
                      |            |
          +-----------+------------+
                      |
          +-----------+------------+
          |                        |
          ▼                        ▼
 +----------------+      +------------------+
 |    MOVE UP     |      |   MOVE DOWN      |
 +----------------+      +------------------+
          |                        |
          +-----------+------------+
                      |
                      ▼
             +----------------+
             |   DOOR OPEN    |
             +----------------+
                      |
                      ▼
             +----------------+
             |  DOOR CLOSE    |
             +----------------+
                      |
                      ▼
                    IDLE
```

---

# State Encoding

Example binary encoding

| State | Encoding |
|---------|----------|
|IDLE|000|
|MOVE_UP|001|
|MOVE_DOWN|010|
|DOOR_OPEN|011|
|DOOR_CLOSE|100|

The synthesis tool may choose different encodings during optimization.

---

# Working Principle

Initially,

```
Reset

↓

IDLE

Current Floor = 0
```

---

### User Requests Floor 2

```
Current Floor = 0

↓

MOVE_UP

↓

Floor 1

↓

Floor 2

↓

DOOR_OPEN

↓

DOOR_CLOSE

↓

IDLE
```

---

### User Requests Floor 1 from Floor 3

```
Current Floor = 3

↓

MOVE_DOWN

↓

Floor 2

↓

Floor 1

↓

DOOR_OPEN

↓

DOOR_CLOSE

↓

IDLE
```

---

### Same Floor Request

If

```
Current Floor = Requested Floor
```

then

```
No Movement

↓

Door Opens

↓

Door Closes
```

---

# Floor Transition Example

```
Floor 0

↓

Floor 1

↓

Floor 2

↓

Floor 3
```

Downward movement

```
Floor 3

↓

Floor 2

↓

Floor 1

↓

Floor 0
```

---

# Truth Table

| Current State | Request | Next State |
|---------------|---------|------------|
|IDLE|Higher Floor|MOVE_UP|
|IDLE|Lower Floor|MOVE_DOWN|
|IDLE|Same Floor|DOOR_OPEN|
|MOVE_UP|Destination Reached|DOOR_OPEN|
|MOVE_DOWN|Destination Reached|DOOR_OPEN|
|DOOR_OPEN|Timer Expired|DOOR_CLOSE|
|DOOR_CLOSE|Completed|IDLE|

---

# Block Diagram

```
                  +--------------------------------------+
Floor Request --->|                                      |
Current Floor --->|      Elevator Controller FSM         |
Clock ----------->|                                      |
Reset ----------->|                                      |
                  +--------------------------------------+
                      │        │         │
                      ▼        ▼         ▼
                 Motor Up  Motor Down   Door
```

---

# Internal Architecture

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
                    │      │      │
                    ▼      ▼      ▼
                 Up     Down    Door
```

---

# RTL Description

Typical Verilog implementation

```verilog
// State Register
always @(posedge clk or posedge rst)
begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end

// Next-State Logic
always @(*)
begin
    case(state)

    IDLE:
    begin
        if(request_floor > current_floor)
            next_state = MOVE_UP;

        else if(request_floor < current_floor)
            next_state = MOVE_DOWN;

        else
            next_state = DOOR_OPEN;
    end

    MOVE_UP:
        ...

    MOVE_DOWN:
        ...

    DOOR_OPEN:
        ...

    DOOR_CLOSE:
        ...

    endcase
end

// Output Logic
always @(*)
begin
    case(state)

    IDLE:
    begin
        motor_up   = 0;
        motor_down = 0;
        door_open  = 0;
    end

    MOVE_UP:
        motor_up = 1;

    MOVE_DOWN:
        motor_down = 1;

    DOOR_OPEN:
        door_open = 1;

    endcase
end
```

The design follows the **three-process Moore FSM coding style**, which is widely used in FPGA and ASIC design flows.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
|CLK|1|System Clock|
|RST|1|Reset|
|REQ_FLOOR|2|Requested Floor (0–3)|
|CURR_FLOOR|2|Current Elevator Floor|

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
|MOTOR_UP|1|Move Elevator Up|
|MOTOR_DOWN|1|Move Elevator Down|
|DOOR_OPEN|1|Open Door|
|DOOR_CLOSE|1|Close Door|

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o elevator.out elevator_controller.v elevator_controller_tb.v
```

### Run

```bash
vvp elevator.out
```

### View Waveform

```bash
gtkwave elevator_controller.vcd
```

---

# Expected Console Output

```
Time Floor Request State        Up Down Door
-------------------------------------------------
0      0      -     IDLE         0   0    0
20     0      2     MOVE_UP      1   0    0
40     1      2     MOVE_UP      1   0    0
60     2      2     DOOR_OPEN    0   0    1
80     2      -     DOOR_CLOSE   0   0    0
100    2      -     IDLE         0   0    0
120    2      1     MOVE_DOWN    0   1    0
140    1      1     DOOR_OPEN    0   0    1
160    1      -     DOOR_CLOSE   0   0    0
180    1      -     IDLE         0   0    0
```

---

# Expected Waveform

```
CLK
_|‾|_|‾|_|‾|_|‾|_|‾|_

Floor

0 → 1 → 2

State

IDLE

↓

MOVE_UP

↓

DOOR_OPEN

↓

DOOR_CLOSE

↓

IDLE

↓

MOVE_DOWN

↓

DOOR_OPEN

↓

DOOR_CLOSE
```

---

# Verification

The testbench verifies the following scenarios:

| Test Case | Expected Result |
|------------|-----------------|
|Reset|FSM enters IDLE|
|Request Higher Floor|MOVE_UP|
|Request Lower Floor|MOVE_DOWN|
|Request Same Floor|Door Opens|
|Destination Reached|DOOR_OPEN|
|Door Timer Expired|DOOR_CLOSE|
|Door Closed|Return to IDLE|
|Continuous Requests|Correct State Transitions|

---

# Applications

Elevator Controllers are widely used in:

- Residential Buildings
- Commercial Buildings
- Hospitals
- Shopping Malls
- Hotels
- Airports
- Smart Buildings
- Industrial Lifts
- Warehouse Automation
- FPGA Educational Projects
- ASIC Control Systems

---

# Advantages

- Safe and deterministic operation
- Glitch-free Moore FSM outputs
- Modular architecture
- Easy to expand for additional floors
- Easy to verify and debug
- Suitable for FPGA and ASIC implementation

---

# Limitations

- Supports only four floors in this implementation.
- Does not include multiple simultaneous floor requests.
- Does not optimize travel direction based on pending requests.
- Does not include emergency or maintenance modes.

---

# Moore FSM vs Mealy FSM

| Feature | Moore FSM | Mealy FSM |
|----------|-----------|-----------|
|Output Depends On|Current State|State + Input|
|Output Stability|Glitch-Free|May Glitch|
|States Required|More|Fewer|
|Timing Analysis|Simpler|More Complex|
|Preferred for FPGA/ASIC|Yes|Depends on Design|

---

# FPGA/ASIC Design Flow

```
System Specification
        │
        ▼
FSM Design
        │
        ▼
State Diagram
        │
        ▼
RTL Coding (Verilog)
        │
        ▼
Testbench Development
        │
        ▼
Simulation & Verification
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
FPGA Bitstream / ASIC GDSII
```

---
---

# Common Design Pitfalls

- Ignoring simultaneous floor requests.
- Mixing combinational and sequential logic in the same `always` block.
- Missing default assignments in combinational logic, leading to latch inference.
- Using blocking (`=`) assignments for state registers instead of non-blocking (`<=`).
- Not synchronizing asynchronous button inputs, which can lead to metastability.

---

# Future Enhancements

- Parameterized N-Floor Elevator Controller
- Multiple Floor Request Queue
- Elevator Direction Scheduling Algorithm
- Door Obstruction Detection
- Emergency Stop Functionality
- Fire Alarm Override Mode
- Maintenance Mode
- Overload Detection
- LCD Floor Display Interface
- Multi-Elevator Dispatch System

---
