# JK Flip-Flop (Positive Edge Triggered)

## Description

A JK Flip-Flop is an edge-triggered sequential circuit that removes the invalid state of the SR Flip-Flop. When both J and K are HIGH, the output toggles on every rising edge of the clock.

## Truth Table

| Clock | J | K | Q(next) | Operation |
|-------|---|---|----------|-----------|
| ↑ | 0 | 0 | Hold | No Change |
| ↑ | 0 | 1 | 0 | Reset |
| ↑ | 1 | 0 | 1 | Set |
| ↑ | 1 | 1 | Toggle | Complement Q |

## Features

- Positive edge-triggered
- No invalid input condition
- Supports Hold, Set, Reset, and Toggle operations
- Uses non-blocking (`<=`) assignments

## Files

- jk_ff.v
- jk_ff_tb.v