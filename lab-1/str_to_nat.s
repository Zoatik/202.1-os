.data
  // A-4 bytes buffer.
  buffer:
    .word 0

.text

.global _start
_start:
  // Prints 42.
  mov   w0, 42
  bl    _print_nat

  // Exit with status 0.
  mov   w0, #0
  mov   w8, #93
  svc   #0

/// Prints the natural number stored in `x0` followed by a newline.
_print_nat:
  // Writes `\n` at the end of the buffer.
  ldr   x3, =buffer
  mov   w4, #10
  strb  w4, [x3, #3]

  // Is `x0` equal to 0?
  cbz   w0, _print_nat_0

  // Otherwise, write each digit from right to left in a buffer, using `w1` to track the index of
  // the leftmost digit written in the buffer referred to by `x3`.
  mov   w1, #3
  mov   w2, #10
_print_nat_head:

  // Are we done?
  cbz   w0, _print_nat_n

  // Otherwise, write the next digit in the buffer.
  udiv  w4, w0, w2      // w4 = w0 / w2
  msub  w5, w4, w2, w0  // w5 = w0 % w2
  mov   w0, w4
  add   w5, w5, #48
  sub   w1, w1, #1
  strb  w5, [x3, x1]
  b     _print_nat_head

_print_nat_0:
  mov   w4, #48
  strb  w4, [x3, #6]
  mov   w1, #6

_print_nat_n:
  // Print the contents of the buffer referred to by `x3` starting from `w2`.
  add   x4, x3, x1
  mov    w3, #4
  sub   w2, w3, w1
  mov   x1, x4
  mov   x0, #1
  mov   w8, #64
  svc   #0
  ret
