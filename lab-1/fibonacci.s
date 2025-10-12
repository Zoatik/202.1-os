
.global _start
_start:
  mov x0, #12

  sub x1, x0, #1    // max_counter
  mov x0, #0
  mov x2, #0      // counter
  mov x3, #0      // f_n-2
  mov x4, #1      // f_n-1

  bl _fib
  mov w8, #93
  svc #0

_fib:
  cmp x2, x1
  blt _continue    // if counter < max_counter -> continue; else return
  ret
  _continue:
    add x0, x3, x4
    mov x3, x4
    mov x4, x0
    add x2, x2, #1 // increment counter

    b _fib
