.text 
  .global _start

_start:

  mov x28, 0 /*used as the increment for the loop*/

  loop:
    mov x27, x28
    add x27, x27, 0x30     /*  convert to ascii */
    adr x26, msg
    strb w27, [x26, len - 2] /*mov the new ascii character into the location of the new byte  */

    mov x0, 1
    adr x1, msg    
    mov x2, len    /*print out the string with the new byte*/
    mov x8, 64
    svc 1 

    add x28, x28, 1
    cmp x28, 10 /*will loop 10 times*/
    bne loop  /*end of the loop*/
  
   /*shut down the program*/
    mov x0, 0  /* use the rzr register */
    mov x8, 93
    svc 0

.data
  msg: .ascii "Loop: #\n"
  len = . - msg          /* Length of the message */
  index = msg + len - 2  /* index of the replacement byte */
