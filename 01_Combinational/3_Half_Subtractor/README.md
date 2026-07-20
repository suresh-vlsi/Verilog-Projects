# Half Subtractor

## Description

A Half Subtractor subtracts one 1-bit binary number from another and produces a Difference and Borrow output.

## Truth Table

| A | B | Difference | Borrow |
|---|---|------------|--------|
|0|0|0|0|
|0|1|1|1|
|1|0|1|0|
|1|1|0|0|

## Boolean Equations

```
Difference = A XOR B

Borrow = ~A AND B
```

## Files

- half_subtractor.v
- half_subtractor_tb.v
