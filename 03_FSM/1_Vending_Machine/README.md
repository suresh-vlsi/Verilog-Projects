# Vending Machine Controller (Moore FSM)

## Description

A Moore FSM that models a vending machine selling an item worth ₹15.

Accepted Coins:
- ₹5
- ₹10

When the total reaches ₹15, the machine dispenses the item and returns to the idle state.

## States

| State | Amount |
|--------|--------|
| S0 | ₹0 |
| S5 | ₹5 |
| S10 | ₹10 |
| S15 | ₹15 |

## Features

- Moore FSM
- Positive edge-triggered
- Asynchronous active-high reset
- Accepts ₹5 and ₹10 coins
- Dispenses item at ₹15
- Automatically returns to idle after dispensing

## Files

- vending_machine.v
- vending_machine_tb.v