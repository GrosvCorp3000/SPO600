.text

  .global _start

_start:
  
  mov x19, 0  /* non zero register */
  mov x23, 10 /* used for dividing */
  adr x24, msg
  mov x25, 0x20 /* space */
 
  loop:
    mov x20, x19/* calculate the byte  */ 
    udiv x21, x20, x23       /* r21 = i / 10 */
    msub x22, x21, x23, x20  /* r22 = i - (r21 * 10) ie gets the remainder*/ 

    add x22, x22, 0x30       /* convert the 1's to  ascii */
   
    strb w25, [x24, len - 3] /* store a space in place of the # */ 
    
    cmp x21, 0x00            /* if the first digit is 0  */
    beq skip                 /* don't write it  */
    
    add x21, x21, 0x30       /* else convert to ascii */
    strb w21, [x24, len - 3] /* and set the byte if not equal to 0 */ 
    
    skip:
    strb w22, [x24, len - 2]
   
    mov x0, 1   /* print the loop */
    adr x1, msg
    mov x2, len
    mov x8, 64
    svc 0

    add x19, x19, 1 /* if not 30 revert to the beginning of the loop */
    cmp x19, 30
    bne loop

    mov x0, 0
    mov x8, 93
    svc 0 
 
.data
  msg: .ascii "Loop: ##\n"
  len = . - msg
