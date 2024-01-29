
uppercase.bin:     file format elf32-littleriscv


Disassembly of section .text:

00010074 <_start>:
   10074:	ffff2517          	auipc	a0,0xffff2
   10078:	f8c50513          	addi	a0,a0,-116 # 2000 <__DATA_BEGIN__>
   1007c:	02000293          	li	t0,32
   10080:	06100313          	li	t1,97
   10084:	07a00393          	li	t2,122

00010088 <loop>:
   10088:	00050e03          	lb	t3,0(a0)
   1008c:	000e0e63          	beqz	t3,100a8 <end_program>
   10090:	006e4863          	blt	t3,t1,100a0 <next>
   10094:	01c3c663          	blt	t2,t3,100a0 <next>
   10098:	405e0e33          	sub	t3,t3,t0
   1009c:	01c50023          	sb	t3,0(a0)

000100a0 <next>:
   100a0:	00150513          	addi	a0,a0,1
   100a4:	fe5ff06f          	j	10088 <loop>

000100a8 <end_program>:
   100a8:	0000006f          	j	100a8 <end_program>
