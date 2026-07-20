# 4:2 Encoder

## Description

A 4:2 Encoder converts one active input out of four into a 2-bit binary output.

> **Note:** This is a basic encoder and assumes only one input is HIGH at a time.

## Truth Table

| D3 | D2 | D1 | D0 | Y1 | Y0 |
|----|----|----|----|----|----|
|0|0|0|1|0|0|
|0|0|1|0|0|1|
|0|1|0|0|1|0|
|1|0|0|0|1|1|

## Boolean Equations

```
Y1 = D2 | D3

Y0 = D1 | D3
```

## Files

- encoder4to2.v
- encoder4to2_tb.v