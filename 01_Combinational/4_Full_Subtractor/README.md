# Full Subtractor

## Description

A Full Subtractor subtracts two 1-bit binary numbers along with a borrow input. It produces a Difference and Borrow Out.

## Truth Table

| A | B | Bin | Difference | Bout |
|---|---|-----|------------|------|
|0|0|0|0|0|
|0|0|1|1|1|
|0|1|0|1|1|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|0|
|1|1|0|0|0|
|1|1|1|1|1|

## Boolean Equations

```
Difference = A XOR B XOR Bin

Bout = (~A AND B) OR (~(A XOR B) AND Bin)
```

## Files

- full_subtractor.v
- full_subtractor_tb.v