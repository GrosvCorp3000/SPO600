.global _start

_start:
  
  xor %r15, %r15  /* r15 used for increment */
  mov $10, %r14   /* used as the divisor */
  mov $0x20, %r13 /* space */

  loop:

    mov %r15, %rax
    xor %rdx, %rdx  /* set rdx to 0 */
    div %r14        
   
    add $0x30, %rdx          /* convert the 1's to ascii */
    mov %dl, (msg + len - 2) /* write the 1's byte */

    mov %r13b, (msg + len - 3) /* write a space in te 10's column */

    cmp $0x00, %rax   /* if the 10's column is 0 */
    je skip_10s     /* don't write it */
 
    add $0x30, %rax /* convert to ascii */
    mov %al, (msg + len - 3) /* set the bytes in the correct index */
    skip_10s:
 
    mov $len, %rdx /*print out the string with the new byte*/
    mov $msg, %rsi
    mov $1, %rdi
    mov $1, %rax
    syscall 

    inc %r15
    cmp $0x1e, %r15
    jne loop
 
    xor %rdi, %rdi /* set to 0 */
    mov $60, %rax
    syscall
.data 
  msg: .ascii "Loop: ##\n"
  len = . - msg   
