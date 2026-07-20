# UART Receiver

## Description

A UART Receiver implemented as a Moore Finite State Machine. The receiver detects a start bit, receives 8 serial data bits (LSB first), verifies the stop bit, and asserts a data valid signal when a complete byte has been received.

## UART Frame

```
Idle | Start | D0 D1 D2 D3 D4 D5 D6 D7 | Stop

  1       0         LSB First             1
```

## FSM States

- IDLE
- START_BIT
- DATA_BITS
- STOP_BIT
- COMPLETE

## Features

- Moore FSM
- Positive edge-triggered
- Asynchronous active-high reset
- 8-bit serial reception
- LSB-first data reception
- Data valid indication

## Files

- uart_rx.v
- uart_rx_tb.v