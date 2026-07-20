# 4-bit Ripple Counter

## Description

A 4-bit counter counts from 0 to 15 in binary. It includes an asynchronous active-high reset that clears the counter to 0000.

## Features

- 4-bit binary counter
- Counts from 0 to 15
- Asynchronous active-high reset
- Positive edge-triggered
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

- ripple_counter.v
- ripple_counter_tb.v