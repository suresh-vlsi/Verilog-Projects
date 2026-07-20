# 2:4 Decoder

## Description

A 2:4 Decoder converts a 2-bit binary input into one of four mutually exclusive outputs. For every input combination, exactly one output is HIGH.

## Truth Table

| A1 | A0 | Y0 | Y1 | Y2 | Y3 |
|----|----|----|----|----|----|
|0|0|1|0|0|0|
|0|1|0|1|0|0|
|1|0|0|0|1|0|
|1|1|0|0|0|1|

## Boolean Equations

```
Y0 = ~A1 & ~A0
Y1 = ~A1 &  A0
Y2 =  A1 & ~A0
Y3 =  A1 &  A0
```

## Files

- decoder2to4.v
- decoder2to4_tb.v