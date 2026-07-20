# D Latch

## Description

A D (Data) Latch is a level-sensitive storage element. When the Enable signal is HIGH, the output follows the input. When Enable is LOW, the latch retains its previous state.

## Truth Table

| EN | D | Q(next) |
|----|---|----------|
|0|X|Hold|
|1|0|0|
|1|1|1|

## Features

- Level-sensitive device
- Transparent when EN = 1
- Holds previous value when EN = 0

## Files

- d_latch.v
- d_latch_tb.v