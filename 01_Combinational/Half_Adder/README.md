# Half Adder

## Objective

Design and verify a 1-bit Half Adder using Verilog.

## Truth Table

| A | B | Sum | Carry |
|---|---|-----|-------|
|0|0|0|0|
|0|1|1|0|
|1|0|1|0|
|1|1|0|1|

## RTL

- XOR → Sum
- AND → Carry

## Files

- half_adder.v
- half_adder_tb.v

## Simulation

```
A B | SUM CARRY
----------------
0 0 | 0 0
0 1 | 1 0
1 0 | 1 0
1 1 | 0 1
```
