# Full Adder

## Description

A Full Adder adds three 1-bit binary inputs (A, B, Cin) and produces a Sum and Carry output.

## Truth Table

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
|0|0|0|0|0|
|0|0|1|1|0|
|0|1|0|1|0|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|1|
|1|1|0|0|1|
|1|1|1|1|1|

## Boolean Equations

```
Sum  = A XOR B XOR Cin

Cout = (A AND B) OR (Cin AND (A XOR B))
```

## Files

- full_adder.v
- full_adder_tb.v