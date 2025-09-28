        .data
// Tampon : 10 chiffres max pour un u32 + '\n' = 11 octets
buffer:
  .skip 11

  .text
  .global _start

_start:
  // Démo : imprime 42\n
  mov     w0, #42
  bl      _print_u32

  // Exit(0)
  mov     w0, #0
  mov     w8, #93            // sys_exit
  svc     #0

// ---------------------------------------------------------------------------------
// void _print_u32(uint32_t w0)
// Imprime w0 en décimal non signé suivi de '\n' via write(1, ...).
// Registres utilisés : x1..x5 / w1..w5, x3 = &buffer
// ---------------------------------------------------------------------------------
_print_u32:
  // x3 = &buffer
  ldr     x3, =buffer

  // Place '\n' tout à la fin du tampon (index 10)
  mov     w4, #10
  strb    w4, [x3, #10]

  // Indice d'écriture (prochaine case libre à gauche de '\n')
  mov     w1, #10

  // Cas w0 == 0 : écrire '0'
  cbnz    w0, 1f
  mov     w5, #'0'
  sub     w1, w1, #1
  strb    w5, [x3, x1]
  b       2f

1:      // Boucle : division par 10, on dépose le reste (un chiffre)
  mov     w2, #10
0:
  udiv    w4, w0, w2         // q = w0 / 10
  msub    w5, w4, w2, w0     // r = w0 - q*10  (reste)
  add     w5, w5, #'0'       // ASCII
  sub     w1, w1, #1
  strb    w5, [x3, x1]
  mov     w0, w4             // w0 = q
  cbnz    w0, 0b

2:      // write(1, buffer + w1, (11 - w1))
  add     x1, x3, x1         // x1 = &buffer[w1]
  mov     w3, #11
  sub     w2, w3, w1         // w2 = nombre d'octets à écrire (incluant '\n')
  mov     x0, #1             // fd = stdout
  mov     w8, #64            // sys_write
  svc     #0
  ret
