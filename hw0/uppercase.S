        .section .data
input_string:   .asciz "Hello world!"

        # tohost/fromhost are data locations used by Spike
        .align 8
tohost: .byte 0
        .align 8
fromhost: .byte 0

        
        .section .text
        .globl _start
_start:
        # Load the address of the input string into a0
        la a0, input_string
        li t0, 32
        li t1, 97
        li t2, 122

loop:
        lb t3, 0(a0)
        beqz t3, end_program
        blt t3, t1, next
        bgt t3, t2, next
        sub t3, t3, t0
        sb t3, 0(a0)

next:
        addi a0, a0, 1
        j loop

        
end_program:
        # jump here when you're done
        j end_program

