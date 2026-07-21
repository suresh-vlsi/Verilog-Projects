# 1_Vending_Machine_Controller_Moore_FSM

## Overview

The **Vending Machine Controller** is one of the most popular **Finite State Machine (FSM)** applications used in Digital Electronics, FPGA Design, ASIC Design, and Embedded Systems. It models the operation of an automatic vending machine that accepts coins, tracks the accumulated amount, dispenses a product when sufficient money has been inserted, and optionally returns change.

Since the controller must remember the total amount inserted before making a decision, it is implemented as a **Sequential Circuit** using a **Moore Finite State Machine (FSM)**.

In a **Moore FSM**, the outputs depend **only on the current state**, making the design stable, predictable, and suitable for FPGA and ASIC implementations.

This project implements a vending machine that sells a product costing **₹15**.

Accepted coins:

- ₹5
- ₹10

When the accumulated amount reaches **₹15**, the machine dispenses the product.

Example:

```
Insert ₹5

↓

Insert ₹10

↓

Product Dispensed
```

or

```
Insert ₹10

↓

Insert ₹5

↓

Product Dispensed
```

---

# Features

- Synthesizable Verilog RTL
- Moore FSM Architecture
- Supports ₹5 and ₹10 coins
- Product Cost = ₹15
- Automatic Product Dispense
- Optional Change Return
- Reset Support
- FPGA Compatible
- ASIC Compatible
- Functional Verification
- GTKWave Waveform Generation

---

# Theory

A vending machine performs the following tasks:

- Accepts valid coins
- Keeps track of the accumulated amount
- Determines when sufficient money has been inserted
- Dispenses the product
- Returns change (if applicable)
- Returns to the idle state

Unlike combinational logic, the vending machine must remember previous coin insertions.

Therefore,

```
Finite State Machine (FSM)

↓

Sequential Logic
```

is the preferred implementation.

---

# Coin Values

| Coin | Value |
|------|------:|
|Coin5|₹5|
|Coin10|₹10|

---

# Product Price

```
₹15
```

---

# State Definitions

| State | Amount Stored |
|--------|---------------|
|S0|₹0|
|S1|₹5|
|S2|₹10|
|S3|Dispense Product|

---

# State Diagram

```
                    Coin5
               +------------+
               |            |
               ▼            |
          +---------+       |
          |   S0    |<------+
          | ₹0      |
          +---------+
          |       |
 Coin5    |       | Coin10
          ▼       ▼
      +--------+ +--------+
      |  S1    | |  S2    |
      | ₹5     | | ₹10    |
      +--------+ +--------+
        |   \       /   |
 Coin5  |    \     / Coin10
        |     \   /
 Coin10 ▼      \ /
          +---------+
          |   S3    |
          |Dispense |
          +---------+
               |
               |
               ▼
              S0
```

---

# State Transition Table

| Current State | Coin = ₹5 | Coin = ₹10 |
|---------------|-----------|------------|
|S0|S1|S2|
|S1|S2|S3|
|S2|S3|S3|
|S3|S0|S0|

---

# Output Table

| State | Dispense | Change |
|--------|----------|--------|
|S0|0|0|
|S1|0|0|
|S2|0|0|
|S3|1|Optional|

Since this is a **Moore FSM**, the outputs depend only on the current state.

---

# State Encoding

One possible encoding is:

| State | Binary |
|--------|--------|
|S0|00|
|S1|01|
|S2|10|
|S3|11|

The synthesis tool may choose another encoding depending on optimization settings.

---

# Working Principle

Initially,

```
Reset

↓

State = S0

Amount = ₹0
```

### Scenario 1

```
Insert ₹5

↓

State = S1
```

```
Insert ₹10

↓

State = S3

↓

Product Dispensed
```

---

### Scenario 2

```
Insert ₹10

↓

State = S2
```

```
Insert ₹5

↓

State = S3

↓

Product Dispensed
```

---

### Scenario 3

```
Insert ₹10

↓

Insert ₹10

↓

₹20 Inserted

↓

Product Dispensed

↓

Optional ₹5 Change Returned
```

---

# Block Diagram

```
                 +----------------------------------+
Coin5 ---------->|                                  |
Coin10 --------->|   Vending Machine Controller     |
Clock ---------->|        Moore FSM                 |
Reset ---------->|                                  |
                 +----------------------------------+
                        │               │
                        ▼               ▼
                  Dispense         Change
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
              │             │
              ▼             ▼
         Dispense       Change
```

