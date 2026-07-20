# 4-bit Universal Shift Register

## Description

A Universal Shift Register is a versatile sequential circuit that can perform multiple operations based on the select inputs.

## Operations

| S1 | S0 | Operation |
|----|----|-----------|
| 0 | 0 | Hold |
| 0 | 1 | Shift Right |
| 1 | 0 | Shift Left |
| 1 | 1 | Parallel Load |

## Features

- 4-bit register
- Positive edge-triggered
- Asynchronous active-high reset
- Hold operation
- Shift Left
- Shift Right
- Parallel Load

## Files

- universal_shift_register.v
- universal_shift_register_tb.v