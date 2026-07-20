# T Flip-Flop (Positive Edge Triggered)

## Description

A T (Toggle) Flip-Flop changes its output state on every rising edge of the clock when the T input is HIGH. It includes an **asynchronous active-high reset**.

## Truth Table

| RST | Clock | T | Q(next) | Operation |
|-----|-------|---|----------|-----------|
| 1 | X | X | 0 | Reset |
| 0 | ↑ | 0 | Hold | No Change |
| 0 | ↑ | 1 | Toggle | Q = ~Q |

## Features

- Positive edge-triggered
- Asynchronous active-high reset
- Single control input
- Ideal for counters and frequency dividers
- Uses non-blocking (`<=`) assignments

## Files

- t_ff.v
- t_ff_tb.v