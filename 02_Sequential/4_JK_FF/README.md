# JK Flip-Flop (Positive Edge Triggered)

## Description

A JK Flip-Flop is an edge-triggered sequential circuit with an **asynchronous active-high reset**. It supports Hold, Set, Reset, and Toggle operations.

## Truth Table

| RST | Clock | J | K | Q(next) | Operation |
|-----|-------|---|---|----------|-----------|
| 1 | X | X | X | 0 | Reset |
| 0 | ↑ | 0 | 0 | Hold | No Change |
| 0 | ↑ | 0 | 1 | 0 | Reset |
| 0 | ↑ | 1 | 0 | 1 | Set |
| 0 | ↑ | 1 | 1 | Toggle | Complement Q |

## Features

- Positive edge-triggered
- Asynchronous active-high reset
- Hold, Set, Reset, and Toggle operations
- Uses non-blocking (`<=`) assignments

## Files

- jk_ff.v
- jk_ff_tb.v