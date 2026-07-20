# 1:2 DEMUX

## Description

A 1:2 Demultiplexer routes one input to one of two outputs based on the select signal.

## Truth Table

| D | S | Y0 | Y1 |
|---|---|----|----|
|0|0|0|0|
|0|1|0|0|
|1|0|1|0|
|1|1|0|1|

## Boolean Equations

```
Y0 = D & ~S

Y1 = D & S
```

## Files

- demux1to2.v
- demux1to2_tb.v