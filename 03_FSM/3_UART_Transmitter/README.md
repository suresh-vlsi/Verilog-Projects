# UART Transmitter

## Description

A UART (Universal Asynchronous Receiver Transmitter) transmitter implemented using a Moore Finite State Machine. The transmitter sends an 8-bit data word serially with one start bit and one stop bit.

## UART Frame

```
Idle | Start | D0 D1 D2 D3 D4 D5 D6 D7 | Stop

  1       0        LSB First              1
```

## FSM States

- IDLE
- START_BIT
- DATA_BITS
- STOP_BIT

## Features

- Moore FSM
- Positive edge-triggered
- Asynchronous active-high reset
- 8-bit serial transmission
- Busy flag

## Files

- uart_tx.v
- uart_tx_tb.v