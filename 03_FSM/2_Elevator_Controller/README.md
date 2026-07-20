# Elevator Controller (Moore FSM)

## Description

A simple 3-floor elevator controller implemented as a Moore Finite State Machine. The controller accepts requests for floors 0, 1, and 2, moves to the requested floor, opens the door for one state, and then returns to the idle state.

## Inputs

- CLK
- RST
- REQ[2:0] (Floor requests)

## Outputs

- FLOOR[1:0]
- DOOR_OPEN

## FSM States

| State | Description |
|--------|-------------|
| IDLE | Waiting for a request |
| MOVE | Move to the requested floor |
| OPEN | Open the elevator door |

## Features

- Moore FSM
- Positive edge-triggered
- Asynchronous active-high reset
- Supports three floors
- Automatic door opening after reaching the requested floor

## Files

- elevator_controller.v
- elevator_controller_tb.v