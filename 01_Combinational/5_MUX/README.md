# 2:1 Multiplexer (MUX)

## Description

A 2:1 Multiplexer selects one of two input signals based on the value of the select line.

## Truth Table

| S | Output |
|---|--------|
|0|I0|
|1|I1|

## Boolean Equation

```
Y = (~S & I0) | (S & I1)
```

## Files

- mux2to1.v
- mux2to1_tb.v