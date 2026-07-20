# SR Latch

## Description

An SR (Set-Reset) Latch is a basic memory element used to store one bit of data. It has two control inputs: Set (S) and Reset (R).

## Truth Table

| S | R | Q(next) | Description |
|---|---|----------|-------------|
|0|0|Hold|No Change|
|0|1|0|Reset|
|1|0|1|Set|
|1|1|Invalid|Forbidden State|

## Features

- Level-sensitive storage element
- Stores one bit of information
- Invalid when both S and R are HIGH simultaneously

## Files

- sr_latch.v
- sr_latch_tb.v