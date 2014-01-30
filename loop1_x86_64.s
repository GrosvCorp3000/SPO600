.text 
  .global _start

_start:

  movq $0, %r15 /*used as the increment for the loop*/

  loop:
    mov %r15, %r13
    add $0x30, %r13
    mov %r13b, (index) /*mov the new ascii character into the location of the new byte  */
    
    mov $len, %rdx /*print out the string with the new byte*/
    mov $msg, %rsi
    mov $1, %rdi
    mov $1, %rax
    syscall 

    inc %r15
    cmp $10, %r15 /*will loop 10 times*/
    jne loop  /*end of the loop*/
  
   /*shut down the program*/
    mov $0,%rdi
    mov $60, %rax
    syscall

.data
  msg: .ascii "Loop: #\n"
  len = . - msg          /* Length of the message */
  index = msg + len - 2  /* index of the replacement byte */