---

# RTL Description

Typical Verilog implementation

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

    S0:
        if (coin5)
            next_state = S1;
        else if (coin10)
            next_state = S2;

    S1:
        if (coin5)
            next_state = S2;
        else if (coin10)
            next_state = S3;

    S2:
        if (coin5 || coin10)
            next_state = S3;

    S3:
        next_state = S0;

    endcase
end

// Output Logic
always @(*)
begin
    dispense = (state == S3);
end
```

The design follows the **three-process Moore FSM coding style**, commonly used in industry.

---

# Inputs

| Signal | Width | Description |
|---------|------:|-------------|
|CLK|1|System Clock|
|RST|1|Reset|
|Coin5|1|₹5 Coin Input|
|Coin10|1|₹10 Coin Input|

---

# Outputs

| Signal | Width | Description |
|---------|------:|-------------|
|Dispense|1|Dispense Product|
|Change|1|Return Change (Optional)|

---
---

# Simulation

## Using Icarus Verilog

### Compile

```bash
iverilog -o vending.out vending_machine_controller.v vending_machine_controller_tb.v
```

### Run

```bash
vvp vending.out
```

### View Waveform

```bash
gtkwave vending_machine_controller.vcd
```

---

# Expected Console Output

```
Time Coin5 Coin10 State Dispense Change
---------------------------------------
0      0      0    S0      0        0
10     1      0    S1      0        0
20     0      1    S3      1        0
30     0      0    S0      0        0
40     0      1    S2      0        0
50     1      0    S3      1        0
60     0      0    S0      0        0
70     0      1    S2      0        0
80     0      1    S3      1        1
```

---

# Expected Waveform

```
CLK
_|‾|_|‾|_|‾|_|‾|_|‾|_

Coin5
__|‾‾|____________

Coin10
______|‾‾|_____|‾‾|

State

S0 → S1 → S3 → S0 → S2 → S3 → S0

Dispense

0 0 1 0 0 1 0

Change

0 0 0 0 0 0 1
```

---

# Verification

The testbench verifies the following scenarios:

| Test Case | Expected Result |
|-----------|-----------------|
|Reset|FSM starts in S0|
|₹5|State changes to S1|
|₹10|State changes to S2|
|₹5 + ₹10|Product dispensed|
|₹10 + ₹5|Product dispensed|
|₹10 + ₹10|Product dispensed with ₹5 change (optional)|
|Continuous Operation|Returns to S0 after dispensing|

---

# Applications

Vending Machine Controllers are widely used in:

- Beverage vending machines
- Snack vending machines
- Ticket vending kiosks
- Parking ticket machines
- Metro ticketing systems
- Self-service kiosks
- Automated retail systems
- FPGA educational projects
- ASIC controller designs
- Industrial automation

---

# Advantages

- Simple and reliable FSM implementation
- Stable Moore FSM outputs
- Easy to verify and debug
- Modular design
- Supports multiple payment sequences
- Suitable for FPGA and ASIC implementation

---

# Limitations

- Supports only predefined coin denominations.
- Fixed product price unless redesigned.
- Cannot process multiple products without additional states.
- Does not include inventory management or coin validation.

---

# Moore FSM vs Mealy FSM in Vending Machines

| Feature | Moore FSM | Mealy FSM |
|----------|-----------|-----------|
|Output Depends On|Current State|State + Input|
|Output Stability|High|May Glitch|
|Number of States|More|Fewer|
|Design Simplicity|Higher|Moderate|
|Preferred for FPGA/ASIC|Yes|Depends on Application|

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

- Not assigning default values in combinational logic, causing latch inference.
- Mixing sequential and combinational logic in the same `always` block.
- Ignoring invalid coin inputs.
- Failing to return to the idle state after dispensing.
- Using blocking (`=`) assignments for state registers instead of non-blocking (`<=`).

---

# Future Enhancements

- Multi-Product Vending Machine
- Configurable Product Prices
- Multiple Coin Denominations
- Digital Display for Balance
- Inventory Management
- Cancel Transaction Option
- Timeout for Inactive Users
- Cashless Payment (RFID/NFC)
- Password-Protected Maintenance Mode
- Parameterized N-Product Vending Machine

---
