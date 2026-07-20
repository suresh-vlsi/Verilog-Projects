# D Flip-Flop (Positive Edge Triggered)

## Description

A D Flip-Flop stores one bit of data and updates its output only on the rising edge of the clock. It includes an **asynchronous active-high reset** that immediately clears the output when asserted.

## Truth Table

| RST | Clock | D | Q(next) |
|-----|-------|---|----------|
| 1 | X | X | 0 |
| 0 | ↑ | 0 | 0 |
| 0 | ↑ | 1 | 1 |
| 0 | No ↑ | X | Hold |

## Features

- Positive edge-triggered
- Asynchronous active-high reset
- Uses non-blocking (`<=`) assignment
- Stores one bit of data

## Files

- d_ff.v
- d_ff_tb.v