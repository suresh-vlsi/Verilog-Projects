# D Flip-Flop (Positive Edge Triggered)

## Description

A D Flip-Flop stores one bit of data and updates its output only on the rising edge of the clock. It is one of the most fundamental sequential elements in digital systems.

## Truth Table

| Clock | D | Q(next) |
|-------|---|----------|
| ↑ | 0 | 0 |
| ↑ | 1 | 1 |
| No ↑ | X | Hold |

## Features

- Edge-triggered
- Updates on positive clock edge
- Uses non-blocking (`<=`) assignment
- Stores one bit of data

## Files

- d_ff.v
- d_ff_tb.v