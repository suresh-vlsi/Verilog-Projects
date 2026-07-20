# Traffic Light Controller (Moore FSM)

## Description

A Moore Finite State Machine (FSM) that controls traffic lights for two intersecting roads: North-South (NS) and East-West (EW). The controller cycles through four traffic light states.

## State Table

| State | North-South | East-West |
|-------|-------------|------------|
| S0 | Green | Red |
| S1 | Yellow | Red |
| S2 | Red | Green |
| S3 | Red | Yellow |

## Features

- Moore FSM
- Positive edge-triggered
- Asynchronous active-high reset
- Four traffic light states
- Continuous cyclic operation

## Files

- traffic_light_controller.v
- traffic_light_controller_tb.v