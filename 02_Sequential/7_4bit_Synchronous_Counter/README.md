# 4-bit Synchronous Counter

## Description

A 4-bit synchronous counter increments its value on every rising edge of the clock. All flip-flops are driven by the same clock, making it faster than a ripple (asynchronous) counter.

## Features

- 4-bit binary up counter
- Counts from 0 to 15
- Positive edge-triggered
- Asynchronous active-high reset
- Uses non-blocking (`<=`) assignments

## Count Sequence

```
0000
0001
0010
0011
...
1111
0000
```

## Files

- synchronous_counter.v
- synchronous_counter_tb.v