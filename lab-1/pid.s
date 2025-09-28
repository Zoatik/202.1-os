    .data
buffer: .skip 11                  // 10 digits max + '\n'

    .text
    .global _start

_start:
    mov     w8, #172          // syscall getpid
    svc     #0                

    // checks if too large
    mov     x1, #0xFFFFFFFF
    cmp     x0, x1
    bhi     _too_large        

    // else print
    bl      _print_nat

    // exit with status 0
    mov     w0, #0
    mov     w8, #93           // syscall exit
    svc     #0

_too_large:
    mov     w0, #1            // error code 1
    mov     w8, #93
    svc     #0

_print_nat:
    ldr     x3, =buffer
    mov     w4, #10
    strb    w4, [x3, #10]     // '\n' at the end
    mov     w1, #10           // index start 

    // Is `x0` not equal to 0?
    cbnz    w0, _1          
    mov     w5, #'0'
    sub     w1, w1, #1
    strb    w5, [x3, x1]
    b       _2

_1:      
    mov     w2, #10
_0:
    udiv    w4, w0, w2        // q = w0 / 10
    msub    w5, w4, w2, w0    // r = w0 - q*10
    add     w5, w5, #'0'
    sub     w1, w1, #1
    strb    w5, [x3, x1]
    mov     w0, w4
    cbnz    w0, _0

_2:     
    add     x1, x3, x1
    mov     w3, #11
    sub     w2, w3, w1        
    mov     x0, #1            // stdout
    mov     w8, #64           // syscall write
    svc     #0
    ret
